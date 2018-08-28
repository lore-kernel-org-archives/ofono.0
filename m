Content-Type: multipart/mixed; boundary="===============3173890181653143113=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 2/2] m95: Add driver for Quectel M95 modem
Date: Tue, 28 Aug 2018 15:08:29 -0500
Message-ID: <9c27fe31-237b-94fe-9190-2d2439f5462f@gmail.com>
In-Reply-To: <20180828074540.21858-2-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3173890181653143113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> +static int m95_probe(struct ofono_modem *modem)
> +{
> +	struct m95_data *data;
> +
> +	DBG("%p", modem);
> +
> +	data =3D g_new0(struct m95_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;

g_new0 cannot fail, so I would take this out

> +
> +	ofono_modem_set_data(modem, data);
> +
> +	return 0;
> +}
> +

<snip>

> +static GAtChat *create_chat(GIOChannel *channel, struct ofono_modem *mod=
em,

Not sure why you need the modem object here

> +				const char *debug)
> +{
> +	GAtSyntax *syntax;
> +	GAtChat *chat;
> +
> +	if (channel =3D=3D NULL)
> +		return NULL;
> +
> +	syntax =3D g_at_syntax_new_gsmv1();
> +	chat =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +
> +	if (chat =3D=3D NULL)
> +		return NULL;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, m95_debug, (gpointer)debug);

This cast wasn't necessary.

> +
> +	return chat;
> +}

<snip>

> +static void send_cmux(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +	GAtResultIter iter;
> +
> +	DBG("%p", modem);
> +
> +	g_at_result_iter_init(&iter, result);
> +	if (!g_at_result_iter_next(&iter, cfun_enable_prefix[0]))

This should likely be just "+CFUN:"

> +		return;

And just returning is not a good idea here..

> +
> +	/* remove the enable-completed listener */
> +	if (data->cfun_enable) {
> +		g_at_chat_unregister(data->setup, data->cfun_enable);
> +		data->cfun_enable =3D 0;
> +	}
> +
> +	/* setup multiplexing */
> +	g_at_chat_send(data->setup, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
> +			mux_setup_cb, modem, NULL);
> +}
> +
> +static void cfun_enable_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	DBG("ok %d", ok);
> +
> +	if (ok)
> +		send_cmux(result, user_data);

What if CFUN fails?

> +}
> +
> +static void cfun_reset(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +	GAtResultIter iter;
> +
> +	DBG("%p", modem);
> +
> +	g_at_result_iter_init(&iter, result);
> +	if (!g_at_result_iter_next(&iter, cfun_reset_prefix[0]))
> +		return;
Same as above, might be clear just using the "CFUN:" string.

> +
> +	/* remove the reset-completed listener */
> +	g_at_chat_unregister(data->setup, data->cfun_reset);
> +	data->cfun_reset =3D 0;
> +
> +	/* prepare to enable the modem */
> +	g_at_chat_send(data->setup, "ATE0", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->setup, "AT+IFC=3D2,2", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->setup, "AT+GMM", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->setup, "AT", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->setup, "AT+IPR=3D115200&w", NULL, NULL, NULL, NULL=
);
> +
> +	/* setup a listener to delay multiplex-setup until modem is ready */
> +	data->cfun_enable =3D g_at_chat_register(data->setup,
> +						cfun_enable_prefix[0],
> +						send_cmux, FALSE, modem, NULL);

So you're registering to +CPIN: <ready/locked> indication here.  Why are =

you then sending the prefixes to the subsequent g_at_chat_send to =

consume those prefixes?

E.g. lets suppose the possible AT command sequences are roughly like:

Sequence 1:
AT+CFUN=3D1\r
+CPIN: <ready>
OK

Sequence 2:
AT+CFUN=3D1\r
OK
+CPIN: <ready>

For Sequence1, you are consuming +CPIN as part of the CFUN command.  You =

could for example use:

static const char *none_prefix[] =3D { NULL }
g_at_chat_send(.., "AT+CFUN=3D1", none_prefix, ...)

In this case the send_cmux would be called regardless of the sequence =

and you can simplify the logic in cfun_enable_cb...

> +
> +	/* enable the modem; responds with +CPIN: <ready/locked> when ready */
> +	g_at_chat_send(data->setup, "AT+CFUN=3D1", cfun_enable_prefix,
> +			cfun_enable_cb, modem, NULL);
> +}
> +
> +static void cfun_reset_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> +{
> +	DBG("ok %d", ok);
> +
> +	if (ok)
> +		cfun_reset(result, user_data);

So what if this fails?

> +}
> +
> +static int m95_enable(struct ofono_modem *modem)
> +{
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	data->setup =3D open_device(modem, "Device", "Setup: ");
> +	if (data->setup =3D=3D NULL)
> +		return -EINVAL;
> +
> +	/*
> +	 * when issuing the reset below, the modem is not ready until it
> +	 * responds with "+CFUN: 4", so set up a listener for this
> +	 */
> +	data->cfun_reset =3D g_at_chat_register(data->setup, cfun_reset_prefix[=
0],
> +						cfun_reset, FALSE, modem, NULL);
> +
> +	/* bring the modem into a known state by issuing a reset */
> +	g_at_chat_send(data->setup, "AT+CFUN=3D0,1", cfun_reset_prefix,
> +			cfun_reset_cb, modem, NULL);

So again, what is the sequence of events here?  You might want to just =

use none_prefix here...

> +
> +	return -EINPROGRESS;
> +}
> +
> +static void cfun_disable(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +	GAtResultIter iter;
> +
> +	DBG("%p", modem);
> +
> +	g_at_result_iter_init(&iter, result);
> +	if (!g_at_result_iter_next(&iter, cfun_reset_prefix[0]))
> +		return;
> +

Why just an empty return?

> +	/* remove the initial setup AT channel before creating mux-channels */
> +	g_at_chat_unref(data->setup);
> +	data->setup =3D NULL;
> +
> +	/* device is now in non-functional mode, so shut down it down */
> +	shutdown_device(data);
> +	ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> +{
> +	DBG("ok %d", ok);
> +
> +	if (ok)
> +		cfun_disable(result, user_data);

So what happens if !ok?

> +}
> +
> +static gboolean send_cfun_disable(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +
> +	/*
> +	 * when issuing the reset below, the modem is not ready until it
> +	 * responds with "+CFUN: 0", so set up a listener for this
> +	 */
> +	data->cfun_reset =3D g_at_chat_register(data->setup, cfun_reset_prefix[=
0],
> +						cfun_disable, FALSE, modem, NULL);
> +
> +	/* now put device in non-functional mode */
> +	g_at_chat_send(data->setup, "AT+CFUN=3D0,1", NULL, cfun_disable_cb, mod=
em,

Note that NULL prefix consumes everything.  Do you want none_prefix here?

> +			NULL);
> +
> +	return FALSE;
> +}
> +
> +static int m95_disable(struct ofono_modem *modem)
> +{
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	/* shut down the device to tear down the muxing channels */
> +	shutdown_device(data);
> +
> +	/* reopen device to get a plain AT control channel */
> +	data->setup =3D open_device(modem, "Device", "Disable: ");
> +	if (data->setup =3D=3D NULL)
> +		return -EINVAL;
> +
> +	/* add a timer to wait for device to drop GSM 07.10 multiplexing */
> +	data->mux_dropped_timer =3D g_timeout_add(1000, send_cfun_disable, mode=
m);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void m95_pre_sim(struct ofono_modem *modem)
> +{
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_sim *sim;
> +
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
> +	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUECTEL_M95, "atmodem",
> +				data->dlcs[VOICE_DLC]);
> +
> +	if (sim)
> +		ofono_sim_inserted_notify(sim, TRUE);
> +
> +	ofono_voicecall_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
> +	ofono_call_volume_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
> +}
> +
> +static void m95_post_sim(struct ofono_modem *modem)
> +{
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_gprs *gprs;
> +	struct ofono_gprs_context *gc;
> +
> +	DBG("%p", modem);
> +
> +	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> +	if (gprs =3D=3D NULL)
> +		return;
> +
> +	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +					data->dlcs[GPRS_DLC]);
> +	if (gc)
> +		ofono_gprs_add_context(gprs, gc);
> +}
> +
> +static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +	GAtResultIter iter;
> +	int status;
> +
> +	DBG("%p", modem);
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+QINISTAT:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &status))
> +		return;
> +
> +	DBG("qinistat: %d", status);
> +
> +	switch (status) {
> +	case 3:
> +		g_source_remove(data->qinitstat_timer);
> +
> +		if (data->have_sms =3D=3D FALSE) {
> +			ofono_sms_create(modem, 0, "atmodem",
> +						data->dlcs[SMS_DLC]);
> +			data->have_sms =3D TRUE;
> +		}
> +		/* fallthrough */
> +	case 2:
> +		if (data->have_phonebook =3D=3D FALSE) {
> +			ofono_phonebook_create(modem, 0, "atmodem",
> +						data->dlcs[VOICE_DLC]);
> +			data->have_phonebook =3D TRUE;
> +		}
> +		break;

Is status a bitmap?  If so, you might want to write this like:

if (status & 2) create phonebook

if (status & 1) create_sms

> +	}
> +}
> +
> +static gboolean send_qinistat_cb(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +
> +	/* QINISTAT tells us when SMS/phonebook is ready to be used */
> +	g_at_chat_send(data->dlcs[SMS_DLC], "AT+QINISTAT",
> +			qinistat_prefix, qinistat_cb, modem, NULL);
> +
> +	return TRUE;
> +}
> +
> +static void m95_post_online(struct ofono_modem *modem)
> +{
> +	struct m95_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_netreg_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +				data->dlcs[NETREG_DLC]);
> +	ofono_ussd_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
> +
> +	/* start timer to detect when phonebook and sms services are ready */
> +	data->qinitstat_timer =3D g_timeout_add(500, send_qinistat_cb, modem);

Ideally, there should be no AT commands sent from =

pre_sim/post_sim/post_online callbacks.  Also note that SMS & Phonebook =

are actually post_sim atoms.  Does QINISTAT support unsolicited =

notifications?  If so, might be better to rely on that than the polling =

logic you have...

> +}

Regards,
-Denis

--===============3173890181653143113==--

