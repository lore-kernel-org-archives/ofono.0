Content-Type: multipart/mixed; boundary="===============6236758657347317286=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 03/19] sms: implement SHA256-based message IDs
 [incomplete]
Date: Thu, 05 Aug 2010 12:20:34 -0500
Message-ID: <4C5AF2E2.2090009@gmail.com>
In-Reply-To: <91ce0be38ecd281e810284966d0f285ad187db23.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6236758657347317286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 08/03/2010 06:50 PM, Inaky Perez-Gonzalez wrote:
> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> This patch removes the sequential SMS message identification gig and
> replaces it with a 16-bit hash cookie based off message contents.
> =

> FIXME: [incomplete] need to figure out how to do so that identical
> messages sent to different or the same numbers also have a different
> ID.
> ---
>  src/ofono.h |    9 +++++----
>  src/sms.c   |   55 +++++++++++++++++++++++------------------------------=
--
>  src/stk.c   |    5 +++--
>  3 files changed, 31 insertions(+), 38 deletions(-)
> =

> diff --git a/src/ofono.h b/src/ofono.h
> index aaa01d9..b73797b 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -185,10 +185,11 @@ enum ofono_sms_submit_flag {
>  =

>  typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
>  =

> -unsigned int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *list,
> -					unsigned int flags,
> -					ofono_sms_txq_submit_cb_t cb,
> -					void *data, ofono_destroy_func destroy);
> +struct tx_queue_entry *__ofono_sms_txq_submit(
> +	struct ofono_sms *sms, GSList *list,
> +	unsigned int flags, unsigned ref,
> +	ofono_sms_txq_submit_cb_t cb,
> +	void *data, ofono_destroy_func destroy);

As I said before, please don't mess with this function.

>  =

>  #include <ofono/sim.h>
>  #include <ofono/stk.h>
> diff --git a/src/sms.c b/src/sms.c
> index 35364db..39d4a32 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -55,7 +55,6 @@ struct ofono_sms {
>  	DBusMessage *pending;
>  	struct ofono_phone_number sca;
>  	struct sms_assembly *assembly;
> -	unsigned int next_msg_id;
>  	guint ref;
>  	GQueue *txq;
>  	gint tx_source;
> @@ -589,7 +588,8 @@ static DBusMessage *sms_send_message(DBusConnection *=
conn, DBusMessage *msg,
>  	int ref_offset;
>  	struct ofono_modem *modem;
>  	unsigned int flags;
> -	unsigned int msg_id;
> +	guint16 msg_id;
> +	struct tx_queue_entry *sms_msg;
>  =

>  	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
>  					DBUS_TYPE_STRING, &text,
> @@ -605,24 +605,19 @@ static DBusMessage *sms_send_message(DBusConnection=
 *conn, DBusMessage *msg,
>  	if (!msg_list)
>  		return __ofono_error_invalid_format(msg);
>  =

> -	set_ref_and_to(msg_list, sms->ref, ref_offset, to);
> -	DBG("ref: %d, offset: %d", sms->ref, ref_offset);
> -
> -	if (ref_offset !=3D 0) {
> -		if (sms->ref =3D=3D 65536)
> -			sms->ref =3D 1;
> -		else
> -			sms->ref =3D sms->ref + 1;
> -	}
> +	msg_id =3D sms_uuid_from_pdu_list(msg_list);

You're calculating the ID before setting the ref and to? That is pretty
silly ;)

> +	set_ref_and_to(msg_list, msg_id, ref_offset, to);
> +	DBG("SMS ID: 0x%04x", msg_id);
>  =

>  	flags =3D OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY;
>  	flags |=3D OFONO_SMS_SUBMIT_FLAG_RETRY;
>  	if (sms->use_delivery_reports)
>  		flags |=3D OFONO_SMS_SUBMIT_FLAG_REQUEST_SR;
>  =

> -	msg_id =3D __ofono_sms_txq_submit(sms, msg_list, flags, send_message_cb,
> -						dbus_message_ref(msg),
> -						send_message_destroy);
> +	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags, msg_id,
> +					 send_message_cb,
> +					 dbus_message_ref(msg),
> +					 send_message_destroy);

Make the ID calculation happen inside tx_queue_entry_new.  That function
already converts all the SMS objects into a PDU.  So simply hashing the
PDUs there would be very easy.

>  =

>  	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
>  	g_slist_free(msg_list);
> @@ -659,7 +654,7 @@ static void dispatch_app_datagram(struct ofono_sms *s=
ms, int dst, int src,
>  }
>  =

>  static void dispatch_text_message(struct ofono_sms *sms,
> -					const char *message,
> +					const char *message, guint16 msg_id,
>  					enum sms_class cls,
>  					const struct sms_address *addr,
>  					const struct sms_scts *scts)
> @@ -717,11 +712,9 @@ static void dispatch_text_message(struct ofono_sms *=
sms,
>  =

>  	g_dbus_send_message(conn, signal);
>  =

> -	if (cls !=3D SMS_CLASS_0) {
> -		__ofono_history_sms_received(modem, sms->next_msg_id, str,
> +	if (cls !=3D SMS_CLASS_0)
> +		__ofono_history_sms_received(modem, msg_id, str,
>  						&remote, &local, message);
> -		sms->next_msg_id +=3D 1;
> -	}
>  }
>  =

>  static void sms_dispatch(struct ofono_sms *sms, GSList *sms_list)
> @@ -732,6 +725,7 @@ static void sms_dispatch(struct ofono_sms *sms, GSLis=
t *sms_list)
>  	enum sms_class cls;
>  	int srcport =3D -1;
>  	int dstport =3D -1;
> +	guint16 msg_id;
>  =

>  	if (sms_list =3D=3D NULL)
>  		return;
> @@ -749,6 +743,7 @@ static void sms_dispatch(struct ofono_sms *sms, GSLis=
t *sms_list)
>  	 * used, the addresses are the same across all segments.
>  	 */
>  =

> +	msg_id =3D sms_uuid_from_pdu_list(sms_list);
>  	for (l =3D sms_list; l; l =3D l->next) {
>  		guint8 dcs;
>  		gboolean comp =3D FALSE;
> @@ -825,8 +820,8 @@ static void sms_dispatch(struct ofono_sms *sms, GSLis=
t *sms_list)
>  =

>  		s =3D sms_list->data;
>  =

> -		dispatch_text_message(sms, message, cls, &s->deliver.oaddr,
> -					&s->deliver.scts);
> +		dispatch_text_message(sms, message, msg_id, cls,
> +					&s->deliver.oaddr, &s->deliver.scts);
>  		g_free(message);
>  	}
>  }
> @@ -1104,8 +1099,6 @@ static void sms_remove(struct ofono_atom *atom)
>  =

>  	if (sms->settings) {
>  		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
> -					"NextMessageId", sms->next_msg_id);
> -		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
>  					"NextReference", sms->ref);
>  		g_key_file_set_boolean(sms->settings, SETTINGS_GROUP,
>  					"UseDeliveryReports",
> @@ -1201,9 +1194,6 @@ static void sms_load_settings(struct ofono_sms *sms=
, const char *imsi)
>  =

>  	sms->imsi =3D g_strdup(imsi);
>  =

> -	sms->next_msg_id =3D g_key_file_get_integer(sms->settings, SETTINGS_GRO=
UP,
> -							"NextMessageId", NULL);
> -
>  	sms->ref =3D g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
>  							"NextReference", NULL);
>  	if (sms->ref >=3D 65536)
> @@ -1306,10 +1296,11 @@ void *ofono_sms_get_data(struct ofono_sms *sms)
>  	return sms->driver_data;
>  }
>  =

> -unsigned int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *list,
> -					unsigned int flags,
> -					ofono_sms_txq_submit_cb_t cb,
> -					void *data, ofono_destroy_func destroy)
> +struct tx_queue_entry *__ofono_sms_txq_submit(
> +	struct ofono_sms *sms, GSList *list,
> +	unsigned int flags, unsigned msg_id,
> +	ofono_sms_txq_submit_cb_t cb,
> +	void *data, ofono_destroy_func destroy)
>  {
>  	struct tx_queue_entry *entry =3D tx_queue_entry_new(list);
>  =

> @@ -1320,7 +1311,7 @@ unsigned int __ofono_sms_txq_submit(struct ofono_sm=
s *sms, GSList *list,
>  				sizeof(entry->receiver));
>  	}
>  =

> -	entry->msg_id =3D sms->next_msg_id++;
> +	entry->msg_id =3D msg_id;
>  	entry->flags =3D flags;
>  	entry->cb =3D cb;
>  	entry->data =3D data;
> @@ -1331,5 +1322,5 @@ unsigned int __ofono_sms_txq_submit(struct ofono_sm=
s *sms, GSList *list,
>  	if (g_queue_get_length(sms->txq) =3D=3D 1)
>  		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
>  =

> -	return entry->msg_id;
> +	return entry;
>  }
> diff --git a/src/stk.c b/src/stk.c
> index 556dc68..620811b 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -323,6 +323,7 @@ static gboolean handle_command_send_sms(const struct =
stk_command *cmd,
>  	struct ofono_atom *sms_atom;
>  	struct ofono_sms *sms;
>  	GSList msg_list;
> +	guint16 msg_id;
>  =

>  	sms_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SMS);
>  =

> @@ -338,8 +339,8 @@ static gboolean handle_command_send_sms(const struct =
stk_command *cmd,
>  =

>  	msg_list.data =3D (void *) &cmd->send_sms.gsm_sms;
>  	msg_list.next =3D NULL;
> -
> -	__ofono_sms_txq_submit(sms, &msg_list, 0, send_sms_submit_cb,
> +	msg_id =3D sms_uuid_from_pdu_list(&msg_list);
> +	__ofono_sms_txq_submit(sms, &msg_list, 0, msg_id, send_sms_submit_cb,
>  				stk->sms_submit_req, g_free);
>  =

>  	stk->cancel_cmd =3D send_sms_cancel;

Regards,
-Denis

--===============6236758657347317286==--

