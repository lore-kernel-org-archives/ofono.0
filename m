Content-Type: multipart/mixed; boundary="===============5263958793599888366=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] telit: rework for HE910
Date: Mon, 08 Apr 2013 13:29:41 -0500
Message-ID: <51630C95.4090805@gmail.com>
In-Reply-To: <1365063652-24286-4-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5263958793599888366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/04/2013 03:20 AM, Jonas Bonn wrote:
> The Telit HE910 turns out to be a rather quirky device and the existing
> 'telit' driver doesn't really work as is.  This patch is the result of
> many hours of trial-and-error and direct consultation with Telit in
> order to find an initialization sequence that works, doesn't lock up
> the modem, and fits the Ofono paradigm.

Is the HE910 sufficiently different that it might be easier to simply =

write a dedicated driver for it?  One can even have multiple drivers in =

the telit.c file.

E.g. something like:

static struct ofono_modem_driver telit_driver =3D {
	.name =3D "telit",
	...
};

static struct ofono_modem_driver telit_he910_driver =3D {
	...
};

>
> 1) The SIM status unsolicited messages need to be used in order to know
> when the SIM is sufficiently ready to allow certain ther commands to
> be able to complete without error.  Unfortunately, these messages are
> not reliably issued in a way that allows them to always be caught.  As
> such, the modem needs to be prodded to re-issue these messages by:
>
> i)   Using SIMDET=3D0 to logically 'remove' the SIM before powering on
>       the modem
> ii)  Setting SIMDET=3D1 iff a SIM is physically inserted in order to have
>       the QSS states re-issued
> iii) Finally, setting SIMDET=3D2 once the modem is powered up to re-enable
>       the normal QSS unsolicited messages
>
> 2) CFUN state 4 powers off the modem (airplane mode), but it also powers
>     off the SIM card.  This doesn't fit well with the Ofono model as the
>     GPRS atom won't be created unless the SIM card is usable.  Consultati=
on
>     with Telit resulted in the following alternative:
>

It sounds like the concept of Online is not relevant.  Maybe you should =

simply not implement the .set_enable method.  This way the modem =

initialization logic in the core proceeds straight to post_online state...

> i)   Set CFUN=3D1 when enabling the modem and set COPS=3D2 to take the mo=
dem
>       'offline'
> ii)  Set COPS=3D0 when putting the modem 'online'
> iii) CFUN=3D4 may be used when disabling the modem.  The telit driver
>       previously used CFUN=3D0, but this is actually not an 'offline' sta=
te
>       at all.

... which is better than trying to mess with COPS, since this has =

potential side effects on the netreg atom.

>
> 3) The voicecall atom cannot be created until the SIM is ready.
>

Then move it to the post_sim or post_online state.

> 4) The CMER command will always fail
>
> 5) The CMER? command will always fail if ofono_sim_inserted_notify is
>     called before QSS reaches state 3.
>
> The combination of using CFUN=3D1 when enabled works around another quirk
> in the modem: if the SIM is hotplugged (SIMIN signal toggles) when CFUN=
=3D4,
> the SIM logic actually wakes up and QSS messages may be issued.  This is
> out of sync with the expected behaviour and is difficult to reconcile
> with the rest of the control flow in the ofono driver.
>
> The Telit HE910 has a propensity to lock up when echo is enabled.  We
> have seen this primarily on the 'modem' port where the modem locks up
> after echoing back the command when there is pending command on the
> 'aux' port.  The changed initialization flow of this patch makes this
> problem in general more difficult to hit, but as an additional measure
> this patch disables echo on the modem port completely.
>
> These changes have been tested with a Telit HE910 modem only.  As the
> documentation for earlier Telit modems is almost identical, I expect
> this new control flow to work with those modems as well.  That said, it
> would be good if that could be tested with someone with such a modem.
> ---
>   plugins/telit.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++---=
-------
>   1 file changed, 114 insertions(+), 24 deletions(-)
>
> diff --git a/plugins/telit.c b/plugins/telit.c
> index f661ab9..2b625da 100644
> --- a/plugins/telit.c
> +++ b/plugins/telit.c
> @@ -63,6 +63,7 @@
>   #endif
>
>   static const char *none_prefix[] =3D { NULL };
> +static const char *simdet_prefix[]=3D { "#SIMDET:", NULL };
>   #ifdef NEED_BLUETOOTH
>   static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
>   #endif
> @@ -242,13 +243,32 @@ static void switch_sim_state_status(struct ofono_mo=
dem *modem, int status)
>   		}
>   		break;
>   	case 1:	/* SIM inserted */
> -	case 2:	/* SIM inserted and PIN unlocked */
> +		/* If PIN is required, we need to inform ofono that sim is inserted. */
>   		if (data->have_sim =3D=3D FALSE) {
>   			ofono_sim_inserted_notify(data->sim, TRUE);
>   			data->have_sim =3D TRUE;
>   		}
>   		break;
> +	case 2:	/* SIM inserted and PIN unlocked */
> +		/* The voicecall atom cannot be created until the SIM is
> +		 * unlocked and ready for use.
> +		 */
> +		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
> +

You can simply move this part to post_sim or post_online

> +		/*
> +		 * Tell the modem not to automatically initiate auto-attach
> +		 * proceedures on its own.  Again, this command requires a
> +		 * functional SIM in order to succeed.
> +		 */
> +		g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
> +				NULL, NULL, NULL);
> +
> +		break;
>   	case 3:	/* SIM inserted, SMS and phonebook ready */
> +		if (data->have_sim =3D=3D FALSE) {
> +			ofono_sim_inserted_notify(data->sim, TRUE);
> +			data->have_sim =3D TRUE;
> +		}
>   		if (data->sms_phonebook_added =3D=3D FALSE) {
>   			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
>   			ofono_sms_create(modem, 0, "atmodem", data->chat);
> @@ -279,6 +299,46 @@ static void telit_qss_notify(GAtResult *result, gpoi=
nter user_data)
>   	switch_sim_state_status(modem, status);
>   }
>
> +static void simdet_query_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_modem *m =3D data->sap_modem ? : modem;
> +	GAtResultIter iter;
> +	int mode;
> +	int inserted;
> +
> +	DBG("%p", modem);
> +
> +	if (!ok)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "#SIMDET:"))
> +		return;
> +
> +	g_at_result_iter_next_number(&iter,&mode);
> +	g_at_result_iter_next_number(&iter,&inserted);
> +
> +	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL);
> +
> +	/* If the SIM is already physically present, we need to tell the
> +	 * modem so by setting SIMDET to 1 in order for it to regenerate
> +	 * the QSS messages corresponding to the current state
> +	 */
> +	if (inserted) {
> +		g_at_chat_send(data->chat, "AT#SIMDET=3D1", none_prefix,
> +				NULL, NULL, NULL);
> +	}
> +
> +	/* Restore SIM presence detection via SIMIN pin */
> +	g_at_chat_send(data->chat, "AT#SIMDET=3D2", none_prefix,
> +				NULL, NULL, NULL);
> +
> +	ofono_modem_set_powered(m, TRUE);
> +}
> +
>   static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
>   {
>   	struct ofono_modem *modem =3D user_data;
> @@ -307,21 +367,14 @@ static void cfun_enable_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
>   	data->have_sim =3D FALSE;
>   	data->sms_phonebook_added =3D FALSE;
>
> -	ofono_modem_set_powered(m, TRUE);
> +	/* Set modem 'offline' */
> +	g_at_chat_send(data->chat, "AT+COPS=3D2", none_prefix, NULL, NULL, NULL=
);
>
> -	/*
> -	 * Tell the modem not to automatically initiate auto-attach
> -	 * proceedures on its own.
> +	/* Re-enabling QSS reporting requires that we manually poke the
> +	 * modem with its current state... this requires querying SIMDET
>   	 */
> -	g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
> -				NULL, NULL, NULL);
> -
> -	/* Follow sim state */
> -	g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
> -				FALSE, modem, NULL);
> -
> -	/* Enable sim state notification */
> -	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL);
> +	g_at_chat_send(data->chat, "AT#SIMDET?", simdet_prefix,
> +				simdet_query_cb, modem, NULL);
>   }
>
>   static int telit_enable(struct ofono_modem *modem)
> @@ -349,15 +402,52 @@ static int telit_enable(struct ofono_modem *modem)
>   	 */
>   	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
>   				NULL, NULL, NULL);
> +	/* The Telit modem loses command responses when ECHO is on...
> +	 * it is a bug and Telit has been informed of it, but the
> +	 * easiest way forward for now is to just disable ECHO on
> +	 * the modem port.
> +	 */
> +	g_at_chat_send(data->modem, "ATE0", none_prefix,
> +				NULL, NULL, NULL);
>
> -	/*
> -	 * Disable sim state notification so that we sure get a notification
> -	 * when we enable it again later and don't have to query it.
> +	/* Telit is quirky, quirky, quirky; getting a reliable QSS
> +	 * indication at startup is tricky.
> +	 * - QSS transitions aren't necessarily sent when the SIM
> +	 *   is first powered on
> +	 * - The QSS state, if 1, doesn't automatically transition
> +	 *   to 2/3 when QSS mode=3D2 is set.
> +	 * In order to ensure that we get a reliable QSS indication,
> +	 * the SIM to needs to be logically (or physically) reinserted
> +	 * when the SIM core is powered up.
> +	 *
> +	 * The SIMIN pin will correctly trigger a QSS transition, but
> +	 * it's edge-triggered so that it won't trigger a QSS indication
> +	 * unless a SIM is physically reinserted; it's therefore necessary
> +	 * to do a "soft" reinsertion by way of the SIMDET command.  The
> +	 * sequence that reliably works is:
> +	 * - set QSS=3D0
> +	 * - set SIMDET to 0 (SIM logically removed)
> +	 * - put modem into CFUN!=3D4 in order to power up the SIM
> +	 * - when modem is powered, set QSS=3D2
> +	 * - check SIMDET value to see if SIM is physically inserted
> +	 *   or not; if yes, we need to manually trigger a QSS transition
> +	 *   by doing a "soft insertion"; we do this by setting SIMDET=3D1
> +	 *   (SIM logically inserted)
> +	 * - then we can set SIMDET=3D2 to enable SIM hotplug the rest
> +	 *   of the way.
>   	 */
> +
> +	/* Follow sim state */
>   	g_at_chat_send(data->chat, "AT#QSS=3D0", none_prefix, NULL, NULL, NULL=
);
> +	g_at_chat_send(data->chat, "AT#SIMDET=3D0", none_prefix,
> +				NULL, NULL, NULL);
> +	g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
> +				FALSE, modem, NULL);
>
> -	/* Set phone functionality */
> -	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
> +	/* Set modem to full functionality... this is required to have the
> +	 * SIM powered up which is pretty much a prerequisite for Ofono.
> +	 */
> +	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
>   				cfun_enable_cb, modem, NULL);
>
>   	return -EINPROGRESS;
> @@ -437,7 +527,7 @@ static int telit_disable(struct ofono_modem *modem)
>   	g_at_chat_unregister_all(data->chat);
>
>   	/* Power down modem */
> -	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
> +	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
>   				cfun_disable_cb, modem, NULL);
>
>   	return -EINPROGRESS;
> @@ -565,9 +655,9 @@ static void telit_pre_sim(struct ofono_modem *modem)
>   	DBG("%p", modem);
>
>   	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
> -	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT, "atmodem",
> -					data->chat);
> -	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
> +	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT,
> +			"atmodem", data->chat);
> +
>   }
>
>   static void telit_post_sim(struct ofono_modem *modem)
> @@ -604,7 +694,7 @@ static void telit_set_online(struct ofono_modem *mode=
m, ofono_bool_t online,
>   {
>   	struct telit_data *data =3D ofono_modem_get_data(modem);
>   	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> -	char const *command =3D online ? "AT+CFUN=3D1,0" : "AT+CFUN=3D4,0";
> +	char const *command =3D online ? "AT+COPS=3D0" : "AT+COPS=3D2";

As mentioned before, I really don't like this due to potential side =

effects with the netreg atom.

>
>   	DBG("modem %p %s", modem, online ? "online" : "offline");
>

Regards,
-Denis

--===============5263958793599888366==--

