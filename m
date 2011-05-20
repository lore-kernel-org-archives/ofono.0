Content-Type: multipart/mixed; boundary="===============0109769822122444436=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2] reopen once if open device failed
Date: Fri, 20 May 2011 06:53:09 -0700
Message-ID: <1305899589.2681.4.camel@aeonflux>
In-Reply-To: <1305881809-20355-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0109769822122444436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

> (1) Sometimes when open the data device, it may fail. If open the data de=
vice failed,
> retry once one second later.
> =

> (2) Fix Huawei NDIS modem gprs doesn't work issue

what does this comment mean. We should just not try the NDIS part of
Huawei until I get clear specs on how to use the NDIS port. Even the
basic AT^DHCP handling of this is unreliable.

> ---
>  plugins/huawei.c |   43 ++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 38 insertions(+), 5 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index e791718..6b2caa4 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -80,6 +80,7 @@ struct huawei_data {
>  	gboolean ndis;
>  	guint sim_poll_timeout;
>  	guint sim_poll_count;
> +	guint reopen_timeout;
>  };
>  =

>  #define MAX_SIM_POLL_COUNT 5
> @@ -107,6 +108,11 @@ static void huawei_remove(struct ofono_modem *modem)
>  =

>  	DBG("%p", modem);
>  =

> +	if (data->reopen_timeout > 0) {
> +		g_source_remove(data->reopen_timeout);
> +		data->reopen_timeout =3D 0;
> +	}
> +
>  	ofono_modem_set_data(modem, NULL);
>  =

>  	if (data->modem)
> @@ -465,6 +471,20 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
>  	return chat;
>  }
>  =

> +static void huawei_disconnect(gpointer user_data);
> +
> +static gboolean reopen_callback(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct huawei_data *data =3D ofono_modem_get_data(modem);
> +
> +	huawei_disconnect(user_data);
> +
> +	data->reopen_timeout =3D 0;
> +
> +	return FALSE;
> +}
> +
>  static void huawei_disconnect(gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -476,8 +496,17 @@ static void huawei_disconnect(gpointer user_data)
>  	data->modem =3D NULL;
>  =

>  	data->modem =3D open_device(modem, "Modem", "Modem: ");
> -	if (data->modem =3D=3D NULL)
> +	/* retry once if failed */
> +	if (data->modem =3D=3D NULL) {
> +		if (data->reopen_timeout =3D=3D 0) {
> +			data->reopen_timeout =3D
> +				g_timeout_add_seconds(1, reopen_callback,
> +					modem);
> +
> +			ofono_debug("open device failed, try to reopen it.");
> +		}
>  		return;
> +	}

Please do not nest here.

	if (data->modem =3D=3D NULL) {
		if (data->reopen_timeout > 0)
			return;

		data->reopen_timeout =3D ...

		return;
	}

>  =

>  	g_at_chat_set_disconnect_function(data->modem,
>  						huawei_disconnect, modem);
> @@ -559,6 +588,11 @@ static int huawei_disable(struct ofono_modem *modem)
>  =

>  	DBG("%p", modem);
>  =

> +	if (data->reopen_timeout > 0) {
> +		g_source_remove(data->reopen_timeout);
> +		data->reopen_timeout =3D 0;
> +	}
> +
>  	if (data->sim_poll_timeout > 0) {
>  		g_source_remove(data->sim_poll_timeout);
>  		data->sim_poll_timeout =3D 0;
> @@ -682,16 +716,15 @@ static void huawei_post_online(struct ofono_modem *=
modem)
>  	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
>  						"atmodem", data->pcui);
>  =

> -	if ((data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> -			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) &&
> -			data->modem !=3D NULL) {
> +	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> +			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {

Why this change?

>  		data->gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
>  						"atmodem", data->pcui);
>  =

>  		if (data->ndis =3D=3D TRUE)
>  			data->gc =3D ofono_gprs_context_create(modem, 0,
>  						"huaweimodem", data->pcui);
> -		else
> +		else if (data->modem !=3D NULL)
>  			data->gc =3D ofono_gprs_context_create(modem, 0,
>  						"atmodem", data->modem);
>  =


I do not understand this change.

Regards

Marcel



--===============0109769822122444436==--

