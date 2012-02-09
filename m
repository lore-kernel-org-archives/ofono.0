Content-Type: multipart/mixed; boundary="===============7748172981159743266=="
MIME-Version: 1.0
From: Jan Pohanka <xhpohanka@gmail.com>
Subject: Re: setup ofono for telit h910 on embedded system
Date: Thu, 09 Feb 2012 13:02:08 +0100
Message-ID: <op.v9euduuoyxxkfz@localhost.localdomain>
In-Reply-To: <4F339FDC.8030700@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7748172981159743266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

Dne Thu, 09 Feb 2012 11:28:44 +0100 nicolas.bertrand  =

<nicolas.bertrand@linux.intel.com> napsal(a):


> Could you try with the following patch?

I have just tried your patch and here is a new log.

ofonod[132]: plugins/udev.c:udev_event() subsystem tty add
ofonod[132]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[132]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[132]: plugins/udevng.c:add_device()  =

/sys/devices/platform/musb_hdrc/usb1/1-1/1-1.3/1-
1.3:1.0/tty/ttyACM0
ofonod[132]: plugins/udevng.c:add_device() /dev/ttyACM0 (telit) 2/2/1 [00]  =

=3D=3D> (null) (null)
ofonod[132]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[132]: plugins/udevng.c:add_device()  =

/sys/devices/platform/musb_hdrc/usb1/1-1/1-1.3/1-
1.3:1.10/tty/ttyACM5
ofonod[132]: plugins/udevng.c:add_device() /dev/ttyACM5 (telit) 2/2/1 [0a]  =

=3D=3D> (null) (null)
ofonod[132]: plugins/udev.c:udev_event() subsystem tty add
ofonod[132]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[132]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[132]: plugins/udevng.c:add_device()  =

/sys/devices/platform/musb_hdrc/usb1/1-1/1-1.3/1-
1.3:1.2/tty/ttyACM1
ofonod[132]: plugins/udevng.c:add_device() /dev/ttyACM1 (telit) 2/2/1 [02]  =

=3D=3D> (null) (null)
ofonod[132]: plugins/udev.c:udev_event() subsystem tty add
ofonod[132]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[132]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[132]: plugins/udevng.c:add_device()  =

/sys/devices/platform/musb_hdrc/usb1/1-1/1-1.3/1-
1.3:1.8/tty/ttyACM4
ofonod[132]: plugins/udevng.c:add_device() /dev/ttyACM4 (telit) 2/2/1 [08]  =

=3D=3D> (null) (null)
ofonod[132]: plugins/udev.c:udev_event() subsystem tty add
ofonod[132]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[132]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[132]: plugins/udevng.c:add_device()  =

/sys/devices/platform/musb_hdrc/usb1/1-1/1-1.3/1-
1.3:1.12/tty/ttyACM6
ofonod[132]: plugins/udevng.c:add_device() /dev/ttyACM6 (telit) 2/2/1 [0c]  =

=3D=3D> (null) (null)
ofonod[132]: plugins/udev.c:udev_event() subsystem tty add
ofonod[132]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[132]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[132]: plugins/udevng.c:add_device()  =

/sys/devices/platform/musb_hdrc/usb1/1-1/1-1.3/1-
1.3:1.4/tty/ttyACM2
ofonod[132]: plugins/udevng.c:add_device() /dev/ttyACM2 (telit) 2/2/1 [04]  =

=3D=3D> (null) (null)
ofonod[132]: plugins/udev.c:udev_event() subsystem tty add
ofonod[132]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[132]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[132]: plugins/udevng.c:add_device()  =

/sys/devices/platform/musb_hdrc/usb1/1-1/1-1.3/1-
1.3:1.6/tty/ttyACM3
ofonod[132]: plugins/udevng.c:add_device() /dev/ttyACM3 (telit) 2/2/1 [06]  =

=3D=3D> (null) (null)
ofonod[132]: plugins/udev.c:udev_event() subsystem tty add
ofonod[132]: src/modem.c:ofono_modem_create() name: (null), type: telit
ofonod[132]: src/modem.c:set_modem_property() modem 0xf29a8 property Path
ofonod[132]: plugins/udev.c:add_modem()  =

/devices/platform/musb_hdrc/usb1/1-1/1-1.3/1-1.3:1.6
/tty/ttyACM3 (telit)
ofonod[132]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[132]: plugins/udevng.c:check_modem_list()
ofonod[132]: plugins/udevng.c:create_modem()  =

/sys/devices/platform/musb_hdrc/usb1/1-1/1-1.3
ofonod[132]: plugins/udevng.c:create_modem() driver=3Dtelit
ofonod[132]: src/modem.c:ofono_modem_create() name: (null), type: telit
ofonod[132]: plugins/udevng.c:setup_telit()  =

/sys/devices/platform/musb_hdrc/usb1/1-1/1-1.3
ofonod[132]: plugins/udevng.c:setup_telit() /dev/ttyACM0 2/2/1 00 (null)
ofonod[132]: plugins/udevng.c:setup_telit() /dev/ttyACM1 2/2/1 02 (null)
ofonod[132]: plugins/udevng.c:setup_telit() /dev/ttyACM2 2/2/1 04 (null)
ofonod[132]: plugins/udevng.c:setup_telit() /dev/ttyACM3 2/2/1 06 (null)
ofonod[132]: plugins/udevng.c:setup_telit() /dev/ttyACM4 2/2/1 08 (null)
ofonod[132]: plugins/udevng.c:setup_telit() /dev/ttyACM5 2/2/1 0a (null)
ofonod[132]: plugins/udevng.c:setup_telit() /dev/ttyACM6 2/2/1 0c (null)
ofonod[132]: plugins/udevng.c:destroy_modem()  =

/sys/devices/platform/musb_hdrc/usb1/1-1/1-1.3
ofonod[132]: src/modem.c:ofono_modem_remove() 0xf2500
ofonod[132]: plugins/udevng.c:destroy_modem() /dev/ttyACM0
ofonod[132]: plugins/udevng.c:destroy_modem() /dev/ttyACM1
ofonod[132]: plugins/udevng.c:destroy_modem() /dev/ttyACM2
ofonod[132]: plugins/udevng.c:destroy_modem() /dev/ttyACM3
ofonod[132]: plugins/udevng.c:destroy_modem() /dev/ttyACM4
ofonod[132]: plugins/udevng.c:destroy_modem() /dev/ttyACM5
ofonod[132]: plugins/udevng.c:destroy_modem() /dev/ttyACM6

It seems that ofono tries to do more than before, but modem is created and  =

removed immediately... Regarding the ttyACM3 - it behaves like serial  =

port. I can connect it with minicom and send and receive AT commands.

regards
Jan


-- =

Tato zpr=C3=A1va byla vytvo=C5=99ena p=C5=99evratn=C3=BDm po=C5=A1tovn=C3=
=ADm klientem Opery:  =

http://www.opera.com/mail/

--===============7748172981159743266==--

