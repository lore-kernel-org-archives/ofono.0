Content-Type: multipart/mixed; boundary="===============7950927687811953489=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2] quectel: handle sim states
Date: Mon, 02 Sep 2019 16:37:24 -0500
Message-ID: <7de7bacc-a71d-f51b-4c5d-d100ca224fc1@gmail.com>
In-Reply-To: <20190902211610.61809-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7950927687811953489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 9/2/19 4:16 PM, Martin Hundeb=C3=B8ll wrote:
> The quectel M95 and MC60 modems are picky about when the sim is properly
> initialized, so the logic to detect this needs to be in the quectel
> plugin.
> =

> After doing basic initialization, a CPIN query is issued to detect sim
> state.
> =

> If the sim is unlocked and ready, a timer is created to wait for the
> modem state (AT+QINISTAT) to complete. At this point ofono is notified
> about the initialized sim.
> =

> If the sim is locked, a listener for "+CPIN: READY" is set up to
> know when a pin is entered. Once the indication is received, the timer
> is set up as if the sim was unlocked from the beginning.
> =

> If the sim is busy/resetting, the CPIN query is issued again.
> ---
> =

> Changes since v1:
>   * New implementation without at_util_sim_state_query_new()
>   * Tested on Quectel UC15
>   * Delays basic SIM initialization until QINISTAT is correct
> =

>   plugins/quectel.c | 281 ++++++++++++++++++++++++++++++----------------
>   1 file changed, 182 insertions(+), 99 deletions(-)
> =

> diff --git a/plugins/quectel.c b/plugins/quectel.c
> index ccfc6c5f..b9c2d911 100644
> --- a/plugins/quectel.c
> +++ b/plugins/quectel.c
> @@ -87,12 +87,11 @@ enum quectel_model {
>   struct quectel_data {
>   	GAtChat *modem;
>   	GAtChat *aux;
> -	guint cpin_ready;
> -	guint call_ready;
> -	bool have_sim;
>   	enum ofono_vendor vendor;
>   	enum quectel_model model;
> -	struct l_timeout *sms_ready_timer;
> +	struct ofono_sim *sim;
> +	enum ofono_sim_state sim_state;
> +	unsigned int sim_watch;
>   =

>   	/* used by quectel uart driver */
>   	GAtChat *uart;
> @@ -185,9 +184,6 @@ static void quectel_remove(struct ofono_modem *modem)
>   =

>   	DBG("%p", modem);
>   =

> -	if (data->cpin_ready !=3D 0)
> -		g_at_chat_unregister(data->aux, data->cpin_ready);
> -
>   	ofono_modem_set_data(modem, NULL);
>   	l_timeout_remove(data->init_timeout);
>   	l_gpio_writer_free(data->gpio);
> @@ -527,42 +523,203 @@ static void dbus_hw_enable(struct ofono_modem *mod=
em)
>   	ofono_modem_add_interface(modem, dbus_hw_interface);
>   }
>   =

> -static void cpin_notify(GAtResult *result, gpointer user_data)
> +static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>   {
>   	struct ofono_modem *modem =3D user_data;
>   	struct quectel_data *data =3D ofono_modem_get_data(modem);
> -	const char *sim_inserted;
>   	GAtResultIter iter;
> +	int ready =3D 0;
> +	int status;
>   =

>   	DBG("%p", modem);
>   =

>   	g_at_result_iter_init(&iter, result);
>   =

> -	if (!g_at_result_iter_next(&iter, "+CPIN:"))
> +	if (!g_at_result_iter_next(&iter, "+QINISTAT:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &status))
>   		return;
>   =

> -	g_at_result_iter_next_unquoted_string(&iter, &sim_inserted);
> +	DBG("qinistat: %d", status);
> +
> +	switch (data->model) {
> +	case QUECTEL_UC15:
> +		/* UC15 uses a bitmap of 1 + 2 + 4 =3D 7 */
> +		ready =3D 7;
> +		break;
> +	case QUECTEL_M95:
> +	case QUECTEL_MC60:
> +		/* M95 and MC60 uses a counter to 3 */
> +		ready =3D 3;
> +		break;
> +	case QUECTEL_UNKNOWN:
> +		ready =3D 0;
> +		break;
> +	}
> +
> +	if (status !=3D ready) {
> +		l_timeout_modify_ms(data->init_timeout, 500);
> +		return;
> +	}
>   =

> -	if (g_strcmp0(sim_inserted, "NOT INSERTED") !=3D 0)
> -		data->have_sim =3D true;
> +	l_timeout_remove(data->init_timeout);
> +	data->init_timeout =3D NULL;
>   =

> -	ofono_modem_set_powered(modem, TRUE);
> +	if (data->sim_state =3D=3D OFONO_SIM_STATE_READY) {
> +		/*
> +		 * when initializing with a non-locked sim card, the sim atom
> +		 * isn't created until now to avoid accessing it before the
> +		 * modem is ready.
> +		 *
> +		 * call ofono_modem_set_powered() to make ofono call
> +		 * quectel_pre_sim() where the sim atom is created. Then signal
> +		 * the inserted state.
> +		 */
> +		ofono_modem_set_powered(modem, true);
> +		ofono_sim_inserted_notify(data->sim, true);
> +	} else {
> +		/*
> +		 * When initialized with a locked sim card, the modem is already
> +		 * powered up, and the inserted signal has been sent to allow
> +		 * the pin to be entered. So simply update the state, and notify
> +		 * about the finished initialization below.
> +		 */
> +		data->sim_state =3D OFONO_SIM_STATE_READY;
> +	}
>   =

> -	/* Turn off the radio. */
> -	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, NULL, NULL, NULL);
> +	ofono_sim_initialized_notify(data->sim);
> +	ofono_sms_create(modem, data->vendor, "atmodem", data->aux);
> +	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
> +	ofono_voicecall_create(modem, data->vendor, "atmodem", data->aux);
> +	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);

Are you sure you want to do this here?  Shouldn't you wait until the =

core actually performs the PIN entry or whatnot prior to initializing =

phonebook & sms, etc?  Otherwise they might be marked as pre-sim state =

and you'll have all sorts of weirdness to worry about.  Keep atom =

creation in the pre_sim/post_sim/post_online callbacks whenever possible.

> +}
>   =

> -	g_at_chat_unregister(data->aux, data->cpin_ready);
> -	data->cpin_ready =3D 0;
> +static void init_timer_cb(struct l_timeout *timeout, void *user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
>   =

> -	dbus_hw_enable(modem);
> +	DBG("%p", modem);
> +
> +	g_at_chat_send(data->aux, "AT+QINISTAT", qinistat_prefix, qinistat_cb,
> +			modem, NULL);
> +}
> +
> +static void sim_watch_cb(GAtResult *result, void *user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_unregister(data->aux, data->sim_watch);
> +	data->sim_watch =3D 0;
> +
> +	data->init_timeout =3D l_timeout_create_ms(500, init_timer_cb, modem, N=
ULL);
> +	if (!data->init_timeout) {
> +		close_serial(modem);
> +		return;
> +	}
> +}
> +
> +static enum ofono_sim_state cme_parse(GAtResult *result)
> +{
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (error.type !=3D OFONO_ERROR_TYPE_CME)
> +		return OFONO_SIM_STATE_RESETTING;
> +
> +	switch (error.error) {
> +	case 5:
> +	case 6:
> +	case 7:
> +	case 11:
> +	case 12:
> +	case 17:
> +	case 18:
> +		return OFONO_SIM_STATE_LOCKED_OUT;
> +	case 10:
> +		return OFONO_SIM_STATE_NOT_PRESENT;
> +	case 13:
> +	case 14:
> +	case 15:
> +		return OFONO_SIM_STATE_RESETTING;
> +	default:
> +		ofono_error("unknown cpin error: %i", error.error);
> +		return OFONO_SIM_STATE_RESETTING;
> +	}
> +}
> +
> +static enum ofono_sim_state cpin_parse(GAtResult *result)
> +{
> +	GAtResultIter iter;
> +	const char *cpin;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CPIN:"))
> +		return OFONO_SIM_STATE_RESETTING;
> +
> +	g_at_result_iter_next_unquoted_string(&iter, &cpin);
> +
> +	if (g_strcmp0(cpin, "NOT INSERTED") =3D=3D 0)
> +		return OFONO_SIM_STATE_NOT_PRESENT;
> +
> +	if (g_strcmp0(cpin, "READY") =3D=3D 0)
> +		return OFONO_SIM_STATE_READY;
> +
> +	return OFONO_SIM_STATE_LOCKED_OUT;
>   }
>   =

>   static void cpin_query(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>   {
> -	DBG("%p ok %d", user_data, ok);
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p ok %i", modem, ok);
>   =

>   	if (ok)
> -		cpin_notify(result, user_data);
> +		data->sim_state =3D cpin_parse(result);
> +	else
> +		data->sim_state =3D cme_parse(result);
> +
> +	/* Turn off the radio. */
> +	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, NULL, NULL, NULL);
> +
> +	switch (data->sim_state) {
> +	case OFONO_SIM_STATE_LOCKED_OUT:
> +		ofono_modem_set_powered(modem, true);
> +		ofono_sim_inserted_notify(data->sim, true);
> +		data->sim_watch =3D g_at_chat_register(data->aux, "+CPIN: READY",
> +							sim_watch_cb, FALSE,
> +							modem, NULL);
> +		if (!data->sim_watch) {
> +			ofono_error("failed to create sim watch");
> +			close_serial(modem);
> +			return;
> +		}
> +		break;
> +	case OFONO_SIM_STATE_READY:
> +		data->init_timeout =3D l_timeout_create_ms(500, init_timer_cb,
> +							modem, NULL);
> +		if (!data->init_timeout) {
> +			ofono_error("failed to create qinitstat timer");
> +			close_serial(modem);
> +			return;
> +		}
> +		break;
> +	case OFONO_SIM_STATE_RESETTING:
> +	case OFONO_SIM_STATE_INSERTED:
> +		g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_query,
> +				modem, NULL);
> +		break;
> +	case OFONO_SIM_STATE_NOT_PRESENT:
> +		ofono_warn("%s: sim not present", ofono_modem_get_path(modem));
> +		ofono_modem_set_powered(modem, true);
> +	}
>   }
>   =

>   static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> @@ -577,8 +734,8 @@ static void cfun_enable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>   		return;
>   	}
>   =

> -	data->cpin_ready =3D g_at_chat_register(data->aux, "+CPIN", cpin_notify,
> -						FALSE, modem, NULL);
> +	dbus_hw_enable(modem);
> +
>   	g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_query, modem,
>   			NULL);
>   }
> @@ -659,67 +816,6 @@ static void cgmm_cb(int ok, GAtResult *result, void =
*user_data)
>   			NULL);
>   }
>   =

> -static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> -{
> -	struct ofono_modem *modem =3D user_data;
> -	struct quectel_data *data =3D ofono_modem_get_data(modem);
> -	GAtResultIter iter;
> -	int status;
> -
> -	DBG("%p", modem);
> -
> -	g_at_result_iter_init(&iter, result);
> -
> -	if (!g_at_result_iter_next(&iter, "+QINISTAT:"))
> -		return;
> -
> -	if (!g_at_result_iter_next_number(&iter, &status))
> -		return;
> -
> -	DBG("qinistat: %d", status);
> -
> -	if (status !=3D 3) {
> -		l_timeout_modify_ms(data->sms_ready_timer, 500);
> -		return;
> -	}
> -
> -	ofono_sms_create(modem, data->vendor, "atmodem", data->aux);
> -	l_timeout_remove(data->sms_ready_timer);
> -	data->sms_ready_timer =3D NULL;
> -}
> -
> -static void sms_ready_cb(struct l_timeout *timeout, void *user_data)
> -{
> -	struct ofono_modem *modem =3D user_data;
> -	struct quectel_data *data =3D ofono_modem_get_data(modem);
> -
> -	DBG("%p", modem);
> -
> -	g_at_chat_send(data->aux, "AT+QINISTAT", qinistat_prefix, qinistat_cb,
> -			modem, NULL);
> -}
> -
> -static void call_ready_notify(GAtResult *result, void *user_data)
> -{
> -	struct ofono_modem *modem =3D user_data;
> -	struct quectel_data *data =3D ofono_modem_get_data(modem);
> -
> -	DBG("%p", modem);
> -
> -	g_at_chat_unregister(data->aux, data->call_ready);
> -	data->call_ready =3D 0;
> -	data->sms_ready_timer =3D l_timeout_create_ms(500, sms_ready_cb, modem,
> -							NULL);
> -	if (!data->sms_ready_timer) {
> -		close_serial(modem);
> -		return;
> -	}
> -
> -	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
> -	ofono_voicecall_create(modem, 0, "atmodem", data->aux);
> -	ofono_call_volume_create(modem, 0, "atmodem", data->aux);
> -}
> -
>   static int open_ttys(struct ofono_modem *modem)
>   {
>   	struct quectel_data *data =3D ofono_modem_get_data(modem);
> @@ -739,19 +835,9 @@ static int open_ttys(struct ofono_modem *modem)
>   		return -EIO;
>   	}
>   =

> -	data->call_ready =3D g_at_chat_register(data->aux, "Call Ready",
> -						call_ready_notify, false,
> -						modem, NULL);
> -	if (!data->call_ready) {
> -		close_serial(modem);
> -		return -ENOTTY;
> -	}
> -
>   	g_at_chat_set_slave(data->modem, data->aux);
>   =

> -	g_at_chat_send(data->modem, "ATE0; &C0; +CMEE=3D1", none_prefix, NULL,
> -			NULL, NULL);
> -	g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1", none_prefix, NULL, NU=
LL,
> +	g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1; +QIURC=3D0", none_pref=
ix, NULL, =


80 chars / line violation?

NULL,
>   			NULL);
>   	g_at_chat_send(data->aux, "AT+CGMM", cgmm_prefix, cgmm_cb, modem,
>   			NULL);
> @@ -1048,10 +1134,7 @@ static void quectel_pre_sim(struct ofono_modem *mo=
dem)
>   	DBG("%p", modem);
>   =

>   	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
> -	sim =3D ofono_sim_create(modem, data->vendor, "atmodem", data->aux);
> -
> -	if (sim && data->have_sim =3D=3D true)
> -		ofono_sim_inserted_notify(sim, TRUE);
> +	data->sim =3D ofono_sim_create(modem, data->vendor, "atmodem", data->au=
x);
>   }
>   =

>   static void quectel_post_sim(struct ofono_modem *modem)
> =


Regards,
-Denis

--===============7950927687811953489==--

