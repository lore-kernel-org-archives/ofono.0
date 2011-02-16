Content-Type: multipart/mixed; boundary="===============6576027539865143905=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 05/18] plugins: add plugin for u8500
Date: Wed, 16 Feb 2011 16:26:52 +0200
Message-ID: <AANLkTi=pZCFHhe37OeydXf-XSa_AhES7Q2YfE6gT04sh@mail.gmail.com>
In-Reply-To: <bb433a06bc7f06dfdf8cf867b7e8ceb507c7bf1b.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6576027539865143905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/2/15 Andreas Westin <andreas.westin@stericsson.com>:
> +static int u8500_probe(struct ofono_modem *modem)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const char *ifname =3D ofono_modem_get_string(mode=
m, "Interface");
> + =C2=A0 =C2=A0 =C2=A0 unsigned address =3D ofono_modem_get_integer(modem=
, "Address");
> + =C2=A0 =C2=A0 =C2=A0 GIsiModem *isimodem;
> + =C2=A0 =C2=A0 =C2=A0 GIsiClient *client =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 GIsiPhonetNetlink *link =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ifname =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("(%p) with %s", modem, ifname);
> +
> + =C2=A0 =C2=A0 =C2=A0 isimodem =3D g_isi_modem_create_by_name(ifname);
> + =C2=A0 =C2=A0 =C2=A0 if (isimodem =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Interface=3D%s: %=
s", ifname, strerror(errno));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -errno;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_modem_set_version(isimodem, modemversio=
n))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;

I'm not going to add this API in GIsiModem. If we went this route, and
used vendor quirks inside the isimodem driver, then it would make a
whole lot more sense to do it in the driver create(), not here.

But we're not going that route. Each driver detects the version of the
ISI service it is talking to when it is probed.

Cheers,
Aki

--===============6576027539865143905==--

