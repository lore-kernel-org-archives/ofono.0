Content-Type: multipart/mixed; boundary="===============2558858377702746440=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 5/6] stk: Handle the Select Item proactive command.
Date: Tue, 27 Jul 2010 02:53:50 +0200
Message-ID: <AANLkTikqWMQNpe1myqvDFiEo=12ka+_=smJ992bmuGoo@mail.gmail.com>
In-Reply-To: <1280190460.2621.67.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2558858377702746440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 27 July 2010 02:27, Marcel Holtmann <marcel@holtmann.org> wrote:
>> + =C2=A0 =C2=A0 switch (result) {
>> + =C2=A0 =C2=A0 case STK_AGENT_RESULT_OK:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D STK_RESULT_TYPE_SUC=
CESS;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> +
>> + =C2=A0 =C2=A0 case STK_AGENT_RESULT_BACK:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D STK_RESULT_TYPE_GO_=
BACK;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send;
>> +
>> + =C2=A0 =C2=A0 case STK_AGENT_RESULT_TIMEOUT:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D STK_RESULT_TYPE_NO_=
RESPONSE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send;
>> +
>> + =C2=A0 =C2=A0 case STK_AGENT_RESULT_TERMINATE:
>> + =C2=A0 =C2=A0 default:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D STK_RESULT_TYPE_USE=
R_TERMINATED;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send;
>> +
>> + =C2=A0 =C2=A0 case STK_AGENT_RESULT_CANCEL:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 }
>
> have you tested this? The STK_AGENT_RESULT_CANCEL will never be reached
> since we hit default label first.

This would really be a matter of incompliant compiler if it didn't
work because of the order of the labels.  I also just checked checked
a similar code in gcc and it works.

So possibly let's add this rule to the coding-style file.

I'm attaching the same patch with just the labels reordered. I left
the default label in because this function should just treat any other
response as ..USER_TERMINATED, even if a new one is added.

Best regards

--===============2558858377702746440==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0005-stk-Handle-the-Select-Item-proactive-command.patch"

RnJvbSBhOGY1Yzg3MDcyM2QxN2I1OTA5Njk3ZGU3ZDEwMjQ5ZTczN2NhYzc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogTW9uLCAyNiBKdWwgMjAxMCAxNDozOToyOCArMDIwMApTdWJqZWN0
OiBbUEFUQ0ggNS82XSBzdGs6IEhhbmRsZSB0aGUgU2VsZWN0IEl0ZW0gcHJvYWN0aXZlIGNvbW1h
bmQuCgotLS0KIHNyYy9zdGsuYyB8ICAxMDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlcyBjaGFuZ2VkLCAxMDUgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvc3RrLmMgYi9zcmMv
c3RrLmMKaW5kZXggZjIxMmU5YS4uMGFhZjgzZCAxMDA2NDQKLS0tIGEvc3JjL3N0ay5jCisrKyBi
L3NyYy9zdGsuYwpAQCAtNzUsNyArNzUsNyBAQCBzdHJ1Y3Qgb2Zvbm9fc3RrIHsKIAlndWludCBy
ZW1vdmVfYWdlbnRfc291cmNlOwogCXN0cnVjdCBzdGtfYXBwX2FnZW50ICpzZXNzaW9uX2FnZW50
OwogCXN0cnVjdCBzdGtfYXBwX2FnZW50ICpkZWZhdWx0X2FnZW50OwotCXN0cnVjdCBzdGtfbWVu
dSAqbWFpbl9tZW51OworCXN0cnVjdCBzdGtfbWVudSAqbWFpbl9tZW51LCAqc2VsZWN0X2l0ZW1f
bWVudTsKIAlnYm9vbGVhbiBpbl9zZXNzaW9uOwogCXN0cnVjdCBzbXNfc3VibWl0X3JlcSAqc21z
X3N1Ym1pdF9yZXE7CiAJY2hhciAqaWRsZV9tb2RlX3RleHQ7CkBAIC0xMDAwLDYgKzEwMDAsMTA2
IEBAIHN0YXRpYyBnYm9vbGVhbiBoYW5kbGVfY29tbWFuZF9zZXRfdXBfbWVudShjb25zdCBzdHJ1
Y3Qgc3RrX2NvbW1hbmQgKmNtZCwKIAlyZXR1cm4gVFJVRTsKIH0KIAorc3RhdGljIHZvaWQgcmVx
dWVzdF9tZW51X3NlbmQoREJ1c01lc3NhZ2UgKmNhbGwsIHZvaWQgKnVzZXJfZGF0YSkKK3sKKwlz
dHJ1Y3Qgb2Zvbm9fc3RrICpzdGsgPSB1c2VyX2RhdGE7CisJc3RydWN0IHN0a19tZW51ICptZW51
ID0gc3RrLT5zZWxlY3RfaXRlbV9tZW51OworCisJZGJ1c19tZXNzYWdlX3NldF9tZW1iZXIoY2Fs
bCwgIlJlcXVlc3RTZWxlY3Rpb24iKTsKKworCWFwcGVuZF9tZW51KGNhbGwsIG1lbnUpOworfQor
CitzdGF0aWMgdm9pZCByZXF1ZXN0X21lbnVfY2IoZW51bSBzdGtfYWdlbnRfcmVzdWx0IHJlc3Vs
dCwgREJ1c01lc3NhZ2UgKnJlcGx5LAorCQkJCXZvaWQgKnVzZXJfZGF0YSkKK3sKKwlzdHJ1Y3Qg
b2Zvbm9fc3RrICpzdGsgPSB1c2VyX2RhdGE7CisJc3RydWN0IHN0a19tZW51ICptZW51ID0gc3Rr
LT5zZWxlY3RfaXRlbV9tZW51OworCXN0cnVjdCBzdGtfaXRlbSAqaXRlbSA9IE5VTEw7CisJZW51
bSBzdGtfcmVzdWx0X3R5cGUgdHlwZTsKKwl1bnNpZ25lZCBjaGFyIHNlbGVjdGlvbjsKKwlzdHJ1
Y3Qgc3RrX3Jlc3BvbnNlIHJzcDsKKwlzdGF0aWMgc3RydWN0IG9mb25vX2Vycm9yIGVycm9yID0g
eyAudHlwZSA9IE9GT05PX0VSUk9SX1RZUEVfRkFJTFVSRSB9OworCisJc3dpdGNoIChyZXN1bHQp
IHsKKwljYXNlIFNUS19BR0VOVF9SRVNVTFRfT0s6CisJCXR5cGUgPSBTVEtfUkVTVUxUX1RZUEVf
U1VDQ0VTUzsKKwkJYnJlYWs7CisKKwljYXNlIFNUS19BR0VOVF9SRVNVTFRfQkFDSzoKKwkJdHlw
ZSA9IFNUS19SRVNVTFRfVFlQRV9HT19CQUNLOworCQlnb3RvIHNlbmQ7CisKKwljYXNlIFNUS19B
R0VOVF9SRVNVTFRfVElNRU9VVDoKKwkJdHlwZSA9IFNUS19SRVNVTFRfVFlQRV9OT19SRVNQT05T
RTsKKwkJZ290byBzZW5kOworCisJY2FzZSBTVEtfQUdFTlRfUkVTVUxUX0NBTkNFTDoKKwkJZ290
byBvdXQ7CisKKwljYXNlIFNUS19BR0VOVF9SRVNVTFRfVEVSTUlOQVRFOgorCWRlZmF1bHQ6CisJ
CXR5cGUgPSBTVEtfUkVTVUxUX1RZUEVfVVNFUl9URVJNSU5BVEVEOworCQlnb3RvIHNlbmQ7CisJ
fQorCisJaWYgKGRidXNfbWVzc2FnZV9nZXRfYXJncyhyZXBseSwgTlVMTCwKKwkJCQkJREJVU19U
WVBFX0JZVEUsICZzZWxlY3Rpb24sCisJCQkJCURCVVNfVFlQRV9JTlZBTElEKSA9PSBGQUxTRSkg
eworCQl0eXBlID0gU1RLX1JFU1VMVF9UWVBFX1VTRVJfVEVSTUlOQVRFRDsKKworCQlvZm9ub19l
cnJvcigiQ2FuJ3QgcGFyc2UgdGhlIHJlcGx5IHRvIFNlbGVjdEl0ZW0oKSIpOworCQlnb3RvIHNl
bmQ7CisJfQorCisJaXRlbSA9IGdfc2xpc3RfbnRoX2RhdGEobWVudS0+aXRlbXMsIHNlbGVjdGlv
bik7CisJaWYgKCFpdGVtKSB7CisJCXR5cGUgPSBTVEtfUkVTVUxUX1RZUEVfVVNFUl9URVJNSU5B
VEVEOworCQlvZm9ub19lcnJvcigiSW52YWxpZCBpdGVtIHNlbGVjdGVkIik7CisJfQorCitzZW5k
OgorCW1lbXNldCgmcnNwLCAwLCBzaXplb2YocnNwKSk7CisJcnNwLnJlc3VsdC50eXBlID0gdHlw
ZTsKKworCWlmIChpdGVtKQorCQlyc3Auc2VsZWN0X2l0ZW0uaXRlbV9pZCA9IGl0ZW0tPmlkOwor
CisJaWYgKHN0a19yZXNwb25kKHN0aywgJnJzcCwgc3RrX2NvbW1hbmRfY2IpKQorCQlzdGtfY29t
bWFuZF9jYigmZXJyb3IsIHN0ayk7CisKK291dDoKKwlzdGtfbWVudV9mcmVlKG1lbnUpOworCXN0
ay0+c2VsZWN0X2l0ZW1fbWVudSA9IE5VTEw7Cit9CisKK3N0YXRpYyBnYm9vbGVhbiBoYW5kbGVf
Y29tbWFuZF9zZWxlY3RfaXRlbShjb25zdCBzdHJ1Y3Qgc3RrX2NvbW1hbmQgKmNtZCwKKwkJCQkJ
CXN0cnVjdCBzdGtfcmVzcG9uc2UgKnJzcCwKKwkJCQkJCXN0cnVjdCBvZm9ub19zdGsgKnN0aykK
K3sKKwlzdGstPnNlbGVjdF9pdGVtX21lbnUgPSBzdGtfbWVudV9jcmVhdGVfZnJvbV9zZWxlY3Rf
aXRlbShjbWQpOworCisJaWYgKCFzdGstPnNlbGVjdF9pdGVtX21lbnUpIHsKKwkJcnNwLT5yZXN1
bHQudHlwZSA9IFNUS19SRVNVTFRfVFlQRV9EQVRBX05PVF9VTkRFUlNUT09EOworCisJCXJldHVy
biBUUlVFOworCX0KKworCWlmICghc3RrLT5pbl9zZXNzaW9uKSB7CisJCXN0ay0+aW5fc2Vzc2lv
biA9IFRSVUU7CisKKwkJaWYgKHN0ay0+bWFpbl9tZW51KQorCQkJZW1pdF9tZW51X2NoYW5nZWQo
c3RrKTsKKwl9CisKKwlzdGstPmNhbmNlbF9jbWQgPSBzdGtfYWdlbnRfcmVxdWVzdF9jYW5jZWw7
CisKKwlzdGtfYWdlbnRfcmVxdWVzdF9zdGFydChzdGssCisJCQkJcmVxdWVzdF9tZW51X3NlbmQs
IHJlcXVlc3RfbWVudV9jYiwgMCk7CisKKwlyZXR1cm4gRkFMU0U7Cit9CisKIHN0YXRpYyB2b2lk
IHN0a19wcm9hY3RpdmVfY29tbWFuZF9jYW5jZWwoc3RydWN0IG9mb25vX3N0ayAqc3RrKQogewog
CWlmICghc3RrLT5wZW5kaW5nX2NtZCkKQEAgLTEwODgsNiArMTE4OCwxMCBAQCB2b2lkIG9mb25v
X3N0a19wcm9hY3RpdmVfY29tbWFuZF9ub3RpZnkoc3RydWN0IG9mb25vX3N0ayAqc3RrLAogCQkJ
cmVzcG9uZCA9IGhhbmRsZV9jb21tYW5kX3NldF91cF9tZW51KHN0ay0+cGVuZGluZ19jbWQsCiAJ
CQkJCQkJCSZyc3AsIHN0ayk7CiAJCQlicmVhazsKKwkJY2FzZSBTVEtfQ09NTUFORF9UWVBFX1NF
TEVDVF9JVEVNOgorCQkJcmVzcG9uZCA9IGhhbmRsZV9jb21tYW5kX3NlbGVjdF9pdGVtKHN0ay0+
cGVuZGluZ19jbWQsCisJCQkJCQkJCSZyc3AsIHN0ayk7CisJCQlicmVhazsKIAkJfQogCiAJCWlm
IChyZXNwb25kKQotLSAKMS43LjEuODYuZzBlNDYwLmRpcnR5Cgo=

--===============2558858377702746440==--

