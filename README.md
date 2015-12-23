# MailClient Module

## Overview

The **MailClient** module configures a postfix mail relay *for local
clients only*. It will also forward email addressed to root on the
puppet client to another address which is configurable in Hiera.

## Configuration

This module can be configured via Hiera via the following keys.

* `mailclient::mail_relay_host` the host name of the central email
  server where emails from local clients will be forwarded to.
* `mailclient::mail_relay_port` the port number of the central email
  server where emails from local clients will be forwarded to.
* `mailclient::admin_mail_to` the email address that will receive email
  addressed to root on the puppet client.

## Dependencies

* This module depends on the Apache, Postfix and HAProxy modules
