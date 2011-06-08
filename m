Content-Type: multipart/mixed; boundary="===============3287265973982515176=="
MIME-Version: 1.0
From: Bernhard Guillon <Bernhard.Guillon@hale.at>
Subject: Re: [PATCH v4 4/4] udev: add Telit UC864-G and update udev rules
Date: Wed, 08 Jun 2011 17:32:57 +0200
Message-ID: <alpine.DEB.2.00.1106081719410.30119@entw48>
In-Reply-To: <1307546317-31831-4-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3287265973982515176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On Wed, 8 Jun 2011, Bernhard.Guillon(a)hale.at wrote:

> From: Bernhard Guillon <Bernhard.Guillon@hale.at>
>
> *add Modem and GPS check for telit
> *make GPS yes/no configurable with udev rules settings
> **this is necessary because telit has different interface
>  numbers on different modems e.g. GPS and UART

Hi,
I did not know how to better ask for some help so I sent this patch
without being completely right.

I needed to move the ENV{OFONO_DRIVER}=3D"telit" to the end like the other
modems do. Without the add_modem is called with different modem objects.

The problem about the current patch is:

ofonod[31654]: src/modem.c:ofono_modem_create() name: 000000000002, type: =

telit

I want to ask for some advice on how to best debug this problem. I tried =

it with a short PROGRAM=3D"/tmp/foo.pl" which prints the environment. If I =

add it to the

ATTRS{idVendor}=3D=3D"1bc7", ENV{OFONO_DRIVER}=3D"telit", PROGRAM=3D"/tmp/f=
oo.pl"

line the environment for OFONO_DRIVER do not exist. If I add the same =

script to one of the lines at the first section I get the proper =

OFONO_DRIVER telit envirionment.

Thanks in advance for any hints :)

I was not able to hard code the interface number as novatel does it
because the interfaces change on different telit modems. I used the huawai =

code as base.

Best regards,
Bernhard

[1]
ofonod[31654]: src/modem.c:set_modem_property() modem 0x1f2d890 property =

Path
ofonod[31654]: src/modem.c:set_modem_property() modem 0x1f2d890 property =

Registered
ofonod[31654]: plugins/udev.c:add_modem() =

/devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.0/ttyUSB1/tty/ttyUSB1 =

(telit)
ofonod[31654]: plugins/udev.c:add_telit() modem 0x1f2d890
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

ModemRegistered
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

GPSRegistered
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

HasGPS
ofonod[31654]: src/modem.c:set_modem_property() modem 0x1f2d890 property =

HasGPS
ofonod[31654]: src/modem.c:set_modem_property() modem 0x1f2d890 property =

Modem
ofonod[31654]: src/modem.c:set_modem_property() modem 0x1f2d890 property =

ModemRegistered
ofonod[31654]: plugins/telit.c:telit_probe() 0x1f2d890
ofonod[31654]: plugins/smart-messaging.c:modem_watch() modem: 0x1f2d890, =

added: 1
ofonod[31654]: plugins/push-notification.c:modem_watch() modem: 0x1f2d890, =

added: 1
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

Path
ofonod[31654]: plugins/udev.c:add_modem() =

/devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.1/ttyUSB2/tty/ttyUSB2 =

(telit)
ofonod[31654]: plugins/udev.c:add_telit() modem 0x1f2d890
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

ModemRegistered
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

GPSRegistered
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

HasGPS
ofonod[31654]: src/modem.c:set_modem_property() modem 0x1f2d890 property =

HasGPS
ofonod[31654]: src/modem.c:unregister_property() property 0x1f2ce60
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

Path
ofonod[31654]: plugins/udev.c:add_modem() =

/devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.2/ttyUSB3/tty/ttyUSB3 =

(telit)
ofonod[31654]: plugins/udev.c:add_telit() modem 0x1f2d890
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

ModemRegistered
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

GPSRegistered
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

HasGPS
ofonod[31654]: src/modem.c:set_modem_property() modem 0x1f2d890 property =

HasGPS
ofonod[31654]: src/modem.c:unregister_property() property 0x1f2d330
ofonod[31654]: src/modem.c:set_modem_property() modem 0x1f2d890 property =

GPS
ofonod[31654]: src/modem.c:set_modem_property() modem 0x1f2d890 property =

GPSRegistered
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

Path
ofonod[31654]: plugins/udev.c:add_modem() =

/devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.3/ttyUSB4/tty/ttyUSB4 =

(telit)
ofonod[31654]: plugins/udev.c:add_telit() modem 0x1f2d890
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

ModemRegistered
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

GPSRegistered
ofonod[31654]: src/modem.c:get_modem_property() modem 0x1f2d890 property =

HasGPS




--
Scanned by MailScanner.


--===============3287265973982515176==--

