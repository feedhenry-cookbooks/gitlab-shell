name             'gitlab-shell'
maintainer       'FeedHenry'
maintainer_email 'david.martin@feedhenry.com'
license          'MIT License'
description      'Installs/Configures gitlab-shell'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.5.8'

%w(build-essential zlib readline ncurses git redisio xml ruby_build certificate).each do |cb_depend|
  depends cb_depend
end

%w(ubuntu).each do |os|
  supports os
end
