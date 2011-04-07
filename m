Content-Type: multipart/mixed; boundary="===============3229029502442039140=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Qualcomm Gobi 2000 Modem Issues
Date: Thu, 07 Apr 2011 08:52:16 -0700
Message-ID: <1302191536.2572.180.camel@aeonflux>
In-Reply-To: <BANLkTimhdWZCh-BFhs5OLRUyVreU6ufJPA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3229029502442039140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

> I ran into two issues trying to setup a data connection with a Gobi 2000 =
card.
> The first one seems to be an error regarding simcard onlocking. After
> enabling the modem test/list-modems shows the following, despite the
> simcard is inserted correctly:
> =

> [ /gobi0 ]
>     Features =3D sim
>     Emergency =3D 0
>     Powered =3D 1
>     Lockdown =3D 0
>     Interfaces =3D org.ofono.SimManager
>     Online =3D 0
>     Model =3D Qualcomm Gobi 2000
>     Revision =3D D1025-STUTABGD-3600  1  [Jan 14 2010 14:00:00]
>     Serial =3D 353093033460401
>     Manufacturer =3D Qualcomm Incorporated
>     [ org.ofono.SimManager ]
>         Present =3D 0
> =

> Our current workaround is quitting ofono and using minicom to unlock
> the sim directly, then restarting ofono.
> > at+cpin?
> +CPIN: SIM PIN
> OK
> =

> > at+cpin=3D"1234"
> OK
> $QCSIMSTAT: 1 SIM INIT COMPLETED

this is weird since the PIN unlocking should just work fine. Have you
tried to use the test/enter-pin script?

> The second issue is not being able to activate an internet context:
> (Network registration and attachment is alright)
> =

> test/enable-modem
> Connecting modem /gobi0...
> test/online-modem
> Setting modem /gobi0 online...
> test/list-contexts
> [ /gobi0 ]
>     [ /gobi0/context1 ]
>         Username =3D
>         Protocol =3D ip
>         Name =3D Internet
>         Settings =3D { }
>         IPv6.Settings =3D { }
>         Active =3D 0
>         AccessPointName =3D internet.t-mobile
>         Password =3D
>         Type =3D internet
> =

> test/activate-context
> Error activating /gobi0/context1: org.ofono.Error.NotImplemented:
> Implementation not provided
> =

> If you could give me a little assisting on where to look, maybe I
> would be able to contribute patches, too.

Of course this does not work. Check doc/hardware-support.txt for
supported modem and supported capabilities.

Until Qualcomm gives us the chance to implement QMI properly, we are a
bit out of luck with just one AT command channel. You need at least two
AT command channel to run oFono properly.

Regards

Marcel



--===============3229029502442039140==--

