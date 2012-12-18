Content-Type: multipart/mixed; boundary="===============8498971416680049768=="
MIME-Version: 1.0
From: Ming Li Wu <mingli@southpole.se>
Subject: Re: [PATCH 1/1] telit: stay 'online' until POST_SIM state reached
Date: Tue, 18 Dec 2012 18:28:43 +0100
Message-ID: <50D0A7CB.8030707@southpole.se>
In-Reply-To: <1354636010-9624-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8498971416680049768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

>
>   plugins/telit.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++----
>   1 file changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/plugins/telit.c b/plugins/telit.c
> index fe2ccd6..a0f7deb 100644
> --- a/plugins/telit.c
> +++ b/plugins/telit.c
> @@ -62,6 +62,7 @@
>   =

>   static const char *none_prefix[] =3D { NULL };
>   static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
> +static const char *qss_prefix[] =3D { "#QSS:", NULL };
>   =

>   struct telit_data {
>   	GAtChat *chat;		/* AT chat */
> @@ -219,7 +220,7 @@ static void switch_sim_state_status(struct ofono_mode=
m *modem, int status)
>   =

>   	switch (status) {
>   	case 0:	/* SIM not inserted */
> -		if (data->have_sim =3D=3D TRUE) {
> +		if (data->have_sim =3D=3D TRUE && ofono_modem_get_online(modem)) {
>   			ofono_sim_inserted_notify(data->sim, FALSE);
>   			data->have_sim =3D FALSE;
>   			data->sms_phonebook_added =3D FALSE;
> @@ -233,6 +234,14 @@ static void switch_sim_state_status(struct ofono_mod=
em *modem, int status)
>   		}
>   		break;
>   	case 3:	/* SIM inserted, SMS and phonebook ready */
> +		/* It's possible that we arrive at QSS=3D3 state without
> +		 * ever seeing QSS=3D2, so we need to make sure that we've
> +		 * also done the QSS=3D2 work, as well
> +		 */
> +		if (data->have_sim =3D=3D FALSE) {
> +			ofono_sim_inserted_notify(data->sim, TRUE);
> +			data->have_sim =3D TRUE;
> +		}
>   		if (data->sms_phonebook_added =3D=3D FALSE) {
>   			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
>   			ofono_sms_create(modem, 0, "atmodem", data->chat);
> @@ -245,6 +254,28 @@ static void switch_sim_state_status(struct ofono_mod=
em *modem, int status)
>   	}
>   }
>   =

> +/*
> + * telit_qss_cb gets invoked once when querying the QSS status immediate=
ly
> + * after enabling the modem.
> + */
> +static void telit_qss_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	int mode;
> +	int status;
> +	GAtResultIter iter;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	DBG("%p", modem);
> +	if (!g_at_result_iter_next(&iter, "#QSS:"))
> +		return;
> +	g_at_result_iter_next_number(&iter, &mode);
> +	g_at_result_iter_next_number(&iter, &status);
> +
> +	switch_sim_state_status(modem, status);
> +}
> +
>   static void telit_qss_notify(GAtResult *result, gpointer user_data)
>   {
>   	struct ofono_modem *modem =3D user_data;
> @@ -304,6 +335,12 @@ static void cfun_enable_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>   =

>   	/* Enable sim state notification */
>   	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL=
);
> +
> +	/* Query current sim state so that we don't need to wait a long
> +	 * time for a notification in case SIM state is already 'ready'
> +	 */
> +	g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
> +				telit_qss_cb, modem, NULL);
>   }
>   =

>   static int telit_enable(struct ofono_modem *modem)
> @@ -334,12 +371,19 @@ static int telit_enable(struct ofono_modem *modem)
>   =

>   	/*
>   	 * Disable sim state notification so that we sure get a notification
> -	 * when we enable it again later and don't have to query it.
> +	 * when we enable it again later and don't have to query it.  For
> +	 * the HE910, this doesn't seem to work... querying appears to be
> +	 * necessary as there will be no notification unless there is an
> +	 * actual _change_ of state.
>   	 */
>   	g_at_chat_send(data->chat, "AT#QSS=3D0", none_prefix, NULL, NULL, NULL=
);
>   =

> -	/* Set phone functionality */
> -	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
> +	/* Set phone functionality.
> +	 * When enabling the modem, we need to have the modem powered
> +	 * up until we've been able to get to post_sim state... for this
> +	 * reason, we start off with CFUN=3D4
> +	 */
> +	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
>   				cfun_enable_cb, modem, NULL);
>   =

>   	return -EINPROGRESS;
> @@ -565,6 +609,10 @@ static void telit_post_sim(struct ofono_modem *modem)
>   =

>   	if (gprs && gc)
>   		ofono_gprs_add_context(gprs, gc);
> +
> +	if (!ofono_modem_get_online(modem))
> +		g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
> +				NULL, NULL, NULL);
>   }
>   =

>   static void set_online_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> @@ -588,6 +636,14 @@ static void telit_set_online(struct ofono_modem *mod=
em, ofono_bool_t online,
>   =

>   	g_at_chat_send(data->chat, command, none_prefix, set_online_cb,
>   						cbd, g_free);
> +
> +	if (online) {
> +		/* Query current sim state in case it changed while we
> +		 * were offline and ignoring the QSS: 0 reports.
> +		 */
> +		g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
> +					telit_qss_cb, modem, NULL);
> +	}
>   }
>   =

>   static void telit_post_online(struct ofono_modem *modem)
Although this patch works for me, Is it a reasonable solution, or are =

there any better solutions for this problem?

Thanks

Mingli


-- =

Mingli Wu                       South Pole AB
Phone:  +46 8 56237100          Anderstorpsv=C3=A4gen 16
Mobile: +46 73 7628460          SE - 171 54 Solna
e-mail: mingli(a)southpole.se      www.southpole.se


--===============8498971416680049768==--

