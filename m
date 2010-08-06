Content-Type: multipart/mixed; boundary="===============3665786970581764413=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 02/17] sms: _txq_submit() returns pointer to object
Date: Thu, 05 Aug 2010 17:55:24 -0700
Message-ID: <f42fb8fee0af7c501fe3757550074a530b58a539.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3665786970581764413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This makes __ofono_sms_txq_submit() return a pointer to the newly
allocated message object, from where the message ID can be recovered.

This is needed for future commits where the object pointer is needed
to use it as the handle for the D-Bus wrapping functionality. This
allows for an effective and simple implementation.
---
 src/ofono.h |   10 ++++++----
 src/sms.c   |   19 +++++++++++--------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index aaa01d9..6fba8c3 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -185,10 +185,12 @@ enum ofono_sms_submit_flag {
 =

 typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
 =

-unsigned int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *list,
-					unsigned int flags,
-					ofono_sms_txq_submit_cb_t cb,
-					void *data, ofono_destroy_func destroy);
+struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
+						GSList *list,
+						unsigned int flags,
+						ofono_sms_txq_submit_cb_t cb,
+						void *data,
+						ofono_destroy_func destroy);
 =

 #include <ofono/sim.h>
 #include <ofono/stk.h>
diff --git a/src/sms.c b/src/sms.c
index f5c3162..dce7d36 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -654,7 +654,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	int ref_offset;
 	struct ofono_modem *modem;
 	unsigned int flags;
-	unsigned int msg_id;
+	struct tx_queue_entry *sms_msg;
 =

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
 					DBUS_TYPE_STRING, &text,
@@ -685,7 +685,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	if (sms->use_delivery_reports)
 		flags |=3D OFONO_SMS_SUBMIT_FLAG_REQUEST_SR;
 =

-	msg_id =3D __ofono_sms_txq_submit(sms, msg_list, flags, send_message_cb,
+	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags, send_message_cb,
 						dbus_message_ref(msg),
 						send_message_destroy);
 =

@@ -693,7 +693,8 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	g_slist_free(msg_list);
 =

 	modem =3D __ofono_atom_get_modem(sms->atom);
-	__ofono_history_sms_send_pending(modem, msg_id, to, time(NULL), text);
+	__ofono_history_sms_send_pending(modem, sms_msg->msg_id, to,
+						time(NULL), text);
 =

 	return NULL;
 }
@@ -1371,10 +1372,12 @@ void *ofono_sms_get_data(struct ofono_sms *sms)
 	return sms->driver_data;
 }
 =

-unsigned int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *list,
-					unsigned int flags,
-					ofono_sms_txq_submit_cb_t cb,
-					void *data, ofono_destroy_func destroy)
+struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
+						GSList *list,
+						unsigned int flags,
+						ofono_sms_txq_submit_cb_t cb,
+						void *data,
+						ofono_destroy_func destroy)
 {
 	struct tx_queue_entry *entry =3D tx_queue_entry_new(list);
 =

@@ -1395,5 +1398,5 @@ unsigned int __ofono_sms_txq_submit(struct ofono_sms =
*sms, GSList *list,
 	if (g_queue_get_length(sms->txq) =3D=3D 1)
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 =

-	return entry->msg_id;
+	return entry;
 }
-- =

1.6.6.1


--===============3665786970581764413==--

