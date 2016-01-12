Content-Type: multipart/mixed; boundary="===============5067542482395838305=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Tue, 12 Jan 2016 18:56:41 +0200
Message-ID: <CADnUhn0zZuV7fCjpTm8HRVjBiONZJV8RKW=rUvyxj-Tmh_bWKg@mail.gmail.com>
In-Reply-To: <CADnUhn2vxkMDZrBkTL98BryyOmzPUM=ivceK1ekcV+uLHgKZcQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5067542482395838305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

2016-01-12 18:46 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:

> activate-context
>>> =3D>
>>> Error activating /huawei_0/context1: org.ofono.Error.NotImplemented:
>>> Implementation not provided
>>>
>>
>> There is no gprs context driver provided or it failed to setup.  Do you
>> have TUN/TAP in the kernel or kernel module?
>>
> It was not loaded, but I modprobed it now manually and got different error
> message:
> Error activating /huawei_1/context1: org.ofono.Error.Failed: Operation
> failed
>

Ofono log gave now some error messages:
..ofonod: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
..ofonod: Modem: > AT+CGDCONT=3D1,"IP","internet"\r
..ofonod: Modem: < \r\nOK\r\n
..ofonod: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
..ofonod: Modem: > AT+CGDATA=3D"PPP",1\r
..ofonod: Modem: < \r\n+CME ERROR: 50\r\n
..ofonod: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
..ofonod: Unable to enter data state
..ofonod: src/gprs.c:pri_activate_callback() 0x122580
..ofonod: src/gprs.c:pri_activate_callback() Activating context failed with
error: Incorrect parameters

-Matti

--===============5067542482395838305==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPkRlbmlzLDxicj48YnI+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE2
LTAxLTEyIDE4OjQ2IEdNVCswMjowMCBtYXR0aSBrYWFzaW5lbiA8c3BhbiBkaXI9Imx0ciI+Jmx0
OzxhIGhyZWY9Im1haWx0bzptYXR0aS5rYWFzaW5lbkBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5tYXR0aS5rYWFzaW5lbkBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj46PGJyPjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48c3Bh
biBjbGFzcz0iIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7
cGFkZGluZy1sZWZ0OjFleCI+PHNwYW4+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPmFjdGl2YXRlLWNvbnRleHQ8YnI+Cj0mZ3Q7
PGJyPgpFcnJvciBhY3RpdmF0aW5nIC9odWF3ZWlfMC9jb250ZXh0MTogb3JnLm9mb25vLkVycm9y
Lk5vdEltcGxlbWVudGVkOjxicj4KSW1wbGVtZW50YXRpb24gbm90IHByb3ZpZGVkPGJyPgo8L2Js
b2NrcXVvdGU+Cjxicj48L3NwYW4+ClRoZXJlIGlzIG5vIGdwcnMgY29udGV4dCBkcml2ZXIgcHJv
dmlkZWQgb3IgaXQgZmFpbGVkIHRvIHNldHVwLsKgIERvIHlvdSBoYXZlIFRVTi9UQVAgaW4gdGhl
IGtlcm5lbCBvciBrZXJuZWwgbW9kdWxlPzxicj48L2Jsb2NrcXVvdGU+PC9zcGFuPjxkaXY+SXQg
d2FzIG5vdCBsb2FkZWQsIGJ1dCBJIG1vZHByb2JlZCBpdCBub3cgbWFudWFsbHkgYW5kIGdvdCBk
aWZmZXJlbnQgZXJyb3IgbWVzc2FnZTo8YnI+RXJyb3IgYWN0aXZhdGluZyAvaHVhd2VpXzEvY29u
dGV4dDE6IG9yZy5vZm9uby5FcnJvci5GYWlsZWQ6IE9wZXJhdGlvbiBmYWlsZWQ8L2Rpdj48L2Js
b2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj5PZm9ubyBs
b2cgZ2F2ZSBub3cgc29tZSBlcnJvciBtZXNzYWdlczo8YnI+Li5vZm9ub2Q6IGRyaXZlcnMvYXRt
b2RlbS9ncHJzLWNvbnRleHQuYzphdF9ncHJzX2FjdGl2YXRlX3ByaW1hcnkoKSBjaWQgMTxicj4u
Lm9mb25vZDogTW9kZW06ICZndDsgQVQrQ0dEQ09OVD0xLCZxdW90O0lQJnF1b3Q7LCZxdW90O2lu
dGVybmV0JnF1b3Q7XHI8YnI+Li5vZm9ub2Q6IE1vZGVtOiAmbHQ7IFxyXG5PS1xyXG48YnI+Li5v
Zm9ub2Q6IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9jZ2Rjb250X2NiKCkgb2sg
MTxicj4uLm9mb25vZDogTW9kZW06ICZndDsgQVQrQ0dEQVRBPSZxdW90O1BQUCZxdW90OywxXHI8
YnI+Li5vZm9ub2Q6IE1vZGVtOiAmbHQ7IFxyXG4rQ01FIEVSUk9SOiA1MFxyXG48YnI+Li5vZm9u
b2Q6IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9jZ2RhdGFfY2IoKSBvayAwPGJy
Pi4ub2Zvbm9kOiBVbmFibGUgdG8gZW50ZXIgZGF0YSBzdGF0ZTxicj4uLm9mb25vZDogc3JjL2dw
cnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSAweDEyMjU4MDxicj4uLm9mb25vZDogc3JjL2dw
cnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSBBY3RpdmF0aW5nIGNvbnRleHQgZmFpbGVkIHdp
dGggZXJyb3I6IEluY29ycmVjdCBwYXJhbWV0ZXJzPGJyPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9leHRyYSI+LU1hdHRpPGJyPjwvZGl2PjwvZGl2Pgo=

--===============5067542482395838305==--

