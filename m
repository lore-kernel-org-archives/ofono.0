Content-Type: multipart/mixed; boundary="===============2709595104170581008=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Running ofono on n900 natively
Date: Tue, 01 Jun 2010 13:49:59 +0200
Message-ID: <AANLkTimOMrft_pm55xVLQ5ZUbVls0fNWXmH9phLlI6iF@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2709595104170581008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to run ofono on n900 natively, with debian sid installed on
an external SD card (not using meego just to have an easy build
environment directly on the device, kernel, modules and firmware
copied from maemo pr 1.2).

I activated the phonet0 with the command:

/mnt/initfs/sbin/phonet -a 0x6C -i phonet0

With version 0.21 phonet is detected as down:

[...]
ofonod[19109]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8c908, name: isimodem
ofonod[19109]: src/gprs.c:ofono_gprs_driver_register() driver:
0x8c91c, name: isimodem
ofonod[19109]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8c930, name: isimodem
ofonod[19109]: src/modem.c:ofono_modem_driver_register() driver:
0x8c724, name: isimodem
ofonod[19109]: plugins/usbpnmodem.c:usbpn_status_cb() Phonet link
phonet0 (4) is down
ofonod[19109]: plugins/usbpnmodem.c:usbpn_status_cb() Phonet link
upnlink0 (5) is down

With version 0.20 phonet is detected up but fails on the mtc driver:

[...]
ofonod[22857]: src/modem.c:ofono_modem_driver_register() driver:
0x7e820, name: isimodem
ofonod[22857]: drivers/isimodem/isimodem.c:netlink_status_cb() PhoNet
is up, addr=3D0x6c, idx=3D0x4
ofonod[22857]: src/modem.c:ofono_modem_create() name: (null), type: isimodem
ofonod[22857]: drivers/isimodem/isimodem.c:netlink_status_cb() Done
regging modem
ofonod[22857]: drivers/isimodem/isimodem.c:reachable_cb() Unable to
bootstrap mtc driver

In can see the /isimodem0 dbus object, and when trying to start it I get:
ofonod[22857]: drivers/isimodem/isimodem.c:mtc_power_on_cb() ISI
client error: -110

Anyway booting maemo and running the same 0.20 executable in chroot
works, so I think my debian deploy misses something userspace.

Any hints?

Another question, will ofono be able to start phonet without closed
userspace tools?

Regards

    Niko

--===============2709595104170581008==--

