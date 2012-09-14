Content-Type: multipart/mixed; boundary="===============4295901883943013268=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Huawei E1552 powered timeout
Date: Fri, 14 Sep 2012 11:22:30 +0200
Message-ID: <CABvLYuBwroDooDd2CW_qrxJ9acxWoPB=pHcZLj3n6-kdk4zRTQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4295901883943013268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

sometimes when i try to set the "Powered" property for a Huawei E1552,
it times out.
In huawei_enable() "ATE0 +CMEE=3D1" is sent to the modem and the pcui
port. It looks like the device doesn't always send a response on both
ports.
I think this device has problems handling AT commands on both ports at
the same time.

Could there be a compatibility problem with other Huawei devices, if
these AT commands are only sent on one port?

ofonod[9065]: plugins/huawei.c:huawei_enable() 0x98e95b0
ofonod[9065]: src/modem.c:get_modem_property() modem 0x98e95b0 property Mod=
em
ofonod[9065]: plugins/huawei.c:open_device() Modem /dev/ttyUSB0
ofonod[9065]: src/modem.c:get_modem_property() modem 0x98e95b0 property Pcui
ofonod[9065]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB2
ofonod[9065]: Modem: > ATE0 +CMEE=3D1\r
ofonod[9065]: PCUI: > ATE0 +CMEE=3D1\r
ofonod[9065]: PCUI: < \r\nOK\r\n
ofonod[9065]: PCUI: > ATI\r
ofonod[9065]: src/modem.c:set_powered_timeout() modem: 0x98e95b0

Thanks,
Cedric

--===============4295901883943013268==--

