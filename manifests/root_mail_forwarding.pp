class mailclient::root_mail_forwarding(
    $absent = $mailclient::params::absent,
    $root_mail_forwarding = $mailclient::params::root_mail_forwarding,
    ) inherits mailclient::params {
    $ensure = $absent ? {
        true  => 'absent',
        false => 'file',
    }
    # Create a .forward file for root so root's mail will be passed on
    file { '/root/.forward':
        ensure  => $ensure,
        content => inline_template('<%= @root_mail_forwarding +"\n"%>'),
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
    }
}
