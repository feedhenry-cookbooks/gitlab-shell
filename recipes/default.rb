#
# Cookbook Name:: gitlab-shell
# Recipe:: default
#
# Copyright 2014, FeedHenry
#
# All rights reserved - Do Not Redistribute
#

gitlab_shell = node['gitlab-shell']

# Install the required packages via cookbook
gitlab_shell['cookbook_dependencies'].each do |requirement|
  include_recipe requirement
end

# Install required packages for Gitlab Shell
gitlab_shell['packages'].each do |pkg|
  package pkg
end

group gitlab_shell['group'] do
end

user gitlab_shell['user'] do
  group gitlab_shell['group']
  shell "/bin/bash"
  home gitlab_shell['home']
  supports :manage_home => true
  system true
end

git gitlab_shell['shell_path'] do
  repository gitlab_shell['shell_repository']
  revision gitlab_shell['shell_revision']
  user gitlab_shell['user']
  group gitlab_shell['group']
  action :sync
end

# The recommended Ruby is >= 1.9.3
# We'll use Fletcher Nichol's ruby_build cookbook to compile a Ruby.
if gitlab_shell['install_ruby'] !~ /package/
  # ruby_build_ruby gitlab_shell['install_ruby']
  ruby_build_ruby gitlab_shell['install_ruby'] do
    prefix_path gitlab_shell['install_ruby_path']
    user gitlab_shell['user']
    group gitlab_shell['group']
  end

  # This hack put here to reliably find Ruby
  # cross-platform. Issue #66
  execute 'update-alternatives-ruby' do
    command "update-alternatives --install /usr/local/bin/ruby ruby #{gitlab_shell['install_ruby_path']}/bin/ruby 10"
    not_if { ::File.exist?('/usr/local/bin/ruby') }
  end

  # Install required Ruby Gems for Gitlab with ~git/bin/gem
  %w(charlock_holmes bundler).each do |gempkg|
    gem_package gempkg do
      gem_binary "#{gitlab_shell['install_ruby_path']}/bin/gem"
      action :install
      options('--no-ri --no-rdoc')
    end
  end
else
  # Install required Ruby Gems for Gitlab with system gem
  %w(charlock_holmes bundler).each do |gempkg|
    gem_package gempkg do
      action :install
      options('--no-ri --no-rdoc')
    end
  end
end

bundler_binary = "#{gitlab_shell['install_ruby_path']}/bin/bundle"

# Install Gems with bundle install
execute 'gitlab-shell-bundle-install' do
  command "#{bundler_binary} install --deployment --binstubs --without development test"
  cwd gitlab_shell['shell_path']
  user gitlab_shell['user']
  group gitlab_shell['group']
  environment('LANG' => 'en_US.UTF-8', 'LC_ALL' => 'en_US.UTF-8')
end

## Edit config and replace gitlab_url
template File.join(gitlab_shell['shell_path'], "config.yml") do
  source "gitlab_shell.yml.erb"
  user gitlab_shell['user']
  group gitlab_shell['group']
  variables({
    :user => gitlab_shell['user'],
    :home => gitlab_shell['home'],
    :url => gitlab_shell['url'],
    :repos_path => gitlab_shell['repos_path'],
    :redis_path => gitlab_shell['redis_path'],
    :redis_host => gitlab_shell['redis_host'],
    :redis_port => gitlab_shell['redis_port'],
    :redis_database => gitlab_shell['redis_database'],
    :namespace => gitlab_shell['namespace'],
    :self_signed_cert => gitlab_shell['self_signed_cert'],
    :rabbit_enabled => gitlab_shell['rabbit_enabled'],
    :rabbit_hosts => gitlab_shell['rabbit_hosts'],
    :rabbit_vhost => gitlab_shell['rabbit_vhost'],
    :rabbit_user => gitlab_shell['rabbit_user'],
    :rabbit_password => gitlab_shell['rabbit_password'],
    :rabbit_queue => gitlab_shell['rabbit_queue']
  })
end

## Do setup
directory "Repositories path" do
  path gitlab_shell['repos_path']
  owner gitlab_shell['user']
  group gitlab_shell['group']
  mode 02770
end

directory "SSH key directory" do
  path File.join(gitlab_shell['home'], "/", ".ssh")
  owner gitlab_shell['user']
  group gitlab_shell['group']
  mode 0700
end

file "authorized keys file" do
  path File.join(gitlab_shell['home'], "/", ".ssh", "/", "authorized_keys")
  owner gitlab_shell['user']
  group gitlab_shell['group']
  mode 0600
  action :create_if_missing
end