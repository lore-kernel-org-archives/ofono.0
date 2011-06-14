Content-Type: multipart/mixed; boundary="===============4355441652392255471=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Caif protocol not working properly in Ofono-0.49 version
Date: Tue, 14 Jun 2011 10:42:41 +0530
Message-ID: <BANLkTinnFzz6VvTRa-rqUNp2n_J9QYYn=w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4355441652392255471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

When tried to enable st ericsson modem with ofono version 0.49.

Always it is giving time out error, while enabling the modem.

Please refer below log messages:

*Ofono Logs:*

ofonod[12846]: src/modem.c:get_modem_property() modem 0x99d4048 property
Device
ofonod[12846]: src/modem.c:get_modem_property() modem 0x99d4048 property
Interface
ofonod[12846]: plugins/ste.c:ste_create_channel() 0x99d4048
ofonod[12846]: src/modem.c:get_modem_property() modem 0x99d4048 property
Device
ofonod[12846]: src/modem.c:get_modem_property() modem 0x99d4048 property
Interface
ofonod[12846]: plugins/ste.c:ste_create_channel() 0x99d4048
ofonod[12846]: src/modem.c:get_modem_property() modem 0x99d4048 property
Device
ofonod[12846]: src/modem.c:get_modem_property() modem 0x99d4048 property
Interface
ofonod[12846]: plugins/ste.c:ste_create_channel() 0x99d4048
ofonod[12846]: src/modem.c:get_modem_property() modem 0x99d4048 property
Device
ofonod[12846]: src/modem.c:get_modem_property() modem 0x99d4048 property
Interface
ofonod[12846]: plugins/ste.c:cfun_enable()
ofonod[12846]: plugins/ste.c:handle_sim_state() ok:0
ofonod[12846]: src/modem.c:set_powered_timeout() modem: 0x99d4048

*Dmesg*:

[ 3789.085030] cfttyUSB1: Features changed: 0x00004800 -> 0x00004000
[ 3789.086752] cfttyUSB1: register
[ 3794.638634] cfttyUSB1: up
[ 3814.498886] caif:cfmuxl_receive(): Received data on unknown link ID =3D 1
(0x1) up =3D=3D NULL
[ 3814.511892] caif:cfmuxl_receive(): Received data on unknown link ID =3D 2
(0x2) up =3D=3D NULL
[ 3814.520057] caif:cfmuxl_receive(): Received data on unknown link ID =3D 3
(0x3) up =3D=3D NULL
[ 3814.525892] caif:cfmuxl_receive(): Received data on unknown link ID =3D 4
(0x4) up =3D=3D NULL
[ 3814.532898] caif:cfmuxl_receive(): Received data on unknown link ID =3D 5
(0x5) up =3D=3D NULL
[ 3814.539890] caif:cfmuxl_receive(): Received data on unknown link ID =3D 6
(0x6) up =3D=3D NULL
[ 3919.926922] caif:cfmuxl_receive(): Received data on unknown link ID =3D 1
(0x1) up =3D=3D NULL
[ 3919.932930] caif:cfmuxl_receive(): Received data on unknown link ID =3D 2
(0x2) up =3D=3D NULL
[ 3919.939929] caif:cfmuxl_receive(): Received data on unknown link ID =3D 3
(0x3) up =3D=3D NULL
[ 3919.946932] caif:cfmuxl_receive(): Received data on unknown link ID =3D 4
(0x4) up =3D=3D NULL
[ 3919.953928] caif:cfmuxl_receive(): Received data on unknown link ID =3D 5
(0x5) up =3D=3D NULL
[ 3919.960930] caif:cfmuxl_receive(): Received data on unknown link ID =3D 6
(0x6) up =3D=3D NULL


*I have loaded caif related modules*

#lsmod | grep caif
caif_socket             9317  12
caif                   44312  2 chnl_net,caif_socket
crc_ccitt               1359  1 caif
caif_serial             4289  1


Please help how do i fix these issue?


Thanks

Yuvaraj R

--===============4355441652392255471==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPkhpLDxicj48YnI+V2hlbiB0cmllZCB0byBlbmFibGUgc3QgZXJpY3Nzb24gbW9kZW0gd2l0
aCBvZm9ubyB2ZXJzaW9uIDAuNDkuPGJyPjxicj5BbHdheXMgaXQgaXMgZ2l2aW5nIHRpbWUgb3V0
IGVycm9yLCB3aGlsZSBlbmFibGluZyB0aGUgbW9kZW0uPGJyPjxicj5QbGVhc2UgcmVmZXIgYmVs
b3cgbG9nIG1lc3NhZ2VzOjxicj48YnI+PGI+T2Zvbm8gTG9nczo8L2I+PGJyPjxicj5vZm9ub2Rb
MTI4NDZdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk5ZDQwNDgg
cHJvcGVydHkgRGV2aWNlPGJyPgpvZm9ub2RbMTI4NDZdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1f
cHJvcGVydHkoKSBtb2RlbSAweDk5ZDQwNDggcHJvcGVydHkgSW50ZXJmYWNlPGJyPm9mb25vZFsx
Mjg0Nl06IHBsdWdpbnMvc3RlLmM6c3RlX2NyZWF0ZV9jaGFubmVsKCkgMHg5OWQ0MDQ4PGJyPm9m
b25vZFsxMjg0Nl06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OTlk
NDA0OCBwcm9wZXJ0eSBEZXZpY2U8YnI+Cm9mb25vZFsxMjg0Nl06IHNyYy9tb2RlbS5jOmdldF9t
b2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OTlkNDA0OCBwcm9wZXJ0eSBJbnRlcmZhY2U8YnI+b2Zv
bm9kWzEyODQ2XTogcGx1Z2lucy9zdGUuYzpzdGVfY3JlYXRlX2NoYW5uZWwoKSAweDk5ZDQwNDg8
YnI+b2Zvbm9kWzEyODQ2XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0g
MHg5OWQ0MDQ4IHByb3BlcnR5IERldmljZTxicj4Kb2Zvbm9kWzEyODQ2XTogc3JjL21vZGVtLmM6
Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5OWQ0MDQ4IHByb3BlcnR5IEludGVyZmFjZTxi
cj5vZm9ub2RbMTI4NDZdOiBwbHVnaW5zL3N0ZS5jOnN0ZV9jcmVhdGVfY2hhbm5lbCgpIDB4OTlk
NDA0ODxicj5vZm9ub2RbMTI4NDZdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBt
b2RlbSAweDk5ZDQwNDggcHJvcGVydHkgRGV2aWNlPGJyPgpvZm9ub2RbMTI4NDZdOiBzcmMvbW9k
ZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk5ZDQwNDggcHJvcGVydHkgSW50ZXJm
YWNlPGJyPm9mb25vZFsxMjg0Nl06IHBsdWdpbnMvc3RlLmM6Y2Z1bl9lbmFibGUoKSA8YnI+b2Zv
bm9kWzEyODQ2XTogcGx1Z2lucy9zdGUuYzpoYW5kbGVfc2ltX3N0YXRlKCkgb2s6MDxicj5vZm9u
b2RbMTI4NDZdOiBzcmMvbW9kZW0uYzpzZXRfcG93ZXJlZF90aW1lb3V0KCkgbW9kZW06IDB4OTlk
NDA0ODxicj4KPGJyPjxiPkRtZXNnPC9iPjo8YnI+PGJyPlsgMzc4OS4wODUwMzBdIGNmdHR5VVNC
MTogRmVhdHVyZXMgY2hhbmdlZDogMHgwMDAwNDgwMCAtJmd0OyAweDAwMDA0MDAwPGJyPlsgMzc4
OS4wODY3NTJdIGNmdHR5VVNCMTogcmVnaXN0ZXI8YnI+WyAzNzk0LjYzODYzNF0gY2Z0dHlVU0Ix
OiB1cDxicj5bIDM4MTQuNDk4ODg2XSBjYWlmOmNmbXV4bF9yZWNlaXZlKCk6IFJlY2VpdmVkIGRh
dGEgb24gdW5rbm93biBsaW5rIElEID0gMSAoMHgxKSB1cCA9PSBOVUxMPGJyPgpbIDM4MTQuNTEx
ODkyXSBjYWlmOmNmbXV4bF9yZWNlaXZlKCk6IFJlY2VpdmVkIGRhdGEgb24gdW5rbm93biBsaW5r
IElEID0gMiAoMHgyKSB1cCA9PSBOVUxMPGJyPlsgMzgxNC41MjAwNTddIGNhaWY6Y2ZtdXhsX3Jl
Y2VpdmUoKTogUmVjZWl2ZWQgZGF0YSBvbiB1bmtub3duIGxpbmsgSUQgPSAzICgweDMpIHVwID09
IE5VTEw8YnI+WyAzODE0LjUyNTg5Ml0gY2FpZjpjZm11eGxfcmVjZWl2ZSgpOiBSZWNlaXZlZCBk
YXRhIG9uIHVua25vd24gbGluayBJRCA9IDQgKDB4NCkgdXAgPT0gTlVMTDxicj4KWyAzODE0LjUz
Mjg5OF0gY2FpZjpjZm11eGxfcmVjZWl2ZSgpOiBSZWNlaXZlZCBkYXRhIG9uIHVua25vd24gbGlu
ayBJRCA9IDUgKDB4NSkgdXAgPT0gTlVMTDxicj5bIDM4MTQuNTM5ODkwXSBjYWlmOmNmbXV4bF9y
ZWNlaXZlKCk6IFJlY2VpdmVkIGRhdGEgb24gdW5rbm93biBsaW5rIElEID0gNiAoMHg2KSB1cCA9
PSBOVUxMPGJyPlsgMzkxOS45MjY5MjJdIGNhaWY6Y2ZtdXhsX3JlY2VpdmUoKTogUmVjZWl2ZWQg
ZGF0YSBvbiB1bmtub3duIGxpbmsgSUQgPSAxICgweDEpIHVwID09IE5VTEw8YnI+ClsgMzkxOS45
MzI5MzBdIGNhaWY6Y2ZtdXhsX3JlY2VpdmUoKTogUmVjZWl2ZWQgZGF0YSBvbiB1bmtub3duIGxp
bmsgSUQgPSAyICgweDIpIHVwID09IE5VTEw8YnI+WyAzOTE5LjkzOTkyOV0gY2FpZjpjZm11eGxf
cmVjZWl2ZSgpOiBSZWNlaXZlZCBkYXRhIG9uIHVua25vd24gbGluayBJRCA9IDMgKDB4MykgdXAg
PT0gTlVMTDxicj5bIDM5MTkuOTQ2OTMyXSBjYWlmOmNmbXV4bF9yZWNlaXZlKCk6IFJlY2VpdmVk
IGRhdGEgb24gdW5rbm93biBsaW5rIElEID0gNCAoMHg0KSB1cCA9PSBOVUxMPGJyPgpbIDM5MTku
OTUzOTI4XSBjYWlmOmNmbXV4bF9yZWNlaXZlKCk6IFJlY2VpdmVkIGRhdGEgb24gdW5rbm93biBs
aW5rIElEID0gNSAoMHg1KSB1cCA9PSBOVUxMPGJyPlsgMzkxOS45NjA5MzBdIGNhaWY6Y2ZtdXhs
X3JlY2VpdmUoKTogUmVjZWl2ZWQgZGF0YSBvbiB1bmtub3duIGxpbmsgSUQgPSA2ICgweDYpIHVw
ID09IE5VTEw8YnI+PGJyPjxicj48Yj5JIGhhdmUgbG9hZGVkIGNhaWYgcmVsYXRlZCBtb2R1bGVz
PC9iPjxicj4KPGJyPiNsc21vZCB8IGdyZXAgY2FpZjxicj5jYWlmX3NvY2tldKCgoKCgoKCgoKCg
oCA5MzE3oCAxMiA8YnI+Y2FpZqCgoKCgoKCgoKCgoKCgoKCgoCA0NDMxMqAgMiBjaG5sX25ldCxj
YWlmX3NvY2tldDxicj5jcmNfY2NpdHSgoKCgoKCgoKCgoKCgoCAxMzU5oCAxIGNhaWY8YnI+Y2Fp
Zl9zZXJpYWygoKCgoKCgoKCgoKAgNDI4OaAgMSA8YnI+PGJyPjxicj5QbGVhc2UgaGVscCBob3cg
ZG8gaSBmaXggdGhlc2UgaXNzdWU/PGJyPgo8YnI+PGJyPlRoYW5rczxicj48YnI+WXV2YXJhaiBS
PGJyPgo=

--===============4355441652392255471==--

