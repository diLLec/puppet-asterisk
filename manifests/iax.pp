# This class describes requirements for the asterisk iax configurations to work
class asterisk::iax {
  $iax_options = $asterisk::iax_options

  asterisk::config_dotd {'/etc/asterisk/iax.conf':
    additional_paths => ['/etc/asterisk/iax.registry.d'],
    content          => template('asterisk/iax.conf.erb'),
  }
}
