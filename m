Content-Type: multipart/mixed; boundary="===============1538141035613222152=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Fri, 03 Dec 2010 16:07:45 +0200
Message-ID: <AANLkTim7GyxfbDttWSuUraSDdRXgcWKT-Fq3odZ1C1EN@mail.gmail.com>
In-Reply-To: <1291369648-25059-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1538141035613222152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

2010/12/3 Antti Paila <antti.paila@nokia.com>:
> +static GDBusMethodTable nettime_methods[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 { "GetNetworkTime", "", "a{sv}", nettime_get_time =
},
> + =C2=A0 =C2=A0 =C2=A0 { }
> +};
> +
> +static GDBusSignalTable nettime_signals[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 { "NetworkTimeChanged", "a{sv}" },
> + =C2=A0 =C2=A0 =C2=A0 { }
> +};

The only thing I would change here are the names. It's customary to
avoid repeating the interface name in the signal or method, but of
course the problem here is then what to call these. Maybe just Get()
and Changed()? ;-)

Oh, and you probably should have included a short description of what
this plugin is for (I forgot to mention this before).

The thinking behind this plugin is that timed in MeeGo wants to get
the information, and a D-Bus API is a fine way to accomplish this.

Cheers,
Aki

--===============1538141035613222152==--

