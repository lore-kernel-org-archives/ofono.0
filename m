Content-Type: multipart/mixed; boundary="===============1884314432888218811=="
MIME-Version: 1.0
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 2/2] Implement HandsfreeGateway Interface
Date: Thu, 21 Jan 2010 18:20:23 -0300
Message-ID: <2a9506371001211320r6dc7958h5b0040cec6f79e4b@mail.gmail.com>
In-Reply-To: <1264105871-27322-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1884314432888218811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Thu, Jan 21, 2010 at 5:31 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> + =C2=A0 =C2=A0 =C2=A0 gw->sco =3D chan;
> + =C2=A0 =C2=A0 =C2=A0 g_io_channel_ref(chan);
> +

You must have forgotten to change this.

> @@ -307,17 +565,15 @@ struct gateway *gateway_init(struct audio_device *d=
ev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gateway *gw;
>
> + =C2=A0 =C2=A0 =C2=A0 gw =3D g_new0(struct gateway, 1);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!g_dbus_register_interface(dev->conn, dev-=
>path,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AUDIO_GAT=
EWAY_INTERFACE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gateway_m=
ethods, gateway_signals,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, dev=
, NULL))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
>

Seems like gw is leaking if registration fails. Move it down a little, perh=
aps?

> - =C2=A0 =C2=A0 =C2=A0 debug("in gateway_init, dev is %p", dev);
> - =C2=A0 =C2=A0 =C2=A0 gw =3D g_new0(struct gateway, 1);
> - =C2=A0 =C2=A0 =C2=A0 gw->state =3D GATEWAY_STATE_DISCONNECTED;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return gw;
> -
> =C2=A0}
>


Cheers,
-- =

Vinicius Gomes
INdT - Instituto Nokia de Tecnologia

--===============1884314432888218811==--

