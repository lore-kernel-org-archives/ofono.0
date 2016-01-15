Content-Type: multipart/mixed; boundary="===============6429139601334977475=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Fri, 15 Jan 2016 12:14:35 +0200
Message-ID: <CADnUhn0LoDXE5j+XRMU_6EgvtRuALH1oz8TfbHcS4etN2Be=rg@mail.gmail.com>
In-Reply-To: <5697BF90.8020806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6429139601334977475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
I tried what you suggested below. Shortly: it did not work.

2016-01-14 17:32 GMT+02:00 Denis Kenzior <denkenz@gmail.com>:

> if (g_at_result_iter_next(&iter, "^DHCP:") =3D=3D FALSE) {
>         gcd->dhcp_source =3D g_timeout_add_seconds(1, dhcp_poll, gc);
>         return;
> }
>

Log:
..drivers/huaweimodem/gprs-context.c:huawei_gprs_activate_primary() cid 1
ofonod: Modem: > AT+CGDCONT=3D1,"IP","internet"\r
ofonod: Modem: < \r\nOK\r\n
..drivers/huaweimodem/gprs-context.c:at_cgdcont_cb() ok 1
ofonod: Modem: > AT^NDISDUP=3D1,1\r
ofonod: Modem: < \r\nOK\r\n
..drivers/huaweimodem/gprs-context.c:at_ndisdup_up_cb() ok 1

## 22 times following block
ofonod: Modem: > AT^DHCP?\r
ofonod: Modem: < \r\nOK\r\n
..drivers/huaweimodem/gprs-context.c:dhcp_query_cb() ok 1

## after that
..src/gprs.c:pri_activate_callback() 0x120500
..src/gprs.c:pri_activate_callback() Activating context failed with error:
Unknown error type

So I guess we have a problem.
I also tried running above commands manually and really AT^DHCP? returns
just ok.

## I compared ModemManager log with ofono.log:
## it has
AT+CGDCONT=3D?
## command returning:
+CGDCONT:
(1-11),"IP",,,(0-2),(0-3)
+CGDCONT:
(1-11),"IPV6",,,(0-2),(0-3)
+CGDCONT:
(1-11),"IPV4V6",,,(0-2),(0-3)
+CGDCONT:
(1-11),"PPP",,,(0-2),(0-3)

OK

## It also has
AT+CGDCONT?
## command returning:
+CGDCONT: 1,"IP","internet","",0,0

OK

I can get same values if I run same commands manually from terminal after
killing ofonod.
However, I do not see any AT^DHCP? nor AT^NDISDUP. So, I suppose
ModemManager is using some other procedure while connecting.

Regards,
Matti

--===============6429139601334977475==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPkhpIERlbmlzLDxicj48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+SSB0cmllZCB3aGF0IHlvdSBzdWdnZXN0ZWQgYmVs
b3cuIFNob3J0bHk6IGl0IGRpZCBub3Qgd29yay48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZXh0cmEiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPjIwMTYtMDEtMTQgMTc6MzIgR01UKzAyOjAwIERlbmlzIEtlbnppb3IgPHNwYW4g
ZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRhcmdldD0i
X2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjo8YnI+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRl
ci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYg
aWQ9Ijp6cyIgY2xhc3M9IiIgc3R5bGU9Im92ZXJmbG93OmhpZGRlbiI+aWYgKGdfYXRfcmVzdWx0
X2l0ZXJfbmV4dCgmYW1wO2l0ZXIsICZxdW90O15ESENQOiZxdW90OykgPT0gRkFMU0UpIHs8YnI+
DQrCoCDCoCDCoCDCoCBnY2QtJmd0O2RoY3Bfc291cmNlID0gZ190aW1lb3V0X2FkZF9zZWNvbmRz
KDEsIGRoY3BfcG9sbCwgZ2MpOzxicj4NCsKgIMKgIMKgIMKgIHJldHVybjs8YnI+DQp9PC9kaXY+
PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+TG9n
Ojxicj4uLmRyaXZlcnMvaHVhd2VpbW9kZW0vZ3Bycy1jb250ZXh0LmM6aHVhd2VpX2dwcnNfYWN0
aXZhdGVfcHJpbWFyeSgpIGNpZCAxPGJyPm9mb25vZDogTW9kZW06ICZndDsgQVQrQ0dEQ09OVD0x
LCZxdW90O0lQJnF1b3Q7LCZxdW90O2ludGVybmV0JnF1b3Q7XHI8YnI+b2Zvbm9kOiBNb2RlbTog
Jmx0OyBcclxuT0tcclxuPGJyPi4uZHJpdmVycy9odWF3ZWltb2RlbS9ncHJzLWNvbnRleHQuYzph
dF9jZ2Rjb250X2NiKCkgb2sgMTxicj5vZm9ub2Q6IE1vZGVtOiAmZ3Q7IEFUXk5ESVNEVVA9MSwx
XHI8YnI+b2Zvbm9kOiBNb2RlbTogJmx0OyBcclxuT0tcclxuPGJyPi4uZHJpdmVycy9odWF3ZWlt
b2RlbS9ncHJzLWNvbnRleHQuYzphdF9uZGlzZHVwX3VwX2NiKCkgb2sgMTxicj48YnI+PC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPiMjIDIyIHRpbWVzIGZvbGxvd2luZyBibG9jazxicj48
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+b2Zvbm9kOiBNb2RlbTogJmd0OyBBVF5ESENQ
P1xyPGJyPm9mb25vZDogTW9kZW06ICZsdDsgXHJcbk9LXHJcbjxicj4uLmRyaXZlcnMvaHVhd2Vp
bW9kZW0vZ3Bycy1jb250ZXh0LmM6ZGhjcF9xdWVyeV9jYigpIG9rIDE8YnI+PGJyPjwvZGl2Pjxk
aXYgY2xhc3M9ImdtYWlsX2V4dHJhIj4jIyBhZnRlciB0aGF0IDxicj48L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9leHRyYSI+Li5zcmMvZ3Bycy5jOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIDB4MTIw
NTAwPGJyPi4uc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSBBY3RpdmF0aW5nIGNv
bnRleHQgZmFpbGVkIHdpdGggZXJyb3I6IFVua25vd24gZXJyb3IgdHlwZTxicj48YnI+PC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPlNvIEkgZ3Vlc3Mgd2UgaGF2ZSBhIHByb2JsZW0uPGJy
PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj5JIGFsc28gdHJpZWQgcnVubmluZyBhYm92
ZSBjb21tYW5kcyBtYW51YWxseSBhbmQgcmVhbGx5IEFUXkRIQ1A/IHJldHVybnMganVzdCBvay48
YnI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj4jIyBJIGNvbXBhcmVkIE1vZGVt
TWFuYWdlciBsb2cgd2l0aCBvZm9uby5sb2c6IDxicj4jIyBpdCBoYXMgPGJyPiBBVCtDR0RDT05U
PT88YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPiMjIGNvbW1hbmQgcmV0dXJuaW5n
Ojxicj4rQ0dEQ09OVDogKDEtMTEpLCZxdW90O0lQJnF1b3Q7LCwsKDAtMiksKDAtMynCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDxicj4rQ0dEQ09OVDogKDEtMTEpLCZxdW90O0lQVjYmcXVvdDss
LCwoMC0yKSwoMC0zKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8YnI+K0NHRENPTlQ6ICgxLTExKSwm
cXVvdDtJUFY0VjYmcXVvdDssLCwoMC0yKSwoMC0zKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxicj4rQ0dE
Q09OVDogKDEtMTEpLCZxdW90O1BQUCZxdW90OywsLCgwLTIpLCgwLTMpwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8YnI+T0vCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCA8YnI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj4jIyBJdCBhbHNvIGhhcyA8
YnI+QVQrQ0dEQ09OVD88YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPiMjIGNvbW1h
bmQgcmV0dXJuaW5nOjxicj4rQ0dEQ09OVDogMSwmcXVvdDtJUCZxdW90OywmcXVvdDtpbnRlcm5l
dCZxdW90OywmcXVvdDsmcXVvdDssMCwwwqDCoMKgwqDCoCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDxicj5PS8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxicj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZXh0cmEiPkkgY2FuIGdldCBzYW1lIHZhbHVlcyBpZiBJIHJ1biBzYW1lIGNvbW1hbmRzIG1h
bnVhbGx5IGZyb20gdGVybWluYWwgYWZ0ZXIga2lsbGluZyBvZm9ub2QuPGJyPjwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2V4dHJhIj5Ib3dldmVyLCBJIGRvIG5vdCBzZWUgYW55IEFUXkRIQ1A/IG5v
ciBBVF5ORElTRFVQLiBTbywgSSBzdXBwb3NlIE1vZGVtTWFuYWdlciBpcyB1c2luZyBzb21lIG90
aGVyIHByb2NlZHVyZSB3aGlsZSBjb25uZWN0aW5nLjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9leHRyYSI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj5SZWdhcmRzLDxicj48
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+TWF0dGk8YnI+PC9kaXY+PC9kaXY+DQo=

--===============6429139601334977475==--

