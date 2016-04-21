Content-Type: multipart/mixed; boundary="===============6986270751012332905=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: Re: Ublox Toby Modem
Date: Thu, 21 Apr 2016 11:03:55 +0200
Message-ID: <5718977B.7030909@endocode.com>
In-Reply-To: <5717C244.3080302@gmx.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6986270751012332905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yarn,

On 04/20/2016 07:54 PM, Yorn wrote:
> Hi Dragos,
> =

> logs + comments inline
> =

> Am 20.04.2016 um 17:01 schrieb Dragos Tatulea:
>> Hi Yorn,
>>
>> On 04/20/2016 04:24 PM, Yorn wrote:
>>> Hi Dragos,
>>>
>>> it is still active=3D0 :(
>>>
>>> root(a)colibri-vf:~/test# ./list-contexts
>>> [ /ublox_0 ]
>>>      [ /ublox_0/context1 ]
>>>          Username =3D
>>>          AuthenticationMethod =3D chap
>>>          Protocol =3D ip
>>>          Name =3D Internet
>>>          Settings =3D { }
>>>          IPv6.Settings =3D { }
>>>          Active =3D 0
>>>          AccessPointName =3D
>>>          Password =3D
>>>          Type =3D internet
>>>
>> Can you run only oFono (no connman) with OFONO_AT_DEBUG env variable set
>> and run the following scripts:
>>
>> enable-modem
>> online-modem
>> activate-context
>>
>> Then send the logs.
> Here they are [1]
> =

> I set the context information now as follows:
> root(a)colibri-vf:~/test# ./list-contexts
> [ /ublox_0 ]
>     [ /ublox_0/context1 ]
>         Username =3D eplus
>         AuthenticationMethod =3D chap
>         Protocol =3D ip
>         Name =3D Internet
>         Settings =3D { }
>         IPv6.Settings =3D { }
>         Active =3D 0
>         AccessPointName =3D m2m.tele2.com
>         Password =3D
>         Type =3D internet
> =

> =

Okay. That's good for the next step.

> I would expect AT Commands like this, however, I am not a modem AT comman=
d expert, so this is more or less taken from a tutorial (which set up my ma=
nual environment successfully)
> =

> AT+COPS?
> AT+CGDCONT=3D1,"IP","m2m.tele2.com"
> ATD*99***1#
> AT+CGACT=3D1,1
It never gets to do a context activation because the modem is not gprs
attached (see Attached state). The reason for that seems to be the
RoamingAllowed property not being set to true/1. Try to set  it to true
(set-roaming-allowed) and try again.

> AT+CGDATA=3D"PPP",1
> CONNECT ""
> =


Also, Toby doesn't use PPP in high throughput mode. It uses an ndis
interface (you should see a usbX interface popping up when inserting
the powered up modem on usb).

Thanks
-- =

Dragos Tatulea
Software Developer @ Endocode AG
dragos(a)endocode.com

Endocode AG, Br=C3=BCckenstra=C3=9Fe 5A, 10179 Berlin
+49 30 1206 4472 | info(a)endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Thomas Fricke, Sebastian Sucker
Aufsichtsratsvorsitzende: Alexandra Boehm

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B

--===============6986270751012332905==--

