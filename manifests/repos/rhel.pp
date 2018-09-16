# Installs the repos needed to install asterisk and it's components
#
class asterisk::repos::rhel {


  if $asterisk::real_manage_package['manage_repos'] == 'all' or $asterisk::real_manage_package['manage_repos'] == 'only-asterisk'
  {
    $tucny_keyfile = 'RPM-GPG-KEY-dtucny'
    $tucny_key = "/etc/pki/rpm-gpg/${tucny_keyfile}"
    yum::gpgkey { $tucny_key:
      ensure => present,
      source => "https://ast.tucny.com/repo/${tucny_keyfile}",
    }

    yumrepo { 'asterisk-common':
      ensure     => present,
      descr      => 'Asterisk Common Requirement Packages @ tucny.com',
      mirrorlist => 'https://ast.tucny.com/mirrorlist.php?release=$releasever&arch=$basearch&repo=asterisk-common',
      enabled    => true,
      gpgcheck   => true,
      gpgkey     => "file://${$tucny_key}",
      require    => Yum::Gpgkey[$tucny_key],
    }

    yumrepo { 'asterisk-13':
      ensure     => present,
      descr      => 'Asterisk 13 Packages @ tucny.com',
      mirrorlist => 'https://ast.tucny.com/mirrorlist.php?release=$releasever&arch=$basearch&repo=asterisk-13',
      enabled    => true,
      gpgcheck   => true,
      gpgkey     => "file://${$tucny_key}",
      require    => Yum::Gpgkey[$tucny_key],
    }

  }

  if $asterisk::real_manage_package['manage_repos'] == 'all' {
    $epel_keyfile = "RPM-GPG-KEY-EPEL-${facts['os']['release']['major']}"
    $epel_key = "/etc/pki/rpm-gpg/${epel_keyfile}"
    yum::gpgkey { $epel_key:
      ensure => present,
      source => "https://dl.fedoraproject.org/pub/epel/${epel_keyfile}",
    }

    yumrepo { 'epel':
      ensure         => present,
      descr          => "Extra Packages for Enterprise Linux ${facts['os']['release']['major']} - \$basearch",
      mirrorlist     => "https://mirrors.fedoraproject.org/metalink?repo=epel-${facts['os']['release']['major']}&arch=\$basearch",
      failovermethod => 'priority',
      enabled        => true,
      gpgcheck       => true,
      gpgkey         => "file://${epel_key}",
      require        => Yum::Gpgkey[$epel_key],
    }
  }

}
