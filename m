Content-Type: multipart/mixed; boundary="===============7488141644254131713=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem when disable GPRS context and try to re-enable it
Date: Tue, 21 May 2013 08:24:18 -0500
Message-ID: <519B7582.4050102@gmail.com>
In-Reply-To: <5196075E.60309@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7488141644254131713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On 05/17/2013 05:33 AM, Viallard Anthony wrote:
> Hello,
>
> I start a new thread about a bad thing I seen. I can't re-enable a
> previously disabled context.
>
> Here the command to reproduce the issue:
>
> ---------------------------
> dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono
> /simcom_0/context1 org.ofono.ConnectionContext.SetProperty string:"Activ
> e" variant:boolean:true
>
> dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono
> /simcom_0/context1 org.ofono.ConnectionContext.SetProperty string:"Activ
> e" variant:boolean:false
>
> dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono
> /simcom_0/context1 org.ofono.ConnectionContext.SetProperty string:"Activ
> e" variant:boolean:true
> ---------------------------
>
> and bellow, the log:
>
> ---------------------------
> ofonod[10347]: Modem: > AT+CGDCONT=3D1,"IP","gprs.swisscom.ch"\r
> ofonod[10347]: Modem: < \r\nOK\r\n
> ofonod[10347]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
> ofonod[10347]: Modem: > AT+CGDATA=3D"PPP",1\r
> ofonod[10347]: Modem: < \r\nCONNECT 115200\r\n
> ofonod[10347]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
> ofonod[10347]: drivers/atmodem/gprs-context.c:setup_ppp()
> ofonod[10347]: drivers/atmodem/gprs-context.c:ppp_connect()
> ofonod[10347]: IP: 10.146.60.102
> ofonod[10347]: DNS: 195.186.216.33, 195.186.152.33
> ofonod[10347]: src/gprs.c:pri_activate_callback() 0x108698
> ofonod[10347]: plugins/udev.c:udev_event() subsystem net add
> ofonod[10347]: plugins/udev.c:udev_event() subsystem net finished
> ofonod[10347]: plugins/udevng.c:check_modem_list()
> ofonod[10347]:
> drivers/atmodem/gprs-context.c:at_gprs_deactivate_primary() cid 1
> ofonod[10347]: plugins/udevng.c:remove_device()
> /sys/devices/virtual/net/ppp0
> ofonod[10347]: plugins/udev.c:udev_event() subsystem net remove
> ofonod[10347]: plugins/udev.c:remove_modem() /devices/virtual/net/ppp0
> ofonod[10347]: plugins/udev.c:udev_event() subsystem net finished
> ofonod[10347]: drivers/atmodem/gprs-context.c:ppp_disconnect() Reason: 6
> ofonod[10347]: Modem: < \r\nNO CARRIER\r\n
>
>
> ofonod[10347]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary()
> cid 1
> ofonod[10347]: src/gprs.c:pri_activate_callback() 0x108698
> ofonod[10347]: src/gprs.c:pri_activate_callback() Activating context
> failed with error: Unknown error type
> ---------------------------
>
> I read the code, added some logs and found the function
> at_chat_send_common() doesn't do his job because chat->command_queue is
> NULL.
>
> I guess chat->command_queue is free and set to NULL in
> chat_cleanup(struct at_chat *chat) but I don't dig more why this
> function is call...
>
> Any ideas ?

I think I've seen this before, or something similar.  It may be that =

when the modem hangs up the PPP link it also hangs up the serial port =

(e.g. using a HUP).  GAtChat thinks that the port has been closed and =

things no longer work.

On most devices this behavior can be turned off by sending AT&C0 init =

string.  Try that?

>
> Regards,
> Anthony Viallard.
>

Regards,
-Denis

--===============7488141644254131713==--

