Content-Type: multipart/mixed; boundary="===============7300854487931046880=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: [PATCH] When setting the serial port,
 the previous settings need to be preserved.
Date: Wed, 21 Oct 2009 10:43:36 +0200
Message-ID: <4ADEC9B8.2050701@gmail.com>
In-Reply-To: <200910201036.03028.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7300854487931046880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I have attached a small patch which allows gattty.c to enable/disable =

the read functionality on the serial port.

Cheers,
Ryan

Denis Kenzior wrote:
> Hi Ryan,
> =

>>> You're blowing away the result of cfmakeraw.  Most of the devices are n=
ot
>>> true serial devices and so do not need any of the special options. =

>>> Passing a NULL options GHashTable should result in cfmakeraw.  Why don't
>>> you just pass all the options you need instead of using tcgetattr?
>> Should i just move the tcgetattr() to happen before cfmakeraw()?
> =

> Only one (executed last) will have effect, and I want it to be the cfmake=
raw.  =

> So simply get rid of tcgetattr.
> =

>>> The other parts of the patch look good to me.
>> Ok. Why don't i just add the string options ("read", others...) in
>> gattty.c?
> =

> This is what I would prefer.
> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============7300854487931046880==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="serial_port_enable_CREAD.patch"

ZGlmZiAtLWdpdCBhL2dhdGNoYXQvZ2F0dHR5LmMgYi9nYXRjaGF0L2dhdHR0eS5jCmluZGV4IDYz
ZDI2ZDQuLmYxOGVjYTQgMTAwNjQ0Ci0tLSBhL2dhdGNoYXQvZ2F0dHR5LmMKKysrIGIvZ2F0Y2hh
dC9nYXR0dHkuYwpAQCAtOTcsNiArOTcsMTggQEAgc3RhdGljIGdib29sZWFuIHNldF9iYXVkKGNv
bnN0IGNoYXIgKmJhdWQsIHN0cnVjdCB0ZXJtaW9zICp0aSkKIAlyZXR1cm4gVFJVRTsKIH0KIAor
c3RhdGljIGdib29sZWFuIHNldF9yZWFkKGNvbnN0IGNoYXIgKmJpdHMsIHN0cnVjdCB0ZXJtaW9z
ICp0aSkKK3sKKwlpZiAoZ19zdHJfZXF1YWwoYml0cywgIm9mZiIpKQorCQl0aS0+Y19jZmxhZyAm
PSB+KENSRUFEKTsKKwllbHNlIGlmIChnX3N0cl9lcXVhbChiaXRzLCAib24iKSkKKwkJdGktPmNf
Y2ZsYWcgfD0gQ1JFQUQ7CisJZWxzZQorCQlyZXR1cm4gRkFMU0U7CisKKwlyZXR1cm4gVFJVRTsK
K30KKwogc3RhdGljIGdib29sZWFuIHNldF9zdG9wX2JpdHMoY29uc3QgY2hhciAqYml0cywgc3Ry
dWN0IHRlcm1pb3MgKnRpKQogewogCWlmIChnX3N0cl9lcXVhbChiaXRzLCAiMSIpKQpAQCAtMjEw
LDYgKzIyMiw4IEBAIHN0YXRpYyBpbnQgb3Blbl9kZXZpY2UoY29uc3QgY2hhciAqdHR5LCBHSGFz
aFRhYmxlICpvcHRpb25zKQogCQkJCW9rID0gc2V0X3J0c2N0cyh2YWx1ZSwgJnRpKTsKIAkJCWVs
c2UgaWYgKGdfc3RyX2VxdWFsKGtleSwgImxvY2FsIikpCiAJCQkJb2sgPSBzZXRfbG9jYWwodmFs
dWUsICZ0aSk7CisJCQllbHNlIGlmIChnX3N0cl9lcXVhbChrZXksICJyZWFkIikpCisJCQkJb2sg
PSBzZXRfcmVhZCh2YWx1ZSwgJnRpKTsKIAogCQkJaWYgKG9rID09IEZBTFNFKQogCQkJCXJldHVy
biAtMTsK

--===============7300854487931046880==--

