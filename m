Content-Type: multipart/mixed; boundary="===============6010405910162652755=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 07/18] isimodem: add wgmodem2.5 to devinfo
Date: Wed, 16 Feb 2011 16:15:31 +0200
Message-ID: <AANLkTikQLAggYRPFrfULAywN93WA-AwLtTo3ktNN1XiH@mail.gmail.com>
In-Reply-To: <b1a7da8d4f03ebca0ee0fd98db11ba4fb8e229e1.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6010405910162652755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/2/15 Andreas Westin <andreas.westin@stericsson.com>:
> @@ -111,17 +115,22 @@ static void isi_query_manufacturer(struct ofono_dev=
info *info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct devinfo_data *dev =3D ofono_devinfo_get=
_data(info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct isi_cb_data *cbd =3D isi_cb_data_new(de=
v, cb, data);
>
> + =C2=A0 =C2=A0 =C2=A0 if (cbd =3D=3D NULL || dev =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_client_resource(dev->client) =3D=3D PN_M=
ODEM_INFO) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 } else {
> +

So do I understand this right, that PN_MODEM_INFO doesn't return any
of manufacturer, model, revision, or serial information at all?

If so, then I don't understand why any of this code is here. To
implement the serial number query, you just need to implement and
register your custom devinfo driver in the U8500 plugin that reads the
serial from under /etc.

Cheers,
Aki

--===============6010405910162652755==--

