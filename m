Content-Type: multipart/mixed; boundary="===============1469694062123600189=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Tue, 12 Jan 2016 18:46:31 +0200
Message-ID: <CADnUhn2vxkMDZrBkTL98BryyOmzPUM=ivceK1ekcV+uLHgKZcQ@mail.gmail.com>
In-Reply-To: <56952A0B.9060203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1469694062123600189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
2016-01-12 18:30 GMT+02:00 Denis Kenzior <denkenz@gmail.com>:

>
>> activate-context
>> =3D>
>> Error activating /huawei_0/context1: org.ofono.Error.NotImplemented:
>> Implementation not provided
>>
>
> There is no gprs context driver provided or it failed to setup.  Do you
> have TUN/TAP in the kernel or kernel module?
>
It was not loaded, but I modprobed it now manually and got different error
message:
Error activating /huawei_1/context1: org.ofono.Error.Failed: Operation
failed


> Please note, that there are two different versions of the Huawei cards
> supported by oFono.  One uses the "gobi" driver (these are Qualcomm
> chips).  While the more traditional one uses PPP & the "huawei" driver.


I suppose I should edit setup_gobi() and vendor_list() as before in case
it's "gobi"?

-Matti

--===============1469694062123600189==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+SGkgRGVuaXMsPGJyPjIwMTYtMDEtMTIgMTg6MzAgR01UKzAyOjAwIERlbmlz
IEtlbnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFp
bC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjo8
YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPjxzcGFuIGNsYXNzPSIiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdi
KDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48YnI+CmFjdGl2YXRlLWNvbnRleHQ8YnI+
Cj0mZ3Q7PGJyPgpFcnJvciBhY3RpdmF0aW5nIC9odWF3ZWlfMC9jb250ZXh0MTogb3JnLm9mb25v
LkVycm9yLk5vdEltcGxlbWVudGVkOjxicj4KSW1wbGVtZW50YXRpb24gbm90IHByb3ZpZGVkPGJy
Pgo8L2Jsb2NrcXVvdGU+Cjxicj48L3NwYW4+ClRoZXJlIGlzIG5vIGdwcnMgY29udGV4dCBkcml2
ZXIgcHJvdmlkZWQgb3IgaXQgZmFpbGVkIHRvIHNldHVwLsKgIERvIHlvdSBoYXZlIFRVTi9UQVAg
aW4gdGhlIGtlcm5lbCBvciBrZXJuZWwgbW9kdWxlPzxicj48L2Jsb2NrcXVvdGU+PGRpdj5JdCB3
YXMgbm90IGxvYWRlZCwgYnV0IEkgbW9kcHJvYmVkIGl0IG5vdyBtYW51YWxseSBhbmQgZ290IGRp
ZmZlcmVudCBlcnJvciBtZXNzYWdlOjxicj5FcnJvciBhY3RpdmF0aW5nIC9odWF3ZWlfMS9jb250
ZXh0MTogb3JnLm9mb25vLkVycm9yLkZhaWxlZDogT3BlcmF0aW9uIGZhaWxlZDxicj48YnI+PC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPgo8YnI+ClBsZWFzZSBub3RlLCB0aGF0IHRoZXJlIGFyZSB0d28gZGlmZmVyZW50
IHZlcnNpb25zIG9mIHRoZSBIdWF3ZWkgY2FyZHMgc3VwcG9ydGVkIGJ5IG9Gb25vLsKgIE9uZSB1
c2VzIHRoZSAmcXVvdDtnb2JpJnF1b3Q7IGRyaXZlciAodGhlc2UgYXJlIFF1YWxjb21tIGNoaXBz
KS7CoCBXaGlsZSB0aGUgbW9yZSB0cmFkaXRpb25hbCBvbmUgdXNlcyBQUFAgJmFtcDsgdGhlICZx
dW90O2h1YXdlaSZxdW90OyBkcml2ZXIuPC9ibG9ja3F1b3RlPjxkaXY+PGJyPkkgc3VwcG9zZSBJ
IHNob3VsZCBlZGl0IHNldHVwX2dvYmkoKSBhbmQgdmVuZG9yX2xpc3QoKSBhcyBiZWZvcmUgaW4g
Y2FzZSBpdCYjMzk7cyAmcXVvdDtnb2JpJnF1b3Q7Pzxicj48YnI+PC9kaXY+PGRpdj4tTWF0dGk8
YnI+PC9kaXY+PC9kaXY+PGJyPjxicj48L2Rpdj48L2Rpdj4K

--===============1469694062123600189==--

