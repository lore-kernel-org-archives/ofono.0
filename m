Content-Type: multipart/mixed; boundary="===============7317600101288588290=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] Parse +CUSD responses.
Date: Fri, 16 Oct 2009 23:12:42 +0200
Message-ID: <fb249edb0910161412l7bf189bar4eb9a28062df067c@mail.gmail.com>
In-Reply-To: <200910161306.07901.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7317600101288588290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2009/10/16 Denis Kenzior <denkenz@gmail.com>:
> Right now we should simply ignore 8bit data and return an error.

Ok, now we return the "unsupported" status on either an 8-bit response
or a dcs that we don't understand.

>
>> I removed the "TODO: be able to send UCS2 string" because the string
>> we send is first checked to be a valid USSD string so we already know
>> it can be encoded with GSM 7-bits.
>
> Actually valid_ussd_string will accept just about everything.

Ah true.  However I think we should never try to send a UCS2 USSD - we
would first need to know that the modem supports this (so a vendor
quirk set by the plugin would tell us this) and then that the network
supports this too.

Neither of the modems I tried yesterday was able to send a string with
DCS of 0x11 or 0x98 or 0xf8 (all of these are supposed to mean UCS2)
with language code prepended or without, only with 0x48 on TI Calypso.

>
>> + =C2=A0 =C2=A0 /* All 7-bit coding schemes - there's no need to disting=
uish
>> + =C2=A0 =C2=A0 =C2=A0* between the different schemes because the modem =
is tasked
>> + =C2=A0 =C2=A0 =C2=A0* with presenting us with only raw 7-bit character=
s.
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 if ((dcs & 0xf0) =3D=3D 0x00 || dcs =3D=3D 0x10 || (dcs =
& 0xf0) =3D=3D 0x20 ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
(dcs & 0xf0) =3D=3D 0x30 || (dcs & 0xcc) =3D=3D 0x40 ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
(dcs & 0xfc) =3D=3D 0x90 || (dcs & 0xf4) =3D=3D 0xf0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 converted =3D convert_gsm_to=
_utf8(content, length,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NULL, NULL, 0);
>> +
>
> What about the evil set of DCSes which indicate a ISO639 2 character code
> preceding the message?

The comment refers to this.  I think 27.007 tries to say the modem has
to take care of this and only give us the actual characters of the
string.

"-       if TE character set other than "HEX" (refer command Select TE
Character Set +CSCS): MT/TA converts GSM alphabet into current TE
character set according to rules of 3GPP TS 27.005 [24] Annex A

-       if TE character set is "HEX": MT/TA converts each 7-bit character of
GSM alphabet into two IRA character long hexadecimal number (e.g.
character ( (GSM 23) is presented as 17 (IRA 49 and 55))"

If we can assume that the same rules apply to encoding and decoding
then the TI Calypso modem and the nokia modems confirm this because
sending a string with DCS =3D 0x10 works without the language code and
doesn't work with the language prepended.

>
>> + =C2=A0 =C2=A0 g_at_chat_send(chat, "AT+CSCS=3D\"HEX\"", NULL, NULL, NU=
LL, NULL);
>
> This part of 27.007 is utterly and completely broken. =C2=A0We have to be=
 extra
> careful whenever we mess with CSCS. =C2=A0Does this have any unfortunate =
side
> effects, in particular with +COPS, +CPUC, etc? =C2=A0Also note that since=
 we change
> the CSCS during phonebook import, any USSDs sent/received during this time
> won't actually work properly :)

Oh right, I had forgotten about +COPS etc, I noticed phonebook used
+CSCS and nothing else used it.  So if we can assume that the default
character set is GSM, then we can use it for 7-bit encoded responses,
but we will need to think of something else to interpret the 8-bit
data.  I changed the patch to leave the encoding alone and assume GSM
alphabet.

Regards

--===============7317600101288588290==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Parse-CUSD-responses.patch"

RnJvbSA4NGZkOGI5OTA3YmYyMTJmNjc4MWQ2NDdiYzg1NDY2ZjZhNjU3YjJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogU2F0LCAxNyBPY3QgMjAwOSAwMDo0NToxNSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIFBhcnNlICtDVVNEIHJlc3BvbnNlcy4KCi0tLQogZHJpdmVycy9hdG1vZGVtL3Vz
c2QuYyB8ICAxMDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tCiBzcmMvdXNzZC5jICAgICAgICAgICAgIHwgICAgMyArCiAyIGZpbGVzIGNoYW5nZWQsIDk2
IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRt
b2RlbS91c3NkLmMgYi9kcml2ZXJzL2F0bW9kZW0vdXNzZC5jCmluZGV4IDFkODE5YTMuLmU5NmRi
OTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYXRtb2RlbS91c3NkLmMKKysrIGIvZHJpdmVycy9hdG1v
ZGVtL3Vzc2QuYwpAQCAtNDAsMjUgKzQwLDg4IEBACiAKICNpbmNsdWRlICJhdG1vZGVtLmgiCiAK
K3N0cnVjdCBjdXNkX3JlcSB7CisJb2Zvbm9fdXNzZF9jYl90IGNiOworCXZvaWQgKmRhdGE7CisJ
c3RydWN0IG9mb25vX3Vzc2QgKnVzc2Q7Cit9OworCitzdGF0aWMgY29uc3QgY2hhciAqY3VzZF9w
cmVmaXhbXSA9IHsgIitDVVNEOiIsIE5VTEwgfTsKIHN0YXRpYyBjb25zdCBjaGFyICpub25lX3By
ZWZpeFtdID0geyBOVUxMIH07CiAKK3N0YXRpYyB2b2lkIGN1c2RfcGFyc2UoR0F0UmVzdWx0ICpy
ZXN1bHQsIHN0cnVjdCBvZm9ub191c3NkICp1c3NkKQoreworCUdBdFJlc3VsdEl0ZXIgaXRlcjsK
KwlpbnQgc3RhdHVzOworCWludCBkY3M7CisJY29uc3QgY2hhciAqY29udGVudDsKKwljaGFyICpj
b252ZXJ0ZWQgPSBOVUxMOworCisJZ19hdF9yZXN1bHRfaXRlcl9pbml0KCZpdGVyLCByZXN1bHQp
OworCisJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHQoJml0ZXIsICIrQ1VTRDoiKSkKKwkJcmV0
dXJuOworCisJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfbnVtYmVyKCZpdGVyLCAmc3RhdHVz
KSkKKwkJcmV0dXJuOworCisJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfc3RyaW5nKCZpdGVy
LCAmY29udGVudCkpCisJCWdvdG8gb3V0OworCisJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRf
bnVtYmVyKCZpdGVyLCAmZGNzKSkKKwkJZ290byBvdXQ7CisKKwkvKiBBbGwgNy1iaXQgY29kaW5n
IHNjaGVtZXMgLSB0aGVyZSdzIG5vIG5lZWQgdG8gZGlzdGluZ3Vpc2gKKwkgKiBiZXR3ZWVuIHRo
ZSBkaWZmZXJlbnQgc2NoZW1lcyBiZWNhdXNlIHRoZSBtb2RlbSBpcyB0YXNrZWQKKwkgKiB3aXRo
IHByZXNlbnRpbmcgdXMgd2l0aCBvbmx5IHJhdyA3LWJpdCBjaGFyYWN0ZXJzLgorCSAqLworCWlm
ICgoZGNzICYgMHhmMCkgPT0gMHgwMCB8fCBkY3MgPT0gMHgxMCB8fCAoZGNzICYgMHhmMCkgPT0g
MHgyMCB8fAorCQkJKGRjcyAmIDB4ZjApID09IDB4MzAgfHwgKGRjcyAmIDB4Y2MpID09IDB4NDAg
fHwKKwkJCShkY3MgJiAweGZjKSA9PSAweDkwIHx8IChkY3MgJiAweGY0KSA9PSAweGYwKQorCQlj
b252ZXJ0ZWQgPSBjb252ZXJ0X2dzbV90b191dGY4KChjb25zdCBndWludDggKikgY29udGVudCwK
KwkJCQkJCXN0cmxlbihjb250ZW50KSwgTlVMTCwgTlVMTCwKKwkJCQkJCTApOworCisJLyogQWxs
IDgtYml0IGNvZGluZyBzY2hlbWVzIGFyZSB0cmVhdGVkIHRoZSBzYW1lIGFnYWluLgorCSAqIFRP
RE8KKwkgKi8KKwllbHNlIGlmICgoZGNzICYgMHhjYykgPT0gMHg0NCB8fCAoZGNzICYgMHhmYykg
PT0gMHg5NCB8fAorCQkJKGRjcyAmIDB4ZjQpID09IDB4ZjQpIHsKKwkJb2Zvbm9fZXJyb3IoIjgt
Yml0IGNvZGVkIFVTU0QgcmVzcG9uc2UgcmVjZWl2ZWQiKTsKKwkJc3RhdHVzID0gNDsgLyogTm90
IHN1cHBvcnRlZCAqLworCX0KKworCS8qIE5vIG90aGVyIGVuY29kaW5nIGlzIG1lbnRpb25lZCBp
biBUUzI3MDA3IDcuMTUgKi8KKwllbHNlIHsKKwkJb2Zvbm9fZXJyb3IoIlVuc3VwcG9ydGVkIFVT
U0QgZGF0YSBjb2Rpbmcgc2NoZW1lICglMDJ4KSIsIGRjcyk7CisJCXN0YXR1cyA9IDQ7IC8qIE5v
dCBzdXBwb3J0ZWQgKi8KKwl9CisKK291dDoKKwlvZm9ub191c3NkX25vdGlmeSh1c3NkLCBzdGF0
dXMsIGNvbnZlcnRlZCk7CisKKwlpZiAoY29udmVydGVkKQorCQlnX2ZyZWUoY29udmVydGVkKTsK
K30KKwogc3RhdGljIHZvaWQgY3VzZF9yZXF1ZXN0X2NiKGdib29sZWFuIG9rLCBHQXRSZXN1bHQg
KnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKQogewotCXN0cnVjdCBjYl9kYXRhICpjYmQgPSB1
c2VyX2RhdGE7Ci0Jb2Zvbm9fdXNzZF9jYl90IGNiID0gY2JkLT5jYjsKKwlzdHJ1Y3QgY3VzZF9y
ZXEgKmNiZCA9IHVzZXJfZGF0YTsKIAlzdHJ1Y3Qgb2Zvbm9fZXJyb3IgZXJyb3I7CiAKIAlkdW1w
X3Jlc3BvbnNlKCJjdXNkX3JlcXVlc3RfY2IiLCBvaywgcmVzdWx0KTsKIAlkZWNvZGVfYXRfZXJy
b3IoJmVycm9yLCBnX2F0X3Jlc3VsdF9maW5hbF9yZXNwb25zZShyZXN1bHQpKTsKIAotCWNiKCZl
cnJvciwgY2JkLT5kYXRhKTsKKwljYmQtPmNiKCZlcnJvciwgY2JkLT5kYXRhKTsKKworCWN1c2Rf
cGFyc2UocmVzdWx0LCBjYmQtPnVzc2QpOwogfQogCiBzdGF0aWMgdm9pZCBhdF91c3NkX3JlcXVl
c3Qoc3RydWN0IG9mb25vX3Vzc2QgKnVzc2QsIGNvbnN0IGNoYXIgKnN0ciwKIAkJCQlvZm9ub191
c3NkX2NiX3QgY2IsIHZvaWQgKmRhdGEpCiB7CiAJR0F0Q2hhdCAqY2hhdCA9IG9mb25vX3Vzc2Rf
Z2V0X2RhdGEodXNzZCk7Ci0Jc3RydWN0IGNiX2RhdGEgKmNiZCA9IGNiX2RhdGFfbmV3KGNiLCBk
YXRhKTsKKwlzdHJ1Y3QgY3VzZF9yZXEgKmNiZCA9IGdfdHJ5X25ldzAoc3RydWN0IGN1c2RfcmVx
LCAxKTsKIAl1bnNpZ25lZCBjaGFyICpjb252ZXJ0ZWQgPSBOVUxMOwogCWludCBkY3M7CiAJaW50
IG1heF9sZW47CkBAIC02OCwxMSArMTMxLDEyIEBAIHN0YXRpYyB2b2lkIGF0X3Vzc2RfcmVxdWVz
dChzdHJ1Y3Qgb2Zvbm9fdXNzZCAqdXNzZCwgY29uc3QgY2hhciAqc3RyLAogCWlmICghY2JkKQog
CQlnb3RvIGVycm9yOwogCisJY2JkLT5jYiA9IGNiOworCWNiZC0+ZGF0YSA9IGRhdGE7CisJY2Jk
LT51c3NkID0gdXNzZDsKKwogCWNvbnZlcnRlZCA9IGNvbnZlcnRfdXRmOF90b19nc20oc3RyLCBz
dHJsZW4oc3RyKSwgTlVMTCwgJndyaXR0ZW4sIDApOwogCi0JLyogVE9ETzogQmUgYWJsZSB0byBj
b252ZXJ0IHRvIFVDUzIsIGFsdGhvdWdoIHRoZSBzdGFuZGFyZCBkb2VzIG5vdAotCSAqIGluZGlj
YXRlIHRoYXQgdGhpcyBpcyBhY3R1YWxseSBwb3NzaWJsZQotCSAqLwogCWlmICghY29udmVydGVk
KQogCQlnb3RvIGVycm9yOwogCWVsc2UgewpAQCAtODMsMTIgKzE0NywxMiBAQCBzdGF0aWMgdm9p
ZCBhdF91c3NkX3JlcXVlc3Qoc3RydWN0IG9mb25vX3Vzc2QgKnVzc2QsIGNvbnN0IGNoYXIgKnN0
ciwKIAlpZiAod3JpdHRlbiA+IG1heF9sZW4pCiAJCWdvdG8gZXJyb3I7CiAKLQlzcHJpbnRmKGJ1
ZiwgIkFUK0NVU0Q9MSxcIiUqc1wiLCVkIiwgKGludCkgd3JpdHRlbiwgY29udmVydGVkLCBkY3Mp
OworCXNwcmludGYoYnVmLCAiQVQrQ1VTRD0xLFwiJSpzXCIsICVkIiwgKGludCkgd3JpdHRlbiwg
Y29udmVydGVkLCBkY3MpOwogCiAJZ19mcmVlKGNvbnZlcnRlZCk7CiAJY29udmVydGVkID0gTlVM
TDsKIAotCWlmIChnX2F0X2NoYXRfc2VuZChjaGF0LCBidWYsIG5vbmVfcHJlZml4LAorCWlmIChn
X2F0X2NoYXRfc2VuZChjaGF0LCBidWYsIGN1c2RfcHJlZml4LAogCQkJCWN1c2RfcmVxdWVzdF9j
YiwgY2JkLCBnX2ZyZWUpID4gMCkKIAkJcmV0dXJuOwogCkBAIC0xMzMsMTMgKzE5NywyOCBAQCBl
cnJvcjoKIAlDQUxMQkFDS19XSVRIX0ZBSUxVUkUoY2IsIGRhdGEpOwogfQogCi1zdGF0aWMgZ2Jv
b2xlYW4gYXRfdXNzZF9yZWdpc3RlcihncG9pbnRlciB1c2VyKQorc3RhdGljIHZvaWQgY3VzZF9u
b3RpZnkoR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSkKK3sKKwlzdHJ1Y3Qg
b2Zvbm9fdXNzZCAqdXNzZCA9IHVzZXJfZGF0YTsKKworCWR1bXBfcmVzcG9uc2UoImN1c2Rfbm90
aWZ5IiwgVFJVRSwgcmVzdWx0KTsKKworCWN1c2RfcGFyc2UocmVzdWx0LCB1c3NkKTsKK30KKwor
c3RhdGljIHZvaWQgYXRfdXNzZF9yZWdpc3RlcihnYm9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1
bHQsIGdwb2ludGVyIHVzZXIpCiB7CiAJc3RydWN0IG9mb25vX3Vzc2QgKnVzc2QgPSB1c2VyOwor
CUdBdENoYXQgKmNoYXQgPSBvZm9ub191c3NkX2dldF9kYXRhKHVzc2QpOwogCi0Jb2Zvbm9fdXNz
ZF9yZWdpc3Rlcih1c3NkKTsKKwlpZiAoIW9rKSB7CisJCW9mb25vX2Vycm9yKCJDb3VsZCBub3Qg
ZW5hYmxlIENVU0Qgbm90aWZpY2F0aW9ucyIpOworCQlyZXR1cm47CisJfQorCisJZ19hdF9jaGF0
X3JlZ2lzdGVyKGNoYXQsICIrQ1VTRDoiLCBjdXNkX25vdGlmeSwgRkFMU0UsIHVzc2QsIE5VTEwp
OwogCi0JcmV0dXJuIEZBTFNFOworCW9mb25vX3Vzc2RfcmVnaXN0ZXIodXNzZCk7CiB9CiAKIHN0
YXRpYyBpbnQgYXRfdXNzZF9wcm9iZShzdHJ1Y3Qgb2Zvbm9fdXNzZCAqdXNzZCwgdW5zaWduZWQg
aW50IHZlbmRvciwKQEAgLTE0OCw3ICsyMjcsOCBAQCBzdGF0aWMgaW50IGF0X3Vzc2RfcHJvYmUo
c3RydWN0IG9mb25vX3Vzc2QgKnVzc2QsIHVuc2lnbmVkIGludCB2ZW5kb3IsCiAJR0F0Q2hhdCAq
Y2hhdCA9IGRhdGE7CiAKIAlvZm9ub191c3NkX3NldF9kYXRhKHVzc2QsIGNoYXQpOwotCWdfaWRs
ZV9hZGQoYXRfdXNzZF9yZWdpc3RlciwgdXNzZCk7CisKKwlnX2F0X2NoYXRfc2VuZChjaGF0LCAi
QVQrQ1VTRD0xIiwgTlVMTCwgYXRfdXNzZF9yZWdpc3RlciwgdXNzZCwgTlVMTCk7CiAKIAlyZXR1
cm4gMDsKIH0KZGlmZiAtLWdpdCBhL3NyYy91c3NkLmMgYi9zcmMvdXNzZC5jCmluZGV4IGJlNTAy
OTYuLjJiZjM3OGQgMTAwNjQ0Ci0tLSBhL3NyYy91c3NkLmMKKysrIGIvc3JjL3Vzc2QuYwpAQCAt
MzEzLDYgKzMxMyw5IEBAIHZvaWQgb2Zvbm9fdXNzZF9ub3RpZnkoc3RydWN0IG9mb25vX3Vzc2Qg
KnVzc2QsIGludCBzdGF0dXMsIGNvbnN0IGNoYXIgKnN0cikKIAogCQlyZXBseSA9IGRidXNfbWVz
c2FnZV9uZXdfbWV0aG9kX3JldHVybih1c3NkLT5wZW5kaW5nKTsKIAorCQlpZiAoIXN0cikKKwkJ
CXN0ciA9ICIiOworCiAJCWRidXNfbWVzc2FnZV9pdGVyX2luaXRfYXBwZW5kKHJlcGx5LCAmaXRl
cik7CiAKIAkJZGJ1c19tZXNzYWdlX2l0ZXJfYXBwZW5kX2Jhc2ljKCZpdGVyLCBEQlVTX1RZUEVf
U1RSSU5HLAotLSAKMS42LjEKCg==

--===============7317600101288588290==--

