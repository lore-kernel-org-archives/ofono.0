Content-Type: multipart/mixed; boundary="===============0310517117924693283=="
MIME-Version: 1.0
From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: Some experiments with the SIMCOM SIM5216E modem on a ARM926 board
Date: Fri, 13 Jan 2012 05:39:39 +0100
Message-ID: <4F0FB58B.6020607@eclis.ch>
In-Reply-To: <1326427044.6454.256.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0310517117924693283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> the USB interface index is:
>> >  0-       DIAG
>> >  1-       NMEA
>> >  2-       AT
>> >  3-       MODEM
>> >  4-       Ethernet
>> >  So, the port index 2 and port index 3 exposes a working AT command
>> >  interface.

> okay then, run ofonod -n -d '*udev*' and see if you get proper debug
> output for your modem. Just pushed a udev patch that does the detection.

Thanks for it. Seem to be ok:

ofonod[484]: oFono version 1.2
ofonod[484]: plugins/udevng.c:udev_start()
ofonod[484]: plugins/udevng.c:enumerate_devices()
ofonod[484]: plugins/udevng.c:check_usb_device() option [05c6:9000]
ofonod[484]: plugins/udevng.c:add_device() =

/sys/devices/platform/ohci.0/usb1/1-1/1-1:1.0/ttyUSB0/tty/ttyUSB0
ofonod[484]: plugins/udevng.c:add_device() /dev/ttyUSB0 (simcom) =

255/255/255 [00] =3D=3D> (null) (null)
ofonod[484]: plugins/udevng.c:check_usb_device() option [05c6:9000]
ofonod[484]: plugins/udevng.c:add_device() =

/sys/devices/platform/ohci.0/usb1/1-1/1-1:1.1/ttyUSB1/tty/ttyUSB1
ofonod[484]: plugins/udevng.c:add_device() /dev/ttyUSB1 (simcom) =

255/255/255 [01] =3D=3D> (null) (null)
ofonod[484]: plugins/udevng.c:check_usb_device() option [05c6:9000]
ofonod[484]: plugins/udevng.c:add_device() =

/sys/devices/platform/ohci.0/usb1/1-1/1-1:1.2/ttyUSB2/tty/ttyUSB2
ofonod[484]: plugins/udevng.c:add_device() /dev/ttyUSB2 (simcom) =

255/255/255 [02] =3D=3D> (null) (null)
ofonod[484]: plugins/udevng.c:check_usb_device() option [05c6:9000]
ofonod[484]: plugins/udevng.c:add_device() =

/sys/devices/platform/ohci.0/usb1/1-1/1-1:1.3/ttyUSB3/tty/ttyUSB3
ofonod[484]: plugins/udevng.c:add_device() /dev/ttyUSB3 (simcom) =

255/255/255 [03] =3D=3D> (null) (null)
ofonod[484]: plugins/udevng.c:check_usb_device() option [05c6:9000]
ofonod[484]: plugins/udevng.c:add_device() =

/sys/devices/platform/ohci.0/usb1/1-1/1-1:1.4/ttyUSB4/tty/ttyUSB4
ofonod[484]: plugins/udevng.c:add_device() /dev/ttyUSB4 (simcom) =

255/255/255 [04] =3D=3D> (null) (null)
ofonod[484]: plugins/udevng.c:create_modem() =

/sys/devices/platform/ohci.0/usb1/1-1
ofonod[484]: plugins/udevng.c:create_modem() driver=3Dsimcom
ofonod[484]: plugins/udevng.c:setup_simcom() =

/sys/devices/platform/ohci.0/usb1/1-1
ofonod[484]: plugins/udevng.c:setup_simcom() /dev/ttyUSB0 255/255/255 00 =

(null)
ofonod[484]: plugins/udevng.c:setup_simcom() /dev/ttyUSB1 255/255/255 01 =

(null)
ofonod[484]: plugins/udevng.c:setup_simcom() /dev/ttyUSB2 255/255/255 02 =

(null)
ofonod[484]: plugins/udevng.c:setup_simcom() /dev/ttyUSB3 255/255/255 03 =

(null)
ofonod[484]: plugins/udevng.c:setup_simcom() /dev/ttyUSB4 255/255/255 04 =

(null)
ofonod[484]: plugins/udevng.c:setup_simcom() modem=3D/dev/ttyUSB3 =

aux=3D/dev/ttyUSB2 gps=3D/dev/ttyUSB1 diag=3D/dev/ttyUSB0

But of course, since the "simcom" driver don't exists yet, there is =

nothing after this:

ofonod[1019]: src/modem.c:set_modem_property() modem 0xfbcf8 property Modem
ofonod[1019]: src/modem.c:set_modem_property() modem 0xfbcf8 property Data
ofonod[1019]: src/modem.c:set_modem_property() modem 0xfbcf8 property GPS
ofonod[1019]: src/modem.c:ofono_modem_register() 0xfbcf8

What is the best driver to fork as a base for the simcom driver ?

Regards,

Jean-Christian

--===============0310517117924693283==--

