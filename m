Content-Type: multipart/mixed; boundary="===============0584841972093906067=="
MIME-Version: 1.0
From: Shane Bryan <shane.bryan@linux.intel.com>
Subject: Re: Compile error
Date: Tue, 04 Aug 2009 09:22:31 -0700
Message-ID: <20090804092231.4e8c8677@cyclone>
In-Reply-To: <4A77C635.7020606@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0584841972093906067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Aug 2009 08:25:09 +0300
Marko Saukko <marko.saukko@gmail.com> wrote:

> Hi,
> =

> I'm getting following error when compiling the latest git version with
> gcc (Ubuntu 4.3.3-5ubuntu4) 4.3.3.

Attached is a patch to fix the errors.

WARNING:  It still does nothing with the return values, but it resolves
the compiler errors, *that's it*.

Someone who knows something about what should happen if the write fails
really ought to review and adjust this as appropriate.  I am not that
person.

Shane...

--===============0584841972093906067==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-fix-ignored-return-size-when-calling-write.patch"

PkZyb20gMmFkYjFmOTk4ZGM2MmI5OTg3YTBiODk4MmQwZTI4ODk2OTcxMDg5MSBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogU2hhbmUgQnJ5YW4gPHNoYW5lLmJyeWFuQGxpbnV4LmludGVs
LmNvbT4KRGF0ZTogVHVlLCA0IEF1ZyAyMDA5IDA5OjEzOjMxIC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gZml4IGlnbm9yZWQgcmV0dXJuIHNpemUgd2hlbiBjYWxsaW5nIHdyaXRlICgpCgogc2ltLmMg
dXNlcyB3cml0ZSAoKSBidXQgaWdub3JlcyB0aGUgc2l6ZSByZXR1cm5lZC4gVGhpcyBjYXVzZXMK
IGNvbXBpbGUgZmFpbHVyZXMgd2l0aCBkZWZhdWx0IG9wdGlvbnMgZ2VuZXJhdGVkIHdpdGggYm9v
dHN0cmFwCgpTaWduZWQtb2ZmLWJ5OiBTaGFuZSBCcnlhbiA8c2hhbmUuYnJ5YW5AbGludXguaW50
ZWwuY29tPgotLS0KIHNyYy9zaW0uYyB8ICAgIDYgKysrKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvc2ltLmMgYi9z
cmMvc2ltLmMKaW5kZXggNmUxNDRmNC4uMWMwNjY2ZSAxMDA2NDQKLS0tIGEvc3JjL3NpbS5jCisr
KyBiL3NyYy9zaW0uYwpAQCAtMzEyLDYgKzMxMiw3IEBAIHN0YXRpYyB2b2lkIHNpbV9vcF9yZXRy
aWV2ZV9jYihjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLAogCWNoYXIgKmltc2kgPSBz
aW0tPmltc2k7CiAJY2hhciAqcGF0aDsKIAlpbnQgZmQ7CisJc3NpemVfdCB3X3NpemU7CiAKIAlp
ZiAoZXJyb3ItPnR5cGUgIT0gT0ZPTk9fRVJST1JfVFlQRV9OT19FUlJPUikgewogCQlzaW1fb3Bf
ZXJyb3IobW9kZW0pOwpAQCAtMzMzLDcgKzMzNCw3IEBAIHN0YXRpYyB2b2lkIHNpbV9vcF9yZXRy
aWV2ZV9jYihjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLAogCQlpZiAobHNlZWsoZmQs
IChvcC0+Y3VycmVudCAtIDEpICogb3AtPnJlY29yZF9sZW5ndGggKwogCQkJCQlTSU1fQ0FDSEVf
SEVBREVSX1NJWkUsIFNFRUtfU0VUKSAhPQogCQkJCShvZmZfdCkgLTEpCi0JCQl3cml0ZShmZCwg
ZGF0YSwgb3AtPnJlY29yZF9sZW5ndGgpOworCQkJd19zaXplID0gd3JpdGUoZmQsIGRhdGEsIG9w
LT5yZWNvcmRfbGVuZ3RoKTsKIAkJY2xvc2UoZmQpOwogCX0KIApAQCAtNDA5LDYgKzQxMCw3IEBA
IHN0YXRpYyB2b2lkIHNpbV9vcF9pbmZvX2NiKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJy
b3IsIGludCBsZW5ndGgsCiAJZW51bSBzaW1fZmlsZV9hY2Nlc3MgdXBkYXRlOwogCWVudW0gc2lt
X2ZpbGVfYWNjZXNzIGludmFsaWRhdGU7CiAJZW51bSBzaW1fZmlsZV9hY2Nlc3MgcmVoYWJpbGl0
YXRlOworCXNzaXplX3Qgd19zaXplOwogCiAJaWYgKGVycm9yLT50eXBlICE9IE9GT05PX0VSUk9S
X1RZUEVfTk9fRVJST1IpIHsKIAkJc2ltX29wX2Vycm9yKG1vZGVtKTsKQEAgLTQ1OSw3ICs0NjEs
NyBAQCBzdGF0aWMgdm9pZCBzaW1fb3BfaW5mb19jYihjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3Ig
KmVycm9yLCBpbnQgbGVuZ3RoLAogCQlmaWxlaW5mb1s0XSA9IHJlY29yZF9sZW5ndGggPj4gODsK
IAkJZmlsZWluZm9bNV0gPSByZWNvcmRfbGVuZ3RoICYgMHhmZjsKIAotCQl3cml0ZShmZCwgZmls
ZWluZm8sIDYpOworCQl3X3NpemUgPSB3cml0ZShmZCwgZmlsZWluZm8sIDYpOwogCQljbG9zZShm
ZCk7CiAJfQogfQotLSAKMS42LjAuNAoK

--===============0584841972093906067==--

