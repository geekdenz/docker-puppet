notice('=== PHP 5 - SilverStripe ===')

class { 'timezone':
  region   => 'Pacific',
  locality => 'Auckland',
}

package{ 'vim':
  ensure => present,
}

#package{ 'mysql-server':
#  ensure => present,
#}

#package{ 'mysql-client':
#  ensure => present,
#}

#package{ 'php5':
#  ensure => present,
#}
#package{ 'libapache2-mod-fastcgi':
#  ensure => present,
#  require => Package['php5'],
#}

# == variables == #
$db_name                   = 'test'
$db_user                   = 'test'
$db_pass                   = 'test'
$project_name              = 'silverstripe'

#class { 'apache': }
#apache::fastcgi::server { 'php':
#  host       => '127.0.0.1:9000',
#  timeout    => 15,
#  #flush      => false,
#  #faux_path  => '/var/www/php.fcgi',
#  #fcgi_alias => '/php.fcgi',
#  file_type  => 'application/x-httpd-php',
#  require => Package['libapache2-mod-fastcgi'],
#}

class { 'apache':
}
class { 'apache::mod::rewrite' : 
}
class { 'apache::mod::actions' : 
  #require => Class['apache'],
}
class { '::php':
  ensure       => latest,
  manage_repos => true,
  fpm          => true,
  dev          => true,
  composer     => true,
  pear         => true,
  phpunit      => false,
  require => Class['apache::mod::actions'],
  extensions => {
    gd => { },
    curl => { },
    tidy => { },
    mysql => { },
  },
  settings => {
    'Date/date.timezone'      => 'Europe/Berlin',
  },
}
apache::fastcgi::server { 'php':
  host       => '127.0.0.1:9000',
  timeout    => 15,
  #flush      => false,
  #faux_path  => '/var/www/php.fcgi',
  #fcgi_alias => '/php.fcgi',
  file_type  => 'application/x-httpd-php',
  #require => Class['apache'],
  require => Class['::php'],
}
apache::vhost { '127.0.0.1':
  port    => '80',
  docroot => '/opt/silverstripe/project',
  custom_fragment => 'AddType application/x-httpd-php .php',
  override => 'All',
  # +Indexes +FollowSymLinks -MultiViews
  options => ['+Indexes', '+FollowSymLinks', '-MultiViews'],
  #rewrites => [
  #  {
  #    rewrite_rule => ['^index\.html$ welcome.html']
  #  },
  #]
  require => Class['::php'],
}
include '::mysql::server'
mysql::db { 'mydb':
  user     => 'test',
  password => 'test',
  host     => 'localhost',
  grant    => ['ALL'],
}
