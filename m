Content-Type: multipart/mixed; boundary="===============0582085581253486199=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 4/6] CHAP with MD5 authentication
Date: Wed, 17 Mar 2010 00:12:09 -0700
Message-ID: <1268809929.2700.107.camel@localhost.localdomain>
In-Reply-To: <20100316171321.0334ac38@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0582085581253486199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> Implement authentication support with CHAP and MD5 digest
> ---
>  Makefile.am               |    3 =

>  gatchat/gatppp.c          |   12 ++
>  gatchat/gatppp.h          |    2 =

>  gatchat/gatppp_internal.h |   15 +++
>  gatchat/gatpppauth.c      |  230 +++++++++++++++++++++++++++++++++++++++=
+++++++

and here we do gatchat/ppp_auth.c.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ofono.orig/gatchat/gatppp.h	2010-03-16 15:27:28.906468886 -0700
> +++ ofono/gatchat/gatppp.h	2010-03-16 15:35:51.931601029 -0700
> @@ -51,6 +51,8 @@
>  void g_at_ppp_shutdown(GAtPPP *ppp);
>  void g_at_ppp_ref(GAtPPP *ppp);
>  void g_at_ppp_unref(GAtPPP *ppp);
> +void g_at_ppp_set_credentials(GAtPPP *ppp, gchar *username,
> +				gchar *passwd);

Please don't use gchar. That thing is the most stupid thing the GLib
guys ever did. Even I fell for it some time ago. It is just wrong and
these days even the GLib guys admit that it was an big mistake.

Also these parameters should be const char * actually.

Regards

Marcel



--===============0582085581253486199==--

