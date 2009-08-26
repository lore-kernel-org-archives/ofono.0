Content-Type: multipart/mixed; boundary="===============4828760776953910004=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: Read EFad and expose MNC length in IMSI as a SimManager property.
Date: Wed, 26 Aug 2009 02:37:04 +0200
Message-ID: <fb249edb0908251737h36837b3em95395c83f84b69b4@mail.gmail.com>
In-Reply-To: <fb249edb0908200720m339e1aecof0862ae1c6b0ebc5@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4828760776953910004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Attaching an updated patch.

2009/8/20 Andrzej Zaborowski <andrew.zaborowski@intel.com>:
> 2009/8/20 Gu, Yang <yang.gu@intel.com>:
>> Several minor comments on this patch:
>> 1. How about unify all the mnc_length to be unsigned char?
>> 2. For this piece of code:
>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D new_mnc_leng=
th;
>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_dbus_signal_prop=
erty_changed(conn, modem->path,
>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0SIM_MANAGER_INTERFACE,
>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"MNCLength", DBUS_TYPE_BYTE,
>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&value);
>> Is it necessary to use temporary variable value? Why not use &sim->mnc_l=
ength instead of &value?
>
> Necessary no, we can use unsigned char for sim->mnc_length --
> ofono_dbus_signal_property_changed requires unsigned char * -- it's
> just proper to use ints for integers. =C2=A0I changed it as you suggest
> nevertheless.
>
>>
>> 3. In function sim_ad_read_cb(), variable "ph" is defined by not used.
>
> Thanks for noticing, removed in the attachment.

Regards

--===============4828760776953910004==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Read-EFad-and-expose-MNC-length-in-IMSI-as-a-SimMana.patch"

RnJvbSBhNzc0M2VkZWI0YjA2NDRhMTkwNzYyMzhlMmRlMzI5ZTNhM2Q5Y2RiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogV2VkLCAyNiBBdWcgMjAwOSAwMjozNjo0NSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIFJlYWQgRUZhZCBhbmQgZXhwb3NlIE1OQyBsZW5ndGggaW4gSU1TSSBhcyBhIFNp
bU1hbmFnZXIgcHJvcGVydHkuCgpBbHRlcm5hdGl2ZWx5IHdlIGNvdWxkIGV4cG9zZSB0aGUgTU5D
IGFzIGEgc2VwYXJhdGUgcHJvcGVydHkuCi0tLQogc3JjL3NpbS5jICAgICB8ICAgNDQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHNyYy9zaW11dGlsLmggfCAg
ICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zcmMvc2ltLmMgYi9zcmMvc2ltLmMKaW5kZXggMzMwOWM5OC4uZjc2ZDRl
ZCAxMDA2NDQKLS0tIGEvc3JjL3NpbS5jCisrKyBiL3NyYy9zaW0uYwpAQCAtNzYsNiArNzYsNyBA
QCBzdHJ1Y3Qgc2ltX2ZpbGVfb3AgewogCiBzdHJ1Y3Qgb2Zvbm9fc2ltIHsKIAljaGFyICppbXNp
OworCXVuc2lnbmVkIGNoYXIgbW5jX2xlbmd0aDsKIAlHU0xpc3QgKm93bl9udW1iZXJzOwogCUdT
TGlzdCAqbmV3X251bWJlcnM7CiAJZ2Jvb2xlYW4gcmVhZHk7CkBAIC0xNTQsNiArMTU1LDEwIEBA
IHN0YXRpYyBEQnVzTWVzc2FnZSAqc2ltX2dldF9wcm9wZXJ0aWVzKERCdXNDb25uZWN0aW9uICpj
b25uLAogCQlvZm9ub19kYnVzX2RpY3RfYXBwZW5kKCZkaWN0LCAiU3Vic2NyaWJlcklkZW50aXR5
IiwKIAkJCQkJREJVU19UWVBFX1NUUklORywgJnNpbS0+aW1zaSk7CiAKKwlpZiAoc2ltLT5tbmNf
bGVuZ3RoKQorCQlvZm9ub19kYnVzX2RpY3RfYXBwZW5kKCZkaWN0LCAiTU5DTGVuZ3RoIiwKKwkJ
CQkJREJVU19UWVBFX0JZVEUsICZzaW0tPm1uY19sZW5ndGgpOworCiAJb3duX251bWJlcnMgPSBn
ZXRfb3duX251bWJlcnMoc2ltLT5vd25fbnVtYmVycyk7CiAKIAlvZm9ub19kYnVzX2RpY3RfYXBw
ZW5kX2FycmF5KCZkaWN0LCAiU3Vic2NyaWJlck51bWJlcnMiLApAQCAtNDA2LDE3ICs0MTEsNTYg
QEAgY2hlY2s6CiAJc2ltLT5uZXdfbnVtYmVycyA9IE5VTEw7CiB9CiAKK3N0YXRpYyB2b2lkIHNp
bV9hZF9yZWFkX2NiKGludCBvaywKKwkJCQllbnVtIG9mb25vX3NpbV9maWxlX3N0cnVjdHVyZSBz
dHJ1Y3R1cmUsCisJCQkJaW50IGxlbmd0aCwgaW50IHJlY29yZCwKKwkJCQljb25zdCB1bnNpZ25l
ZCBjaGFyICpkYXRhLAorCQkJCWludCByZWNvcmRfbGVuZ3RoLCB2b2lkICp1c2VyZGF0YSkKK3sK
KwlzdHJ1Y3Qgb2Zvbm9fc2ltICpzaW0gPSB1c2VyZGF0YTsKKwlEQnVzQ29ubmVjdGlvbiAqY29u
biA9IG9mb25vX2RidXNfZ2V0X2Nvbm5lY3Rpb24oKTsKKwljb25zdCBjaGFyICpwYXRoID0gX19v
Zm9ub19hdG9tX2dldF9wYXRoKHNpbS0+YXRvbSk7CisJaW50IG5ld19tbmNfbGVuZ3RoOworCisJ
aWYgKCFvaykKKwkJcmV0dXJuOworCisJaWYgKHN0cnVjdHVyZSAhPSBPRk9OT19TSU1fRklMRV9T
VFJVQ1RVUkVfVFJBTlNQQVJFTlQpCisJCXJldHVybjsKKworCWlmIChsZW5ndGggPCA0KQorCQly
ZXR1cm47CisKKwluZXdfbW5jX2xlbmd0aCA9IGRhdGFbM10gJiAweGY7CisKKwlpZiAoc2ltLT5t
bmNfbGVuZ3RoICE9IG5ld19tbmNfbGVuZ3RoKSB7CisJCXNpbS0+bW5jX2xlbmd0aCA9IG5ld19t
bmNfbGVuZ3RoOworCisJCW9mb25vX2RidXNfc2lnbmFsX3Byb3BlcnR5X2NoYW5nZWQoY29ubiwg
cGF0aCwKKwkJCQkJCVNJTV9NQU5BR0VSX0lOVEVSRkFDRSwKKwkJCQkJCSJNTkNMZW5ndGgiLCBE
QlVTX1RZUEVfQllURSwKKwkJCQkJCSZzaW0tPm1uY19sZW5ndGgpOworCX0KK30KKwogc3RhdGlj
IHZvaWQgc2ltX293bl9udW1iZXJzX3VwZGF0ZShzdHJ1Y3Qgb2Zvbm9fc2ltICpzaW0pCiB7CiAJ
b2Zvbm9fc2ltX3JlYWQoc2ltLCBTSU1fRUZNU0lTRE5fRklMRUlELAogCQkJc2ltX21zaXNkbl9y
ZWFkX2NiLCBzaW0pOwogfQogCitzdGF0aWMgdm9pZCBzaW1fbW5jX2xlbmd0aF91cGRhdGUoc3Ry
dWN0IG9mb25vX3NpbSAqc2ltKQoreworCW9mb25vX3NpbV9yZWFkKHNpbSwgU0lNX0VGQURfRklM
RUlELAorCQkJc2ltX2FkX3JlYWRfY2IsIHNpbSk7Cit9CisKIHN0YXRpYyB2b2lkIHNpbV9yZWFk
eSh2b2lkICp1c2VyKQogewogCXN0cnVjdCBvZm9ub19zaW0gKnNpbSA9IHVzZXI7CiAKIAlzaW1f
b3duX251bWJlcnNfdXBkYXRlKHNpbSk7CisJc2ltX21uY19sZW5ndGhfdXBkYXRlKHNpbSk7CiB9
CiAKIHN0YXRpYyB2b2lkIHNpbV9pbXNpX2NiKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJy
b3IsIGNvbnN0IGNoYXIgKmltc2ksCmRpZmYgLS1naXQgYS9zcmMvc2ltdXRpbC5oIGIvc3JjL3Np
bXV0aWwuaAppbmRleCBjMGQzZDUyLi45YmI1MzIzIDEwMDY0NAotLS0gYS9zcmMvc2ltdXRpbC5o
CisrKyBiL3NyYy9zaW11dGlsLmgKQEAgLTIyLDYgKzIyLDcgQEAKIGVudW0gc2ltX2ZpbGVpZCB7
CiAJU0lNX0VGTVNJU0ROX0ZJTEVJRCA9IDB4NmY0MCwKIAlTSU1fRUZTUE5fRklMRUlEID0gMHg2
ZjQ2LAorCVNJTV9FRkFEX0ZJTEVJRCA9IDB4NmZhZCwKIAlTSU1fRUZQTk5fRklMRUlEID0gMHg2
ZmM1LAogCVNJTV9FRk9QTF9GSUxFSUQgPSAweDZmYzYsCiAJU0lNX0VGTUJETl9GSUxFSUQgPSAw
eDZmYzcsCi0tIAoxLjYuMQoK

--===============4828760776953910004==--

