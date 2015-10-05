define asterisk::sip (
  $ensure        = present,
  $username      = false,
  $defaultuser   = false,
  $template_name = false,
  $secret        = false,
  $context       = false,
  $account_type  = 'friend',
  $canreinvite   = 'no',
  $host          = 'dynamic',
  $insecure      = 'no',
  $language      = 'en',
  $nat           = false,
  $qualify       = 'no',
  $vmexten       = false,
  $callerid      = false,
  $calllimit     = false,
  $callgroup     = false,
  $mailbox       = false,
  $md5secret     = false,
  $pickupgroup   = false,
  $fromdomain    = false,
  $fromuser      = false,
  $outboundproxy = false,
  $t38pt_udptl   = false,
  $disallow      = [],
  $allow         = [],
  $dtmfmode      = false,
  $transports    = [],
  $encryption    = ''
) {

  # Ensure that we can iterate over some of the parameters.
  validate_array($disallow)
  validate_array($allow)
  validate_array($transports)

  asterisk::dotd::file {"sip_${name}.conf":
    ensure   => $ensure,
    dotd_dir => 'sip.d',
    content  => template('asterisk/snippet/sip.erb'),
    filename => "${name}.conf",
  }
}
