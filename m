Content-Type: multipart/mixed; boundary="===============4827699253799995469=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [RFC] GPRS context setup and teardown
 (doc/dataconnectionmanager-api.txt)
Date: Sun, 25 Oct 2009 08:39:27 +0200
Message-ID: <fb249edb0910242339n7e1db5f1qf62747e0fef3970b@mail.gmail.com>
In-Reply-To: <200910242243.59094.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4827699253799995469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/10/25 Denis Kenzior <denkenz@gmail.com>:
>> > Lets suppose status=3Dregistered arrives and we're already attached. =
=C2=A0Here
>> > attached will be set to FALSE, Attached property will be set to false =
and
>> > emitted. =C2=A0gprs_netreg_update will presumably reset Attached back =
to True.
>>
>> Now I see it and you're absolutely right to be alerted, I set
>> "attached" to the reverse of what it should be set to. =C2=A0We're attac=
hed
>> when we're either in REGISTERED or ROAMING state. =C2=A0If I had done it
>> right then the logic would look simple (I suppose):
>
> I still don't believe that it works. =C2=A0Suppose we're attached and reg=
istered.
> Now we get an indication that we're in 'searching' state. =C2=A0set attac=
h to true,
> compare with stored value (true). =C2=A0Ah, don't do anything -> not good.

I tried to say that I agree that current code is wrong, but assuming
the variable "attached" was set correctly, this would not happen (see
attached patch).

Now that I think of it if the current status is 'searching' then
possibly there's no point calling driver->set_attached (see second
patch).

> Resetting Powered in the core leads to strange situations where after com=
ing
> from an overseas trip you'd need to reset Powered back to on. =C2=A0I wou=
ld find
> that annoying.
>
> The nice thing is I don't think we need to play the attach/detach dance. =
=C2=A0We
> can take advantage of the netreg atom's information. =C2=A0If we're roami=
ng there,
> we will be roaming on GPRS as well. =C2=A0If we're registered there, then=
 we should
> try to attach.

That's a great idea, I will send a patch separately.

Regards

--===============4827699253799995469==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Fix-interpretation-of-new-GPRS-registration-status-s.patch"

RnJvbSAwM2Y5YjM4ZDZhZTVkOThiY2ZiNDZjM2Y2MzZiNzkxZTAxOGI2NTE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogU3VuLCAyNSBPY3QgMjAwOSAwOToxNDo1NCArMDEwMApTdWJqZWN0
OiBbUEFUQ0ggMS8yXSBGaXggaW50ZXJwcmV0YXRpb24gb2YgbmV3IEdQUlMgcmVnaXN0cmF0aW9u
IHN0YXR1cyBzaWduYWwuCgotLS0KIHNyYy9ncHJzLmMgfCAgICA0ICsrLS0KIDEgZmlsZXMgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9n
cHJzLmMgYi9zcmMvZ3Bycy5jCmluZGV4IDE4MjdjZWIuLmJjYmE5OWMgMTAwNjQ0Ci0tLSBhL3Ny
Yy9ncHJzLmMKKysrIGIvc3JjL2dwcnMuYwpAQCAtODgyLDggKzg4Miw4IEBAIHN0YXRpYyB2b2lk
IHNldF9yZWdpc3RyYXRpb25fc3RhdHVzKHN0cnVjdCBvZm9ub19ncHJzICpncHJzLCBpbnQgc3Rh
dHVzKQogCQkJCQkiU3RhdHVzIiwgREJVU19UWVBFX1NUUklORywKIAkJCQkJJnN0cl9zdGF0dXMp
OwogCi0JYXR0YWNoZWQgPSAoc3RhdHVzICE9IE5FVFdPUktfUkVHSVNUUkFUSU9OX1NUQVRVU19S
RUdJU1RFUkVEICYmCi0JCQlzdGF0dXMgIT0gTkVUV09SS19SRUdJU1RSQVRJT05fU1RBVFVTX1JP
QU1JTkcpOworCWF0dGFjaGVkID0gKHN0YXR1cyA9PSBORVRXT1JLX1JFR0lTVFJBVElPTl9TVEFU
VVNfUkVHSVNURVJFRCB8fAorCQkJc3RhdHVzID09IE5FVFdPUktfUkVHSVNUUkFUSU9OX1NUQVRV
U19ST0FNSU5HKTsKIAlpZiAoZ3Bycy0+YXR0YWNoZWQgIT0gKGludCkgYXR0YWNoZWQgJiYKIAkJ
CSEoZ3Bycy0+ZmxhZ3MgJiBHUFJTX0ZMQUdfQVRUQUNISU5HKSkgewogCQlncHJzLT5hdHRhY2hl
ZCA9IChpbnQpIGF0dGFjaGVkOwotLSAKMS42LjEKCg==

--===============4827699253799995469==
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
JiYKKwkJCSEoYXR0YWNoICYmIGdwcnMtPnN0YXR1cyAhPQorCQkJCU5FVFdPUktfUkVHSVNUUkFU
SU9OX1NUQVRVU19TRUFSQ0hJTkcpKSB7CiAJCWdwcnMtPmZsYWdzIHw9IEdQUlNfRkxBR19BVFRB
Q0hJTkc7CiAKIAkJZ3Bycy0+ZHJpdmVyLT5zZXRfYXR0YWNoZWQoZ3BycywgYXR0YWNoLCBncHJz
X2F0dGFjaF9jYWxsYmFjaywKQEAgLTg5Miw5ICs4OTQsOSBAQCBzdGF0aWMgdm9pZCBzZXRfcmVn
aXN0cmF0aW9uX3N0YXR1cyhzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3BycywgaW50IHN0YXR1cykKIAkJ
CQlEQVRBX0NPTk5FQ1RJT05fTUFOQUdFUl9JTlRFUkZBQ0UsCiAJCQkJIkF0dGFjaGVkIiwgREJV
U19UWVBFX0JPT0xFQU4sCiAJCQkJJmF0dGFjaGVkKTsKLQotCQlncHJzX25ldHJlZ191cGRhdGUo
Z3Bycyk7CiAJfQorCisJZ3Byc19uZXRyZWdfdXBkYXRlKGdwcnMpOwogfQogCiBzdGF0aWMgdm9p
ZCBzZXRfcmVnaXN0cmF0aW9uX2xvY2F0aW9uKHN0cnVjdCBvZm9ub19ncHJzICpncHJzLAotLSAK
MS42LjEKCg==

--===============4827699253799995469==--

