Content-Type: multipart/mixed; boundary="===============1862153908404993098=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Ofono and PPP
Date: Tue, 22 Jun 2010 17:33:55 +0200
Message-ID: <1277220835.2301.160.camel@localhost.localdomain>
In-Reply-To: <AANLkTinmsDix_J1MviE68tcDJGfyBX-NOmmeoq1nDnd5@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1862153908404993098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

> I have managed to put together ofono and conn man for an at modem
> interface. =

> =

> The atmodem is working and here is the detail of a pdp context i
> created.
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------
> [ /generic ]
>     [ /generic/primarycontext1 ]
>         Username =3D =

>         Name =3D Internet access
>         Settings =3D { Interface=3Dppp0 Netmask=3D255.255.255.255
> Method=3Dstatic DomainNameServers=3D192.89.123.231,192.89.123.230,
> Address=3D109.240.193.169 }
>         Active =3D 1
>         AccessPointName =3D internet
>         Password =3D =

>         Type =3D internet
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------
> =

> the ifconfig:
> =

> ppp0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  =

>           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:32 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:500 =

>           RX bytes:0 (0.0 B)  TX bytes:10944 (10.9 KB)
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------
> =

> The ifconfig doesn't seem to have all the required information from
> the ppp link created. why this is so? Is there a way to put these in
> sync?

try the latest versions of ConnMan and oFono. I have this actually
working perfectly fine with Novatel and Huawei devices. Maybe the
atmodem driver has an issue, but in general this works fine.

Regards

Marcel



--===============1862153908404993098==--

