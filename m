Content-Type: multipart/mixed; boundary="===============7431199620462099616=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Bug/Oversight in gatchat/gatresult.c with negative numbers
Date: Fri, 06 Aug 2021 15:28:45 +0100
Message-ID: <1b573a42-717d-9639-fe19-833667804137@dynamicdevices.co.uk>
In-Reply-To: <3e7af84c-b9be-251e-b288-aa621dcd3e4e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7431199620462099616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 06/08/2021 15:20, Denis Kenzior wrote:
> Hi Alex,
>
>> Denis - I am being directed to the ITU 36.133 spec here
>>
>> https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetai=
ls.aspx?specificationId=3D2420 =

>>
>>
>
> Sure, same document/section where 27.007 refers to for <rsrp>.=C2=A0 But =

> unfortunately 27.007 only defines the range 0..97 where 0 is <rsrp> < =

> 140 dbm. How 3GPP decides to represent <rsrp> values between 156 and =

> 140 is up to 3GPP. If your vendor is using negative integers in AT =

> commands, then that is a vendor extension and not something that is =

> permitted by ITU v.250.
>
>> This document defines this in 9.1.4
>>
>> I can't see where RSRP_-17 is defined anywhere but the strong =

>> implication to me is that this number should be -17
>>
>> Can you confirm where it states that these numbers cannot be negative =

>> numbers as I cannot find that requirement.
>>
>
> V.250 Section 5.3.1.=C2=A0 Notice that 27.007 never uses negative integer=
s, =

> there's a reason for that.
>
> Regards,
> -Denis


OK - they say it's fine and you say it's not. I don't have the time to =

be the middle-man here.

Although I'd like to, clearly I won't be able to contribute this Quectel =

support upstream.

Thanks anyway,

Alex


--===============7431199620462099616==--

