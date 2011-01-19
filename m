Content-Type: multipart/mixed; boundary="===============8059501864086393496=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] Allow distcheck to work without bluetooth
Date: Wed, 19 Jan 2011 14:20:58 +0100
Message-ID: <1295443258.3873.243.camel@aeonflux>
In-Reply-To: <1295433065-26502-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8059501864086393496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> diff --git a/Makefile.am b/Makefile.am
> index c1c34ca..e93076a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -550,6 +550,9 @@ gatchat_test_qcdm_LDADD =3D @GLIB_LIBS@
>  =

> =

>  DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles
> +if !BLUETOOTH
> +DISTCHECK_CONFIGURE_FLAGS +=3D --disable-bluetooth
> +endif

this patch makes no sense to me. I am not going to apply it. Using make
distcheck works nicely on my system where I build the releases.

Regards

Marcel



--===============8059501864086393496==--

