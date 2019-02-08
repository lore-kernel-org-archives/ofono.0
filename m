Content-Type: multipart/mixed; boundary="===============1500160716588429355=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Compiling: error: cast increases required alignment of target
 type [-Werror=cast-align]
Date: Fri, 08 Feb 2019 14:15:32 -0600
Message-ID: <5fcbd5d1-a539-16f0-3666-7381400fe1fd@gmail.com>
In-Reply-To: <2123041549319326@iva3-2961a207771d.qloud-c.yandex.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1500160716588429355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/04/2019 04:28 PM, Pi=C4=8Dugins Arsenijs wrote:
>  =C2=A0 CC =C2=A0 =C2=A0 =C2=A0 drivers/mbimmodem/mbim-message.o
> drivers/mbimmodem/mbim-message.c: In function =E2=80=98_iter_copy_string=
=E2=80=99:
> drivers/mbimmodem/mbim-message.c:199:18: error: cast increases required =

> alignment of target type [-Werror=3Dcast-align]
>  =C2=A0 =C2=A0uint16_t *le =3D (uint16_t *) buf;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^

Does the attached patch fix this?

Regards,
-Denis




--===============1500160716588429355==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-mbim-Fix-compile-warning.patch"

PkZyb20gODViMjE4NzMwZWZhZDcxNDNiOWJlMGMzNjUzYWQzZjQ1NDVmZjBjNyBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IEZyaSwgOCBGZWIgMjAxOSAxNDoxNDowOSAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIG1iaW06
IEZpeCBjb21waWxlIHdhcm5pbmcKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0
L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKCiAg
Q0MgICAgICAgZHJpdmVycy9tYmltbW9kZW0vbWJpbS1tZXNzYWdlLm8KZHJpdmVycy9tYmltbW9k
ZW0vbWJpbS1tZXNzYWdlLmM6IEluIGZ1bmN0aW9uIOKAmF9pdGVyX2NvcHlfc3RyaW5n4oCZOgpk
cml2ZXJzL21iaW1tb2RlbS9tYmltLW1lc3NhZ2UuYzoxOTk6MTg6IGVycm9yOiBjYXN0IGluY3Jl
YXNlcyByZXF1aXJlZCBhbGlnbm1lbnQgb2YgdGFyZ2V0IHR5cGUgWy1XZXJyb3I9Y2FzdC1hbGln
bl0KICAgdWludDE2X3QgKmxlID0gKHVpbnQxNl90ICopIGJ1ZjsKICAgICAgICAgICAgICAgICAg
XgotLS0KIGRyaXZlcnMvbWJpbW1vZGVtL21iaW0tbWVzc2FnZS5jIHwgNiArKystLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tYmltbW9kZW0vbWJpbS1tZXNzYWdlLmMgYi9kcml2ZXJzL21iaW1tb2RlbS9tYmlt
LW1lc3NhZ2UuYwppbmRleCA3ODk5YmM2NS4uMGMxMTc2NTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
bWJpbW1vZGVtL21iaW0tbWVzc2FnZS5jCisrKyBiL2RyaXZlcnMvbWJpbW1vZGVtL21iaW0tbWVz
c2FnZS5jCkBAIC0xNTMsOCArMTUzLDggQEAgc3RhdGljIGJvb2wgX2l0ZXJfY29weV9zdHJpbmco
c3RydWN0IG1iaW1fbWVzc2FnZV9pdGVyICppdGVyLAogCQkJCQl1aW50MzJfdCBvZmZzZXQsIHVp
bnQzMl90IGxlbiwKIAkJCQkJY2hhciAqKm91dCkKIHsKLQl1aW50OF90IGJ1ZltsZW5dOwotCXVp
bnQ4X3QgKmRlc3QgPSBidWY7CisJdWludDE2X3QgYnVmW2xlbiAvIDIgKyAxXTsKKwl1aW50OF90
ICpkZXN0ID0gKHVpbnQ4X3QgKikgYnVmOwogCXVpbnQzMl90IHJlbWFpbmluZyA9IGxlbjsKIAl1
aW50MzJfdCBpb3Zfc3RhcnQgPSAwOwogCXVpbnQzMl90IGkgPSAwOwpAQCAtMTk2LDcgKzE5Niw3
IEBAIHN0YXRpYyBib29sIF9pdGVyX2NvcHlfc3RyaW5nKHN0cnVjdCBtYmltX21lc3NhZ2VfaXRl
ciAqaXRlciwKIAogCS8qIFN0cmluZ3MgYXJlIGluIFVURjE2LUxFLCBzbyBjb252ZXJ0IHRvIFVU
RjE2LUNQVSBmaXJzdCBpZiBuZWVkZWQgKi8KIAlpZiAoTF9DUFVfVE9fTEUxNigweDgwMDApICE9
IDB4ODAwMCkgewotCQl1aW50MTZfdCAqbGUgPSAodWludDE2X3QgKikgYnVmOworCQl1aW50MTZf
dCAqbGUgPSBidWY7CiAKIAkJZm9yIChpID0gMDsgaSA8IGxlbiAvIDI7IGkrKykKIAkJCWxlW2ld
ID0gX19idWlsdGluX2Jzd2FwMTYobGVbaV0pOwotLSAKMi4xMy41Cgo=

--===============1500160716588429355==--

