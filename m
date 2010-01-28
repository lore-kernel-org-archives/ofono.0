Content-Type: multipart/mixed; boundary="===============6870730297098628317=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add STE voice call support.
Date: Thu, 28 Jan 2010 17:20:11 +0100
Message-ID: <1264695611.3227.21.camel@violet>
In-Reply-To: <1264688583-9253-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6870730297098628317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> ---
>  Makefile.am                  |    1 +
>  drivers/stemodem/stemodem.c  |    2 +
>  drivers/stemodem/stemodem.h  |    3 +
>  drivers/stemodem/voicecall.c |  596 ++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/ste.c                |    2 +-
>  5 files changed, 603 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/stemodem/voicecall.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index ac13d73..ecd2660 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -159,6 +159,7 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
>  			drivers/stemodem/stemodem.h \
>  			drivers/stemodem/stemodem.c \
>  			drivers/stemodem/gprs-context.c \
> +			drivers/stemodem/voicecall.c \
>  			drivers/stemodem/caif_socket.h \
>  			drivers/stemodem/if_caif.h
>  =

> diff --git a/drivers/stemodem/stemodem.c b/drivers/stemodem/stemodem.c
> index 53207db..9184a42 100644
> --- a/drivers/stemodem/stemodem.c
> +++ b/drivers/stemodem/stemodem.c
> @@ -37,6 +37,7 @@
>  static int stemodem_init(void)
>  {
>  	ste_gprs_context_init();
> +	ste_voicecall_init();
>  =

>  	return 0;
>  }
> @@ -44,6 +45,7 @@ static int stemodem_init(void)
>  static void stemodem_exit(void)
>  {
>  	ste_gprs_context_exit();
> +	ste_voicecall_exit();
>  }
>  =

>  OFONO_PLUGIN_DEFINE(stemodem, "STE modem driver", VERSION,
> diff --git a/drivers/stemodem/stemodem.h b/drivers/stemodem/stemodem.h
> index e55a2c3..e7c6934 100644
> --- a/drivers/stemodem/stemodem.h
> +++ b/drivers/stemodem/stemodem.h
> @@ -25,3 +25,6 @@
>  extern void ste_gprs_context_init();
>  extern void ste_gprs_context_exit();
>  =

> +extern void ste_voicecall_init();
> +extern void ste_voicecall_exit();
> +

just a small style issue. Can you put voicecall before GPRS in the init
routines and the Makefile.

Regards

Marcel



--===============6870730297098628317==--

