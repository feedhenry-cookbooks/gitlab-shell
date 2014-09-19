gitlab-shell Cookbook
=====================

Chef cookbook for gitlab shell https://github.com/gitlabhq/gitlab-shell

Requirements
------------

### Platforms

- Ubuntu

Attributes
----------

#### gitlab-shell::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['user']</tt></td>
    <td>String</td>
    <td>Gitlab Shell User</td>
    <td><tt>"git"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['group']</tt></td>
    <td>String</td>
    <td>Gitlab Shell User group</td>
    <td><tt>"git"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['home']</tt></td>
    <td>String</td>
    <td>Gitlab Shell home directory</td>
    <td><tt>"/home/git"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['shell_repository']</tt></td>
    <td>String</td>
    <td>Gitlab Shell git repo location</td>
  <td><tt>"https://github.com/gitlabhq/gitlab-shell.git"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['shell_revision']</tt></td>
    <td>String</td>
    <td>Gitlab Shell git repo ref to checkout/install</td>
    <td><tt>"master"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['repos_path']</tt></td>
    <td>String</td>
    <td>Gitlab Shell git repositories path</td>
  <td><tt>"#{node['gitlab-shell']['home']}/repositories"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['shell_path']</tt></td>
    <td>String</td>
    <td>Gitlab Shell ssh script run via authorized_keys</td>
    <td><tt>"#{node['gitlab-shell']['home']}/gitlab-shell"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['redis_path']</tt></td>
    <td>String</td>
    <td>Redis cli location</td>
    <td><tt>"/usr/local/bin/redis-cli"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['redis_host']</tt></td>
    <td>String</td>
    <td>Redis Host</td>
    <td><tt>"127.0.0.1"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['redis_port']</tt></td>
    <td>String</td>
    <td>Redis Port</td>
    <td><tt>"6379"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['redis_database']</tt></td>
    <td>String</td>
    <td>Redis Database</td>
    <td><tt>nil # Default value is 0</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['namespace']</tt></td>
    <td>String</td>
    <td>Redis Namespace</td>
    <td><tt>"resque:gitlab"</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['self_signed_cert']</tt></td>
    <td>Boolean</td>
    <td>Use self signed cert</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab-shell']['url']</tt></td>
    <td>String</td>
    <td>Gitlab callback host for auth and key checks</td>
    <td><tt>"http://localhost:3000/"</tt></td>
  </tr>
</table>

Usage
-----
#### gitlab-shell::default

Just include `gitlab-shell` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[gitlab-shell]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github https://github.com/feedhenry-cookbooks/gitlab-shell
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: david.martin@feedhenry.com https://github.com/david-martin
