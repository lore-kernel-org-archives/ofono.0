Content-Type: multipart/mixed; boundary="===============2532311136780158420=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: Re: Ublox Toby Modem
Date: Wed, 20 Apr 2016 17:01:27 +0200
Message-ID: <571799C7.6040906@endocode.com>
In-Reply-To: <57179117.5000007@gmx.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2532311136780158420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yorn,

On 04/20/2016 04:24 PM, Yorn wrote:
> Hi Dragos,
> =

> it is still active=3D0 :(
> =

> root(a)colibri-vf:~/test# ./list-contexts
> [ /ublox_0 ]
>     [ /ublox_0/context1 ]
>         Username =3D
>         AuthenticationMethod =3D chap
>         Protocol =3D ip
>         Name =3D Internet
>         Settings =3D { }
>         IPv6.Settings =3D { }
>         Active =3D 0
>         AccessPointName =3D
>         Password =3D
>         Type =3D internet
> =

Can you run only oFono (no connman) with OFONO_AT_DEBUG env variable set
and run the following scripts:

enable-modem
online-modem
activate-context

Then send the logs.

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

--===============2532311136780158420==--

