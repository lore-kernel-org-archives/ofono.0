Content-Type: multipart/mixed; boundary="===============1069160069509463448=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] plugins:ste:preparation for hotswap
Date: Fri, 28 Jan 2011 15:59:49 +0100
Message-ID: <1296226789.1520.182.camel@aeonflux>
In-Reply-To: <1296226151-3432-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1069160069509463448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

> ---
> Hi, =

> =

> This patch enables ste modem to handle hotswap situation. =


for the subject just ste: is enough.

> Br, =

> Jussi
> =

>  plugins/ste.c |  109 +++++++++++++++++++++++++++++++++++++++++----------=
-----
>  1 files changed, 80 insertions(+), 29 deletions(-)
> =

> diff --git a/plugins/ste.c b/plugins/ste.c
> index 85d2d51..e183073 100644
> --- a/plugins/ste.c
> +++ b/plugins/ste.c
> @@ -66,15 +66,23 @@
>  =

>  #define NUM_CHAT	1
>  =

> -static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
> -
>  static char *chat_prefixes[NUM_CHAT] =3D { "Default: " };
>  =

>  struct ste_data {
>  	GAtChat *chat;
> -	guint cpin_poll_source;
> -	guint cpin_poll_count;
>  	gboolean have_sim;
> +	struct ofono_sim *sim;
> +};
> +
> +enum ste_sim_state {
> +	SIM_STATE_NULL =3D 0,
> +	SIM_STATE_AWAITING_APP,
> +	SIM_STATE_BLOCKED,
> +	SIM_STATE_BLOCKED_FOREVER,
> +	SIM_STATE_WAIT_FOR_PIN,
> +	SIM_STATE_ACTIVE,
> +	SIM_STATE_TERMINATING,
> +	SIM_STATE_POWER_OFF
>  };

I am a bit lost in how you fit this into the existing SIM pin check.
Maybe it would be cleaner to remove that check first. And then add a
patch for the SIM notification handling.

Also this seems pretty much similar to what IFX does. Can we make sure
that it is handled similar as well?

Regards

Marcel



--===============1069160069509463448==--

