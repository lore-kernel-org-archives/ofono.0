Content-Type: multipart/mixed; boundary="===============6462760561858209582=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] Present list of preferred languages on SimManager
 interface.
Date: Wed, 23 Sep 2009 22:52:21 +0200
Message-ID: <fb249edb0909231352w440052d4n83bdc818c27f414a@mail.gmail.com>
In-Reply-To: <200909171450.40482.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6462760561858209582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/9/17 Denis Kenzior <denkenz@gmail.com>:
>> 2009/9/16 Andrzej Zaborowski <andrew.zaborowski@intel.com>:
>> > So here's another version generated on top of HEAD and with an attempt
>> > to detect when the card uses EFlp format instead of EFli.
>>
>> Sorry, I sent the wrong file, here's the *actual* new version.
>
> Patch has been applied. =C2=A0I cleaned it up a little afterward. =C2=A0L=
et me know if I
> broke anything.

The only corner case where order is now different is when the first
item in EFli is empty and other items aren't.  Attached a cosmetic
patch.

Regards

--===============6462760561858209582==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-Rename-eflp_format-to-efli_format-the-opposite.patch"

RnJvbSBiMDMyM2E3NTg3MjEzOGZmZDg4M2Q4NDNiNGQwYmM4MTZjMzY3YTJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogV2VkLCAyMyBTZXAgMjAwOSAyMzoyMzo0MyArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIFJlbmFtZSBlZmxwX2Zvcm1hdCB0byBlZmxpX2Zvcm1hdCwgc2VtYW50aWNhbGx5
IG9wcG9zaXRlLgoKLS0tCiBzcmMvc2ltLmMgfCAgICA4ICsrKystLS0tCiAxIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvc2lt
LmMgYi9zcmMvc2ltLmMKaW5kZXggMWE0ZWRjNC4uZWMwMDNlZSAxMDA2NDQKLS0tIGEvc3JjL3Np
bS5jCisrKyBiL3NyYy9zaW0uYwpAQCAtMTA2NSw3ICsxMDY1LDcgQEAgc3RhdGljIHZvaWQgc2lt
X2VmcGxfcmVhZF9jYihpbnQgb2ssCiAJc3RydWN0IG9mb25vX3NpbSAqc2ltID0gdXNlcmRhdGE7
CiAJY29uc3QgY2hhciAqcGF0aCA9IF9fb2Zvbm9fYXRvbV9nZXRfcGF0aChzaW0tPmF0b20pOwog
CURCdXNDb25uZWN0aW9uICpjb25uID0gb2Zvbm9fZGJ1c19nZXRfY29ubmVjdGlvbigpOwotCWdi
b29sZWFuIGVmbHBfZm9ybWF0ID0gVFJVRTsKKwlnYm9vbGVhbiBlZmxpX2Zvcm1hdCA9IFRSVUU7
CiAJR1NMaXN0ICplZmxpID0gTlVMTDsKIAlHU0xpc3QgKmVmcGwgPSBOVUxMOwogCkBAIC0xMDc3
LDkgKzEwNzcsOSBAQCBzdGF0aWMgdm9pZCBzaW1fZWZwbF9yZWFkX2NiKGludCBvaywKIAogc2tp
cF9lZnBsOgogCWlmIChzaW0tPmVmbGkgJiYgc2ltLT5lZmxpX2xlbmd0aCA+IDApIHsKLQkJZWZs
cF9mb3JtYXQgPSBzaW1fZWZsaV9mb3JtYXQoc2ltLT5lZmxpLCBzaW0tPmVmbGlfbGVuZ3RoKTsK
KwkJZWZsaV9mb3JtYXQgPSBzaW1fZWZsaV9mb3JtYXQoc2ltLT5lZmxpLCBzaW0tPmVmbGlfbGVu
Z3RoKTsKIAotCQlpZiAoZWZscF9mb3JtYXQpCisJCWlmIChlZmxpX2Zvcm1hdCkKIAkJCWVmbGkg
PSBwYXJzZV9sYW5ndWFnZV9saXN0KHNpbS0+ZWZsaSwgc2ltLT5lZmxpX2xlbmd0aCk7CiAJCWVs
c2UKIAkJCWVmbGkgPSBwYXJzZV9lZmxwKHNpbS0+ZWZsaSwgc2ltLT5lZmxpX2xlbmd0aCk7CkBA
IC0xMDk2LDcgKzEwOTYsNyBAQCBza2lwX2VmcGw6CiAJICogcHJlZmVyZW5jZSB0byB0aGUgRUZQ
TCBhdCB0aGUgTUYgdW5sZXNzLi4uCiAJICogT3RoZXJ3aXNlIGluIG9yZGVyIG9mIHByZWZlcmVu
Y2UgYWNjb3JkaW5nIHRvIFRTIDUxLjAxMQogCSAqLwotCWlmIChlZmxwX2Zvcm1hdCkKKwlpZiAo
ZWZsaV9mb3JtYXQpCiAJCXNpbS0+bGFuZ3VhZ2VfcHJlZnMgPSBjb25jYXRfbGFuZ19wcmVmcyhl
ZmxpLCBlZnBsKTsKIAllbHNlCiAJCXNpbS0+bGFuZ3VhZ2VfcHJlZnMgPSBjb25jYXRfbGFuZ19w
cmVmcyhlZnBsLCBlZmxpKTsKLS0gCjEuNi4xCgo=

--===============6462760561858209582==--

