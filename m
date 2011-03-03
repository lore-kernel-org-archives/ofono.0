Content-Type: multipart/mixed; boundary="===============8002429833659199818=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: patch to fix BMC #13679 Huawei EM770: ofonod crash when
 disable/enable 3G technology
Date: Wed, 02 Mar 2011 23:22:47 -0600
Message-ID: <4D6F25A7.503@gmail.com>
In-Reply-To: <FC2FB65B4D919844ADE4BE3C2BB739AD36C9398F@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8002429833659199818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 03/02/2011 03:59 AM, Xu, Martin wrote:
> Looks like my smtp server has some issue currently. =

> So send the patch through attachment.
> Sorry for inconvenient.
> =


> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index 6f05677..5e2ee90 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -78,6 +78,7 @@ struct huawei_data {
>  	struct ofono_gprs *gprs;
>  	struct ofono_gprs_context *gc;
>  	gboolean voice;
> +	gboolean online;

I don't think you really need this one, you can use the presence of gprs
atom instead.

>  	gboolean ndis;
>  	guint sim_poll_timeout;
>  	guint sim_poll_count;
> @@ -97,6 +98,7 @@ static int huawei_probe(struct ofono_modem *modem)
>  	if (data =3D=3D NULL)
>  		return -ENOMEM;
>  =

> +	data->online =3D FALSE;
>  	ofono_modem_set_data(modem, data);
>  =

>  	return 0;
> @@ -111,6 +113,11 @@ static void huawei_remove(struct ofono_modem *modem)
>  	ofono_modem_set_data(modem, NULL);
>  =

>  	if (data->modem)
> +		/*
> +		 * huawei_disconnect should not be called when the chat
> +		 * is closed initiatively
> +		 */
> +		g_at_chat_set_disconnect_function(data->modem, NULL, NULL);
>  		g_at_chat_unref(data->modem);

Are you missing some parentheses around the if statement now?

Setting the disconnect function here seems fishy.  We automatically set
it to NULL when GAtIO is unref-ed.  Seems to me g_at_chat_unref should
be enough.

>  =

>  	g_at_chat_unref(data->pcui);
> @@ -470,10 +477,7 @@ static void huawei_disconnect(gpointer user_data)
>  	struct ofono_modem *modem =3D user_data;
>  	struct huawei_data *data =3D ofono_modem_get_data(modem);
>  =

> -	DBG("");
> -
> -	if (data->gc)
> -		ofono_gprs_context_remove(data->gc);
> +	DBG("data->online %d", data->online);
>  =

>  	g_at_chat_unref(data->modem);
>  	data->modem =3D NULL;
> @@ -485,6 +489,13 @@ static void huawei_disconnect(gpointer user_data)
>  	g_at_chat_set_disconnect_function(data->modem,
>  						huawei_disconnect, modem);
>  =

> +	/* reopen GPRS context channel only at online state */
> +	if (data->online =3D=3D FALSE)
> +		return;
> +
> +	if (data->gc)
> +		ofono_gprs_context_remove(data->gc);
> +
>  	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
>  			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
>  		ofono_info("Reopened GPRS context channel");
> @@ -515,6 +526,11 @@ static int huawei_enable(struct ofono_modem *modem)
>  =

>  	data->pcui =3D open_device(modem, "Pcui", "PCUI: ");
>  	if (data->pcui =3D=3D NULL) {
> +		/*
> +		 * huawei_disconnect should not be called when the chat
> +		 * is closed initiatively
> +		 */
> +		g_at_chat_set_disconnect_function(data->modem, NULL, NULL);
>  		g_at_chat_unref(data->modem);
>  		data->modem =3D NULL;
>  		return -EIO;
> @@ -564,6 +580,11 @@ static int huawei_disable(struct ofono_modem *modem)
>  	if (data->modem) {
>  		g_at_chat_cancel_all(data->modem);
>  		g_at_chat_unregister_all(data->modem);
> +		/*
> +		 * huawei_disconnect should not be called when the chat
> +		 * is closed initiatively
> +		 */
> +		g_at_chat_set_disconnect_function(data->modem, NULL, NULL);
>  		g_at_chat_unref(data->modem);
>  		data->modem =3D NULL;
>  	}
> @@ -579,15 +600,27 @@ static int huawei_disable(struct ofono_modem *modem)
>  	return -EINPROGRESS;
>  }
>  =

> +struct huawei_cb_data {
> +	struct cb_data *cbd;
> +	ofono_bool_t online;
> +	struct ofono_modem *modem;
> +};
> +
>  static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
>  {
> -	struct cb_data *cbd =3D user_data;
> -	ofono_modem_online_cb_t cb =3D cbd->cb;
> +	struct huawei_cb_data *online_cbd =3D user_data;
> +	ofono_modem_online_cb_t cb =3D online_cbd->cbd->cb;
> +	struct huawei_data *data =3D ofono_modem_get_data(online_cbd->modem);
>  =

> -	if (ok)
> -		CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +	if (ok) {
> +		data->online =3D online_cbd->online;
> +
> +		CALLBACK_WITH_SUCCESS(cb, online_cbd->cbd->data);
> +
> +		g_free(online_cbd);
> +	}
>  	else
> -		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		CALLBACK_WITH_FAILURE(cb, online_cbd->cbd->data);
>  }

All of this can be better accomplished by using two separate callbacks.
 One for online and one for offline.

I suspect all you need to do is unref data->modem, set data->gc and
data->gprs to NULL in the offline callback prior to calling back into
the core.

>  =

>  static void huawei_set_online(struct ofono_modem *modem, ofono_bool_t on=
line,
> @@ -595,21 +628,26 @@ static void huawei_set_online(struct ofono_modem *m=
odem, ofono_bool_t online,
>  {
>  	struct huawei_data *data =3D ofono_modem_get_data(modem);
>  	GAtChat *chat =3D data->pcui;
> -	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	struct huawei_cb_data *online_cbd;
>  	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D5";
>  =

>  	DBG("modem %p %s", modem, online ? "online" : "offline");
>  =

> -	if (cbd =3D=3D NULL)
> +	online_cbd =3D g_try_new0(struct huawei_cb_data, 1);
> +	online_cbd->cbd =3D cb_data_new(cb, user_data);
> +	if (online_cbd->cbd =3D=3D NULL)
>  		goto error;
> +	online_cbd->online =3D online;
> +	online_cbd->modem =3D modem;
>  =

> -	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
> +	if (g_at_chat_send(chat, command, NULL, set_online_cb,
> +						online_cbd, g_free))
>  		return;
>  =

>  error:
> -	g_free(cbd);
> +	g_free(online_cbd);
>  =

> -	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +	CALLBACK_WITH_FAILURE(cb, user_data);
>  }
>  =

>  static void huawei_pre_sim(struct ofono_modem *modem)
> -- 1.6.1.3 =


Regards,
-Denis

--===============8002429833659199818==--

