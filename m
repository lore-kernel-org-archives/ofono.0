Content-Type: multipart/mixed; boundary="===============5892257996637658698=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: [PATCH] When setting the serial port,
 the previous settings need to be preserved.
Date: Tue, 20 Oct 2009 11:10:22 +0200
Message-ID: <4ADD7E7E.8030903@gmail.com>
In-Reply-To: <4ADD6A05.8060301@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5892257996637658698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry. I have had a long few days. The last patch was just COMPLETELY =

wrong :(

I think i got it right this time...

Apologies,

Ryan

Ryan Raasch wrote:
> =

> Denis Kenzior wrote:
>> Hi Ryan,
>>
>>> This took a while to locate. Shouldn't it be possible to use stty
>>> outside the daemon, and then daemon would just continue as usual?
>>>
>>> In my case, the cread was being removed, so no input data could be read.
>>
>> Sorry but the patch is wrong, since you're blowing away all options =

>> that have been set via the GHashTable.
> =

> Yea. Sorry. Put it in the wrong place, uggh. It should go before setting =

> the options, since the switches are or'ing and xor'ing.
> =

>>
>> GAtTty is really a convenience method, if you need something specific, =

>> pass the option in the GHashTable or setup the fd however you wish by =

>> yourself.
>>
>> Regards,
>> -Denis
> =

> But, there is a problem with the opening of the serial port b/c the =

> CREAD flag is destroyed if it is active, making the serial port unreadabl=
e.
> =

> Ryan
> =

>> _______________________________________________
>> ofono mailing list
>> ofono-bdc2hr5oBkPYtjvyW6yDsg(a)public.gmane.org
>> http://lists.ofono.org/listinfo/ofono
>=20

--===============5892257996637658698==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="serial_port_enable_CREAD.patch"

ZGlmZiAtLWdpdCBhL2dhdGNoYXQvZ2F0dHR5LmMgYi9nYXRjaGF0L2dhdHR0eS5jCmluZGV4IDYz
ZDI2ZDQuLmQ2MjQzMzYgMTAwNjQ0Ci0tLSBhL2dhdGNoYXQvZ2F0dHR5LmMKKysrIGIvZ2F0Y2hh
dC9nYXR0dHkuYwpAQCAtOTcsNiArOTcsMTkgQEAgc3RhdGljIGdib29sZWFuIHNldF9iYXVkKGNv
bnN0IGNoYXIgKmJhdWQsIHN0cnVjdCB0ZXJtaW9zICp0aSkKIAlyZXR1cm4gVFJVRTsKIH0KIAor
c3RhdGljIGdib29sZWFuIHNldF9yZWFkKGNvbnN0IGNoYXIgKmJpdHMsIHN0cnVjdCB0ZXJtaW9z
ICp0aSkKK3sKKwlpZiAoZ19zdHJfZXF1YWwoYml0cywgIm9mZiIpKQorCQl0aS0+Y19jZmxhZyAm
PSB+KENSRUFEKTsKKwllbHNlIGlmIChnX3N0cl9lcXVhbChiaXRzLCAib24iKSkKKwkJdGktPmNf
Y2ZsYWcgfD0gQ1JFQUQ7CisJZWxzZQorCQlyZXR1cm4gRkFMU0U7CisKKwlyZXR1cm4gVFJVRTsK
KworfQorCiBzdGF0aWMgZ2Jvb2xlYW4gc2V0X3N0b3BfYml0cyhjb25zdCBjaGFyICpiaXRzLCBz
dHJ1Y3QgdGVybWlvcyAqdGkpCiB7CiAJaWYgKGdfc3RyX2VxdWFsKGJpdHMsICIxIikpCkBAIC0x
ODYsNiArMTk5LDEyIEBAIHN0YXRpYyBpbnQgb3Blbl9kZXZpY2UoY29uc3QgY2hhciAqdHR5LCBH
SGFzaFRhYmxlICpvcHRpb25zKQogCW1lbXNldCgmdGksIDAsIHNpemVvZih0aSkpOwogCWNmbWFr
ZXJhdygmdGkpOwogCisJZmQgPSBvcGVuKHR0eSwgT19SRFdSIHwgT19OT0NUVFkgfCBPX05PTkJM
T0NLKTsKKwlpZiAoZmQgPCAwKQorCQlyZXR1cm4gLTE7CisKKwl0Y2dldGF0dHIoZmQsJnRpKTsK
KwogCWlmIChvcHRpb25zKSB7CiAJCUdIYXNoVGFibGVJdGVyIGl0ZXI7CiAJCWNvbnN0IGNoYXIg
KmtleTsKQEAgLTIxMCwxNiArMjI5LDE0IEBAIHN0YXRpYyBpbnQgb3Blbl9kZXZpY2UoY29uc3Qg
Y2hhciAqdHR5LCBHSGFzaFRhYmxlICpvcHRpb25zKQogCQkJCW9rID0gc2V0X3J0c2N0cyh2YWx1
ZSwgJnRpKTsKIAkJCWVsc2UgaWYgKGdfc3RyX2VxdWFsKGtleSwgImxvY2FsIikpCiAJCQkJb2sg
PSBzZXRfbG9jYWwodmFsdWUsICZ0aSk7CisJCQllbHNlIGlmIChnX3N0cl9lcXVhbChrZXksICJy
ZWFkIikpCisJCQkJb2sgPSBzZXRfcmVhZCh2YWx1ZSwgJnRpKTsKIAogCQkJaWYgKG9rID09IEZB
TFNFKQogCQkJCXJldHVybiAtMTsKIAkJfQogCX0KIAotCWZkID0gb3Blbih0dHksIE9fUkRXUiB8
IE9fTk9DVFRZIHwgT19OT05CTE9DSyk7Ci0JaWYgKGZkIDwgMCkKLQkJcmV0dXJuIC0xOwotCiAJ
dGNmbHVzaChmZCwgVENJT0ZMVVNIKTsKIAl0Y3NldGF0dHIoZmQsIFRDU0FOT1csICZ0aSk7CiAK

--===============5892257996637658698==--

