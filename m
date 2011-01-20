Content-Type: multipart/mixed; boundary="===============7971616068322044991=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix IFX large file Downlink data transer
Date: Thu, 20 Jan 2011 11:43:00 +0100
Message-ID: <1295520180.3873.272.camel@aeonflux>
In-Reply-To: <2A84145621092446B6659B8A0F28E26F47006AA770@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7971616068322044991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

please prefix the patch with gatchat: <short description>

And while you are fixing a IFX issue, that should be only mentioned in
the body here. Along with a more detailed explanation what and why.

This is especially important for things like buffer sizes etc., but in a
few weeks nobody remembers why we did it.

> -              io->buf =3D ring_buffer_new(4096);
> =

> +             io->buf =3D ring_buffer_new(8192);

Something scrambled your tabs vs spaces. Might have been our Exchange
server again. Just point to linux.intel.com as SMTP if in doubt.

>                 if (!io->buf)
> =

>                                goto error;
> =

> @@ -288,7 +288,7 @@ gboolean g_at_io_set_write_handler(GAtIO *io,
> GAtIOWriteFunc write_handler,
> =

>  =

> =

>                 if (io->use_write_watch =3D=3D TRUE)
> =

>                                io->write_watch =3D
> g_io_add_watch_full(io->channel,
> =

> -
> G_PRIORITY_DEFAULT,
> =

> +
> G_PRIORITY_HIGH,

Same here. This locks like the server mangled with your email or your
editor did.

Regards

Marcel




--===============7971616068322044991==--

