Content-Type: multipart/mixed; boundary="===============6969739873471855966=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 00/14][RESEND] STK patches without agent
Date: Thu, 15 Jul 2010 22:37:20 +0200
Message-ID: <AANLkTilVBUkiZnL6OXgkdZMGIflA4uhrnMH89uHzgZkh@mail.gmail.com>
In-Reply-To: <4C3626DD.8010800@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6969739873471855966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 8 July 2010 21:28, Denis Kenzior <denkenz@gmail.com> wrote:
> On 07/06/2010 05:38 PM, Andrzej Zaborowski wrote:
>> These are some patches I sent before reordered and refactored to
>> skip stuff related to the Agent API, i.e. related to the UI.
>>
>> Andrzej Zaborowski (14):
>> =C2=A0 stk: Utilities for proactive command/envelope handling.
>> =C2=A0 mbmmodem: End session on *STKEND.
>> =C2=A0 stk: Handle the More Time proactive command as a nop.
>> =C2=A0 Add OFONO_ERROR_TYPE_SIM for negative SIM statuses.
>> =C2=A0 atmodem: Make sim operations return sim error codes.
>> =C2=A0 stk: Handle ENVELOPEs in a queue, retry on sim busy.
>> =C2=A0 Add __ofono_sms_submit for other atoms to submit SMs.
>> =C2=A0 stk: Handle the Send SMS proactive command.
>> =C2=A0 Add Dbus interface names for STK.
>> =C2=A0 stk: Handle the Set Up Idle Text proactive command.
>> =C2=A0 sktutil: Use the Mandatory flag in parse_dataobj.
>> =C2=A0 stkutil: Timer Value is conditional, not optional.
>> =C2=A0 stk: Handle the Timer Management proactive command.
>> =C2=A0 stk: Handle the Poll Interval proactive command.
>
> All patches in this series have been pushed upstream with some
> refactoring afterwards. =C2=A0Please review and make sure I didn't screw
> something up.

Thanks, just a small change to remove the seconds =3D=3D 0 check for Set
Poll Interval.  Seconds can't be 0 or parsing would fail.  The logic
behind the original code was:

Try to set the modem property to "seconds".
If setting fails, then return the previous value (which is actually
the nearest value we could accept).
If getting previous value fails (function returns 0) then return 30
secs, the default value, which also happens to be the nearest we could
accept.

Best regards

--===============6969739873471855966==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0003-stk-Remove-a-unneeded-check.patch"

RnJvbSBjNjE3ZDU2N2YxYzIzNDVmZGJjZTQyMDgwNTMxZjA5OWE4Zjk2NGRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogVHVlLCAxMyBKdWwgMjAxMCAxNjoyMzozNSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIHN0azogUmVtb3ZlIGFuIHVubmVlZGVkIGNoZWNrLgoKLS0tCiBzcmMvc3RrLmMg
fCAgICAzIC0tLQogMSBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3N0ay5jIGIvc3JjL3N0ay5jCmluZGV4IGJmMTYxNjkuLmYz
ZDgyNDcgMTAwNjQ0Ci0tLSBhL3NyYy9zdGsuYworKysgYi9zcmMvc3RrLmMKQEAgLTk3Nyw5ICs5
NzcsNiBAQCBzdGF0aWMgZ2Jvb2xlYW4gaGFuZGxlX2NvbW1hbmRfcG9sbF9pbnRlcnZhbChjb25z
dCBzdHJ1Y3Qgc3RrX2NvbW1hbmQgKmNtZCwKIAkJcmV0dXJuIFRSVUU7CiAJfQogCi0JaWYgKHNl
Y29uZHMgPT0gMCkKLQkJc2Vjb25kcyA9IDMwOwotCiAJb2Zvbm9fbW9kZW1fc2V0X2ludGVnZXIo
bW9kZW0sICJzdGF0dXMtcG9sbC1pbnRlcnZhbCIsIHNlY29uZHMpOwogCiAJaWYgKHNlY29uZHMg
PiAyNTUpIHsKLS0gCjEuNy4xLjg2LmcwZTQ2MC5kaXJ0eQoK

--===============6969739873471855966==--

