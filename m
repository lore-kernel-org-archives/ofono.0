Content-Type: multipart/mixed; boundary="===============1520588921675538606=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Makefile.am: fix missing line continuation
Date: Fri, 07 Jan 2011 12:55:22 -0800
Message-ID: <1294433722.2501.19.camel@aeonflux>
In-Reply-To: <1294411771-27849-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1520588921675538606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

>  Makefile.am |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 09dc9ad..679e4bf 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -436,7 +436,7 @@ test_scripts =3D test/backtrace \
>  		test/send-vcard \
>  		test/set-tty \
>  		test/set-gsm-band \
> -		test/set-umts-band
> +		test/set-umts-band \
>  		test/lockdown-modem

good catch. Patch has been applied. Thanks.

Regards

Marcel



--===============1520588921675538606==--

