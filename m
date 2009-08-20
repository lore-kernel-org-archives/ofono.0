Content-Type: multipart/mixed; boundary="===============2779090102404376118=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: Read EFad and expose MNC length in IMSI as a SimManager property.
Date: Thu, 20 Aug 2009 16:20:19 +0200
Message-ID: <fb249edb0908200720m339e1aecof0862ae1c6b0ebc5@mail.gmail.com>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001AB3CC719@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2779090102404376118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/8/20 Gu, Yang <yang.gu@intel.com>:
> Several minor comments on this patch:
> 1. How about unify all the mnc_length to be unsigned char?
> 2. For this piece of code:
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D new_mnc_lengt=
h;
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_dbus_signal_prope=
rty_changed(conn, modem->path,
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0SIM_MANAGER_INTERFACE,
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"MNCLength", DBUS_TYPE_BYTE,
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&value);
> Is it necessary to use temporary variable value? Why not use &sim->mnc_le=
ngth instead of &value?

Necessary no, we can use unsigned char for sim->mnc_length --
ofono_dbus_signal_property_changed requires unsigned char * -- it's
just proper to use ints for integers.  I changed it as you suggest
nevertheless.

>
> 3. In function sim_ad_read_cb(), variable "ph" is defined by not used.

Thanks for noticing, removed in the attachment.

Regards

--===============2779090102404376118==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Read-EFad-and-expose-MNC-length-in-IMSI-as-a-SimMana.patch"

RnJvbSAyNzRlZWVlMjk3ZTQ1YjFhZDc1MzZjZGFmODBjNDFhZjVhMDYzNDExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogVGh1LCAyMCBBdWcgMjAwOSAxODowMTowNyArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIFJlYWQgRUZhZCBhbmQgZXhwb3NlIE1OQyBsZW5ndGggaW4gSU1TSSBhcyBhIFNp
bU1hbmFnZXIgcHJvcGVydHkuCgpBbHRlcm5hdGl2ZWx5IHdlIGNvdWxkIGV4cG9zZSB0aGUgTU5D
IGFzIGEgc2VwYXJhdGUgcHJvcGVydHkuCi0tLQogc3JjL3NpbS5jICAgICB8ICAgNDMgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogc3JjL3NpbXV0aWwuaCB8ICAg
IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3NyYy9zaW0uYyBiL3NyYy9zaW0uYwppbmRleCAzOTk3NmIzLi5kNDM4N2M5
IDEwMDY0NAotLS0gYS9zcmMvc2ltLmMKKysrIGIvc3JjL3NpbS5jCkBAIC03Nyw2ICs3Nyw3IEBA
IHN0cnVjdCBzaW1fZmlsZV9vcCB7CiBzdHJ1Y3Qgc2ltX21hbmFnZXJfZGF0YSB7CiAJc3RydWN0
IG9mb25vX3NpbV9vcHMgKm9wczsKIAljaGFyICppbXNpOworCXVuc2lnbmVkIGNoYXIgbW5jX2xl
bmd0aDsKIAlHU0xpc3QgKm93bl9udW1iZXJzOwogCUdTTGlzdCAqbmV3X251bWJlcnM7CiAJR1NM
aXN0ICpyZWFkeV9ub3RpZnk7CkBAIC0xNzksNiArMTgwLDEwIEBAIHN0YXRpYyBEQnVzTWVzc2Fn
ZSAqc2ltX2dldF9wcm9wZXJ0aWVzKERCdXNDb25uZWN0aW9uICpjb25uLAogCQlvZm9ub19kYnVz
X2RpY3RfYXBwZW5kKCZkaWN0LCAiU3Vic2NyaWJlcklkZW50aXR5IiwKIAkJCQkJREJVU19UWVBF
X1NUUklORywgJnNpbS0+aW1zaSk7CiAKKwlpZiAoc2ltLT5tbmNfbGVuZ3RoKQorCQlvZm9ub19k
YnVzX2RpY3RfYXBwZW5kKCZkaWN0LCAiTU5DTGVuZ3RoIiwKKwkJCQkJREJVU19UWVBFX0JZVEUs
ICZzaW0tPm1uY19sZW5ndGgpOworCiAJb3duX251bWJlcnMgPSBnZXRfb3duX251bWJlcnMoc2lt
LT5vd25fbnVtYmVycyk7CiAKIAlvZm9ub19kYnVzX2RpY3RfYXBwZW5kX2FycmF5KCZkaWN0LCAi
U3Vic2NyaWJlck51bWJlcnMiLApAQCAtNDMyLDE1ICs0MzcsNTMgQEAgY2hlY2s6CiAJc2ltLT5u
ZXdfbnVtYmVycyA9IE5VTEw7CiB9CiAKK3N0YXRpYyB2b2lkIHNpbV9hZF9yZWFkX2NiKHN0cnVj
dCBvZm9ub19tb2RlbSAqbW9kZW0sIGludCBvaywKKwkJCQllbnVtIG9mb25vX3NpbV9maWxlX3N0
cnVjdHVyZSBzdHJ1Y3R1cmUsCisJCQkJaW50IGxlbmd0aCwgaW50IHJlY29yZCwKKwkJCQljb25z
dCB1bnNpZ25lZCBjaGFyICpkYXRhLAorCQkJCWludCByZWNvcmRfbGVuZ3RoLCB2b2lkICp1c2Vy
ZGF0YSkKK3sKKwlzdHJ1Y3Qgc2ltX21hbmFnZXJfZGF0YSAqc2ltID0gdXNlcmRhdGE7CisJREJ1
c0Nvbm5lY3Rpb24gKmNvbm4gPSBvZm9ub19kYnVzX2dldF9jb25uZWN0aW9uKCk7CisJaW50IG5l
d19tbmNfbGVuZ3RoOworCisJaWYgKCFvaykKKwkJcmV0dXJuOworCisJaWYgKHN0cnVjdHVyZSAh
PSBPRk9OT19TSU1fRklMRV9TVFJVQ1RVUkVfVFJBTlNQQVJFTlQpCisJCXJldHVybjsKKworCWlm
IChsZW5ndGggPCA0KQorCQlyZXR1cm47CisKKwluZXdfbW5jX2xlbmd0aCA9IGRhdGFbM10gJiAw
eGY7CisKKwlpZiAoc2ltLT5tbmNfbGVuZ3RoICE9IG5ld19tbmNfbGVuZ3RoKSB7CisJCXNpbS0+
bW5jX2xlbmd0aCA9IG5ld19tbmNfbGVuZ3RoOworCisJCW9mb25vX2RidXNfc2lnbmFsX3Byb3Bl
cnR5X2NoYW5nZWQoY29ubiwgbW9kZW0tPnBhdGgsCisJCQkJCQlTSU1fTUFOQUdFUl9JTlRFUkZB
Q0UsCisJCQkJCQkiTU5DTGVuZ3RoIiwgREJVU19UWVBFX0JZVEUsCisJCQkJCQkmc2ltLT5tbmNf
bGVuZ3RoKTsKKwl9Cit9CisKIHN0YXRpYyB2b2lkIHNpbV9vd25fbnVtYmVyc191cGRhdGUoc3Ry
dWN0IG9mb25vX21vZGVtICptb2RlbSkKIHsKIAlvZm9ub19zaW1fcmVhZChtb2RlbSwgU0lNX0VG
TVNJU0ROX0ZJTEVJRCwKIAkJCXNpbV9tc2lzZG5fcmVhZF9jYiwgbW9kZW0tPnNpbV9tYW5hZ2Vy
KTsKIH0KIAorc3RhdGljIHZvaWQgc2ltX21uY19sZW5ndGhfdXBkYXRlKHN0cnVjdCBvZm9ub19t
b2RlbSAqbW9kZW0pCit7CisJb2Zvbm9fc2ltX3JlYWQobW9kZW0sIFNJTV9FRkFEX0ZJTEVJRCwK
KwkJCXNpbV9hZF9yZWFkX2NiLCBtb2RlbS0+c2ltX21hbmFnZXIpOworfQorCiBzdGF0aWMgdm9p
ZCBzaW1fcmVhZHkoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSkKIHsKIAlzaW1fb3duX251bWJl
cnNfdXBkYXRlKG1vZGVtKTsKKwlzaW1fbW5jX2xlbmd0aF91cGRhdGUobW9kZW0pOwogfQogCiBz
dGF0aWMgdm9pZCBzaW1faW1zaV9jYihjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLCBj
b25zdCBjaGFyICppbXNpLApkaWZmIC0tZ2l0IGEvc3JjL3NpbXV0aWwuaCBiL3NyYy9zaW11dGls
LmgKaW5kZXggYzBkM2Q1Mi4uOWJiNTMyMyAxMDA2NDQKLS0tIGEvc3JjL3NpbXV0aWwuaAorKysg
Yi9zcmMvc2ltdXRpbC5oCkBAIC0yMiw2ICsyMiw3IEBACiBlbnVtIHNpbV9maWxlaWQgewogCVNJ
TV9FRk1TSVNETl9GSUxFSUQgPSAweDZmNDAsCiAJU0lNX0VGU1BOX0ZJTEVJRCA9IDB4NmY0NiwK
KwlTSU1fRUZBRF9GSUxFSUQgPSAweDZmYWQsCiAJU0lNX0VGUE5OX0ZJTEVJRCA9IDB4NmZjNSwK
IAlTSU1fRUZPUExfRklMRUlEID0gMHg2ZmM2LAogCVNJTV9FRk1CRE5fRklMRUlEID0gMHg2ZmM3
LAotLSAKMS42LjEKCg==

--===============2779090102404376118==--

