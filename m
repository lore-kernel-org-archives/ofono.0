Content-Type: multipart/mixed; boundary="===============8218044872044233979=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Bug/Oversight in gatchat/gatresult.c with negative numbers
Date: Tue, 03 Aug 2021 15:45:09 +0100
Message-ID: <6130ae5f-0d7c-cc40-e94b-114cdb452076@dynamicdevices.co.uk>
In-Reply-To: <70bd0c15-0fe5-59ea-f619-54dadd35e586@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8218044872044233979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 03/08/2021 15:28, Denis Kenzior wrote:
> Hi Alex,
>
>> I have been chasing this up with Quectel and they tell me this the =

>> correct implementation.
>>
>> "QCOPS and QENG command show the RSSI=E3=80=81RSRP and SINR value of the =

>> network, this is in accordance with the 3GPP TS regulations, so it is =

>> normal for negative numbers to be displayed.image"
>
>
> So the image shows the value for <rsrp>
>
> '0' if -140 dbm
> ...
> '95' if dbm is -46 to -45
> etc.
>
> <rsrp> (what is actually sent over AT commands) is never negative. =

> Isn't the image supporting my earlier assertion:=C2=A0 'AT commands do no=
t =

> have a concept of negative numbers'?
>
> oFono exposes the <rsrp> value from 3GPP:
>
> "byte ReferenceSignalReceivedPower [optional, lte]
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Contains the Reference Signal =
Received Power.=C2=A0 Valid range of =

> values
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is 0-97. Refer to <rsrp> in 27=
.007, Section 8.69 for more =

> details.
> "
>
> Regards,
> -Denis


Thanks... will go back to Quectel... (!)

Cheers,

Alex

--===============8218044872044233979==--

