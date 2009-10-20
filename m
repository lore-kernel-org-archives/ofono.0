Content-Type: multipart/mixed; boundary="===============7851025378434865898=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: [PATCH] When setting the serial port,
 the previous settings need to be preserved.
Date: Tue, 20 Oct 2009 09:43:01 +0200
Message-ID: <4ADD6A05.8060301@gmail.com>
In-Reply-To: <200910191232.45844.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7851025378434865898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Denis Kenzior wrote:
> Hi Ryan,
> =

>> This took a while to locate. Shouldn't it be possible to use stty
>> outside the daemon, and then daemon would just continue as usual?
>>
>> In my case, the cread was being removed, so no input data could be read.
> =

> Sorry but the patch is wrong, since you're blowing away all options that =
have =

> been set via the GHashTable.

Yea. Sorry. Put it in the wrong place, uggh. It should go before setting =

the options, since the switches are or'ing and xor'ing.

> =

> GAtTty is really a convenience method, if you need something specific, pa=
ss the =

> option in the GHashTable or setup the fd however you wish by yourself.
> =

> Regards,
> -Denis

But, there is a problem with the opening of the serial port b/c the =

CREAD flag is destroyed if it is active, making the serial port unreadable.

Ryan

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============7851025378434865898==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="serial_port_enable_CREAD.patch"

IGdhdGNoYXQvZ2F0dHR5LmMgfCAgIDI2ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZp
bGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZ2F0Y2hhdC9nYXR0dHkuYyBiL2dhdGNoYXQvZ2F0dHR5LmMKaW5kZXggZWQwZmFkZi4uYWE5
ZDNhNCAxMDA2NDQKLS0tIGEvZ2F0Y2hhdC9nYXR0dHkuYworKysgYi9nYXRjaGF0L2dhdHR0eS5j
CkBAIC05Nyw2ICs5NywxOSBAQCBzdGF0aWMgZ2Jvb2xlYW4gc2V0X2JhdWQoY29uc3QgY2hhciAq
YmF1ZCwgc3RydWN0IHRlcm1pb3MgKnRpKQogCXJldHVybiBUUlVFOwogfQogCitzdGF0aWMgZ2Jv
b2xlYW4gc2V0X3JlYWQodmFsdWUsICZ0aSkKK3sKKwlpZiAoZ19zdHJfZXF1YWwoYml0cywgIm9m
ZiIpKQorCQl0aS0+Y19jZmxhZyAmPSB+KENSRUFEKTsKKwllbHNlIGlmIChnX3N0cl9lcXVhbChi
aXRzLCAib24iKSkKKwkJdGktPmNfY2ZsYWcgfD0gQ1JFQUQ7CisJZWxzZQorCQlyZXR1cm4gRkFM
U0U7CisKKwlyZXR1cm4gVFJVRTsKKworfQorCiBzdGF0aWMgZ2Jvb2xlYW4gc2V0X3N0b3BfYml0
cyhjb25zdCBjaGFyICpiaXRzLCBzdHJ1Y3QgdGVybWlvcyAqdGkpCiB7CiAJaWYgKGdfc3RyX2Vx
dWFsKGJpdHMsICIxIikpCkBAIC0xODYsNiArMTk5LDEyIEBAIHN0YXRpYyBpbnQgb3Blbl9kZXZp
Y2UoY29uc3QgY2hhciAqdHR5LCBHSGFzaFRhYmxlICpvcHRpb25zKQogCW1lbXNldCgmdGksIDAs
IHNpemVvZih0aSkpOwogCWNmbWFrZXJhdygmdGkpOwogCisJZmQgPSBvcGVuKHR0eSwgT19SRFdS
IHwgT19OT0NUVFkgfCBPX05PTkJMT0NLKTsKKwlpZiAoZmQgPCAwKQorCQlyZXR1cm4gLTE7CisK
Kwl0Y2dldGF0dHIoZmQsJnRpKTsKKwogCWlmIChvcHRpb25zKSB7CiAJCUdIYXNoVGFibGVJdGVy
IGl0ZXI7CiAJCWNvbnN0IGNoYXIgKmtleTsKQEAgLTIxMCwxNyArMjI5LDE0IEBAIHN0YXRpYyBp
bnQgb3Blbl9kZXZpY2UoY29uc3QgY2hhciAqdHR5LCBHSGFzaFRhYmxlICpvcHRpb25zKQogCQkJ
CW9rID0gc2V0X3J0c2N0cyh2YWx1ZSwgJnRpKTsKIAkJCWVsc2UgaWYgKGdfc3RyX2VxdWFsKGtl
eSwgImxvY2FsIikpCiAJCQkJb2sgPSBzZXRfbG9jYWwodmFsdWUsICZ0aSk7CisJCQllbHNlIGlm
IChnX3N0cl9lcXVhbChrZXksICJyZWFkIikpCisJCQkJb2sgPSBzZXRfcmVhZCh2YWx1ZSwgJnRp
KTsKIAogCQkJaWYgKG9rID09IEZBTFNFKQogCQkJCXJldHVybiAtMTsKIAkJfQogCX0KIAotCWZk
ID0gb3Blbih0dHksIE9fUkRXUiB8IE9fTk9DVFRZIHwgT19OT05CTE9DSyk7Ci0JaWYgKGZkIDwg
MCkKLQkJcmV0dXJuIC0xOwotCi0JdGNnZXRhdHRyKGZkLCZ0aSk7CiAJdGNmbHVzaChmZCwgVENJ
T0ZMVVNIKTsKIAl0Y3NldGF0dHIoZmQsIFRDU0FOT1csICZ0aSk7CiAK

--===============7851025378434865898==--

