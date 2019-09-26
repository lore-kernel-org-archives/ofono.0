Content-Type: multipart/mixed; boundary="===============0403261266177772551=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] quectel: rework sim detection
Date: Thu, 26 Sep 2019 17:10:12 -0500
Message-ID: <20d45d76-089c-09e7-3025-0b24c598b7ca@gmail.com>
In-Reply-To: <20190926192725.227285-3-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0403261266177772551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 9/26/19 2:27 PM, Martin Hundeb=C3=B8ll wrote:
> Simplify sim handling by querying cpin state directly from
> quectel_pre_sim().

Don't initiate commands from pre_sim/post_sim/post_online callbacks =

please.  There's almost never a reason to.

> =

> The query is conducted by issuing a AT+CPIN?, where only CME errors are
> catched by the command response handler. The +CPIN: <state> response is
> instead catched by a listener.

nit: s/catched/caught

> =

> The CME handler allows proper handling of the sim-busy and sim-not-
> inserted states, which are returned as CME errors by the quectel
> modems.
> =

> The +CPIN listener allows handling of both sim-locked and sim-ready
> states. When the sim is not locked, the listener catches the +CPIN:
> READY response from the query in quectel_pre_sim(). If the sim is
> locked, the listener catched the +CPIN: READY indication received after
> unlocking the sim.
> ---
>   plugins/quectel.c | 401 +++++++++++++++++-----------------------------
>   1 file changed, 149 insertions(+), 252 deletions(-)
> =


<snip>

> @@ -751,9 +534,8 @@ static void cfun_enable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>   	}
>   =

>   	dbus_hw_enable(modem);
> -
> -	g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_query, modem,
> -			NULL);
> +	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, NULL, NULL, NULL);

Don't you want to wait until this succeeds?

Also, you could issue a query for CPIN here and record whether the sim =

is inserted.  I assume no hot-swap of SIM is supported?

> +	ofono_modem_set_powered(modem, true);
>   }
>   =

>   static void cfun_query(gboolean ok, GAtResult *result, gpointer user_da=
ta)

<snip>

> +
> +	if (ofono_sim_get_state(data->sim) =3D=3D OFONO_SIM_STATE_INSERTED)
> +		ofono_sim_initialized_notify(data->sim);
> +	else
> +		ofono_sim_inserted_notify(data->sim, true);

This is a strange dance.  Shouldn't the modem tell you up front that the =

SIM is inserted or not?  So then you only need to run QINISTAT when it =

goes from pin locked to unlocked?

> +}
> +
> +static void init_timer_cb(struct l_timeout *timeout, void *user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
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
> +	enum ofono_sim_state state =3D ofono_sim_get_state(data->sim);
> +	const char *path =3D ofono_modem_get_path(modem);
> +	GAtResultIter iter;
> +	const char *cpin;
> +
> +	DBG("%p", modem);
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CPIN:"))
>   		return;
>   =

> -	switch (data->sim_state) {
> -	case OFONO_SIM_STATE_LOCKED_OUT:
> -	case OFONO_SIM_STATE_READY:
> +	g_at_result_iter_next_unquoted_string(&iter, &cpin);
> +
> +	if (g_strcmp0(cpin, "NOT INSERTED") =3D=3D 0) {
> +		ofono_warn("%s: sim not present", path);
> +		return;
> +	}
> +
> +	if (g_strcmp0(cpin, "READY") !=3D 0) {
> +		if (state !=3D OFONO_SIM_STATE_INSERTED) {
> +			ofono_info("%s: sim locked", path);
> +			ofono_sim_inserted_notify(data->sim, true);

Okay, but  it might be easier to just know this up front whether the sim =

is inserted or not.

> +		}
> +
> +		return;
> +	}
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

So then this READY case becomes simple.  Didn't you also say that =

Quectel sends +CPIN: READY unsolicited?

> +}
> +
> +static void cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_error error;
> +
> +	if (ok)
> +		return;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (error.type !=3D OFONO_ERROR_TYPE_CME)
> +		return;
> +
> +	switch (error.error) {
> +	case 5:
> +	case 6:
> +	case 7:
> +	case 11:
> +	case 12:
> +	case 17:
> +	case 18:
>   		ofono_sim_inserted_notify(data->sim, true);
>   		break;
> -	default:
> +	case 10:
> +		ofono_warn("%s: sim not present", ofono_modem_get_path(modem));
> +		break;
> +	case 13:
> +	case 14:
> +	case 15:
> +		/* wait for +CPIN: indication */
>   		break;
> +	default:
> +		ofono_error("unknown cpin error: %i", error.error);
>   	}
>   }

at_util_sim_state_query_new does most of this for you btw...

>   =

> +static void quectel_pre_sim(struct ofono_modem *modem)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_voicecall_create(modem, data->vendor, "atmodem", data->aux);
> +	data->sim =3D ofono_sim_create(modem, data->vendor, "atmodem", data->au=
x);
> +	data->sim_watch =3D g_at_chat_register(data->aux, "+CPIN:", sim_watch_c=
b,
> +						FALSE, modem, NULL);
> +
> +	/*
> +	 * unsolicited indications about a missing or locked sim can occur befo=
re
> +	 * the auto-baud dance in open_serial(), so issue a CPIN query here
> +	 *
> +	 * the callback is only called for CME errors to catch those. The +CPIN
> +	 * response is catched by the watch registered above

nit: caught

> +	 */
> +	g_at_chat_send(data->aux, "AT+CPIN?", none_prefix, cpin_cb, modem, NULL=
);

So as mentioned before, don't run commands in pre_sim.  You can do this =

as part of .enable sequence instead, store sim presence info and simply =

call sim_create & sim_inserted if needed.

> +}
> +

Regards,
-Denis

--===============0403261266177772551==--

