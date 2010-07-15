Content-Type: multipart/mixed; boundary="===============5632154665560892692=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Error sending DTMF with calypso
Date: Thu, 15 Jul 2010 09:30:44 -0500
Message-ID: <4C3F1B94.2070406@gmail.com>
In-Reply-To: <AANLkTil4AMwD5v6V_SGtSlXyHgpeMpnsgYhlSzz2TjEm@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5632154665560892692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

On 07/14/2010 09:03 PM, Nicola Mfb wrote:
> Hi!
> I tried SendTones with calypso during an active call but it failed (v0.22=
):
> =

> ofonod[259]: DLC0: > AT\r
> ofonod[259]: DLC0: < \r\nOK\r\n
> ofonod[259]: DLC0: Finally woke up the modem
> ofonod[259]: DLC0: > AT+VTS=3D"1"\r
> ofonod[259]: DLC0: < \r\nERROR\r\n
> ofonod[259]: src/voicecall.c:generic_callback() command failed with
> error: Unknown error type
> =

> Am I missing somethings?
> =


I admit I never tested it on the calypso.  I have a hunch that the
quotes are not needed for the DTMF character.  E.g. AT+VTS=3D1.

Can you try the attached patch and report back?

Thanks,
-Denis

--===============5632154665560892692==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dtmf.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2FseXBzb21vZGVtL3ZvaWNlY2FsbC5jIGIvZHJpdmVycy9j
YWx5cHNvbW9kZW0vdm9pY2VjYWxsLmMKaW5kZXggYWU0OWViMC4uNTExZDUzMyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jYWx5cHNvbW9kZW0vdm9pY2VjYWxsLmMKKysrIGIvZHJpdmVycy9jYWx5cHNv
bW9kZW0vdm9pY2VjYWxsLmMKQEAgLTIwOSwxMCArMjA5LDEwIEBAIHN0YXRpYyB2b2lkIGNhbHlw
c29fc2VuZF9kdG1mKHN0cnVjdCBvZm9ub192b2ljZWNhbGwgKnZjLCBjb25zdCBjaGFyICpkdG1m
LAogCQlyZXR1cm47CiAJfQogCi0JcyA9IHNwcmludGYoYnVmLCAiQVQrVlRTPVwiJWNcIiIsIGR0
bWZbMF0pOworCXMgPSBzcHJpbnRmKGJ1ZiwgIkFUK1ZUUz0lYyIsIGR0bWZbMF0pOwogCiAJZm9y
IChpID0gMTsgaSA8IGxlbjsgaSsrKQotCQlzICs9IHNwcmludGYoYnVmICsgcywgIjsrVlRTPVwi
JWNcIiIsIGR0bWZbaV0pOworCQlzICs9IHNwcmludGYoYnVmICsgcywgIjsrVlRTPSVjIiwgZHRt
ZltpXSk7CiAKIAljYWx5cHNvX3RlbXBsYXRlKHZjLCBidWYsIGNiLCBkYXRhKTsKIAlnX2ZyZWUo
YnVmKTsK

--===============5632154665560892692==--

