Content-Type: multipart/mixed; boundary="===============1289066678236361055=="
MIME-Version: 1.0
From: Li, Minjun <minjun.li@intel.com>
Subject: RE: add a common exit function for interfaces when manager_free and
 manager_destroy function is called
Date: Wed, 03 Jun 2009 09:11:37 +0800
Message-ID: <61563CE63B4F854986A895DA7AD3C17709D9919F0C@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <200906021738.04488.denis.kenzior@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1289066678236361055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I regenerated the patch again.
Thank denis for good advice.

Best Regards,

Minjun
-----Original Message-----
From: Kenzior, Denis =

Sent: 2009=E5=B9=B46=E6=9C=883=E6=97=A5 6:38
To: ofono(a)ofono.org
Cc: Li, Minjun
Subject: Re: add a common exit function for interfaces when manager_free an=
d manager_destroy function is called

Hi Minjun,

On Tuesday 02 June 2009 02:02:29 Li, Minjun wrote:
> Hi Folks,
> I regenerated the patch.
> Because I found that manager_destroy function is lack of some exit functi=
on
> calls comparing to manager_free function, I add a common exit function for
> interfaces when manager_free and manager_destroy function is called.
>

In interface_exit: Please remove if (at)  block, its pointless.

Please get rid of all mode changes, only submit changes to files that are =

relevant to the fix.

Get a proper commit message.  E.g. put the description in the email into th=
e =

commit message.  =


> Best Regards,
> Minjun

Regards,
-Denis


--===============1289066678236361055==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Adding-a-common-exit-function-for-interfaces-when-ma.patch"

RnJvbSA5NjkzOWU2MzFmNTI2YTJjODljZGI5NWNmNWI4ZTYzNjBlY2JkN2QzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaW5qdW4gTGkgPG1pbmp1bi5saUBpbnRlbC5jb20+CkRhdGU6
IFR1ZSwgMiBKdW4gMjAwOSAwODo1MDozNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFkZGluZyBh
IGNvbW1vbiBleGl0IGZ1bmN0aW9uIGZvciBpbnRlcmZhY2VzIHdoZW4gbWFuYWdlcl9mcmVlCiBh
bmQgbWFuYWdlcl9kZXN0cm95IGZ1bmN0aW9uIGlzIGNhbGxlZCBiZWNhdXNlIG1hbmFnZXJfZGVz
dHJveQogZnVuY3Rpb24gaXMgbGFjayBvZiBzb21lIGV4aXQgZnVuY3Rpb24gY2FsbHMgY29tcGFy
aW5nIHRvCiBtYW5hZ2VyX2ZyZWUKCi0tLQogZHJpdmVycy9hdG1vZGVtL2F0bW9kZW0uYyB8ICAg
MjYgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdG1vZGVtL2F0
bW9kZW0uYyBiL2RyaXZlcnMvYXRtb2RlbS9hdG1vZGVtLmMKaW5kZXggMmYxZTQzMC4uMjBiOTVh
NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9hdG1vZGVtL2F0bW9kZW0uYworKysgYi9kcml2ZXJzL2F0
bW9kZW0vYXRtb2RlbS5jCkBAIC05MCw2ICs5MCwxOSBAQCBzdGF0aWMgdm9pZCBhdF9kZXN0cm95
KHN0cnVjdCBhdF9kYXRhICphdCkKIAlnX2ZyZWUoYXQpOwogfQogCitzdGF0aWMgdm9pZCBpbnRl
cmZhY2VfZXhpdChzdHJ1Y3QgYXRfZGF0YSAqYXQpCit7CisJYXRfc21zX2V4aXQoYXQtPm1vZGVt
KTsKKwlhdF9jYWxsX2ZvcndhcmRpbmdfZXhpdChhdC0+bW9kZW0pOworCWF0X2NhbGxfc2V0dGlu
Z3NfZXhpdChhdC0+bW9kZW0pOworCWF0X25ldHdvcmtfcmVnaXN0cmF0aW9uX2V4aXQoYXQtPm1v
ZGVtKTsKKwlhdF92b2ljZWNhbGxfZXhpdChhdC0+bW9kZW0pOworCWF0X2NhbGxfbWV0ZXJfZXhp
dChhdC0+bW9kZW0pOworCWF0X2NhbGxfYmFycmluZ19leGl0KGF0LT5tb2RlbSk7CisJYXRfdXNz
ZF9leGl0KGF0LT5tb2RlbSk7CisJYXRfc2ltX2V4aXQoYXQtPm1vZGVtKTsKK30KKwogc3RhdGlj
IHZvaWQgbWFuYWdlcl9mcmVlKGdwb2ludGVyIHVzZXIpCiB7CiAJR1NMaXN0ICpsOwpAQCAtMTAy
LDE1ICsxMTUsNyBAQCBzdGF0aWMgdm9pZCBtYW5hZ2VyX2ZyZWUoZ3BvaW50ZXIgdXNlcikKIAlm
b3IgKGwgPSBnX3Nlc3Npb25zOyBsOyBsID0gbC0+bmV4dCkgewogCQlzdHJ1Y3QgYXRfZGF0YSAq
YXQgPSBsLT5kYXRhOwogCi0JCWF0X3Ntc19leGl0KGF0LT5tb2RlbSk7Ci0JCWF0X2NhbGxfZm9y
d2FyZGluZ19leGl0KGF0LT5tb2RlbSk7Ci0JCWF0X2NhbGxfc2V0dGluZ3NfZXhpdChhdC0+bW9k
ZW0pOwotCQlhdF9uZXR3b3JrX3JlZ2lzdHJhdGlvbl9leGl0KGF0LT5tb2RlbSk7Ci0JCWF0X3Zv
aWNlY2FsbF9leGl0KGF0LT5tb2RlbSk7Ci0JCWF0X2NhbGxfbWV0ZXJfZXhpdChhdC0+bW9kZW0p
OwotCQlhdF9jYWxsX2JhcnJpbmdfZXhpdChhdC0+bW9kZW0pOwotCQlhdF91c3NkX2V4aXQoYXQt
Pm1vZGVtKTsKLQkJYXRfc2ltX2V4aXQoYXQtPm1vZGVtKTsKKwkJaW50ZXJmYWNlX2V4aXQoYXQp
OwogCQlvZm9ub19tb2RlbV91bnJlZ2lzdGVyKGF0LT5tb2RlbSk7CiAKIAkJYXRfZGVzdHJveShh
dCk7CkBAIC00MjEsOCArNDI2LDcgQEAgc3RhdGljIERCdXNNZXNzYWdlICptYW5hZ2VyX2Rlc3Ry
b3koREJ1c0Nvbm5lY3Rpb24gKmNvbm4sIERCdXNNZXNzYWdlICptc2csCiAJCWlmIChzdHJjbXAo
YXQtPm1vZGVtLT5wYXRoLCBwYXRoKSkKIAkJCWNvbnRpbnVlOwogCi0JCWF0X25ldHdvcmtfcmVn
aXN0cmF0aW9uX2V4aXQoYXQtPm1vZGVtKTsKLQkJYXRfdm9pY2VjYWxsX2V4aXQoYXQtPm1vZGVt
KTsKKwkJaW50ZXJmYWNlX2V4aXQoYXQpOwogCQlvZm9ub19tb2RlbV91bnJlZ2lzdGVyKGF0LT5t
b2RlbSk7CiAKIAkJZ19zZXNzaW9ucyA9IGdfc2xpc3RfcmVtb3ZlKGdfc2Vzc2lvbnMsIGF0KTsK
LS0gCjEuNi4wLjMKCg==

--===============1289066678236361055==--

