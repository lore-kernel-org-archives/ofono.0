Content-Type: multipart/mixed; boundary="===============6955881591981496250=="
MIME-Version: 1.0
From: =?unknown-8bit?b?6buE5Y+26Z2S?= <hyqzyf@163.com>
Subject: ppp problem
Date: Mon, 24 Jan 2011 15:55:56 +0800
Message-ID: <a08dc9.a078.12db705a4b0.Coremail.hyqzyf@163.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6955881591981496250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I have got a problem about 3G connectrion from ofono, does anyone have idea=
 to resolve it?
The  modem ishuawei EM560.

Here is the log:

ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property Path
ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property Regi=
stered
ofonod[940]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:00.7/us=
b1/1-1/1-1.2/1-1.2:2.1/tty/ttyACM0 (huawei)
ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property Mode=
mRegistered
ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property Pcui=
Registered
ofonod[940]: plugins/udev.c:add_huawei() add_huaweiingggggggggg by hyq
ofonod[940]: plugins/udev.c:add_huawei() name =3DOFONO_HUAWEI_TYPE by hyq
ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property Modem
ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property Mode=
mRegistered
ofonod[940]: plugins/udev.c:add_huawei() after ofono_modem_register by hyq =
ppp=3D1 pcui=3D0
ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property Path
ofonod[940]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:00.7/us=
b1/1-1/1-1.2/1-1.2:2.3/tty/ttyACM1 (huawei)
ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property Mode=
mRegistered
ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property Pcui=
Registered
ofonod[940]: plugins/udev.c:add_huawei() add_huaweiingggggggggg by hyq
ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property HasV=
oice
ofonod[940]: plugins/udev.c:add_huawei() after ofono_modem_register by hyq =
ppp=3D1 pcui=3D0
ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property Path
ofonod[940]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:00.7/us=
b1/1-1/1-1.2/1-1.2:2.7/tty/ttyACM2 (huawei)
ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property Mode=
mRegistered
ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property Pcui=
Registered
ofonod[940]: plugins/udev.c:add_huawei() name =3DOFONO_HUAWEI_TYPE by hyq
ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property Pcui
ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property Pcui=
Registered

[root(a)localhost test]# ./activate-context
Entering new phase: 1
Entering new phase: 3
Entering new phase: 4
ofonod[815]: drivers/atmodem/gprs-context.c:ppp_connect()
ofonod[815]: IP: 0.0.0.0
ofonod[815]: DNS: 0.0.0.0, 0.0.0.0
ofonod[815]: src/gprs.c:pri_activate_callback() 0xa063660 ppp0

[root(a)localhost test]# ./list-contexts
[ /huawei0 ]
    [ /huawei0/primarycontext1 ]
        Username =3D tee
        Protocol =3D ip
        Name =3D 3G Connection
        Settings =3D { Interface=3Dppp0 Netmask=3D255.255.255.255 Method=3D=
static DomainNameServers=3D0.0.0.0,0.0.0.0, Address=3D0.0.0.0 }
        Active =3D 1
        AccessPointName =3D cmwap
        Password =3D tee
        Type =3D internet

 I just cant get the the DNS and address. Does anyone have any idea ?

Thanks!






--===============6955881591981496250==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGZvbnQgY29sb3I9IiMwMDAwZmYiPkhpLCA8YnI+SSBoYXZlIGdvdCBhIHByb2JsZW0gYWJvdXQg
M0cgY29ubmVjdHJpb24gZnJvbSBvZm9ubywgZG9lcyBhbnlvbmUgaGF2ZSBpZGVhIHRvIHJlc29s
dmUgaXQ/IDxicj5UaGUmbmJzcDsgbW9kZW0gaXMgIDxmb250IGNvbG9yPSIjZmYwMGZmIj5odWF3
ZWkgRU01NjAuPC9mb250PiA8YnI+PGJyPkhlcmUgaXMgdGhlIGxvZzo8L2ZvbnQ+PGJyPjxicj48
Zm9udCBjb2xvcj0iIzAwODA4MCI+b2Zvbm9kWzk0MF06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9w
cm9wZXJ0eSgpIG1vZGVtIDB4OGQ0OTA1OCBwcm9wZXJ0eSBQYXRoPGJyPm9mb25vZFs5NDBdOiBz
cmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDhkNDkwNTggcHJvcGVydHkg
UmVnaXN0ZXJlZDxicj5vZm9ub2RbOTQwXTogcGx1Z2lucy91ZGV2LmM6YWRkX21vZGVtKCkgL2Rl
dmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjAwLjcvdXNiMS8xLTEvMS0xLjIvMS0xLjI6Mi4xL3R0
eS90dHlBQ00wIChodWF3ZWkpPGJyPm9mb25vZFs5NDBdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1f
cHJvcGVydHkoKSBtb2RlbSAweDhkNDkwNTggcHJvcGVydHkgTW9kZW1SZWdpc3RlcmVkPGJyPm9m
b25vZFs5NDBdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDhkNDkw
NTggcHJvcGVydHkgUGN1aVJlZ2lzdGVyZWQ8YnI+b2Zvbm9kWzk0MF06IHBsdWdpbnMvdWRldi5j
OmFkZF9odWF3ZWkoKSBhZGRfaHVhd2VpaW5nZ2dnZ2dnZ2dnIGJ5IGh5cTxicj5vZm9ub2RbOTQw
XTogcGx1Z2lucy91ZGV2LmM6YWRkX2h1YXdlaSgpIG5hbWUgPU9GT05PX0hVQVdFSV9UWVBFIGJ5
IGh5cTxicj5vZm9ub2RbOTQwXTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9k
ZW0gMHg4ZDQ5MDU4IHByb3BlcnR5IE1vZGVtPGJyPm9mb25vZFs5NDBdOiBzcmMvbW9kZW0uYzpz
ZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDhkNDkwNTggcHJvcGVydHkgTW9kZW1SZWdpc3Rl
cmVkPGJyPm9mb25vZFs5NDBdOiBwbHVnaW5zL3VkZXYuYzphZGRfaHVhd2VpKCkgYWZ0ZXIgb2Zv
bm9fbW9kZW1fcmVnaXN0ZXIgYnkgaHlxIHBwcD0xIHBjdWk9MDxicj5vZm9ub2RbOTQwXTogc3Jj
L21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4ZDQ5MDU4IHByb3BlcnR5IFBh
dGg8YnI+b2Zvbm9kWzk0MF06IHBsdWdpbnMvdWRldi5jOmFkZF9tb2RlbSgpIC9kZXZpY2VzL3Bj
aTAwMDA6MDAvMDAwMDowMDowMC43L3VzYjEvMS0xLzEtMS4yLzEtMS4yOjIuMy90dHkvdHR5QUNN
MSAoaHVhd2VpKTxicj5vZm9ub2RbOTQwXTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5
KCkgbW9kZW0gMHg4ZDQ5MDU4IHByb3BlcnR5IE1vZGVtUmVnaXN0ZXJlZDxicj5vZm9ub2RbOTQw
XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4ZDQ5MDU4IHByb3Bl
cnR5IFBjdWlSZWdpc3RlcmVkPGJyPm9mb25vZFs5NDBdOiBwbHVnaW5zL3VkZXYuYzphZGRfaHVh
d2VpKCkgYWRkX2h1YXdlaWluZ2dnZ2dnZ2dnZyBieSBoeXE8YnI+b2Zvbm9kWzk0MF06IHNyYy9t
b2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQ0OTA1OCBwcm9wZXJ0eSBIYXNW
b2ljZTxicj5vZm9ub2RbOTQwXTogcGx1Z2lucy91ZGV2LmM6YWRkX2h1YXdlaSgpIGFmdGVyIG9m
b25vX21vZGVtX3JlZ2lzdGVyIGJ5IGh5cSBwcHA9MSBwY3VpPTA8YnI+b2Zvbm9kWzk0MF06IHNy
Yy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQ0OTA1OCBwcm9wZXJ0eSBQ
YXRoPGJyPm9mb25vZFs5NDBdOiBwbHVnaW5zL3VkZXYuYzphZGRfbW9kZW0oKSAvZGV2aWNlcy9w
Y2kwMDAwOjAwLzAwMDA6MDA6MDAuNy91c2IxLzEtMS8xLTEuMi8xLTEuMjoyLjcvdHR5L3R0eUFD
TTIgKGh1YXdlaSk8YnI+b2Zvbm9kWzk0MF06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0
eSgpIG1vZGVtIDB4OGQ0OTA1OCBwcm9wZXJ0eSBNb2RlbVJlZ2lzdGVyZWQ8YnI+b2Zvbm9kWzk0
MF06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQ0OTA1OCBwcm9w
ZXJ0eSBQY3VpUmVnaXN0ZXJlZDxicj5vZm9ub2RbOTQwXTogcGx1Z2lucy91ZGV2LmM6YWRkX2h1
YXdlaSgpIG5hbWUgPU9GT05PX0hVQVdFSV9UWVBFIGJ5IGh5cTxicj5vZm9ub2RbOTQwXTogc3Jj
L21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4ZDQ5MDU4IHByb3BlcnR5IFBj
dWk8YnI+b2Zvbm9kWzk0MF06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVt
IDB4OGQ0OTA1OCBwcm9wZXJ0eSBQY3VpUmVnaXN0ZXJlZDxicj48YnI+PGZvbnQgY29sb3I9IiNm
ZjAwMDAiPltyb290QGxvY2FsaG9zdCB0ZXN0XSMgLi9hY3RpdmF0ZS1jb250ZXh0IDwvZm9udD48
YnI+RW50ZXJpbmcgbmV3IHBoYXNlOiAxPGJyPkVudGVyaW5nIG5ldyBwaGFzZTogMzxicj5FbnRl
cmluZyBuZXcgcGhhc2U6IDQ8YnI+b2Zvbm9kWzgxNV06IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNv
bnRleHQuYzpwcHBfY29ubmVjdCgpIDxicj5vZm9ub2RbODE1XTogSVA6IDAuMC4wLjA8YnI+b2Zv
bm9kWzgxNV06IEROUzogMC4wLjAuMCwgMC4wLjAuMDxicj5vZm9ub2RbODE1XTogc3JjL2dwcnMu
YzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSAweGEwNjM2NjAgcHBwMDxicj48YnI+PGZvbnQgY29s
b3I9IiNmZjAwMDAiPltyb290QGxvY2FsaG9zdCB0ZXN0XSMgLi9saXN0LWNvbnRleHRzIDwvZm9u
dD48YnI+WyAvaHVhd2VpMCBdPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBbIC9odWF3ZWkwL3ByaW1h
cnljb250ZXh0MSBdPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBVc2VybmFtZSA9IHRlZTxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgUHJvdG9jb2wgPSBpcDxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgTmFtZSA9IDNHIENvbm5lY3Rpb248YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IFNldHRpbmdzID0geyBJbnRlcmZhY2U9cHBwMCBOZXRtYXNrPTI1
NS4yNTUuMjU1LjI1NSBNZXRob2Q9c3RhdGljIERvbWFpbk5hbWVTZXJ2ZXJzPTAuMC4wLjAsMC4w
LjAuMCwgQWRkcmVzcz0wLjAuMC4wIH08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IEFjdGl2ZSA9IDE8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IEFjY2Vzc1BvaW50TmFtZSA9IGNtd2FwPGJyPiZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBQYXNzd29yZCA9IHRlZTxicj4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgVHlwZSA9IGludGVybmV0PGJyPjxicj48Zm9u
dCBjb2xvcj0iIzAwMDBmZiI+Jm5ic3A7SSBqdXN0IGNhbnQgZ2V0IHRoZSB0aGUgRE5TIGFuZCBh
ZGRyZXNzLiBEb2VzIGFueW9uZSBoYXZlIGFueSBpZGVhID88YnI+PGJyPlRoYW5rcyE8YnI+PGJy
PjwvZm9udD48L2ZvbnQ+PGJyPjxicj4gICAgICAgIAo8YnI+PGJyPjxzcGFuIHRpdGxlPSJuZXRl
YXNlZm9vdGVyIj48c3BhbiBpZD0ibmV0ZWFzZV9tYWlsX2Zvb3RlciI+PC9zcGFuPjwvc3Bhbj48
YnI+PGJyPjxzcGFuIHRpdGxlPSJuZXRlYXNlZm9vdGVyIj48c3BhbiBpZD0ibmV0ZWFzZV9tYWls
X2Zvb3RlciI+PC9zcGFuPjwvc3Bhbj4=
--===============6955881591981496250==--

