Content-Type: multipart/mixed; boundary="===============2936483844461485002=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] huawei: cleanup sim polling when the modem is removed.
Date: Wed, 03 Aug 2011 12:11:55 +0200
Message-ID: <1312366315.3373.15.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC28893900696C@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2936483844461485002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Betrand,

> > We call disable before we call remove, but the only thing that I have
> > not checked is what happens to this if we have not succeeded with
> > enable
> > yet. So if I remember this right, then disable is always called (even
> > if
> > enable has not yet called set_powered), but I need Denis to confirm
> > this.
> =

> Except in the unplug test.

it is just the race condition for the time enable is running. Once the
modem is properly enabled, even the unplug case is fine.

ofonod[14344]: plugins/udev.c:udev_event() subsystem net remove
ofonod[14344]: plugins/udev.c:remove_modem() /devices/pci0000:00/0000:00:1a=
.0/usb1/1-1/1-1.1/1-1.1:1.1/net/wwan0
ofonod[14344]: src/modem.c:get_modem_property() modem 0x7beff0 property Path
ofonod[14344]: src/modem.c:ofono_modem_remove() 0x7beff0
ofonod[14344]: src/modem.c:modem_unregister() 0x7beff0
ofonod[14344]: src/modem.c:modem_change_state() old state: 2, new state: 0
ofonod[14344]: src/modem.c:flush_atoms() =

ofonod[14344]: Example Network Time Remove for modem: 0x7beff0
ofonod[14344]: Example History Remove for modem: 0x7beff0
ofonod[14344]: src/gprs.c:gprs_context_unregister() 0x7be230, 0x7bc8c0
ofonod[14344]: src/gprs.c:gprs_context_remove() atom: 0x7be270
ofonod[14344]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =

ofonod[14344]: Unregistered handle for channel 1: 0x10000
ofonod[14344]: src/gprs.c:gprs_unregister() 0x7bc8c0
ofonod[14344]: src/gprs.c:gprs_remove() atom: 0x7bd840
ofonod[14344]: plugins/push-notification.c:push_notification_cleanup() 0x7b=
a6a0
ofonod[14344]: plugins/smart-messaging.c:smart_messaging_cleanup() 0x7ba640
ofonod[14344]: src/sms.c:sms_remove() atom: 0x7bf300
ofonod[14344]: src/radio-settings.c:radio_settings_remove() atom: 0x7bea90
ofonod[14344]: src/phonebook.c:phonebook_remove() atom: 0x7ba400
ofonod[14344]: src/sim.c:sim_remove() atom: 0x7b8b00
ofonod[14344]: src/modem.c:devinfo_remove() atom: 0x7b8d00
ofonod[14344]: plugins/huawei.c:huawei_disable() 0x7beff0
ofonod[14344]: plugins/huawei.c:huawei_remove() 0x7beff0

We do call disable before we call remove in the "clean" unplug case. So
that is not the problem.

However there is a real race condition here. My previous comment still
stands that we do want to disarm the timeout in the disable callback
already in case of a clean shutdown.

However this opens another set of questions. Since now we have the
problem that we will cleanup the control TTY, but we will not cleanup
the modem TTY. So we are leaking memory and a file descriptor here.

The file descriptor is kinda nasty since a running process is still
having a file descriptor for an already removed kernel device. So
depending on how clean the kernel driver handles this, it can be no
problem or a big problem. Nevertheless the running ofonod process will
have certain problems with this over time.

Luckily that part is a small race condition that is even extremely hard
to reproduce, but it does need to be fixed.

Regards

Marcel



--===============2936483844461485002==--

