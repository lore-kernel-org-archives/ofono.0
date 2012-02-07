Content-Type: multipart/mixed; boundary="===============8451238453012835460=="
MIME-Version: 1.0
From: nicolas.bertrand <nicolas.bertrand@linux.intel.com>
Subject: Re: setup ofono for telit h910 on embedded system
Date: Tue, 07 Feb 2012 18:34:17 +0100
Message-ID: <4F316099.8090005@linux.intel.com>
In-Reply-To: <op.v83xfep0yxxkfz@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8451238453012835460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Jan,

On 02/03/2012 03:34 PM, Jan Pohanka wrote:
> Hello,
>
> I'm working on embedded system with dm365 processor (arm926ej-s) and I
> want to use ofono with a Telit h910 modem connected by usb. The module
> works, I can make a calls using AT commands on /dev/ttyACM3 (or ttyS1),
> but I'm not able to register it with ofono.
>
> I have added following line to /lib/udev/rules.d/ofono.rules
> KERNEL=3D=3D"ttyACM3", ENV{OFONO_DRIVER}=3D"telit" (I have tried atgen al=
so)
>
> After enabling the modem I'm getting following debug messages...
> ofonod[133]: plugins/udevng.c:udev_start()
> ofonod[133]: plugins/udevng.c:enumerate_devices()
> ofonod[133]: plugins/udevng.c:check_usb_device() MOSCHIP usb-ethernet
> driver [9710:7830]
> usb 1-1.3: new high speed USB device using musb_hdrc and address 5
> usb 1-1.3: config 1 interface 0 altsetting 0 endpoint 0x81 has an
> invalid bInterval 255, changing t
> o 11
> usb 1-1.3: New USB device found, idVendor=3D058b, idProduct=3D0041
> usb 1-1.3: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
> usb 1-1.3: configuration #1 chosen from 1 choice
> usb 1-1.3: USB disconnect, address 5
> usb 1-1.3: new high speed USB device using musb_hdrc and address 6
> usb 1-1.3: New USB device found, idVendor=3D1bc7, idProduct=3D0021
> usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
> usb 1-1.3: Product: Telit Wireless Module
> usb 1-1.3: Manufacturer: Telit wireless solutions
> usb 1-1.3: SerialNumber: 357164040028220
> usb 1-1.3: configuration #1 chosen from 1 choice
> cdc_acm 1-1.3:1.0: This device cannot do calls on its own. It is not a
> modem.
> cdc_acm 1-1.3:1.0: ttyACM0: USB ACM device
> cdc_acm 1-1.3:1.2: This device cannot do calls on its own. It is not a
> modem.
> cdc_acm 1-1.3:1.2: ttyACM1: USB ACM device
> cdc_acm 1-1.3:1.4: This device cannot do calls on its own. It is not a
> modem.
> cdc_acm 1-1.3:1.4: ttyACM2: USB ACM device
> cdc_acm 1-1.3:1.6: This device cannot do calls on its own. It is not a
> modem.
> cdc_acm 1-1.3:1.6: ttyACM3: USB ACM device
> cdc_acm 1-1.3:1.8: This device cannot do calls on its own. It is not a
> modem.
> cdc_acm 1-1.3:1.8: ttyACM4: USB ACM device
> cdc_acm 1-1.3:1.10: This device cannot do calls on its own. It is not a
> modem.
> cdc_acm 1-1.3:1.10: ttyACM5: USB ACM device
> cdc_acm 1-1.3:1.12: This device cannot do calls on its own. It is not a
> modem.
> cdc_acm 1-1.3:1.12: ttyACM6: USB ACM device
> ofonod[133]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[133]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[133]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[133]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[133]: src/modem.c:ofono_modem_create() name: (null), type: atgen
> ofonod[133]: src/modem.c:set_modem_property() modem 0xeebb0 property Path
> ofonod[133]: plugins/udev.c:add_modem()
> /devices/platform/musb_hdrc/usb1/1-1/1-1.3/1-1.3:1.6/tty/ttyACM3 (atgen)
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[133]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[133]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[133]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[133]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[133]: plugins/udevng.c:check_modem_list()
>
>
> Unfortunately list-modems command still return nothing.
> Could please anybody here give me some advice how to solve the problem?
>
> best regards
> Jan
>
>

What is your version of ofono?

The log is not complete and so we can't see this information.

Some features about telit devices have been implemented recently, using =

a ofono version >=3D 1.1 should be better and then you won't need =

ofono.rules anymore , it's a deprecated file.

-- =

regards,
Nico

--===============8451238453012835460==--

