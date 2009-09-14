Content-Type: multipart/mixed; boundary="===============5461362076153941227=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] Present list of preferred languages on SimManager
 interface.
Date: Mon, 14 Sep 2009 19:33:24 +0200
Message-ID: <fb249edb0909141033o6ed93fe6p3fbc0e50fcffbb9f@mail.gmail.com>
In-Reply-To: <200909141106.48522.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5461362076153941227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2009/9/14 Denis Kenzior <denkenz@gmail.com>:
>> +static int parse_language_list(char **out_list, const unsigned char
>> *sim_list, + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int length)
>> +{
>> + =C2=A0 =C2=A0 unsigned char code[3];
>> + =C2=A0 =C2=A0 int count, i;
>> + =C2=A0 =C2=A0 long written;
>> +
>> + =C2=A0 =C2=A0 count =3D 0;
>> + =C2=A0 =C2=A0 length--;
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < length; i +=3D 2) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code[0] =3D sim_list[i + 0];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code[1] =3D sim_list[i + 1];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code[2] =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (code[0] =3D=3D 0xff || c=
ode[1] =3D=3D 0xff)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
continue;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_list[count] =3D convert_=
gsm_to_utf8(code, 2,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, &written, 0);
>
> Lets skip the gsm conversion. =C2=A0The ISO639 standard only uses latin c=
haracters
> which are guaranteed to be the same between utf8 / gsm.

Ok, I was considering doing that but decided there wasn't any gain
from not doing the conversion.

>
>> +static void sim_efpl_read_cb(int ok,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum ofono_sim_file_structure structure,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int length, int record,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *data,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int record_length, void *userdata)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_sim *sim =3D userdata;
>> + =C2=A0 =C2=A0 unsigned char *efli =3D sim->efli;
>> + =C2=A0 =C2=A0 const unsigned char *efpl =3D data;
>> + =C2=A0 =C2=A0 int efli_length =3D sim->efli_length;
>> + =C2=A0 =C2=A0 int efpl_length =3D length;
>> + =C2=A0 =C2=A0 int count;
>> + =C2=A0 =C2=A0 const char *path =3D __ofono_atom_get_path(sim->atom);
>> + =C2=A0 =C2=A0 DBusConnection *conn =3D ofono_dbus_get_connection();
>> +
>> + =C2=A0 =C2=A0 if (!ok || structure !=3D OFONO_SIM_FILE_STRUCTURE_TRANS=
PARENT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 efpl =3D NULL;
>> +
>> + =C2=A0 =C2=A0 if (length < 2)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 efpl =3D NULL;
>> +
>> + =C2=A0 =C2=A0 sim->language_prefs =3D g_malloc(((efli_length + efpl_le=
ngth) / 2 + 1) *
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
sizeof(char *));
>> +
>> + =C2=A0 =C2=A0 count =3D 0;
>> +
>> + =C2=A0 =C2=A0 /* Make a list of languages in both files in order of pr=
eferences
>> + =C2=A0 =C2=A0 =C2=A0* following 31.102.
>> + =C2=A0 =C2=A0 =C2=A0*/
>> +
>> + =C2=A0 =C2=A0 if (efli && efpl && efli[0] =3D=3D 0xff && efli[1] =3D=
=3D 0xff) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count +=3D parse_language_li=
st(sim->language_prefs + count,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 efpl, efpl_length);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 efpl =3D NULL;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (efli) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count +=3D parse_language_li=
st(sim->language_prefs + count,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 efli, efli_length);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(efli);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->efli =3D NULL;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (efpl)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count +=3D parse_language_li=
st(sim->language_prefs + count,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 efpl, efpl_length);
>
> If we're going down the path of preserving both EFli and EFpl, then you s=
hould
> make sure no duplicates exist. Alternatively we can assume that oFono/UI =
will
> support all languages and simply not read EFpl if there is useable inform=
ation
> in EFli.

Let's present the full list, I added checking for duplicates.

>
>> +static void sim_retrieve_efli(struct ofono_sim *sim)
>> +{
>> + =C2=A0 =C2=A0 /* According to 31.102 the EFli is read first and EFpl i=
s then
>> + =C2=A0 =C2=A0 =C2=A0* only read if none of the EFli languages are supp=
orted by user
>> + =C2=A0 =C2=A0 =C2=A0* interface. =C2=A051.011 mandates the exact oppos=
ite, making EFpl/EFelp
>> + =C2=A0 =C2=A0 =C2=A0* preferred over EFlp (same ID as EFli, different =
format).
>> + =C2=A0 =C2=A0 =C2=A0* However we don't depend on the user interface an=
d so
>> + =C2=A0 =C2=A0 =C2=A0* need to read both files now.
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 ofono_sim_read(sim, SIM_EFLI_FILEID, sim_efli_read_cb, s=
im);
>> + =C2=A0 =C2=A0 ofono_sim_read(sim, SIM_EFPL_FILEID, sim_efpl_read_cb, s=
im);
>
> Strictly speaking 31.101 & 31.102 supersede 51.011.

I think that was the plan but apparently they don't have all contents
51.011 has, and 31.102 even explicitely refers to 51.011 for the EFpl
format (which 51.011 only says is defined by ETSI).

Also the card I tested has a 5 byte EFli / EFlp, filled with 0xff
bytes, which means it must be in the 51.011 format so the document is
not obsolete.

Regards

--===============5461362076153941227==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Present-list-of-preferred-languages-on-SimManager-in.patch"

RnJvbSA3NjNhMGIxMmE2NjM2ZDdmMWVjNWJlOTlkOGZlMjRjNTkyNWM2Njc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogTW9uLCAxNCBTZXAgMjAwOSAyMToyNTowNSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIFByZXNlbnQgbGlzdCBvZiBwcmVmZXJyZWQgbGFuZ3VhZ2VzIG9uIFNpbU1hbmFn
ZXIgaW50ZXJmYWNlLgoKUGF0Y2ggbWFkZSBvbiB0b3Agb2YgW1BBVENIXSBEbyB0aGUgUElOIGNo
ZWNrIGluIFNJTU1hbmFnZXIuCi0tLQogc3JjL3NpbS5jICAgICB8ICAxMjQgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBzcmMvc2ltdXRp
bC5oIHwgICAgMiArCiAyIGZpbGVzIGNoYW5nZWQsIDEyNiBpbnNlcnRpb25zKCspLCAwIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9zaW0uYyBiL3NyYy9zaW0uYwppbmRleCAzODg2NDg1
Li43YTQyZWU3IDEwMDY0NAotLS0gYS9zcmMvc2ltLmMKKysrIGIvc3JjL3NpbS5jCkBAIC04MCwx
MCArODAsMTMgQEAgc3RydWN0IG9mb25vX3NpbSB7CiAJZ2Jvb2xlYW4gcmVhZHk7CiAJZ2Jvb2xl
YW4gcGluX3JlYWR5OwogCWludCBwaW5fdHlwZTsKKwljaGFyICoqbGFuZ3VhZ2VfcHJlZnM7CiAJ
R1F1ZXVlICpzaW1vcF9xOwogCWdpbnQgc2ltb3Bfc291cmNlOwogCXVuc2lnbmVkIGNoYXIgZWZt
c2lzZG5fbGVuZ3RoOwogCXVuc2lnbmVkIGNoYXIgZWZtc2lzZG5fcmVjb3JkczsKKwl1bnNpZ25l
ZCBjaGFyICplZmxpOworCXVuc2lnbmVkIGNoYXIgZWZsaV9sZW5ndGg7CiAJdW5zaWduZWQgaW50
IG5leHRfcmVhZHlfd2F0Y2hfaWQ7CiAJR1NMaXN0ICpyZWFkeV93YXRjaGVzOwogCWNvbnN0IHN0
cnVjdCBvZm9ub19zaW1fZHJpdmVyICpkcml2ZXI7CkBAIC0yMjQsNiArMjI3LDExIEBAIHN0YXRp
YyBEQnVzTWVzc2FnZSAqc2ltX2dldF9wcm9wZXJ0aWVzKERCdXNDb25uZWN0aW9uICpjb25uLAog
CQkJCQkodm9pZCAqKSAmcGluX25hbWUpOwogCX0KIAorCWlmIChzaW0tPmxhbmd1YWdlX3ByZWZz
KQorCQlvZm9ub19kYnVzX2RpY3RfYXBwZW5kX2FycmF5KCZkaWN0LCAiUHJlZmVycmVkTGFuZ3Vh
Z2VzIiwKKwkJCQkJCURCVVNfVFlQRV9TVFJJTkcsCisJCQkJCQkmc2ltLT5sYW5ndWFnZV9wcmVm
cyk7CisKIAlkYnVzX21lc3NhZ2VfaXRlcl9jbG9zZV9jb250YWluZXIoJml0ZXIsICZkaWN0KTsK
IAogCXJldHVybiByZXBseTsKQEAgLTc0Niw2ICs3NTQsMTE2IEBAIHN0YXRpYyB2b2lkIHNpbV9w
aW5fY2hlY2soc3RydWN0IG9mb25vX3NpbSAqc2ltKQogCXNpbS0+ZHJpdmVyLT5xdWVyeV9wYXNz
d2Rfc3RhdGUoc2ltLCBzaW1fcGluX3F1ZXJ5X2NiLCBzaW0pOwogfQogCitzdGF0aWMgdm9pZCBz
aW1fZWZsaV9yZWFkX2NiKGludCBvaywKKwkJCQllbnVtIG9mb25vX3NpbV9maWxlX3N0cnVjdHVy
ZSBzdHJ1Y3R1cmUsCisJCQkJaW50IGxlbmd0aCwgaW50IHJlY29yZCwKKwkJCQljb25zdCB1bnNp
Z25lZCBjaGFyICpkYXRhLAorCQkJCWludCByZWNvcmRfbGVuZ3RoLCB2b2lkICp1c2VyZGF0YSkK
K3sKKwlzdHJ1Y3Qgb2Zvbm9fc2ltICpzaW0gPSB1c2VyZGF0YTsKKworCWlmICghb2sgfHwgc3Ry
dWN0dXJlICE9IE9GT05PX1NJTV9GSUxFX1NUUlVDVFVSRV9UUkFOU1BBUkVOVCkKKwkJcmV0dXJu
OworCisJaWYgKGxlbmd0aCA8IDIpCisJCXJldHVybjsKKworCXNpbS0+ZWZsaSA9IGdfbWVtZHVw
KGRhdGEsIGxlbmd0aCk7CisJc2ltLT5lZmxpX2xlbmd0aCA9IGxlbmd0aDsKK30KKworc3RhdGlj
IHZvaWQgcGFyc2VfbGFuZ3VhZ2VfbGlzdChjaGFyICoqb3V0X2xpc3QsIGludCAqY291bnQsCisJ
CQkJY29uc3QgdW5zaWduZWQgY2hhciAqc2ltX2xpc3QsIGludCBsZW5ndGgpCit7CisJaW50IGks
IGo7CisKKwlsZW5ndGgtLTsKKworCWZvciAoaSA9IDA7IGkgPCBsZW5ndGg7IGkgKz0gMikgewor
CQlpZiAoc2ltX2xpc3RbaV0gPT0gMHhmZiB8fCBzaW1fbGlzdFtpICsgMV0gPT0gMHhmZikKKwkJ
CWNvbnRpbnVlOworCisJCWZvciAoaiA9IDA7IGogPCAqY291bnQ7IGorKykKKwkJCWlmICghbWVt
Y21wKG91dF9saXN0W2pdLCBzaW1fbGlzdCArIGksIDIpKQorCQkJCWJyZWFrOworCQlpZiAoaiA8
ICpjb3VudCkKKwkJCWNvbnRpbnVlOworCisJCS8qIElTTyA2MzkgY29kZXMgY29udGFpbiBvbmx5
IGNoYXJhY3RlcnMgdGhhdCBhcmUgY29kZWQKKwkJICogaWRlbnRpY2FsbHkgaW4gU01TIDcgYml0
IGNoYXJzZXQsIEFTQ0lJIG9yIFVURjggc28KKwkJICogbm8gY29udmVyc2lvbi4KKwkJICovCisJ
CW91dF9saXN0WygqY291bnQpKytdID0gZ19zdHJuZHVwKChjaGFyICopIHNpbV9saXN0ICsgaSwg
Mik7CisJfQorfQorCitzdGF0aWMgdm9pZCBzaW1fZWZwbF9yZWFkX2NiKGludCBvaywKKwkJCQll
bnVtIG9mb25vX3NpbV9maWxlX3N0cnVjdHVyZSBzdHJ1Y3R1cmUsCisJCQkJaW50IGxlbmd0aCwg
aW50IHJlY29yZCwKKwkJCQljb25zdCB1bnNpZ25lZCBjaGFyICpkYXRhLAorCQkJCWludCByZWNv
cmRfbGVuZ3RoLCB2b2lkICp1c2VyZGF0YSkKK3sKKwlzdHJ1Y3Qgb2Zvbm9fc2ltICpzaW0gPSB1
c2VyZGF0YTsKKwl1bnNpZ25lZCBjaGFyICplZmxpID0gc2ltLT5lZmxpOworCWNvbnN0IHVuc2ln
bmVkIGNoYXIgKmVmcGwgPSBkYXRhOworCWludCBlZmxpX2xlbmd0aCA9IHNpbS0+ZWZsaV9sZW5n
dGg7CisJaW50IGVmcGxfbGVuZ3RoID0gbGVuZ3RoOworCWludCBjb3VudDsKKwljb25zdCBjaGFy
ICpwYXRoID0gX19vZm9ub19hdG9tX2dldF9wYXRoKHNpbS0+YXRvbSk7CisJREJ1c0Nvbm5lY3Rp
b24gKmNvbm4gPSBvZm9ub19kYnVzX2dldF9jb25uZWN0aW9uKCk7CisKKwlpZiAoIW9rIHx8IHN0
cnVjdHVyZSAhPSBPRk9OT19TSU1fRklMRV9TVFJVQ1RVUkVfVFJBTlNQQVJFTlQpCisJCWVmcGwg
PSBOVUxMOworCisJaWYgKGxlbmd0aCA8IDIpCisJCWVmcGwgPSBOVUxMOworCisJc2ltLT5sYW5n
dWFnZV9wcmVmcyA9IGdfbmV3MChjaGFyICosCisJCQkJCShlZmxpX2xlbmd0aCArIGVmcGxfbGVu
Z3RoKSAvIDIgKyAxKTsKKworCWNvdW50ID0gMDsKKworCS8qIE1ha2UgYSBsaXN0IG9mIGxhbmd1
YWdlcyBpbiBib3RoIGZpbGVzIGluIG9yZGVyIG9mIHByZWZlcmVuY2VzCisJICogZm9sbG93aW5n
IDMxLjEwMi4KKwkgKi8KKworCWlmIChlZmxpICYmIGVmcGwgJiYgZWZsaVswXSA9PSAweGZmICYm
IGVmbGlbMV0gPT0gMHhmZikgeworCQlwYXJzZV9sYW5ndWFnZV9saXN0KHNpbS0+bGFuZ3VhZ2Vf
cHJlZnMsICZjb3VudCwKKwkJCQkJZWZwbCwgZWZwbF9sZW5ndGgpOworCQllZnBsID0gTlVMTDsK
Kwl9CisKKwlpZiAoZWZsaSkgeworCQlwYXJzZV9sYW5ndWFnZV9saXN0KHNpbS0+bGFuZ3VhZ2Vf
cHJlZnMsICZjb3VudCwKKwkJCQkJZWZsaSwgZWZsaV9sZW5ndGgpOworCQlnX2ZyZWUoZWZsaSk7
CisJCXNpbS0+ZWZsaSA9IE5VTEw7CisJfQorCisJaWYgKGVmcGwpCisJCXBhcnNlX2xhbmd1YWdl
X2xpc3Qoc2ltLT5sYW5ndWFnZV9wcmVmcywgJmNvdW50LAorCQkJCQllZnBsLCBlZnBsX2xlbmd0
aCk7CisKKwlvZm9ub19kYnVzX3NpZ25hbF9hcnJheV9wcm9wZXJ0eV9jaGFuZ2VkKGNvbm4sIHBh
dGgsCisJCQkJCQkJU0lNX01BTkFHRVJfSU5URVJGQUNFLAorCQkJCQkJCSJQcmVmZXJyZWRMYW5n
dWFnZXMiLAorCQkJCQkJCURCVVNfVFlQRV9TVFJJTkcsCisJCQkJCQkJJnNpbS0+bGFuZ3VhZ2Vf
cHJlZnMpOworfQorCitzdGF0aWMgdm9pZCBzaW1fcmV0cmlldmVfZWZsaShzdHJ1Y3Qgb2Zvbm9f
c2ltICpzaW0pCit7CisJLyogQWNjb3JkaW5nIHRvIDMxLjEwMiB0aGUgRUZsaSBpcyByZWFkIGZp
cnN0IGFuZCBFRnBsIGlzIHRoZW4KKwkgKiBvbmx5IHJlYWQgaWYgbm9uZSBvZiB0aGUgRUZsaSBs
YW5ndWFnZXMgYXJlIHN1cHBvcnRlZCBieSB1c2VyCisJICogaW50ZXJmYWNlLiAgNTEuMDExIG1h
bmRhdGVzIHRoZSBleGFjdCBvcHBvc2l0ZSwgbWFraW5nIEVGcGwvRUZlbHAKKwkgKiBwcmVmZXJy
ZWQgb3ZlciBFRmxwIChzYW1lIElEIGFzIEVGbGksIGRpZmZlcmVudCBmb3JtYXQpLgorCSAqIEhv
d2V2ZXIgd2UgZG9uJ3QgZGVwZW5kIG9uIHRoZSB1c2VyIGludGVyZmFjZSBhbmQgc28KKwkgKiBu
ZWVkIHRvIHJlYWQgYm90aCBmaWxlcyBub3cuCisJICovCisJb2Zvbm9fc2ltX3JlYWQoc2ltLCBT
SU1fRUZMSV9GSUxFSUQsIHNpbV9lZmxpX3JlYWRfY2IsIHNpbSk7CisJb2Zvbm9fc2ltX3JlYWQo
c2ltLCBTSU1fRUZQTF9GSUxFSUQsIHNpbV9lZnBsX3JlYWRfY2IsIHNpbSk7Cit9CisKIHN0YXRp
YyB2b2lkIHNpbV9vcF9lcnJvcihzdHJ1Y3Qgb2Zvbm9fc2ltICpzaW0pCiB7CiAJc3RydWN0IHNp
bV9maWxlX29wICpvcCA9IGdfcXVldWVfcG9wX2hlYWQoc2ltLT5zaW1vcF9xKTsKQEAgLTEzNTcs
NiArMTQ3NSwxMSBAQCBzdGF0aWMgdm9pZCBzaW1fcmVtb3ZlKHN0cnVjdCBvZm9ub19hdG9tICph
dG9tKQogCQlzaW0tPnNlcnZpY2VfbnVtYmVycyA9IE5VTEw7CiAJfQogCisJaWYgKHNpbS0+bGFu
Z3VhZ2VfcHJlZnMpIHsKKwkJZ19zdHJmcmVldihzaW0tPmxhbmd1YWdlX3ByZWZzKTsKKwkJc2lt
LT5sYW5ndWFnZV9wcmVmcyA9IE5VTEw7CisJfQorCiAJaWYgKHNpbS0+c2ltb3Bfc291cmNlKSB7
CiAJCWdfc291cmNlX3JlbW92ZShzaW0tPnNpbW9wX3NvdXJjZSk7CiAJCXNpbS0+c2ltb3Bfc291
cmNlID0gMDsKQEAgLTE0NDYsNiArMTU2OSw3IEBAIHZvaWQgb2Zvbm9fc2ltX3JlZ2lzdGVyKHN0
cnVjdCBvZm9ub19zaW0gKnNpbSkKIAkgKiBhcmJpdHJhcnkgZmlsZXMgdG8gYmUgd3JpdHRlbiBv
ciByZWFkLCBhc3N1bWluZyB0aGVpciBwcmVzZW5jZQogCSAqIGluIHRoZSBFRnVzdAogCSAqLwor
CXNpbV9yZXRyaWV2ZV9lZmxpKHNpbSk7CiAJc2ltX3Bpbl9jaGVjayhzaW0pOwogfQogCmRpZmYg
LS1naXQgYS9zcmMvc2ltdXRpbC5oIGIvc3JjL3NpbXV0aWwuaAppbmRleCBmYzRmMDYzLi5kMTUx
N2VkIDEwMDY0NAotLS0gYS9zcmMvc2ltdXRpbC5oCisrKyBiL3NyYy9zaW11dGlsLmgKQEAgLTIw
LDYgKzIwLDggQEAKICAqLwogCiBlbnVtIHNpbV9maWxlaWQgeworCVNJTV9FRlBMX0ZJTEVJRCA9
IDB4MmYwNSwKKwlTSU1fRUZMSV9GSUxFSUQgPSAweDZmMDUsCiAJU0lNX0VGTVNJU0ROX0ZJTEVJ
RCA9IDB4NmY0MCwKIAlTSU1fRUZTUE5fRklMRUlEID0gMHg2ZjQ2LAogCVNJTV9FRlNETl9GSUxF
SUQgPSAweDZmNDksCi0tIAoxLjYuMQoK

--===============5461362076153941227==--

