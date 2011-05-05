Content-Type: multipart/mixed; boundary="===============8950761600321883304=="
MIME-Version: 1.0
From: Alexander Khryukin <alexander@mezon.ru>
Subject: ofono modem plug loop
Date: Thu, 05 May 2011 16:55:33 +0400
Message-ID: <BANLkTikRHqy0gYWhQeqzXG5zLZaC5p-epw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8950761600321883304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

BUILD IMAGE: any image with ofono 0.36 - latest or git ofono

HARDWARE MODEL: HUAWEI E620, HUAWEI E1550

BUG DETAILED DESCRIPTIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
When E1550 plugged ofono succefful work with udev rules and start modem.
But everytime ofono drops in remove_modem, add_modem loop

log herehttp://pastie.org/1867821

ofonod[5983]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.1/ttyUSB1/tty/ttyUSB1 (huaw=
ei)
ofonod[5983]: plugins/udev.c:add_huawei() modem 0x995c260
......
......
plugins/udev.c:remove_modem()
/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.0/ttyUSB0/tty/ttyUSB0

Again and again



EXACT STEPS LEADING TO PROBLEM:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
1.meego any build
2.any version of ofono
3./usr/sbin/ofono -n -d
4.plug modem

EXPECTED OUTCOME:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Modem must not reconnect loop

ACTUAL OUTCOME:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Modem in add\remove loop

--===============8950761600321883304==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHByZSBjbGFzcz0iYnpfY29tbWVudF90ZXh0IiBpZD0iY29tbWVudF90ZXh0XzAiPkJVSUxEIElN
QUdFOiBhbnkgaW1hZ2Ugd2l0aCBvZm9ubyAwLjM2IC0gbGF0ZXN0IG9yIGdpdCBvZm9ubyAgICAg
IAoKSEFSRFdBUkUgTU9ERUw6IEhVQVdFSSBFNjIwLCBIVUFXRUkgRTE1NTAKCkJVRyBERVRBSUxF
RCBERVNDUklQVElPTlMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KV2hlbiBFMTU1MCBwbHVnZ2VkIG9mb25vIHN1Y2NlZmZ1bCB3b3Jr
IHdpdGggdWRldiBydWxlcyBhbmQgc3RhcnQgbW9kZW0uCkJ1dCBldmVyeXRpbWUgb2Zvbm8gZHJv
cHMgaW4gcmVtb3ZlX21vZGVtLCBhZGRfbW9kZW0gbG9vcAoKbG9nIGhlcmUKPGEgaHJlZj0iaHR0
cDovL3Bhc3RpZS5vcmcvMTg2NzgyMSI+aHR0cDovL3Bhc3RpZS5vcmcvMTg2NzgyMTwvYT4KCm9m
b25vZFs1OTgzXTogcGx1Z2lucy91ZGV2LmM6YWRkX21vZGVtKCkKL2RldmljZXMvcGNpMDAwMDow
MC8wMDAwOjAwOjFkLjcvdXNiMS8xLTEvMS0xOjEuMS90dHlVU0IxL3R0eS90dHlVU0IxIChodWF3
ZWkpCm9mb25vZFs1OTgzXTogcGx1Z2lucy91ZGV2LmM6YWRkX2h1YXdlaSgpIG1vZGVtIDB4OTk1
YzI2MAouLi4uLi4KLi4uLi4uCnBsdWdpbnMvdWRldi5jOnJlbW92ZV9tb2RlbSgpCi9kZXZpY2Vz
L3BjaTAwMDA6MDAvMDAwMDowMDoxZC43L3VzYjEvMS0xLzEtMToxLjAvdHR5VVNCMC90dHkvdHR5
VVNCMAoKQWdhaW4gYW5kIGFnYWluCgoKCkVYQUNUIFNURVBTIExFQURJTkcgVE8gUFJPQkxFTToK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KMS5tZWVnbyBhbnkgYnVpbGQKMi5hbnkgdmVyc2lvbiBvZiBvZm9ubwozLi91c3Ivc2Jpbi9v
Zm9ubyAtbiAtZAo0LnBsdWcgbW9kZW0gCgpFWFBFQ1RFRCBPVVRDT01FOgo9PT09PT09PT09PT09
PT09PT09Ck1vZGVtIG11c3Qgbm90IHJlY29ubmVjdCBsb29wCgpBQ1RVQUwgT1VUQ09NRToKPT09
PT09PT09PT09PT09PT09PQpNb2RlbSBpbiBhZGRccmVtb3ZlIGxvb3AgICAgICAgIDwvcHJlPgo=

--===============8950761600321883304==--

