Content-Type: multipart/mixed; boundary="===============0012994457230421655=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [RFC] GPRS context setup and teardown
 (doc/dataconnectionmanager-api.txt)
Date: Sun, 25 Oct 2009 08:43:43 +0200
Message-ID: <fb249edb0910242343h6198ac24vac6112b09d1d833a@mail.gmail.com>
In-Reply-To: <fb249edb0910242339n7e1db5f1qf62747e0fef3970b@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0012994457230421655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/10/25 andrzej zaborowski <balrogg@gmail.com>:
> Now that I think of it if the current status is 'searching' then
> possibly there's no point calling driver->set_attached (see second
> patch).

I repeated the same typo in this patch, attached is a corrected version, so=
rry.

Regards

--===============0012994457230421655==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-Don-t-ask-driver-to-attach-GPRS-if-modem-is-already.patch"

RnJvbSBkMGYwMzMxZWE4ZDNmOGM0ZGY3NTA2OWNmY2EwODJiYjk5Y2UwZGZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogU3VuLCAyNSBPY3QgMjAwOSAwOTozNToyNiArMDEwMApTdWJqZWN0
OiBbUEFUQ0ggMi8yXSBEb24ndCBhc2sgZHJpdmVyIHRvIGF0dGFjaCBHUFJTIGlmIG1vZGVtIGlz
IGFscmVhZHkgc2VhcmNoaW5nIGZvciBvcGVyYXRvci4KCi0tLQogc3JjL2dwcnMuYyB8ICAgIDgg
KysrKystLS0KIDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3NyYy9ncHJzLmMgYi9zcmMvZ3Bycy5jCmluZGV4IGJjYmE5OWMuLjI3
NjljMjcgMTAwNjQ0Ci0tLSBhL3NyYy9ncHJzLmMKKysrIGIvc3JjL2dwcnMuYwpAQCAtNTQzLDcg
KzU0Myw5IEBAIHN0YXRpYyB2b2lkIGdwcnNfbmV0cmVnX3VwZGF0ZShzdHJ1Y3Qgb2Zvbm9fZ3By
cyAqZ3BycykKIAlhdHRhY2ggPSBncHJzLT5wb3dlcmVkICYmIG9wZXJhdG9yX29rOwogCiAJaWYg
KGdwcnMtPmF0dGFjaGVkICE9IGF0dGFjaCAmJgotCQkJIShncHJzLT5mbGFncyAmIEdQUlNfRkxB
R19BVFRBQ0hJTkcpKSB7CisJCQkhKGdwcnMtPmZsYWdzICYgR1BSU19GTEFHX0FUVEFDSElORykg
JiYKKwkJCSEoYXR0YWNoICYmIGdwcnMtPnN0YXR1cyA9PQorCQkJCU5FVFdPUktfUkVHSVNUUkFU
SU9OX1NUQVRVU19TRUFSQ0hJTkcpKSB7CiAJCWdwcnMtPmZsYWdzIHw9IEdQUlNfRkxBR19BVFRB
Q0hJTkc7CiAKIAkJZ3Bycy0+ZHJpdmVyLT5zZXRfYXR0YWNoZWQoZ3BycywgYXR0YWNoLCBncHJz
X2F0dGFjaF9jYWxsYmFjaywKQEAgLTg5Miw5ICs4OTQsOSBAQCBzdGF0aWMgdm9pZCBzZXRfcmVn
aXN0cmF0aW9uX3N0YXR1cyhzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3BycywgaW50IHN0YXR1cykKIAkJ
CQlEQVRBX0NPTk5FQ1RJT05fTUFOQUdFUl9JTlRFUkZBQ0UsCiAJCQkJIkF0dGFjaGVkIiwgREJV
U19UWVBFX0JPT0xFQU4sCiAJCQkJJmF0dGFjaGVkKTsKLQotCQlncHJzX25ldHJlZ191cGRhdGUo
Z3Bycyk7CiAJfQorCisJZ3Byc19uZXRyZWdfdXBkYXRlKGdwcnMpOwogfQogCiBzdGF0aWMgdm9p
ZCBzZXRfcmVnaXN0cmF0aW9uX2xvY2F0aW9uKHN0cnVjdCBvZm9ub19ncHJzICpncHJzLAotLSAK
MS42LjEKCg==

--===============0012994457230421655==--

