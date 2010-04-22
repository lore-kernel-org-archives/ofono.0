Content-Type: multipart/mixed; boundary="===============1972943185256767036=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 1/3] Fix CTLV three-byte tag parsing.
Date: Thu, 22 Apr 2010 23:17:55 +0200
Message-ID: <u2nfb249edb1004221417qbddbc4feyfecdebf87ef3e930@mail.gmail.com>
In-Reply-To: <1271923876-3320-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1972943185256767036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 22 April 2010 10:11, Andrzej Zaborowski <andrew.zaborowski@intel.com> =
wrote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If byte 1 of the tag is equal to 0x7F, then=
 the tag is encoded
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* on the following two bytes, with bit 8 of =
the 2nd byte of the tag
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* being the CR flag.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* on the following two bytes, with bit 8 of =
the 1st byte of the tag
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* as the most significant bit.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */

I noticed my comment change is wrong, it should probably say "bit 8 of
the 1st byte of the tag being the CR flag" (1st referring to the first
of the last two bytes).

Best regards

--===============1972943185256767036==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0013-Fix-CTLV-three-byte-tag-parsing.patch"

RnJvbSA5N2RkMGY3ZGU2YzJiMjc2MmNmZDVkZDE4OTczZDU2ZTY5M2I4YmJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogVGh1LCAyMiBBcHIgMjAxMCAwMToxNTo1NiArMDIwMApTdWJqZWN0
OiBbUEFUQ0ggMS8zXSBGaXggQ1RMViB0aHJlZS1ieXRlIHRhZyBwYXJzaW5nLgoKLS0tCiBzcmMv
c2ltdXRpbC5jIHwgICAxMiArKysrKystLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9zaW11dGlsLmMgYi9zcmMv
c2ltdXRpbC5jCmluZGV4IDlmYjExMWYuLjgyMjkzOGMgMTAwNjQ0Ci0tLSBhL3NyYy9zaW11dGls
LmMKKysrIGIvc3JjL3NpbXV0aWwuYwpAQCAtMjEwLDcgKzIxMCw3IEBAIHZvaWQgY29tcHJlaGVu
c2lvbl90bHZfaXRlcl9pbml0KHN0cnVjdCBjb21wcmVoZW5zaW9uX3Rsdl9pdGVyICppdGVyLAog
CWl0ZXItPmRhdGEgPSAwOwogfQogCi0vKiBDb21wcmVoZW5zaW9uIFRMVnMgZGVmaW5lZCBpbiBT
ZWN0aW9uIDcgb2YgRVRTSSBUUyAxMDIuMjIwICovCisvKiBDb21wcmVoZW5zaW9uIFRMVnMgZGVm
aW5lZCBpbiBTZWN0aW9uIDcgb2YgRVRTSSBUUyAxMDEuMjIwICovCiBnYm9vbGVhbiBjb21wcmVo
ZW5zaW9uX3Rsdl9pdGVyX25leHQoc3RydWN0IGNvbXByZWhlbnNpb25fdGx2X2l0ZXIgKml0ZXIp
CiB7CiAJY29uc3QgdW5zaWduZWQgY2hhciAqcGR1ID0gaXRlci0+cGR1ICsgaXRlci0+cG9zOwpA
QCAtMjMwLDE4ICsyMzAsMTggQEAgZ2Jvb2xlYW4gY29tcHJlaGVuc2lvbl90bHZfaXRlcl9uZXh0
KHN0cnVjdCBjb21wcmVoZW5zaW9uX3Rsdl9pdGVyICppdGVyKQogCQlyZXR1cm4gRkFMU0U7CiAK
IAkvKgotCSAqIEVUU0kgVFMgMTAyLjIyMCwgU2VjdGlvbiA3LjEuMS4yCisJICogRVRTSSBUUyAx
MDEuMjIwLCBTZWN0aW9uIDcuMS4xLjIKIAkgKiAKIAkgKiBJZiBieXRlIDEgb2YgdGhlIHRhZyBp
cyBlcXVhbCB0byAweDdGLCB0aGVuIHRoZSB0YWcgaXMgZW5jb2RlZAotCSAqIG9uIHRoZSBmb2xs
b3dpbmcgdHdvIGJ5dGVzLCB3aXRoIGJpdCA4IG9mIHRoZSAybmQgYnl0ZSBvZiB0aGUgdGFnCi0J
ICogYmVpbmcgdGhlIENSIGZsYWcuCisJICogb24gdGhlIGZvbGxvd2luZyB0d28gYnl0ZXMsIHdp
dGggYml0IDggb2YgdGhlIDFzdCBieXRlIG9mIHRoZSB0YWcKKwkgKiBiZWluZyB0aGUgQ1IgZmxh
Zy4KIAkgKi8KLQlpZiAodGFnID09IDB4N0YpIHsKKwlpZiAodGFnID09IDB4N0YgJiYgIWNyKSB7
CiAJCWlmICgocGR1ICsgMikgPiBlbmQpCiAJCQlyZXR1cm4gRkFMU0U7CiAKIAkJY3IgPSBiaXRf
ZmllbGQocGR1WzBdLCA3LCAxKTsKLQkJdGFnID0gKChwZHVbMF0gJiAweDdmKSA8PCA3KSB8IHBk
dVsxXTsKKwkJdGFnID0gKChwZHVbMF0gJiAweDdmKSA8PCA4KSB8IHBkdVsxXTsKIAogCQlpZiAo
dGFnIDwgMHgwMDAxIHx8IHRhZyA+IDB4N2ZmZikKIAkJCXJldHVybiBGQUxTRTsKLS0gCjEuNi4x
Cgo=

--===============1972943185256767036==--

