Content-Type: multipart/mixed; boundary="===============4106089681911668001=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] huawei: cleanup sim polling when the modem is removed.
Date: Wed, 03 Aug 2011 12:02:07 +0200
Message-ID: <1312365728.3373.8.camel@aeonflux>
In-Reply-To: <1312365045.3373.4.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4106089681911668001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> We call disable before we call remove, but the only thing that I have
> not checked is what happens to this if we have not succeeded with enable
> yet. So if I remember this right, then disable is always called (even if
> enable has not yet called set_powered), but I need Denis to confirm
> this.

seems we are not calling disable if set_powered has not been called yet.

ofonod[13972]: plugins/huawei.c:huawei_enable() 0x10cfef0
ofonod[13972]: src/modem.c:get_modem_property() modem 0x10cfef0 property Mo=
dem
ofonod[13972]: plugins/huawei.c:open_device() Modem /dev/ttyUSB3
ofonod[13972]: src/modem.c:get_modem_property() modem 0x10cfef0 property Pc=
ui
ofonod[13972]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB5
ofonod[13972]: Modem: > ATE0 +CMEE=3D1\r
ofonod[13972]: PCUI: > ATE0 +CMEE=3D1\r
ofonod[13972]: PCUI: < ATE0 +CMEE=3D1\r\r\nOK\r\n
ofonod[13972]: PCUI: > AT+CFUN=3D?\r
ofonod[13972]: Modem: < \r\nOK\r\n
ofonod[13972]: PCUI: < \r\n+CFUN: (0-1,4-7),(0-1)\r\n\r\nOK\r\n
ofonod[13972]: PCUI: > AT+CFUN=3D1\r
ofonod[13972]: PCUI: < \r\nOK\r\n
ofonod[13972]: plugins/huawei.c:cfun_enable() =

ofonod[13972]: PCUI: > AT^SYSINFO\r
ofonod[13972]: PCUI: < \r\n^SYSINFO:2,3,0,3,1,,3\r\n\r\nOK\r\n
ofonod[13972]: plugins/huawei.c:sysinfo_enable_cb() 255 -> 1
ofonod[13972]: Modem: > AT&C0\r
ofonod[13972]: PCUI: > AT&C0\r
ofonod[13972]: PCUI: < \r\nOK\r\n
ofonod[13972]: Modem: < \r\nOK\r\n
ofonod[13972]: PCUI: > AT^CVOICE=3D?\r
ofonod[13972]: PCUI: < \r\n^CVOICE:(1)\r\n\r\nOK\r\n
ofonod[13972]: PCUI: > AT+CFUN=3D7\r
ofonod[13972]: plugins/udev.c:udev_event() subsystem net remove
ofonod[13972]: plugins/udev.c:remove_modem() /devices/pci0000:00/0000:00:1a=
.0/usb1/1-1/1-1.1/1-1.1:1.1/net/wwan0
ofonod[13972]: src/modem.c:get_modem_property() modem 0x10cfef0 property Pa=
th
ofonod[13972]: src/modem.c:ofono_modem_remove() 0x10cfef0
ofonod[13972]: src/modem.c:modem_unregister() 0x10cfef0
ofonod[13972]: plugins/huawei.c:huawei_remove() 0x10cfef0

I unplugged the dongle during the enable phase. So now I am asking
myself if we might wanna have some sort of abort_enable callback?
Anyway, I check up with Denis on this one.

Regards

Marcel



--===============4106089681911668001==--

