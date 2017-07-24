$project_name = "webcms"
$virtual_evn_dir = "/home/virtualenvs/$project_name"


/*
class { 'apt':
  update => {
    frequency => 'daily',
  }
}

*/


$package_list = ["build-essential", 'git', 'npm', 'nodejs-legacy', 'libmysqld-dev', 'phpmyadmin', 'libaio-dev',
     'libldap2-dev', 'libsasl2-dev', 'libssl-dev', 'libffi-dev', 'libxml2-dev', 'libxslt1-dev', 'libcairo2', 'libpangocairo-1.0-0', 'libpq-dev', 'memcached', 'freetds-dev']
package { $package_list: ensure => latest }

$package_list2 = ['python3-venv', 'python3-dev', 'python-pyodbc', 'python3-pyodbc']
package { $package_list2: ensure => latest }

$package_list3 = ['php-mbstring', 'php-gettext']
package { $package_list3: ensure => latest }


package { 'apache2':
    ensure => latest
}

package {'libapache2-mod-wsgi-py3':
    ensure => latest,
    require => Package['apache2'],
}

file {"/etc/apache2/conf-enabled/phpmyadmin.conf":
    ensure => link,
    target => "/etc/phpmyadmin/apache.conf",
    require => Package['apache2', 'phpmyadmin'],
}


service { apache2:
    ensure => running,
    subscribe => File["/etc/apache2/conf-enabled/phpmyadmin.conf", "/etc/apache2/sites-enabled/$project_name.conf"],
}


class apache2_site
{
    file {"/etc/apache2/sites-available/$project_name.conf":
        ensure => present,
        source => "puppet:///modules/apache2_site/$project_name.conf",
        require => Package['apache2', 'libapache2-mod-wsgi-py3'],
    }

    file {"/etc/apache2/sites-enabled/$project_name.conf":
        ensure => link,
        target => "/etc/apache2/sites-available/$project_name.conf",
        require => File["/etc/apache2/sites-available/$project_name.conf"],
    }

}

include apache2_site


file {'/home/virtualenvs':
      ensure => directory,
      recurse => true,
      owner        => 'www-data',
      group        => 'www-data',
}


python::pyvenv { "virtual_evn_dir" :
    ensure       => present,
    systempkgs   => true,
    venv_dir     => "$virtual_evn_dir",
    owner        => 'www-data',
    group        => 'www-data',
    require => [File['/home/virtualenvs']]
}


python::pip { 'Django' :
    pkgname => 'Django',
    ensure => latest,
    virtualenv => $virtual_evn_dir
}

python::pip { 'django-axes' :
    pkgname => 'django-axes',
    ensure => latest,
    virtualenv => $virtual_evn_dir
}

python::pip { 'python-requests' :
    pkgname => 'python-requests',
    ensure => latest,
    virtualenv => $virtual_evn_dir
}


python::pip { 'python-memcached' :
    pkgname => 'python-memcached',
    ensure => latest,
    virtualenv => $virtual_evn_dir
}

python::pip { 'django-debug-toolbar' :
    pkgname => 'django-debug-toolbar',
    ensure => latest,
    require => Python::Pip['Django'],
    virtualenv => $virtual_evn_dir
}


python::pip { 'pymssql' :
    pkgname => 'pymssql',
    ensure => latest,
    require => Python::Pip['Django'],
    virtualenv => $virtual_evn_dir
}


package { 'python-mysqldb':
    ensure => latest,
}

package { 'bower':
    ensure => present,
    provider => 'npm',
    require => Package['npm'],
}

python::pip { 'django-bower' :
    pkgname => 'django-bower',
    ensure => latest,
    require => [Package['bower'], Python::Pip['Django']],
    virtualenv => $virtual_evn_dir
}


python::pip { 'mysqlclient' :
    pkgname => 'mysqlclient',
    ensure => latest,
    install_args  => ['--allow-external mysqlclient --allow-unverified mysqlclient'],
    require => [Python::Pip['Django'], Package["python3-dev"]],
    virtualenv => $virtual_evn_dir
}


include '::mysql::server'

mysql::db { "$project_name":
    user     => "$project_name",
    password => 'webcmsp',
    host     => 'localhost',
    grant    => ['ALL'],
    require => Package["mysql-server"],
}

mysql::db { "test_$project_name":
    user     => "$project_name",
    password => 'webcmsp',
    host     => 'localhost',
    grant    => ['ALL'],
    require => Package["mysql-server"],
}