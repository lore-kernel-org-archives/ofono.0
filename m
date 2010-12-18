Content-Type: multipart/mixed; boundary="===============8152683377462318777=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2] ifx: Adding modem selftest to Infineon modem
Date: Sat, 18 Dec 2010 19:25:39 +0100
Message-ID: <1292696739.2658.10.camel@aeonflux>
In-Reply-To: <1292637119-9288-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8152683377462318777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index 2f4c65b..3647dbc 100644
> --- a/plugins/ifx.c
> +++ b/plugins/ifx.c
> @@ -71,6 +71,8 @@
>  #define GPRS3_DLC   4
>  #define AUX_DLC     5
>  =

> +#define IFX_SELF_TESTS_TIMEOUT	5
> +

this is not what I meant actually. Adding a comment for the
g_timeout_add_seconds is just fine.

What I wanted to know is where the actual value came from. Is 5 seconds
enough? How do we know the time a test takes?

>  static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "GPRS1: ",
>  					"GPRS2: ", "GPRS3: ", "Aux: " };
>  =

> @@ -80,6 +82,18 @@ static const char *dlc_nodes[NUM_DLC] =3D { "/dev/ttyG=
SM1", "/dev/ttyGSM2",
>  =

>  static const char *none_prefix[] =3D { NULL };
>  static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
> +static const char *empty_prefix[] =3D { "", NULL };

This is still wrong. See my comment from the original email. I am not
sure you really know what { "", NULL } means.

> +struct ifx_self_tests {
> +	char *test_desc;
> +	char *at_cmd;
> +};
> +
> +static const struct ifx_self_tests mst[] =3D {
> +		{ "RTC GTI Test", "at(a)rtc:rtc_gti_test_verify_32khz()" },
> +		{ "Device Version Test", "at(a)vers:device_version_id()" },
> +		{ NULL, NULL }
> +};

No need to declare the struct before assigning it. Just do it all in
once. And fix up the indentation for the values. Just one tab please.
 =

>  struct ifx_data {
>  	GIOChannel *device;
> @@ -99,6 +113,8 @@ struct ifx_data {
>  	int audio_loopback;
>  	struct ofono_sim *sim;
>  	gboolean have_sim;
> +	guint self_test_timeout;
> +	int self_test_idx;
>  };
>  =

>  static void ifx_debug(const char *str, void *user_data)
> @@ -545,6 +561,64 @@ static gboolean mux_timeout_cb(gpointer user_data)
>  	return FALSE;
>  }
>  =

> +static gboolean self_test_timeout_cb(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +
> +	ofono_error("Modem %s: TIMED OUT",
> +			mst[data->self_test_idx].test_desc);
> +
> +	g_source_remove(data->self_test_timeout);
> +	data->self_test_timeout =3D 0;
> +
> +	shutdown_device(data);
> +	ofono_modem_set_powered(modem, FALSE);
> +
> +	return FALSE;
> +}

I am stopping right here now actually. Please fix my review comments
from the initial review as well. This function is still broken.

Regards

Marcel



--===============8152683377462318777==--

