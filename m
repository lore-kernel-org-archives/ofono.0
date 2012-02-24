Content-Type: multipart/mixed; boundary="===============4831533594678780107=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: LG VX8360 HFP non-compliance issue
Date: Thu, 23 Feb 2012 23:20:44 -0600
Message-ID: <4F471E2C.9020208@gmail.com>
In-Reply-To: <CAB7rCTiFvG17u=3x1vB1tOAKyM7xC1QObj43ScEX3Uk16kOeDw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4831533594678780107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On 02/23/2012 06:49 PM, Mike wrote:
> I'm getting weird behaviour from an LG VX8360, connected via bluetooth
> HFP.  When the phone connects, I see a CallAdded signal go out over
> dbus, despite there being no call on the phone itself.  You can see
> the signal below.  The LineIdentification held the actual phone number
> of the phone, but I replaced it with "xxxxxxxxxx".  I also copied in
> the initial RFCOMM communication.  It looks to me like this phone does
> not comply with the HFP spec in that it returns an answer to AT+CLCC
> when there is no phone call present (and at that, an index of 0).  It
> also happens that the status is a 6, which does not appear to be a
> valid status in HFPv1.5.  This just happens to map to the enum
> CALL_STATUS_DISCONNECTED, but I'm guessing this was merely
> coincidence.  Since the state is broadcast as disconnected, I can
> simply ignore it in my GUI application.  However, I'm wondering if
> this is something that is better handled in the ofono side?
> =

> Thanks,
> Mike
> =


Try the following patch.

Regards,
-Denis

--===============4831533594678780107==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-atutil-Ignore-invalid-CLCC-results.patch"

PkZyb20gOTU5MWE3NzY4ZDkxMzE0ZThiNzJjMWU5M2Y1MTA4NjBiYmZmMWQwNCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IFRodSwgMjMgRmViIDIwMTIgMjM6MTQ6MDggLTA2MDAKU3ViamVjdDogW1BBVENIXSBhdHV0
aWw6IElnbm9yZSBpbnZhbGlkIENMQ0MgcmVzdWx0cwoKU29tZSBwaG9uZXMgcmVwb3J0IENMQ0Mg
Y2FsbHMgd2l0aCBvdXQtb2YtcmFuZ2UgaW5mby4gIEUuZy4gY2FsbCBpbmRleApiZWluZyAwIChp
dCBpcyAxIGJhc2VkIGFjY29yZGluZyB0byAyNy4wMDcpIGFuZCBjYWxsIHN0YXRlcyBiZWluZwpy
ZXBvcnRlZCBhcyAnNicgKHZhbGlkIGNhbGwgc3RhdGVzIGFyZSAwLTUuKQotLS0KIGRyaXZlcnMv
YXRtb2RlbS9hdHV0aWwuYyB8ICAgIDYgKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2F0bW9kZW0vYXR1
dGlsLmMgYi9kcml2ZXJzL2F0bW9kZW0vYXR1dGlsLmMKaW5kZXggYjgyZWQyMC4uMGM2YWFiNCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9hdG1vZGVtL2F0dXRpbC5jCisrKyBiL2RyaXZlcnMvYXRtb2Rl
bS9hdHV0aWwuYwpAQCAtMTMxLDEyICsxMzEsMTggQEAgR1NMaXN0ICphdF91dGlsX3BhcnNlX2Ns
Y2MoR0F0UmVzdWx0ICpyZXN1bHQpCiAJCWlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJl
cigmaXRlciwgJmlkKSkKIAkJCWNvbnRpbnVlOwogCisJCWlmIChpZCA9PSAwKQorCQkJY29udGlu
dWU7CisKIAkJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfbnVtYmVyKCZpdGVyLCAmZGlyKSkK
IAkJCWNvbnRpbnVlOwogCiAJCWlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmaXRl
ciwgJnN0YXR1cykpCiAJCQljb250aW51ZTsKIAorCQlpZiAoc3RhdHVzID4gNSkKKwkJCWNvbnRp
bnVlOworCiAJCWlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmaXRlciwgJnR5cGUp
KQogCQkJY29udGludWU7CiAKLS0gCjEuNy4zLjQKCg==

--===============4831533594678780107==--

