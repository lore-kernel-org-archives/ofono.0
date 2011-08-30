Content-Type: multipart/mixed; boundary="===============1991886021584709942=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [VPATH PATCH 2/2] Fix $(INCLUDE) in Makefile.am
Date: Tue, 30 Aug 2011 11:39:59 -0700
Message-ID: <1314729601.3373.248.camel@aeonflux>
In-Reply-To: <1314706818-9720-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1991886021584709942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> Allow using directory names as namespaces.
> ---
>  Makefile.am |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 832c8ac..92ef72e 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -447,7 +447,8 @@ AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLA=
GS@ @USB_CFLAGS@ \
>  					-DOFONO_PLUGIN_BUILTIN \
>  					-DPLUGINDIR=3D\""$(build_plugindir)"\"
>  =

> -INCLUDES =3D -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/src \
> +INCLUDES =3D -I$(builddir) -I$(srcdir) -I$(builddir)/include \
> +			-I$(builddir)/src -I$(srcdir)/src \
>  			-I$(srcdir)/gdbus -I$(srcdir)/gisi -I$(srcdir)/gatchat \
>  			-I$(srcdir)/btio

what problem is this patch fixing?

Regards

Marcel



--===============1991886021584709942==--

