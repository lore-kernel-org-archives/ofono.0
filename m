Content-Type: multipart/mixed; boundary="===============6795027695227813296=="
MIME-Version: 1.0
From: Radek Polak <psonek2@seznam.cz>
Subject: Re: Polling CLCC error handling on Option modem (GTA04)
Date: Wed, 07 Mar 2012 11:36:24 +0100
Message-ID: <201203071136.24508.psonek2@seznam.cz>
In-Reply-To: <4F551365.9000200@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6795027695227813296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Monday 05 March 2012 20:26:29 Denis Kenzior wrote:

> You can always try ignoring CME ERROR 100 and re-try the CLCC poll.
> Maybe the modem is in a transitional period (e.g. call being released)
> and it can't answer the CLCC properly.  In other words, there's a bug
> related to timing of call state changes & CLCC implementation in the
> modem firmware.

Yes, it is definitely timing bug. Attached is patch that continues CLCC pol=
ling =

even after error assuming that CLCC will start working again. It works fine=
 for =

me (see log below). It would be nice to get this in ofono git.

ofonod[1188]: App: < \r\n+CLCC: 1,1,4,0,0,"+420608828973",145\r\n\r\nOK\r\n
ofonod[1188]: App: > AT+CLCC\r
ofonod[1188]: App: < \r\n+CME ERROR: 100\r\n
ofonod[1188]: We are polling CLCC and received an error, retrying...
ofonod[1188]: App: > AT+CLCC\r
ofonod[1188]: App: < \r\nOK\r\n
ofonod[1188]: src/voicecall.c:ofono_voicecall_disconnected() Got disconnect=
ion =

event for id: 1, reason: 2


Regards

Radek

--===============6795027695227813296==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="continue_clcc_after_error.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRtb2RlbS92b2ljZWNhbGwuYyBiL2RyaXZlcnMvYXRtb2Rl
bS92b2ljZWNhbGwuYwppbmRleCBkMDcwNTJjLi4zMjRlYTRiIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2F0bW9kZW0vdm9pY2VjYWxsLmMKKysrIGIvZHJpdmVycy9hdG1vZGVtL3ZvaWNlY2FsbC5jCkBA
IC0xNDcsOCArMTQ3LDkgQEAgc3RhdGljIHZvaWQgY2xjY19wb2xsX2NiKGdib29sZWFuIG9rLCBH
QXRSZXN1bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKQogCWdib29sZWFuIHBvbGxfYWdh
aW4gPSBGQUxTRTsKIAogCWlmICghb2spIHsKLQkJb2Zvbm9fZXJyb3IoIldlIGFyZSBwb2xsaW5n
IENMQ0MgYW5kIHJlY2VpdmVkIGFuIGVycm9yIik7Ci0JCW9mb25vX2Vycm9yKCJBbGwgYmV0cyBh
cmUgb2ZmIGZvciBjYWxsIG1hbmFnZW1lbnQiKTsKKwkJb2Zvbm9fZXJyb3IoIldlIGFyZSBwb2xs
aW5nIENMQ0MgYW5kIHJlY2VpdmVkIGFuIGVycm9yLCByZXRyeWluZy4uLiIpOworCQl2ZC0+Y2xj
Y19zb3VyY2UgPSBnX3RpbWVvdXRfYWRkKFBPTExfQ0xDQ19JTlRFUlZBTCwKKwkJCQkJCXBvbGxf
Y2xjYywgdmMpOwogCQlyZXR1cm47CiAJfQogCg==

--===============6795027695227813296==--

