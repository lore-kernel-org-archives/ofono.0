Content-Type: multipart/mixed; boundary="===============8529561601607351712=="
MIME-Version: 1.0
From: Thiago Cangussu de Castro Gomes <thiagoc@syst.com.br>
Subject: Re: Connecting with Huawei E226
Date: Fri, 27 Aug 2010 15:57:09 -0300
Message-ID: <AANLkTi=zGHmLy0y1FdJvDY7-4=_OFt0Vs0O6CC-osPYW@mail.gmail.com>
In-Reply-To: <1282932890.6841.79.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8529561601607351712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>> I understand. I mixed up two problems and that got confusing. The ZTE
>> modem is not showing the race condition issue. It didn't showed up
>> when I called list-modems. That is why I tested it with other
>> software, just to be sure it works with linux (MeeGo in this case). I
>> will test again with the ZTE modem and send the logs to the list.
>
> my ZTE modem works, but you need the latest oFono and its udev rules to
> make it detect.

I'm using ofono from git (last commit from yesterday) and the udev
rules are installed and loaded. The ZTE is a MF110.

When I plug the device, I need to call eject /dev/sr0, only after that
it is recognized correctly. After that, the following appears on ofono
log:

ofonod[1632]: src/modem.c:ofono_modem_create() name: P671A2VIVD010000, type=
: zte
ofonod[1632]: src/modem.c:set_modem_property() modem 0x87ca1b0 property Path
ofonod[1632]: src/modem.c:set_modem_property() modem 0x87ca1b0
property Registered
ofonod[1632]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.0/ttyUSB0/tty/ttyUSB0
(zte)
ofonod[1632]: plugins/udev.c:add_zte() modem 0x87ca1b0
ofonod[1632]: src/modem.c:get_modem_property() modem 0x87ca1b0
property ModemRegistered
ofonod[1632]: src/modem.c:get_modem_property() modem 0x87ca1b0
property AuxRegistered
ofonod[1632]: src/modem.c:get_modem_property() modem 0x87ca1b0 property Path
ofonod[1632]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.3/ttyUSB2/tty/ttyUSB2
(zte)
ofonod[1632]: plugins/udev.c:add_zte() modem 0x87ca1b0
ofonod[1632]: src/modem.c:get_modem_property() modem 0x87ca1b0
property ModemRegistered
ofonod[1632]: src/modem.c:get_modem_property() modem 0x87ca1b0
property AuxRegistered
ofonod[1632]: src/modem.c:get_modem_property() modem 0x87ca1b0 property Path
ofonod[1632]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.1/ttyUSB1/tty/ttyUSB1
(zte)
ofonod[1632]: plugins/udev.c:add_zte() modem 0x87ca1b0
ofonod[1632]: src/modem.c:get_modem_property() modem 0x87ca1b0
property ModemRegistered
ofonod[1632]: src/modem.c:get_modem_property() modem 0x87ca1b0
property AuxRegistered

After that, if I run list-modems nothing happens.

I don't know if it is related, but I'm getting lots of error messages
from option driver:

option: option_instat_callback: error -2

They appear as soon as the modem is detected (after eject /dev/sr0).

Regards,
Thiago

--===============8529561601607351712==--

