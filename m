Content-Type: multipart/mixed; boundary="===============8626416745572502979=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v5 4/7] stemodem: Add Radio Settings to STE Modem
Date: Tue, 17 Aug 2010 14:43:48 +0200
Message-ID: <1282049028.23399.91.camel@localhost.localdomain>
In-Reply-To: <1282047754-15562-5-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8626416745572502979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> ---
> Changes:
> o Changed order of files in Makefile
> o Fixed missing empty line in copyright
> o Formatted enum better
> o Removed default is switches
> o Removed ste in function names
> =

>  Makefile.am                       |    2 +
>  drivers/stemodem/radio-settings.c |  230 +++++++++++++++++++++++++++++++=
++++++
>  drivers/stemodem/stemodem.c       |    2 +
>  drivers/stemodem/stemodem.h       |    2 +
>  4 files changed, 236 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/stemodem/radio-settings.c

patch has been applied.

> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -202,10 +202,12 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
>  			drivers/stemodem/stemodem.h \
>  			drivers/stemodem/stemodem.c \
>  			drivers/stemodem/voicecall.c \
> +			drivers/stemodem/radio-settings.c \
>  			drivers/stemodem/gprs-context.c \
>  			drivers/stemodem/caif_socket.h \
>  			drivers/stemodem/if_caif.h
>  =

> +
>  builtin_modules +=3D phonesim
>  builtin_sources +=3D plugins/phonesim.c

I fixed this for you, but in the future, please don't add extra unneeded
empty lines.

Regards

Marcel



--===============8626416745572502979==--

