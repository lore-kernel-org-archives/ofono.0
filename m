Content-Type: multipart/mixed; boundary="===============8484641524417121704=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v7] ifx: Adding modem selftest for Infineon modem
Date: Tue, 01 Feb 2011 11:08:58 +0100
Message-ID: <1296554938.1520.246.camel@aeonflux>
In-Reply-To: <1296532191-22449-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8484641524417121704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> Infineon modem selftest, during ifx_enable().
> Two steps trigger, with timeout. In case one
> fails, modem will not power up.
> =

> ---
>  plugins/ifx.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 47 insertions(+), 3 deletions(-)
> =

> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index 411c012..da8ed0b 100644
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

> @@ -524,10 +526,12 @@ static gboolean mux_timeout_cb(gpointer user_data)
>  	struct ofono_modem *modem =3D user_data;
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
>  =

> -	ofono_error("Timeout with multiplexer setup");
> +	ofono_error("Timeout with AT command setup");

call this "Timeout with modem and multiplexer setup" now.

>  	data->mux_init_timeout =3D 0;
>  =

> +	g_at_chat_cancel_all(data->dlcs[AUX_DLC]);
> +

This one is not needed. Since first it is the last command anyway. There
is nothing else in the queue.

>  	g_at_chat_unref(data->dlcs[AUX_DLC]);

And second this will do it anyway for you.

>  	data->dlcs[AUX_DLC] =3D NULL;
>  =

> @@ -539,6 +543,35 @@ static gboolean mux_timeout_cb(gpointer user_data)
>  	return FALSE;
>  }
>  =

> +static void dev_ver_selftest_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +
> +	struct ofono_modem *modem =3D user_data;
> +	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (!ok) {
> +		ofono_error("ERROR:IFX Selftest at(a)vers:device_version_id()"
> +				"-FAILED");
> +
> +		g_at_chat_cancel_all(data->dlcs[AUX_DLC]);
> +	}
> +}

I would just do here this:

	if (ok)
		return;

	ofono_error(...

However you now need to clean up properly.

	if (data->mux_init_timeout > 0) {
		g_source_remove(data->mux_init_timeout);
		data->mux_init_timeout =3D 0;
	}

	g_at_chat_unref(data->dlcs[AUX_DLC]);
	data->dlcs[AUX_DLC] =3D NULL;

	g_io_channel_unref(data->device);
	data->device =3D NULL;

	ofono_modem_set_powered(modem, FALSE);

If you don't do that you leak memory and a file descriptor. And in
addition the user has to wait for the setup timeout, even if it is
already clear that the enabling failed.

> +
> +static void rtc_gti_selftest_cb(gboolean ok, GAtResult *result,
> +			gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (!ok) {
> +		ofono_error("ERROR:IFX Selftest"
> +			"at(a)rtc:rtc_gti_test_verify_32khz()-FAILED");
> +
> +		g_at_chat_cancel_all(data->dlcs[AUX_DLC]);
> +	}
> +}
> +
>  static int ifx_enable(struct ofono_modem *modem)
>  {
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
> @@ -592,13 +625,24 @@ static int ifx_enable(struct ofono_modem *modem)
>  	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL,
>  					NULL, NULL, NULL);
>  =

> +	/* Execute Modem Self tests */
> +	data->dlcs[AUX_DLC] =3D chat;

Don't bother moving this one around. It is fine where it is. There is no
race condition here. We are single threaded and we need to go back to
the mainloop to write the commands before this will be called.

> +	g_at_chat_send(data->dlcs[AUX_DLC],
> +		"at(a)rtc:rtc_gti_test_verify_32khz()",
> +		NULL, rtc_gti_selftest_cb, modem, NULL);
> +
> +	g_at_chat_send(data->dlcs[AUX_DLC], "at(a)vers:device_version_id()",
> +		NULL, dev_ver_selftest_cb, modem, NULL);
> +
> +	/* Enable  MUX Channels */
>  	data->frame_size =3D 1509;
>  =

>  	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
>  					mux_setup_cb, modem, NULL);
>  =

> -	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
> -								modem);
> +	data->mux_init_timeout =3D g_timeout_add_seconds(
> +		IFX_SETUP_TIMEOUT, mux_timeout_cb, modem);

To be honest the define with the setup timeout value does not help here.
Just change this to 10 and put a comment section above the the timeout
command to state what is expected execution time of the test commands.
That makes this a lot clearer to understand.
 =

>  	data->dlcs[AUX_DLC] =3D chat;

Regards

Marcel



--===============8484641524417121704==--

