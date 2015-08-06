Content-Type: multipart/mixed; boundary="===============6809882050144782338=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] Driver specific dial string validation
Date: Thu, 06 Aug 2015 17:40:02 -0500
Message-ID: <55C3E242.8040708@gmail.com>
In-Reply-To: <1438880221-23834-2-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6809882050144782338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 08/06/2015 11:56 AM, Kuba Pawlak wrote:
> Dial() method is generic for all modems but hfpmodem may not support some=
 dial
> strings. HFP 1.6 SPEC for ATD says: "Only voice calls are covered in this
> specification."
> Problem is with dialling USSD codes. Request is accepted and a call object
> is state dialling is created. USSD code is completed, result displays on
> the phone, but there are no events that would allow oFono to remove this =
fake
> call object.
> We may end up in such situation (Samsung S3 4.3):
> ofonod[292]: > ATD*132#;\r
> ofonod[292]: < \r\nOK\r\n

Funny that the HFP AG implementation accepts this, but okay.

On a phone, the Dialer was instructed to call =

SupplementaryServices.Initiate() first, before calling =

VoiceCallManager.Dial().  See doc/mmi-codes.txt.

Since we have no SupplementaryServices / ussd atom, I guess it would =

make sense to have the voicecall atom double check that the passed in =

string is not a USSD string.

Try the attached patch.

Regards,
-Denis

--===============6809882050144782338==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-voicecall-Don-t-accept-USSD-strings-in-Dial.patch"

PkZyb20gOWVjOGQwM2M3YzU3OWEwZDY2MWZiNzg4NWIyNjI3YzAzMDBmMTRjMSBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IFRodSwgNiBBdWcgMjAxNSAxNzoxNjowMyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIHZvaWNl
Y2FsbDogRG9uJ3QgYWNjZXB0IFVTU0Qgc3RyaW5ncyBpbiBEaWFsKCkKCi0tLQogc3JjL3ZvaWNl
Y2FsbC5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9zcmMvdm9pY2VjYWxsLmMgYi9zcmMvdm9pY2VjYWxsLmMKaW5kZXggNTUwYjc5Yi4uYjA4
ODIzOSAxMDA2NDQKLS0tIGEvc3JjL3ZvaWNlY2FsbC5jCisrKyBiL3NyYy92b2ljZWNhbGwuYwpA
QCAtMTUxMyw2ICsxNTEzLDkgQEAgc3RhdGljIGludCB2b2ljZWNhbGxfZGlhbChzdHJ1Y3Qgb2Zv
bm9fdm9pY2VjYWxsICp2YywgY29uc3QgY2hhciAqbnVtYmVyLAogCWlmIChnX3NsaXN0X2xlbmd0
aCh2Yy0+Y2FsbF9saXN0KSA+PSBNQVhfVk9JQ0VfQ0FMTFMpCiAJCXJldHVybiAtRVBFUk07CiAK
KwlpZiAodmFsaWRfdXNzZF9zdHJpbmcobnVtYmVyLCB2Yy0+Y2FsbF9saXN0ICE9IE5VTEwpKQor
CQlyZXR1cm4gLUVJTlZBTDsKKwogCWlmICghdmFsaWRfbG9uZ19waG9uZV9udW1iZXJfZm9ybWF0
KG51bWJlcikpCiAJCXJldHVybiAtRUlOVkFMOwogCi0tIAoyLjMuNgoK

--===============6809882050144782338==--

