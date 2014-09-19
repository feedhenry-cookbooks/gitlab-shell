#
# Cookbook Name:: gitlab-shell
# Recipe:: default
#
# Copyright 2014, FeedHenry
#
# All rights reserved - Do Not Redistribute
#

gitlab_shell = node['gitlab-shell']


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
    :self_signed_cert => gitlab_shell['self_signed_cert']
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