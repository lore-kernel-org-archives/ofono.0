Content-Type: multipart/mixed; boundary="===============3285049432577123222=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] ifx: adding Infineon modem self test
Date: Mon, 13 Dec 2010 03:47:42 +0100
Message-ID: <1292208462.30085.81.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <1291976804-8739-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3285049432577123222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,
 =

>  static const char *none_prefix[] =3D { NULL };
>  static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
> +static const char *empty_prefix[] =3D { "", NULL };

this is essentially to just passing NULL as argument. What are you
trying to achieve here?

> +static const char *modem_self_tests[][2] =3D {
> +			{ "RTC Test", "at(a)rtc:rtc_gti_test_verify_32khz()" },
> +			{ "Version Info Test", "at(a)vers:device_version_id()" },
> +			{ NULL, NULL } };

The coding style is broken here. Please check the oFono source code for
example on how to format these type of array correctly.

In addition the string array is wrong. It should be a struct array. The
magic of [1] and [2] for picking the command or the text string is not
intuitive and leads to unreadable code.

>  struct ifx_data {
>  	GIOChannel *device;
> @@ -99,6 +105,8 @@ struct ifx_data {
>  	int audio_loopback;
>  	struct ofono_sim *sim;
>  	gboolean have_sim;
> +	guint self_test_timeout;
> +	int self_test_idx;
>  };
>  =

>  static void ifx_debug(const char *str, void *user_data)
> @@ -545,6 +553,82 @@ static gboolean mux_timeout_cb(gpointer user_data)
>  	return FALSE;
>  }
>  =

> +static gboolean self_test_timeout_cb(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +
> +	ofono_error("Timeout with modem self_test");

You need an extra empty line here. The error is logically separated.

> +	g_source_remove(data->self_test_timeout);

You can not remove a source in its own callback. Have you tested this
code path actually?

> +	data->self_test_timeout =3D 0;
> +
> +	shutdown_device(data);

You can not use shutdown_device here since the multiplexer is not ready
yet. If you decide the execute the selftests before bringing up the
multiplexer then this is a different error path.

You need to cleanup data->dlcs[AUX_DLC] and data->device in this failure
case.

> +	ofono_modem_set_powered(modem, FALSE);

This needs an extra empty before the return statement.

> +	return FALSE;
> +}
> +
> +static void ifx_self_test_get_device_resp(GAtResult *result, int test_id)
> +{

The function is just wrong in conjunction with your array approach.

> +	GAtResultIter iter;
> +	const char *str;
> +
> +	ofono_info("Modem Response: %s",
> +				modem_self_tests[test_id][0]);

Can you give an example on a positive and negative selftest response
here. I don't wanna spam the logs with details if everything is fine.

This should use ofono_error and that only in case of an error.

> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, NULL)) {
> +
> +		if (g_at_result_iter_next_string(&iter, &str))
> +			ofono_info("Modem Response: %s", str);
> +	}

What is this while loop actually doing? How does a response look like.

> +}
> +
> +static void ifx_self_test_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (ok) {

This needs to be a if (!ok) here actually and then leaving this function
with a simple error case.

Having the positive handling nested is not a good idea and we don't
really do it that way.

> +
> +		if (data->self_test_timeout > 0) {
> +			g_source_remove(data->self_test_timeout);
> +			data->self_test_timeout =3D 0;
> +		}
> +
> +		ifx_self_test_get_device_resp(result, data->self_test_idx);
> +		data->self_test_idx++;
> +
> +		if (modem_self_tests[data->self_test_idx][1] !=3D NULL) {
> +

No empty line here.

> +			g_at_chat_send(data->dlcs[AUX_DLC],
> +				modem_self_tests[data->self_test_idx][1],
> +				empty_prefix, ifx_self_test_cb, modem, NULL);
> +
> +			data->self_test_timeout =3D g_timeout_add_seconds(10,
> +					self_test_timeout_cb, modem);
> +			return;

No empty line here, but this is not needed in case of (!ok) anyway.

> +		} else {
> +

No empty line here either.

> +			/* Enable  MUX Channels */
> +			data->frame_size =3D 1509;
> +			g_at_chat_send(data->dlcs[AUX_DLC],
> +					"AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
> +					mux_setup_cb, modem, NULL);
> +
> +			data->mux_init_timeout =3D g_timeout_add_seconds(5,
> +					mux_timeout_cb,	modem);
> +			return;
> +		}
> +	}

With proper if (error) { ... ; return; } coding style this function
becomes a lot more readable.

> +
> +	ofono_error("Modem %s: FAIL", modem_self_tests[data->self_test_idx][0]);
> +	shutdown_device(data);

Again here, the shutdown_device call can not be used since the
multiplexer is not yet brought up.

> +	ofono_modem_set_powered(modem, FALSE);
> +}
> +
>  static int ifx_enable(struct ofono_modem *modem)
>  {
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
> @@ -598,15 +682,17 @@ static int ifx_enable(struct ofono_modem *modem)
>  	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL,
>  					NULL, NULL, NULL);

Now here is the question if we wanna execute ATE0 first or run the
selftests first?

> -	data->frame_size =3D 1509;
> +	/* Execute Modem Self tests */
>  =

> -	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
> -					mux_setup_cb, modem, NULL);
> +	data->dlcs[AUX_DLC] =3D chat;
> +	data->self_test_idx =3D 0;
>  =

> -	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
> -								modem);
> +	g_at_chat_send(data->dlcs[AUX_DLC],
> +		modem_self_tests[data->self_test_idx][1],
> +		empty_prefix, ifx_self_test_cb, modem, NULL);
>  =

> -	data->dlcs[AUX_DLC] =3D chat;
> +	data->self_test_timeout =3D g_timeout_add_seconds(10,
> +				self_test_timeout_cb,	modem);

Where does these 10 seconds come from?

Regards

Marcel



--===============3285049432577123222==--

