Content-Type: multipart/mixed; boundary="===============2019957513968868002=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH v3 1/2] stemodem: Add RTNL functionality managing CAIF
 Network Interfaces.
Date: Thu, 04 Nov 2010 15:02:13 +0100
Message-ID: <AANLkTik8SAy8HEzS2+UPH6BGUEU+KcQcVCt6113Z01s-@mail.gmail.com>
In-Reply-To: <1288809604-976-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2019957513968868002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

> +int caif_rtnl_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct sockaddr_nl addr;
> + =C2=A0 =C2=A0 =C2=A0 int sk, err;
> + =C2=A0 =C2=A0 =C2=A0 GError *gerr =3D NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 sk =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUT=
E);
> + =C2=A0 =C2=A0 =C2=A0 if (sk < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return sk;
> +
> + =C2=A0 =C2=A0 =C2=A0 memset(&addr, 0, sizeof(addr));
> + =C2=A0 =C2=A0 =C2=A0 addr.nl_family =3D AF_NETLINK;
> + =C2=A0 =C2=A0 =C2=A0 addr.nl_groups =3D RTMGRP_LINK | RTMGRP_IPV4_IFADD=
R | RTMGRP_IPV4_ROUTE;
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D bind(sk, (struct sockaddr *) &addr, sizeof=
(addr));
> + =C2=A0 =C2=A0 =C2=A0 if (err < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(sk);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 channel =3D g_io_channel_unix_new(sk);
> + =C2=A0 =C2=A0 =C2=A0 g_io_channel_set_flags(channel, G_IO_FLAG_NONBLOCK=
, &gerr);
> + =C2=A0 =C2=A0 =C2=A0 g_io_channel_set_encoding(channel, NULL, &gerr);
> + =C2=A0 =C2=A0 =C2=A0 g_io_channel_set_buffered(channel, TRUE);
> + =C2=A0 =C2=A0 =C2=A0 g_io_channel_set_close_on_unref(channel, TRUE);
> +
> + =C2=A0 =C2=A0 =C2=A0 rtnl_watch =3D g_io_add_watch(channel,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ER=
R,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netlink_event, NULL);
> + =C2=A0 =C2=A0 =C2=A0 pending_requests =3D NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}

Sigh, I realize I have a potential leak on gerr above. I'll wait for
more review comments from you,
and resubmit later.

Regards,
Sjur

--===============2019957513968868002==--

