Content-Type: multipart/mixed; boundary="===============2839856722995212309=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] plugins: add a new driver for Quectel UC15 modems
Date: Mon, 30 Jun 2014 13:57:43 -0500
Message-ID: <53B1B327.5010800@gmail.com>
In-Reply-To: <1403802494-4542-4-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2839856722995212309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

<snip>

> +static void sim_state_cb(gboolean present, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("present %d", present);
> +
> +	at_util_sim_state_query_free(data->sim_state_query);
> +	data->sim_state_query =3D NULL;
> +
> +	data->have_sim =3D present;
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +
> +	/* Enable +CME error reporting and turn off the radio. */
> +	g_at_chat_send(data->aux, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->aux, "AT+CFUN=3D4", NULL, NULL, NULL, NULL);

Please use none_prefix here since it is already defined.

> +}
> +

<snip>

> +static void cfun_query(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +	GAtResultIter iter;
> +	int status;
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (g_at_result_iter_next(&iter, "+CFUN:") =3D=3D FALSE)
> +		return;
> +
> +	g_at_result_iter_next_number(&iter, &status);
> +
> +	/*
> +	 * When coming out of reset or transitioning out of CFUN=3D0, the modem
> +	 * firmware will respond to most commands with ERROR until some amount
> +	 * of time (which varies with temperature) passes.  Empirical evidence
> +	 * suggests that the firmware will report an unsolicited +CPIN:
> +	 * indication when it is ready to be useful.
> +	 *
> +	 * Specific issues:
> +	 *
> +	 *  o The modem firmware powers up in CFUN=3D1 but responds to
> +	 *    AT+CFUN=3D4 with ERROR until it has sent an unsolicited
> +	 *    +CPIN: indication.
> +	 *
> +	 *  o In CFUN=3D0 or after toggling the modem's reset line, the
> +	 *    modem firmware will respond to AT+CPIN? queries with
> +	 *    +CME ERROR: 10 ("SIM not inserted", regardless of whether
> +	 *    a SIM is actually inserted), again until it has sent an
> +	 *    unsolicited +CPIN: indication.
> +	 *
> +	 * Work around these features by temporarily disabling +CME error
> +	 * reporting and transitioning to CFUN=3D4 only after polling the
> +	 * AT+CPIN? status.
> +	 */

So why not query CFUN, register to unsolicited CPIN notifications and
query CPIN.  If that fails, then in theory CPIN will come in
unsolicited.  Beats polling.

> +
> +	if (status !=3D 1) {
> +		g_at_chat_send(data->aux, "AT+CMEE=3D0", NULL, NULL,
> +					NULL, NULL);

Might want to use a prefix here as well

> +		g_at_chat_send(data->aux, "AT+CFUN=3D1", none_prefix,
> +					cfun_enable, modem, NULL);

Should you be using CFUN=3D4 here?

> +		return;
> +	}
> +
> +	cfun_enable(TRUE, NULL, modem);
> +}
> +
> +static int quectel_enable(struct ofono_modem *modem)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	data->modem =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->modem =3D=3D NULL)
> +		return -EINVAL;
> +
> +	data->aux =3D open_device(modem, "Aux", "Aux: ");
> +	if (data->aux =3D=3D NULL) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		return -EIO;
> +	}
> +	g_at_chat_set_slave(data->modem, data->aux);
> +
> +	g_at_chat_send(data->modem, "ATE0 &C0", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->aux, "ATE0 &C0", NULL, NULL, NULL, NULL);
> +

prefixes here

> +	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix,
> +					cfun_query, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	g_at_chat_unref(data->aux);
> +	data->aux =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static int quectel_disable(struct ofono_modem *modem)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_cancel_all(data->modem);
> +	g_at_chat_unregister_all(data->modem);
> +
> +	g_at_chat_unref(data->modem);
> +	data->modem =3D NULL;
> +
> +	g_at_chat_cancel_all(data->aux);
> +	g_at_chat_unregister_all(data->aux);
> +
> +	g_at_chat_send(data->aux, "AT+CFUN=3D0", cfun_prefix,

That should probably be none_prefix if the modem follows standards.

> +					cfun_disable, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_modem_online_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +	cb(&error, cbd->data);
> +}
> +
> +static void quectel_set_online(struct ofono_modem *modem, ofono_bool_t o=
nline,
> +				ofono_modem_online_cb_t cb, void *user_data)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
> +
> +	DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +	if (g_at_chat_send(data->aux, command, cfun_prefix, set_online_cb,
> +					cbd, g_free) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +
> +	g_free(cbd);
> +}
> +
> +static void quectel_pre_sim(struct ofono_modem *modem)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_sim *sim;
> +
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +					data->aux);

We don't specify VENDOR flags if the atom driver uses default behavior.
 That way it is easy to tell where non-standard behavior occurs for a
particular modem.  So just use 0 here.

> +	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +					data->aux);
> +
> +	if (sim && data->have_sim =3D=3D TRUE)
> +		ofono_sim_inserted_notify(sim, TRUE);
> +}
> +
> +static void quectel_post_sim(struct ofono_modem *modem)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_gprs *gprs;
> +	struct ofono_gprs_context *gc;
> +
> +	DBG("%p", modem);
> +
> +	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +					data->aux);
> +	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +					data->modem);

Same as above

> +
> +	if (gprs && gc)
> +		ofono_gprs_add_context(gprs, gc);
> +}
> +
> +static void quectel_post_online(struct ofono_modem *modem)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	ofono_netreg_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +					data->aux);

And here

> +}
> +

<snip>

Regards,
-Denis


--===============2839856722995212309==--

