Content-Type: multipart/mixed; boundary="===============7123621121499414786=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] Present list of preferred languages on SimManager
 interface.
Date: Fri, 25 Sep 2009 20:56:52 +0200
Message-ID: <fb249edb0909251156jc5f3715tdab09b2ab5a359d4@mail.gmail.com>
In-Reply-To: <200909231730.03820.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7123621121499414786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2009/9/24 Denis Kenzior <denkenz@gmail.com>:
> I pushed a patch to simply ignore EFli if the first
> entry is 0xffff

I moved the check a little up because at that point the raw EFli would
have been freed already (see attached).

Regards

--===============7123621121499414786==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Check-the-first-EFli-record-before-EFli-is-freed.patch"

RnJvbSAxMjNhNDI2ZWJhMzk4NDFkOGFhYmYzZjIxZDEwMTNjN2FhMWIzYTEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogRnJpLCAyNSBTZXAgMjAwOSAwMzoyODo1MiArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIENoZWNrIHRoZSBmaXJzdCBFRmxpIHJlY29yZCBiZWZvcmUgRUZsaSBpcyBmcmVl
ZC4KCi0tLQogc3JjL3NpbS5jIHwgICAyMiArKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGVz
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3NyYy9zaW0uYyBiL3NyYy9zaW0uYwppbmRleCBjNzIyNzU0Li43MmFlYWJiIDEwMDY0NAotLS0g
YS9zcmMvc2ltLmMKKysrIGIvc3JjL3NpbS5jCkBAIC0xMTY2LDkgKzExNjYsMTUgQEAgc2tpcF9l
ZnBsOgogCWlmIChzaW0tPmVmbGkgJiYgc2ltLT5lZmxpX2xlbmd0aCA+IDApIHsKIAkJZWZsaV9m
b3JtYXQgPSBzaW1fZWZsaV9mb3JtYXQoc2ltLT5lZmxpLCBzaW0tPmVmbGlfbGVuZ3RoKTsKIAot
CQlpZiAoZWZsaV9mb3JtYXQpCi0JCQllZmxpID0gcGFyc2VfbGFuZ3VhZ2VfbGlzdChzaW0tPmVm
bGksIHNpbS0+ZWZsaV9sZW5ndGgpOwotCQllbHNlCisJCWlmIChlZmxpX2Zvcm1hdCkgeworCQkJ
LyogRGlzY2FyZCBpZiBGRkZGIGluIGhpZ2hlc3QgcHJpb3JpdHkgcG9zaXRpb24gKi8KKwkJCWlm
IChzaW0tPmVmbGlfbGVuZ3RoID49IDIgJiYgc2ltLT5lZmxpWzBdID09IDB4ZmYgJiYKKwkJCQkJ
c2ltLT5lZmxpWzFdID09IDB4ZmYpCisJCQkJZWZsaSA9IE5VTEw7CisJCQllbHNlCisJCQkJZWZs
aSA9IHBhcnNlX2xhbmd1YWdlX2xpc3Qoc2ltLT5lZmxpLAorCQkJCQkJCXNpbS0+ZWZsaV9sZW5n
dGgpOworCQl9IGVsc2UKIAkJCWVmbGkgPSBwYXJzZV9lZmxwKHNpbS0+ZWZsaSwgc2ltLT5lZmxp
X2xlbmd0aCk7CiAKIAkJZ19mcmVlKHNpbS0+ZWZsaSk7CkBAIC0xMTg2LDEzICsxMTkyLDkgQEAg
c2tpcF9lZnBsOgogCSAqICAgcHJlZmVyZW5jZSBpbiB0aGUgRUZQTCBhdCB0aGUgTUYgbGV2ZWwK
IAkgKiBPdGhlcndpc2UgaW4gb3JkZXIgb2YgcHJlZmVyZW5jZSBhY2NvcmRpbmcgdG8gVFMgNTEu
MDExCiAJICovCi0JaWYgKGVmbGlfZm9ybWF0KSB7Ci0JCWlmIChzaW0tPmVmbGlfbGVuZ3RoID49
IDIgJiYgc2ltLT5lZmxpWzBdID09IDB4ZmYgJiYKLQkJCQlzaW0tPmVmbGlbMV0gPT0gMHhmZikK
LQkJCXNpbS0+bGFuZ3VhZ2VfcHJlZnMgPSBjb25jYXRfbGFuZ19wcmVmcyhOVUxMLCBlZnBsKTsK
LQkJZWxzZQotCQkJc2ltLT5sYW5ndWFnZV9wcmVmcyA9IGNvbmNhdF9sYW5nX3ByZWZzKGVmbGks
IGVmcGwpOwotCX0gZWxzZQorCWlmIChlZmxpX2Zvcm1hdCkKKwkJc2ltLT5sYW5ndWFnZV9wcmVm
cyA9IGNvbmNhdF9sYW5nX3ByZWZzKGVmbGksIGVmcGwpOworCWVsc2UKIAkJc2ltLT5sYW5ndWFn
ZV9wcmVmcyA9IGNvbmNhdF9sYW5nX3ByZWZzKGVmcGwsIGVmbGkpOwogCiAJaWYgKGVmbGkpIHsK
LS0gCjEuNi4xCgo=

--===============7123621121499414786==--

