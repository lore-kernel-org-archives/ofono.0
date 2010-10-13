Content-Type: multipart/mixed; boundary="===============8231030452218222551=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC online/offline atoms PATCH 2/4] sms: watch modem state
Date: Wed, 13 Oct 2010 15:45:58 -0500
Message-ID: <4CB61A86.2000008@gmail.com>
In-Reply-To: <1286278512-3529-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8231030452218222551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 10/05/2010 06:35 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Allow use of SMS atom in online and offline states.  The messages are
> queued but not sent in offline mode. Errors occurring when an SMS is
> being sent while transition from online to offline are handled
> gracefully.
> ---
>  src/sms.c |   46 ++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 42 insertions(+), 4 deletions(-)
> =

> diff --git a/src/sms.c b/src/sms.c
> index aee9a61..f79bb7d 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -72,6 +72,7 @@ struct ofono_sms {
>  	guint tx_source;
>  	struct ofono_message_waiting *mw;
>  	unsigned int mw_watch;
> +	unsigned int online_watch;
>  	struct ofono_sim *sim;
>  	GKeyFile *settings;
>  	char *imsi;
> @@ -661,6 +662,11 @@ static void tx_finished(const struct ofono_error *er=
ror, int mr, void *data)
>  	DBG("tx_finished");
>  =

>  	if (ok =3D=3D FALSE) {
> +		/* Retry again when back in online mode */
> +		/* Note this does not increment retry count */
> +		if (!ofono_modem_get_online(modem))
> +			return;
> +

So this part needs to be discused some more.  Should we be using an
online watch here, or checking the status of the netreg atom instead?
Since netreg is not available in offline mode, its absence is a good
indicator of being offline as well.  Plus we shouldn't try to send SMSes
when we're not registered / roaming.

>  		if (!(entry->flags & OFONO_SMS_SUBMIT_FLAG_RETRY))
>  			goto next_q;
>  =

> @@ -668,7 +674,7 @@ static void tx_finished(const struct ofono_error *err=
or, int mr, void *data)
>  =

>  		if (entry->retry < TXQ_MAX_RETRIES) {
>  			DBG("Sending failed, retry in %d secs",
> -					entry->retry * 5);
> +				entry->retry * 5);

This doesn't seem related...

>  			sms->tx_source =3D g_timeout_add_seconds(entry->retry * 5,
>  								tx_next, sms);
>  			return;
> @@ -718,6 +724,9 @@ next_q:
>  =

>  	tx_queue_entry_destroy(entry);
>  =

> +	if (!ofono_modem_get_online(modem))
> +		return;
> +
>  	if (g_queue_peek_head(sms->txq)) {
>  		DBG("Scheduling next");
>  		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
> @@ -727,6 +736,7 @@ next_q:
>  static gboolean tx_next(gpointer user_data)
>  {
>  	struct ofono_sms *sms =3D user_data;
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
>  	int send_mms =3D 0;
>  	struct tx_queue_entry *entry =3D g_queue_peek_head(sms->txq);
>  	struct pending_pdu *pdu =3D &entry->pdus[entry->cur_pdu];
> @@ -741,6 +751,9 @@ static gboolean tx_next(gpointer user_data)
>  	if (!entry)
>  		return FALSE;
>  =

> +	if (!ofono_modem_get_online(modem))
> +		return FALSE;
> +
>  	if (g_queue_get_length(sms->txq) > 1
>  			|| (entry->num_pdus - entry->cur_pdu) > 1)
>  		send_mms =3D 1;
> @@ -751,6 +764,21 @@ static gboolean tx_next(gpointer user_data)
>  	return FALSE;
>  }
>  =

> +static void online_watch(enum ofono_modem_state modem_state, void *data)
> +{
> +
> +	struct ofono_sms *sms =3D data;
> +
> +	if (modem_state !=3D MODEM_STATE_ONLINE)
> +		return;
> +
> +	if (sms->tx_source > 0)
> +		return;

If the modem goes offline / netreg atom disappears or gets deregistered,
removing the tx_source might be better.

> +
> +	if (g_queue_get_length(sms->txq))
> +		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
> +}
> +
>  static void set_ref_and_to(GSList *msg_list, guint16 ref, int offset,
>  				gboolean use_16bit, const char *to)
>  {
> @@ -943,14 +971,15 @@ static DBusMessage *sms_send_message(DBusConnection=
 *conn, DBusMessage *msg,
>  =

>  	g_queue_push_tail(sms->txq, entry);
>  =

> -	if (g_queue_get_length(sms->txq) =3D=3D 1)
> +	modem =3D __ofono_atom_get_modem(sms->atom);
> +
> +	if (ofono_modem_get_online(modem) && g_queue_get_length(sms->txq) =3D=
=3D 1)
>  		sms->tx_source =3D g_timeout_add(0, tx_next, sms);

So here again, perhaps we also need to check the netreg status.

>  =

>  	path =3D message_build_path(sms, m);
>  	g_dbus_send_reply(conn, msg, DBUS_TYPE_OBJECT_PATH, &path,
>  					DBUS_TYPE_INVALID);
>  =

> -	modem =3D __ofono_atom_get_modem(sms->atom);
>  	__ofono_history_sms_send_pending(modem, &entry->uuid,
>  						to, time(NULL), text);
>  =

> @@ -1512,6 +1541,11 @@ static void sms_unregister(struct ofono_atom *atom)
>  		sms->mw =3D NULL;
>  	}
>  =

> +	if (sms->online_watch) {
> +		__ofono_modem_remove_state_watch(modem, sms->online_watch);
> +		sms->online_watch =3D 0;
> +	}
> +
>  	if (sms->messages) {
>  		GHashTableIter iter;
>  		struct message *m;
> @@ -1714,6 +1748,9 @@ void ofono_sms_register(struct ofono_sms *sms)
>  	if (mw_atom && __ofono_atom_get_registered(mw_atom))
>  		mw_watch(mw_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, sms);
>  =

> +	sms->online_watch =3D __ofono_modem_add_state_watch(modem,
> +					online_watch, sms, NULL);
> +
>  	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
>  =

>  	/*
> @@ -1765,6 +1802,7 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, G=
SList *list,
>  				ofono_sms_txq_submit_cb_t cb,
>  				void *data, ofono_destroy_func destroy)
>  {
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
>  	struct tx_queue_entry *entry;
>  =

>  	entry =3D tx_queue_entry_new(list, flags, cb, data, destroy);
> @@ -1773,7 +1811,7 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, G=
SList *list,
>  =

>  	g_queue_push_tail(sms->txq, entry);
>  =

> -	if (g_queue_get_length(sms->txq) =3D=3D 1)
> +	if (ofono_modem_get_online(modem) && g_queue_get_length(sms->txq) =3D=
=3D 1)
>  		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
>  =

>  	if (uuid)

Regards,
-Denis

--===============8231030452218222551==--

