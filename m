Content-Type: multipart/mixed; boundary="===============0526560618982612777=="
MIME-Version: 1.0
From: Shane Bryan <shane.bryan@linux.intel.com>
Subject: [PATCH] fix test compile
Date: Wed, 24 Jun 2009 16:51:25 -0700
Message-ID: <20090624165125.1a66f6ef@cyclone>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0526560618982612777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

unit/test-sms.c: g_print format errors on x86_64 compiles, using %zd
and %ld as appropriate.

Shane...

--===============0526560618982612777==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-fix-test-compile.patch"

PkZyb20gNjQ3NGRhODgyZDBkNzI4OWZiZjFiZTY2NGU5OTJhZTBmY2RhY2JkMSBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogU2hhbmUgQnJ5YW4gPHNoYW5lLmJyeWFuQGxpbnV4LmludGVs
LmNvbT4KRGF0ZTogV2VkLCAyNCBKdW4gMjAwOSAxNToxNjowMiAtMDcwMApTdWJqZWN0OiBbUEFU
Q0hdIGZpeCB0ZXN0IGNvbXBpbGUKClNpZ25lZC1vZmYtYnk6IFNoYW5lIEJyeWFuIDxzaGFuZS5i
cnlhbkBsaW51eC5pbnRlbC5jb20+Ci0tLQogdW5pdC90ZXN0LXNtcy5jIHwgICAgNCArKy0tCiAx
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS91bml0L3Rlc3Qtc21zLmMgYi91bml0L3Rlc3Qtc21zLmMKaW5kZXggMzdmMGYyNi4uNDdh
M2Y0YiAxMDA2NDQKLS0tIGEvdW5pdC90ZXN0LXNtcy5jCisrKyBiL3VuaXQvdGVzdC1zbXMuYwpA
QCAtNzgxLDcgKzc4MSw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfcHJlcGFyZV9jb25jYXQoKQogCWd1
aW50OCBzZXE7CiAKIAlpZiAoZ190ZXN0X3ZlcmJvc2UoKSkKLQkJZ19wcmludCgic3RybGVuOiAl
ZFxuIiwgc3RybGVuKHBhZDEpKTsKKwkJZ19wcmludCgic3RybGVuOiAlemRcbiIsIHN0cmxlbihw
YWQxKSk7CiAKIAlyID0gc21zX3RleHRfcHJlcGFyZShwYWQxLCAwLCBUUlVFLCBOVUxMKTsKIApA
QCAtODE1LDcgKzgxNSw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfcHJlcGFyZV9jb25jYXQoKQogCQlk
ZWNvZGVfaGV4X293bl9idWYoKGNoYXIgKilsLT5kYXRhLCAtMSwgJmxlbiwgMCwgcGR1KTsKIAog
CQlpZiAoZ190ZXN0X3ZlcmJvc2UoKSkKLQkJCWdfcHJpbnQoIlBEVSBMZW46ICVkIiwgbGVuKTsK
KwkJCWdfcHJpbnQoIlBEVSBMZW46ICVsZCIsIGxlbik7CiAKIAkJb2sgPSBzbXNfZGVjb2RlKHBk
dSwgbGVuLCBUUlVFLCBsZW4gLSAxLCAmZGVjb2RlZCk7CiAKLS0gCjEuNi4wLjQKCg==

--===============0526560618982612777==--

