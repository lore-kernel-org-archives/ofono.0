Content-Type: multipart/mixed; boundary="===============0894644978577571019=="
MIME-Version: 1.0
From: Richard Genoud <richard.genoud@gmail.com>
Subject: 3G usb key TP-link MA180
Date: Fri, 25 Jul 2014 12:09:56 +0200
Message-ID: <53D22CF4.1080707@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0894644978577571019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi !

I've been trying to use the TP-link MA180 3G usb key with ofono without suc=
cess.

ofonod[1265]: plugins/udevng.c:remove_device() /sys/devices/ahb.0/700000.eh=
ci/usb1/1-2/1-2.2/1-2.2:1.0
ofonod[1265]: plugins/udevng.c:remove_device() /sys/devices/ahb.0/700000.eh=
ci/usb1/1-2/1-2.2
ofonod[1265]: plugins/udevng.c:check_usb_device() usb [2357:0201]
ofonod[1265]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[1265]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[1265]: plugins/udevng.c:check_usb_device() usb-storage [(null):(null=
)]
ofonod[1265]: plugins/udevng.c:check_usb_device() qmi_wwan [(null):(null)]
ofonod[1265]: plugins/udevng.c:check_usb_device() qmi_wwan [2357:0201]
ofonod[1265]: plugins/udevng.c:add_device() /sys/devices/ahb.0/700000.ehci/=
usb1/1-2/1-2.2
ofonod[1265]: plugins/udevng.c:add_device() /sys/devices/ahb.0/700000.ehci/=
usb1/1-2/1-2.2/1-2.2:1.4/net/wwan0
ofonod[1265]: plugins/udevng.c:add_device() wwan0 (gobi) 255/255/255 [04] =
=3D=3D> (null) (null)
ofonod[1265]: plugins/udev.c:udev_event() subsystem net add
ofonod[1265]: plugins/udev.c:udev_event() subsystem net finished
ofonod[1265]: plugins/udevng.c:check_usb_device() option [2357:0201]
ofonod[1265]: plugins/udev.c:udev_event() subsystem tty add
ofonod[1265]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[1265]: plugins/udevng.c:check_usb_device() option [2357:0201]
ofonod[1265]: plugins/udev.c:udev_event() subsystem tty add
ofonod[1265]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[1265]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[1265]: plugins/udevng.c:check_usb_device() option [2357:0201]
ofonod[1265]: plugins/udev.c:udev_event() subsystem tty add
ofonod[1265]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[1265]: plugins/udevng.c:check_modem_list() =

ofonod[1265]: plugins/udevng.c:create_modem() /sys/devices/ahb.0/700000.ehc=
i/usb1/1-2/1-2.2
ofonod[1265]: plugins/udevng.c:create_modem() driver=3Dgobi
ofonod[1265]: src/modem.c:ofono_modem_create() name: (null), type: gobi
ofonod[1265]: plugins/udevng.c:setup_gobi() /sys/devices/ahb.0/700000.ehci/=
usb1/1-2/1-2.2
ofonod[1265]: plugins/udevng.c:setup_gobi() wwan0 255/255/255 04 (null)
ofonod[1265]: plugins/udevng.c:destroy_modem() /sys/devices/ahb.0/700000.eh=
ci/usb1/1-2/1-2.2
ofonod[1265]: src/modem.c:ofono_modem_remove() 0x103788
ofonod[1265]: plugins/udevng.c:destroy_modem() wwan0

Looking at the code in plugins/udevng.c setup_gobi(), I've seen that the ca=
se info->number =3D=3D 04 is not handled.
Thus, setup_gobi() returns FALSE, and the modem is destroyed.

Any clue ?


Richard.

--===============0894644978577571019==--

