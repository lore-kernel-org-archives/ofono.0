Content-Type: multipart/mixed; boundary="===============1770506804458544108=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Can I modify CallingLineRestriction(the Property of
 CallSetting)	value to "disabled" or "enabled"
Date: Wed, 10 Nov 2010 17:32:14 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A47330518CE2@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1865303E0DED764181A9D882DEF65FB67E94584CCB@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1770506804458544108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Haitao,


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Ding, HaitaoX
>Sent: Wednesday, November 10, 2010 12:13 PM
>To: ofono(a)ofono.org
>Subject: RE: Can I modify CallingLineRestriction(the Property of CallSetti=
ng) value to
>"disabled" or "enabled"
>
>Hi, yang
>
>Thanks a lot for your feedback.
>
>According to your tip , I tried to set "HideCallerId" to "default", "disab=
led" and
>"enabled", and I can verify by run list-modem script that "HideCallerId" h=
ad been
>modified . but I still could find phone number on both called party and ca=
lling party ,
>regardless the value of  "HideCallerId" is what.
>
>How can I let phone number be withheld on incoming at called party , when =
I make a
>voice call.
>
>Could you give me some help .
>

I think the reason is your operator doesn't provide this supplementary serv=
ice. Below is my log when enable the "HideCallerId". I couldn't enable this=
 feature either.

ofonod[17734]: PCUI: > AT+CLIR=3D1\r
ofonod[17734]: PCUI: < \r\nOK\r\n
ofonod[17734]: PCUI: > AT+CLIR?\r
ofonod[17734]: PCUI: < \r\n+CLIR: 1,0\r\n\r\nOK\r\n
ofonod[17734]: drivers/atmodem/call-settings.c:clir_query_cb() clir_query_c=
b: override: 1, network: 0

Regards,
-Yang

--===============1770506804458544108==--

