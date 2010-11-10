Content-Type: multipart/mixed; boundary="===============4715007459242620691=="
MIME-Version: 1.0
From: Ding, HaitaoX <haitaox.ding@intel.com>
Subject: RE: Can I modify CallingLineRestriction(the Property of
 CallSetting)	value to "disabled" or "enabled"
Date: Wed, 10 Nov 2010 12:12:40 +0800
Message-ID: <1865303E0DED764181A9D882DEF65FB67E94584CCB@shsmsx502.ccr.corp.intel.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A473303C3FEF@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4715007459242620691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, yang

Thanks a lot for your feedback. =


According to your tip , I tried to set "HideCallerId" to "default", "disabl=
ed" and  "enabled", and I can verify by run list-modem script that "HideCal=
lerId" had been modified . but I still could find phone number on both call=
ed party and calling party , regardless the value of  "HideCallerId" is wha=
t. =


How can I let phone number be withheld on incoming at called party , when I=
 make a voice call. =


Could you give me some help .


Best Regards
Haitao


-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Gu, Yang
Sent: Thursday, October 28, 2010 7:32 PM
To: ofono(a)ofono.org
Subject: RE: Can I modify CallingLineRestriction(the Property of CallSettin=
g) value to "disabled" or "enabled"

Hi Haitao,

> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf Of Ding, HaitaoX
> Sent: Thursday, October 28, 2010 3:29 PM
> To: ofono(a)ofono.org
> Subject: Can I modify CallingLineRestriction(the Property of CallSetting)=
 value to "disabled" or "enabled"
>
> Hi, =

>=C2=A0
> Can I modify=C2=A0 CallingLineRestriction(the Property of CallSetting)=C2=
=A0 value to "disalbed" or "enabled". =

>=C2=A0
> I refer to the newest doc for CallSettings and found the CallingLineRestr=
iction is a read-only property, is it means ofono does not support enable o=
r disable CLIP. =

> Thanks a lot=E2=98=BA
>
=C2=A0
You may set the property "HideCallerId"=C2=A0to "default", "disabled" or "e=
nabled".
=C2=A0
=C2=A0
Regards,
-Yang=C2=A0
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============4715007459242620691==--

