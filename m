Content-Type: multipart/mixed; boundary="===============1190281129969102028=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] fix can't attach GPRS issue
Date: Thu, 02 Jun 2011 02:51:31 -0500
Message-ID: <4DE74103.3010500@gmail.com>
In-Reply-To: <1305009484-27363-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1190281129969102028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 05/10/2011 01:38 AM, Caiwen Zhang wrote:
> This patch is to fix the issue that can't attach GPRS after detach it. =

> =


I'd like to see a complete AT log of this situation if possible.  It
sounds like there's something else going on here...

> Cause:
>   When start detaching GPRS, driver_attched value is set to FALSE, if
> device registered to GPRS network during GPRS detaching, driver_attched i=
s set to TURE.
> After that, GPRS attaching will always be ignored because driver_attched =
is always TURE.
> It seems the definition of driver_attched is confused.
> =

> Scenario:
>   When device is unregistered(+CREG: 2), GPRS is detached. During GPRS de=
taching, device
> registered to network again(+CREG: 1, xxx, xxx).

Really sounds like your firmware is too twitchy.  Why does it report
CREG: 2 and then immediately finds registration?  Is this related to
cell roaming or technology switch?

> =

> Solution:
>   variable attached represents the GPRS attach status, it only be TRUE, w=
hen CGATT=3D1 and =

> CGREG is registered or roaming(roaming allowed). variable driver_attached=
 represents CGATT
> status of the driver. its value will only be changed after set_attached s=
uccessfully or =

> GPRS detached notified. variable pending_attached represents the pending =
status of CGATT.
> =


Can you try the attached patch and tell me if this fixes your problem?

Regards,
-Denis

--===============1190281129969102028==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-gprs-Experimental-fix-for-twitchy-Huawei-firmware.patch"

PkZyb20gNGUwMmYyYjQ2Y2U3YjkzMGIyYzNlZTYyMjhkOGM0M2U1MjlhMjI1NCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IFRodSwgMiBKdW4gMjAxMSAwMjo0ODowNSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIGdwcnM6
IEV4cGVyaW1lbnRhbCBmaXggZm9yIHR3aXRjaHkgSHVhd2VpIGZpcm13YXJlCgotLS0KIHNyYy9n
cHJzLmMgfCAgICA4ICsrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvZ3Bycy5jIGIvc3JjL2dwcnMuYwppbmRl
eCBhY2JmYTU2Li5iOWUzMTA1IDEwMDY0NAotLS0gYS9zcmMvZ3Bycy5jCisrKyBiL3NyYy9ncHJz
LmMKQEAgLTIxMDgsNiArMjEwOCwxNCBAQCB2b2lkIG9mb25vX2dwcnNfc3RhdHVzX25vdGlmeShz
dHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3BycywgaW50IHN0YXR1cykKIAkJcmV0dXJuOwogCX0KIAorCS8q
CisJICogSWYgd2UncmUgYWxyZWFkeSB0YWtpbmcgYWN0aW9uLCBlLmcuIGF0dGFjaGluZyBvciBk
ZXRhY2hpbmcsIHRoZW4KKwkgKiBpZ25vcmUgdGhpcyBub3RpZmljYXRpb24gZm9yIG5vdywgd2Ug
d2lsbCB0YWtlIGFwcHJvcHJpYXRlIGFjdGlvbgorCSAqIGFmdGVyIHRoZSBzZXRfYXR0YWNoIG9w
ZXJhdGlvbiBoYXMgY29tcGxldGVkCisJICovCisJaWYgKGdwcnMtPmZsYWdzICYgR1BSU19GTEFH
X0FUVEFDSElORykKKwkJcmV0dXJuOworCiAJLyogV2UgcmVnaXN0ZXJlZCB3aXRob3V0IGJlaW5n
IHBvd2VyZWQgKi8KIAlpZiAoZ3Bycy0+cG93ZXJlZCA9PSBGQUxTRSkKIAkJZ290byBkZXRhY2g7
Ci0tIAoxLjcuMy40Cgo=

--===============1190281129969102028==--

