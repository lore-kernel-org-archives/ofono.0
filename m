Content-Type: multipart/mixed; boundary="===============7422250453464592848=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Fwd: Caif protocol not working properly in Ofono-0.49 version
Date: Wed, 15 Jun 2011 10:39:23 +0530
Message-ID: <BANLkTinaT26mO+wLWPvZYBvBQxpZRU0qtg@mail.gmail.com>
In-Reply-To: <BANLkTinnFzz6VvTRa-rqUNp2n_J9QYYn=w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7422250453464592848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I don't have any problem with older versions. Problem with latest version
0.49

Anybodies input is real help ful


Thanks

Yuvaraj R


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

--===============7422250453464592848==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPkhpLDxicj48YnI+SSBkb24mIzM5O3QgaGF2ZSBhbnkgcHJvYmxlbSB3aXRoIG9sZGVyIHZl
cnNpb25zLiBQcm9ibGVtIHdpdGggbGF0ZXN0IHZlcnNpb24gMC40OTxicj48YnI+QW55Ym9kaWVz
IGlucHV0IGlzIHJlYWwgaGVscCBmdWw8YnI+PGJyPjxicj5UaGFua3M8YnI+PGJyPll1dmFyYWog
Ujxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJyPjxicj5IaSw8YnI+PGJyPldoZW4gdHJp
ZWQgdG8gZW5hYmxlIHN0IGVyaWNzc29uIG1vZGVtIHdpdGggb2Zvbm8gdmVyc2lvbiAwLjQ5Ljxi
cj4KPGJyPkFsd2F5cyBpdCBpcyBnaXZpbmcgdGltZSBvdXQgZXJyb3IsIHdoaWxlIGVuYWJsaW5n
IHRoZSBtb2RlbS48YnI+PGJyPlBsZWFzZSByZWZlciBiZWxvdyBsb2cgbWVzc2FnZXM6PGJyPjxi
cj48Yj5PZm9ubyBMb2dzOjwvYj48YnI+PGJyPm9mb25vZFsxMjg0Nl06IHNyYy9tb2RlbS5jOmdl
dF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OTlkNDA0OCBwcm9wZXJ0eSBEZXZpY2U8YnI+Cgpv
Zm9ub2RbMTI4NDZdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk5
ZDQwNDggcHJvcGVydHkgSW50ZXJmYWNlPGJyPm9mb25vZFsxMjg0Nl06IHBsdWdpbnMvc3RlLmM6
c3RlX2NyZWF0ZV9jaGFubmVsKCkgMHg5OWQ0MDQ4PGJyPm9mb25vZFsxMjg0Nl06IHNyYy9tb2Rl
bS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OTlkNDA0OCBwcm9wZXJ0eSBEZXZpY2U8
YnI+CgpvZm9ub2RbMTI4NDZdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2Rl
bSAweDk5ZDQwNDggcHJvcGVydHkgSW50ZXJmYWNlPGJyPm9mb25vZFsxMjg0Nl06IHBsdWdpbnMv
c3RlLmM6c3RlX2NyZWF0ZV9jaGFubmVsKCkgMHg5OWQ0MDQ4PGJyPm9mb25vZFsxMjg0Nl06IHNy
Yy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OTlkNDA0OCBwcm9wZXJ0eSBE
ZXZpY2U8YnI+CgpvZm9ub2RbMTI4NDZdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHko
KSBtb2RlbSAweDk5ZDQwNDggcHJvcGVydHkgSW50ZXJmYWNlPGJyPm9mb25vZFsxMjg0Nl06IHBs
dWdpbnMvc3RlLmM6c3RlX2NyZWF0ZV9jaGFubmVsKCkgMHg5OWQ0MDQ4PGJyPm9mb25vZFsxMjg0
Nl06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OTlkNDA0OCBwcm9w
ZXJ0eSBEZXZpY2U8YnI+CgpvZm9ub2RbMTI4NDZdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJv
cGVydHkoKSBtb2RlbSAweDk5ZDQwNDggcHJvcGVydHkgSW50ZXJmYWNlPGJyPm9mb25vZFsxMjg0
Nl06IHBsdWdpbnMvc3RlLmM6Y2Z1bl9lbmFibGUoKSA8YnI+b2Zvbm9kWzEyODQ2XTogcGx1Z2lu
cy9zdGUuYzpoYW5kbGVfc2ltX3N0YXRlKCkgb2s6MDxicj5vZm9ub2RbMTI4NDZdOiBzcmMvbW9k
ZW0uYzpzZXRfcG93ZXJlZF90aW1lb3V0KCkgbW9kZW06IDB4OTlkNDA0ODxicj4KCjxicj48Yj5E
bWVzZzwvYj46PGJyPjxicj5bIDM3ODkuMDg1MDMwXSBjZnR0eVVTQjE6IEZlYXR1cmVzIGNoYW5n
ZWQ6IDB4MDAwMDQ4MDAgLSZndDsgMHgwMDAwNDAwMDxicj5bIDM3ODkuMDg2NzUyXSBjZnR0eVVT
QjE6IHJlZ2lzdGVyPGJyPlsgMzc5NC42Mzg2MzRdIGNmdHR5VVNCMTogdXA8YnI+WyAzODE0LjQ5
ODg4Nl0gY2FpZjpjZm11eGxfcmVjZWl2ZSgpOiBSZWNlaXZlZCBkYXRhIG9uIHVua25vd24gbGlu
ayBJRCA9IDEgKDB4MSkgdXAgPT0gTlVMTDxicj4KClsgMzgxNC41MTE4OTJdIGNhaWY6Y2ZtdXhs
X3JlY2VpdmUoKTogUmVjZWl2ZWQgZGF0YSBvbiB1bmtub3duIGxpbmsgSUQgPSAyICgweDIpIHVw
ID09IE5VTEw8YnI+WyAzODE0LjUyMDA1N10gY2FpZjpjZm11eGxfcmVjZWl2ZSgpOiBSZWNlaXZl
ZCBkYXRhIG9uIHVua25vd24gbGluayBJRCA9IDMgKDB4MykgdXAgPT0gTlVMTDxicj5bIDM4MTQu
NTI1ODkyXSBjYWlmOmNmbXV4bF9yZWNlaXZlKCk6IFJlY2VpdmVkIGRhdGEgb24gdW5rbm93biBs
aW5rIElEID0gNCAoMHg0KSB1cCA9PSBOVUxMPGJyPgoKWyAzODE0LjUzMjg5OF0gY2FpZjpjZm11
eGxfcmVjZWl2ZSgpOiBSZWNlaXZlZCBkYXRhIG9uIHVua25vd24gbGluayBJRCA9IDUgKDB4NSkg
dXAgPT0gTlVMTDxicj5bIDM4MTQuNTM5ODkwXSBjYWlmOmNmbXV4bF9yZWNlaXZlKCk6IFJlY2Vp
dmVkIGRhdGEgb24gdW5rbm93biBsaW5rIElEID0gNiAoMHg2KSB1cCA9PSBOVUxMPGJyPlsgMzkx
OS45MjY5MjJdIGNhaWY6Y2ZtdXhsX3JlY2VpdmUoKTogUmVjZWl2ZWQgZGF0YSBvbiB1bmtub3du
IGxpbmsgSUQgPSAxICgweDEpIHVwID09IE5VTEw8YnI+CgpbIDM5MTkuOTMyOTMwXSBjYWlmOmNm
bXV4bF9yZWNlaXZlKCk6IFJlY2VpdmVkIGRhdGEgb24gdW5rbm93biBsaW5rIElEID0gMiAoMHgy
KSB1cCA9PSBOVUxMPGJyPlsgMzkxOS45Mzk5MjldIGNhaWY6Y2ZtdXhsX3JlY2VpdmUoKTogUmVj
ZWl2ZWQgZGF0YSBvbiB1bmtub3duIGxpbmsgSUQgPSAzICgweDMpIHVwID09IE5VTEw8YnI+WyAz
OTE5Ljk0NjkzMl0gY2FpZjpjZm11eGxfcmVjZWl2ZSgpOiBSZWNlaXZlZCBkYXRhIG9uIHVua25v
d24gbGluayBJRCA9IDQgKDB4NCkgdXAgPT0gTlVMTDxicj4KClsgMzkxOS45NTM5MjhdIGNhaWY6
Y2ZtdXhsX3JlY2VpdmUoKTogUmVjZWl2ZWQgZGF0YSBvbiB1bmtub3duIGxpbmsgSUQgPSA1ICgw
eDUpIHVwID09IE5VTEw8YnI+WyAzOTE5Ljk2MDkzMF0gY2FpZjpjZm11eGxfcmVjZWl2ZSgpOiBS
ZWNlaXZlZCBkYXRhIG9uIHVua25vd24gbGluayBJRCA9IDYgKDB4NikgdXAgPT0gTlVMTDxicj48
YnI+PGJyPjxiPkkgaGF2ZSBsb2FkZWQgY2FpZiByZWxhdGVkIG1vZHVsZXM8L2I+PGJyPgoKPGJy
PiNsc21vZCB8IGdyZXAgY2FpZjxicj5jYWlmX3NvY2tldKCgoKCgoKCgoKCgoCA5MzE3oCAxMiA8
YnI+Y2FpZqCgoKCgoKCgoKCgoKCgoKCgoCA0NDMxMqAgMiBjaG5sX25ldCxjYWlmX3NvY2tldDxi
cj5jcmNfY2NpdHSgoKCgoKCgoKCgoKCgoCAxMzU5oCAxIGNhaWY8YnI+Y2FpZl9zZXJpYWygoKCg
oKCgoKCgoKAgNDI4OaAgMSA8YnI+PGJyPjxicj5QbGVhc2UgaGVscCBob3cgZG8gaSBmaXggdGhl
c2UgaXNzdWU/PGJyPgoKPGJyPjxicj5UaGFua3M8YnI+PGJyPll1dmFyYWogUjxicj4KPC9kaXY+
PGJyPgo=

--===============7422250453464592848==--

