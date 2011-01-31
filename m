Content-Type: multipart/mixed; boundary="===============1480252315791289765=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v6] ifx: Adding modem selftest for Infineon modem
Date: Mon, 31 Jan 2011 17:08:19 +0100
Message-ID: <1296490099.1520.231.camel@aeonflux>
In-Reply-To: <1296086884-14687-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1480252315791289765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> Infineon modem selftest, during ifx_enable().
> Two steps trigger, with timeout. In case one
> fails, modem will not power up.
> =

> ---
>  plugins/ifx.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++---=
------
>  1 files changed, 95 insertions(+), 17 deletions(-)
> =

> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index 0d31167..39f38ab 100644
> --- a/plugins/ifx.c
> +++ b/plugins/ifx.c
> @@ -72,6 +72,8 @@
>  #define GPRS3_DLC   4
>  #define AUX_DLC     5
>  =

> +#define IFX_SETUP_TIMEOUT	10
> +
>  static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "GPRS1: ",
>  					"GPRS2: ", "GPRS3: ", "Aux: " };
>  =

> @@ -89,7 +91,7 @@ struct ifx_data {
>  	guint dlc_poll_count;
>  	guint dlc_poll_source;
>  	guint dlc_init_source;
> -	guint mux_init_timeout;
> +	guint cmd_setup_timeout;
>  	guint frame_size;
>  	int mux_ldisc;
>  	int saved_ldisc;
> @@ -100,6 +102,9 @@ struct ifx_data {
>  	int audio_loopback;
>  	struct ofono_sim *sim;
>  	gboolean have_sim;
> +	gboolean rtc_gti_selftest_timeout;
> +	gboolean dev_ver_selftest_timeout;
> +	gboolean mux_setup_timeout;

what is this for? It is not a good idea.

>  };
>  =

>  static void ifx_debug(const char *str, void *user_data)
> @@ -475,9 +480,9 @@ static void mux_setup_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  =

>  	DBG("");
>  =

> -	if (data->mux_init_timeout > 0) {
> -		g_source_remove(data->mux_init_timeout);
> -		data->mux_init_timeout =3D 0;
> +	if (data->cmd_setup_timeout > 0) {
> +		g_source_remove(data->cmd_setup_timeout);
> +		data->cmd_setup_timeout =3D 0;
>  	}

Why do you bother renaming this. Stick with mux_init_timeout.
 =

>  	g_at_chat_unref(data->dlcs[AUX_DLC]);
> @@ -519,26 +524,88 @@ error:
>  	ofono_modem_set_powered(modem, FALSE);
>  }
>  =

> -static gboolean mux_timeout_cb(gpointer user_data)
> +static gboolean cmd_setup_timeout_cb(gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
>  =

> -	ofono_error("Timeout with multiplexer setup");
> +	if (data->rtc_gti_selftest_timeout)
> +		ofono_error("ERROR:IFX Selftest"
> +			"at(a)rtc:rtc_gti_test_verify_32khz()-TIMEOUT");
> +	else if (data->dev_ver_selftest_timeout)
> +		ofono_error("ERROR:IFX Selftest"
> +			"at(a)vers:device_version_id()-TIMEOUT");
> +	else if (data->mux_setup_timeout)
> +		ofono_error("ERROR:IFX Mux setup-TIMEOUT");

I really thought that we cleared on how to do this. This is utterly
complex and unneeded.

So GAtChat has a builtin queue. And new commands will only be send after
the other has been processed. You can easily cancel pending commands
from a callback these days.

So you can just call g_at_chat_send() three times initially and then be
done with it. If any of these fail, you just cancel all pending commands
and fail the init. That simple.

There is no need for this complexity at all. Please re-work this patch
as I described in the other review. It should be a really simple patch
actually.

Regards

Marcel



--===============1480252315791289765==--

