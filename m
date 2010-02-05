Content-Type: multipart/mixed; boundary="===============7057412252387758735=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] hfp: set timeout service level connection procedure
Date: Fri, 05 Feb 2010 13:54:34 -0600
Message-ID: <201002051354.34983.denkenz@gmail.com>
In-Reply-To: <1326572835-9013-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7057412252387758735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> If it expires we call org.bluez.HandsfreeGateway.Disconnect()
> ---
>  drivers/hfpmodem/hfpmodem.h |    1 +
>  plugins/hfp.c               |   27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
> index 6ec8a7c..deb6399 100644
> --- a/drivers/hfpmodem/hfpmodem.h
> +++ b/drivers/hfpmodem/hfpmodem.h
> @@ -71,6 +71,7 @@ struct hfp_data {
>  	unsigned int hf_features;
>  	unsigned char cind_pos[HFP_INDICATOR_LAST];
>  	unsigned int cind_val[HFP_INDICATOR_LAST];
> +	unsigned int connect_to;

Don't need to use g_source for this, see below.

>  };
> =

>  extern void hfp_netreg_init();
> diff --git a/plugins/hfp.c b/plugins/hfp.c
> index d0af7e8..0c1c508 100644
> --- a/plugins/hfp.c
> +++ b/plugins/hfp.c
> @@ -99,6 +99,8 @@ static void sevice_level_conn_established(struct
>  ofono_modem *modem) dbus_message_unref(data->slc_msg);
>  	data->slc_msg =3D NULL;
> =

> +	g_source_remove(data->connect_to);
> +

Don't need this

>  	ofono_info("Service level connection established");
> =

>  	g_at_chat_send(data->chat, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
> @@ -118,6 +120,8 @@ static void service_level_conn_failed(struct
>  ofono_modem *modem) dbus_message_unref(data->slc_msg);
>  	data->slc_msg =3D NULL;
> =

> +	g_source_remove(data->connect_to);
> +

Or this

>  	ofono_error("Service level connection failed");
>  	ofono_modem_set_powered(modem, FALSE);
>  	clear_data(modem);
> @@ -785,11 +789,34 @@ static int hfp_connect_ofono_handsfree(struct
>  ofono_modem *modem) NULL, NULL, DBUS_TYPE_INVALID);
>  }
> =

> +static gboolean hfp_enable_timeout(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct hfp_data *data =3D ofono_modem_get_data(modem);
> +	int ret;
> +
> +	if (ofono_modem_get_powered(modem))
> +		return FALSE;
> +
> +	ret =3D send_method_call(BLUEZ_SERVICE, data->handsfree_path,
> +				BLUEZ_GATEWAY_INTERFACE, "Disconnect",
> +				NULL, NULL, DBUS_TYPE_INVALID);
> +	if (ret < 0)
> +		ofono_error("GetProperties failed(%d)", ret);

What does GetProperties have to do here?

> +
> +	return FALSE;
> +}
> +
>  /* power up hardware */
>  static int hfp_enable(struct ofono_modem *modem)
>  {
> +	struct hfp_data *data =3D ofono_modem_get_data(modem);
> +
>  	DBG("%p", modem);
> =

> +	data->connect_to =3D
> +		g_timeout_add_seconds(15, hfp_enable_timeout, modem);
> +
>  	if (hfp_connect_ofono_handsfree(modem) < 0)

In hfp_connect_ofono_handsfree, simply set a proper timeout and callback =

function.  You don't need to use a g_source here@all.

>  		return -EINVAL;
> =


Regards,
-Denis

--===============7057412252387758735==--

