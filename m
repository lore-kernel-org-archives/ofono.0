Content-Type: multipart/mixed; boundary="===============0489087871416913679=="
MIME-Version: 1.0
From: Li, Minjun <minjun.li@intel.com>
Subject: two patches for voicecall.c
Date: Wed, 27 May 2009 15:46:00 +0800
Message-ID: <61563CE63B4F854986A895DA7AD3C17709D989BF6F@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0489087871416913679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Folks,
I have made 2 patches for minor bugs in functions of voicecall_busy and dia=
l_callback in /src/voicecall.c.
The first one is to use the function pointer set_udub to replace release_sp=
ecific.
The second one is to delete the repeated calling of voicecall_create in dia=
l_callback function, since it was called in previous line in the same funct=
ion.

Best Regards,
Minjun


--===============0489087871416913679==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Modify-the-function-pointer-in-voicecall_busy-to-set.patch"

RnJvbSAzMjI5ZDI4MjI2NGI4YWUzZjM0ZDQzNzQ2N2M2ZTg0Y2IzZDIzMzVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaW5qdW4gTGkgPG1pbmp1bi5saUBpbnRlbC5jb20+CkRhdGU6
IFR1ZSwgMjYgTWF5IDIwMDkgMTU6Mjg6MDAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBNb2RpZnkg
dGhlIGZ1bmN0aW9uIHBvaW50ZXIgaW4gdm9pY2VjYWxsX2J1c3kgdG8gc2V0X3VkdWIKCi0tLQog
c3JjL3ZvaWNlY2FsbC5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3ZvaWNlY2FsbC5jIGIvc3JjL3Zv
aWNlY2FsbC5jCmluZGV4IGJiYzdiZjUuLjczZDg4ODkgMTAwNjQ0Ci0tLSBhL3NyYy92b2ljZWNh
bGwuYworKysgYi9zcmMvdm9pY2VjYWxsLmMKQEAgLTE5OCw3ICsxOTgsNyBAQCBzdGF0aWMgREJ1
c01lc3NhZ2UgKnZvaWNlY2FsbF9idXN5KERCdXNDb25uZWN0aW9uICpjb25uLAogCQljYWxsLT5z
dGF0dXMgIT0gQ0FMTF9TVEFUVVNfV0FJVElORykKIAkJcmV0dXJuIGRidXNfZ3NtX2ZhaWxlZCht
c2cpOwogCi0JaWYgKCF2b2ljZWNhbGxzLT5vcHMtPnJlbGVhc2Vfc3BlY2lmaWMpCisJaWYgKCF2
b2ljZWNhbGxzLT5vcHMtPnNldF91ZHViKQogCQlyZXR1cm4gZGJ1c19nc21fbm90X2ltcGxlbWVu
dGVkKG1zZyk7CiAKIAlpZiAodm9pY2VjYWxscy0+ZmxhZ3MgJiBWT0lDRUNBTExTX0ZMQUdfUEVO
RElORykKLS0gCjEuNi4wLjMKCg==

--===============0489087871416913679==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-Delete-the-repeated-calling-of-voicecall_creat-funct.patch"

RnJvbSA5ZThmNDQyZTE0YjdhYTc2MWU3NWY3ZDhmNTI2MzZjNjAwMzY2MjZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaW5qdW4gTGkgPG1pbmp1bi5saUBpbnRlbC5jb20+CkRhdGU6
IFR1ZSwgMjYgTWF5IDIwMDkgMTU6Mzc6MjIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBEZWxldGUg
dGhlIHJlcGVhdGVkIGNhbGxpbmcgb2Ygdm9pY2VjYWxsX2NyZWF0IGZ1bmN0aW9uCgotLS0KIHNy
Yy92b2ljZWNhbGwuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy92b2ljZWNhbGwuYyBiL3NyYy92b2lj
ZWNhbGwuYwppbmRleCA3M2Q4ODg5Li44MzE4MTQzIDEwMDY0NAotLS0gYS9zcmMvdm9pY2VjYWxs
LmMKKysrIGIvc3JjL3ZvaWNlY2FsbC5jCkBAIC0xNDQ0LDcgKzE0NDQsNyBAQCBzdGF0aWMgdm9p
ZCBkaWFsX2NhbGxiYWNrKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsIHZvaWQgKmRh
dGEpCiAJCX0KIAogCQlvZm9ub19kZWJ1ZygiUmVnaXN0ZXJpbmcgbmV3IGNhbGw6ICVkIiwgY2Fs
bC0+aWQpOwotCQl2b2ljZWNhbGxfZGJ1c19yZWdpc3Rlcih2b2ljZWNhbGxfY3JlYXRlKG1vZGVt
LCBjYWxsKSk7CisJCXZvaWNlY2FsbF9kYnVzX3JlZ2lzdGVyKHYpOwogCiAJCWNhbGxzLT5jYWxs
X2xpc3QgPSBnX3NsaXN0X2luc2VydF9zb3J0ZWQoY2FsbHMtPmNhbGxfbGlzdCwgdiwKIAkJCQkJ
Y2FsbF9jb21wYXJlKTsKLS0gCjEuNi4wLjMKCg==

--===============0489087871416913679==--

