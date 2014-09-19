default['gitlab-shell']['user'] = "git"
default['gitlab-shell']['group'] = "git"
default['gitlab-shell']['home'] = "/home/git"

default['gitlab-shell']['shell_repository'] = "https://github.com/gitlabhq/gitlab-shell.git"
default['gitlab-shell']['shell_revision'] = "master"

default['gitlab-shell']['repos_path'] = "#{node['gitlab-shell']['home']}/repositories"
default['gitlab-shell']['shell_path'] = "#{node['gitlab-shell']['home']}/gitlab-shell"
default['gitlab-shell']['redis_path'] = "/usr/local/bin/redis-cli"
default['gitlab-shell']['redis_host'] = "127.0.0.1"
default['gitlab-shell']['redis_port'] = "6379"
default['gitlab-shell']['redis_database'] = nil # Default value is 0
default['gitlab-shell']['namespace']  = "resque:gitlab"
default['gitlab-shell']['self_signed_cert'] = false
default['gitlab-shell']['url'] = "http://localhost:3000/"
