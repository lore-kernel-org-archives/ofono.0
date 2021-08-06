Content-Type: multipart/mixed; boundary="===============0865439895078879089=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Bug/Oversight in gatchat/gatresult.c with negative numbers
Date: Fri, 06 Aug 2021 09:20:02 -0500
Message-ID: <3e7af84c-b9be-251e-b288-aa621dcd3e4e@gmail.com>
In-Reply-To: <0af28d41-60eb-47b7-7b9a-99fc734bab31@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0865439895078879089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

> Denis - I am being directed to the ITU 36.133 spec here
> =

> https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetail=
s.aspx?specificationId=3D2420
> =


Sure, same document/section where 27.007 refers to for <rsrp>.  But =

unfortunately 27.007 only defines the range 0..97 where 0 is <rsrp> < 140 d=
bm. =

How 3GPP decides to represent <rsrp> values between 156 and 140 is up to 3G=
PP. =

If your vendor is using negative integers in AT commands, then that is a ve=
ndor =

extension and not something that is permitted by ITU v.250.

> This document defines this in 9.1.4
> =

> I can't see where RSRP_-17 is defined anywhere but the strong implication=
 to me =

> is that this number should be -17
> =

> Can you confirm where it states that these numbers cannot be negative num=
bers as =

> I cannot find that requirement.
> =


V.250 Section 5.3.1.  Notice that 27.007 never uses negative integers, ther=
e's a =

reason for that.

Regards,
-Denis
--===============0865439895078879089==--

