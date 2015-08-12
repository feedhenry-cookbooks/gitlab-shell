default['gitlab-shell']['user'] = "git"
default['gitlab-shell']['group'] = "git"
default['gitlab-shell']['home'] = "/home/git"

default['gitlab-shell']['shell_repository'] = "https://github.com/gitlabhq/gitlab-shell.git"
default['gitlab-shell']['shell_revision'] = "master"

default['gitlab-shell']['repos_path'] = "#{node['gitlab-shell']['home']}/repositories"
default['gitlab-shell']['shell_path'] = "#{node['gitlab-shell']['home']}/gitlab-shell"

# redis
default['gitlab-shell']['redis_path'] = "/usr/local/bin/redis-cli"
default['gitlab-shell']['redis_host'] = "127.0.0.1"
default['gitlab-shell']['redis_port'] = "6379"
default['gitlab-shell']['redis_database'] = nil # Default value is 0
default['gitlab-shell']['namespace']  = "resque:gitlab"

#rabbit
default['gitlab-shell']['rabbit_enabled'] = false
default['gitlab-shell']['rabbit_hosts'] = ["127.0.0.1"]
default['gitlab-shell']['rabbit_vhost'] = "/"
default['gitlab-shell']['rabbit_user'] = "user"
default['gitlab-shell']['rabbit_password'] = "password"
default['gitlab-shell']['rabbit_queue'] = "gitlab"

default['gitlab-shell']['self_signed_cert'] = false
default['gitlab-shell']['url'] = "http://localhost:3000/"

# Ruby setup
include_attribute 'ruby_build'
default['ruby_build']['upgrade'] = 'sync'
default['gitlab-shell']['install_ruby'] = '1.9.3-p484'
default['gitlab-shell']['install_ruby_path'] = node['gitlab-shell']['home']
default['gitlab-shell']['cookbook_dependencies'] = %w(
  zlib readline ncurses logrotate ruby_build
)

# Required packages for Gitlab
case node['platform_family']
when 'debian'
  default['gitlab-shell']['packages'] = %w(
    libyaml-dev libssl-dev libgdbm-dev libffi-dev checkinstall
    curl libcurl4-openssl-dev libicu-dev wget python-docutils sudo
  )
when 'rhel'
  default['gitlab-shell']['packages'] = %w(
    libyaml-devel openssl-devel gdbm-devel libffi-devel
    curl libcurl-devel libicu-devel wget python-docutils sudo
  )
else
  default['gitlab-shell']['install_ruby'] = 'package'
  default['gitlab-shell']['cookbook_dependencies'] = %w(
    readline zlib ruby_build
  )
  default['gitlab-shell']['packages'] = %w(
    autoconf binon flex gcc gcc-c++ make m4
    git
    zlib1g-dev libyaml-dev libssl-dev libgdbm-dev
    libreadline-dev libncurses5-dev libffi-dev curl git-core
    checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev
    libicu-dev python-docutils sudo
  )
end