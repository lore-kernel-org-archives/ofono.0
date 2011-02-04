Content-Type: multipart/mixed; boundary="===============3348662921222247101=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/7] sms: factor out 'remove entry' from tx_finished()
Date: Fri, 04 Feb 2011 13:02:41 -0200
Message-ID: <1296831764-6554-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296831764-6554-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3348662921222247101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Refactor tx_finished() and create a function to remove an entry from the
tx queue. This function will be used also when a message is cancelled.
Thus, handle the case in which state is MESSAGE_STATE_CANCELLED as well.

Based on patch from Yang Gu <gyagp0@gmail.com>
---
 src/sms.c |   99 ++++++++++++++++++++++++++++++++++++---------------------=
---
 1 files changed, 59 insertions(+), 40 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 73e067e..7db91cb 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -65,6 +65,7 @@ struct ofono_sms {
 	struct sms_assembly *assembly;
 	guint ref;
 	GQueue *txq;
+	enum message_state tx_state;
 	unsigned long tx_counter;
 	guint tx_source;
 	struct ofono_message_waiting *mw;
@@ -538,15 +539,65 @@ static void tx_queue_entry_destroy_foreach(gpointer _=
entry, gpointer unused)
 	tx_queue_entry_destroy(_entry);
 }
 =

+static void sms_tx_queue_remove_entry(struct ofono_sms *sms, GList *entry_=
list)
+{
+	struct tx_queue_entry *entry =3D entry_list->data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
+
+	g_queue_delete_link(sms->txq, entry_list);
+
+	DBG("%p", entry);
+
+	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY) {
+		enum ofono_history_sms_status hs;
+
+		switch(sms->tx_state) {
+		case MESSAGE_STATE_SENT:
+			hs =3D OFONO_HISTORY_SMS_STATUS_SUBMITTED;
+			break;
+		case MESSAGE_STATE_FAILED:
+			hs =3D OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED;
+			break;
+		case MESSAGE_STATE_CANCELLED:
+			hs =3D OFONO_HISTORY_SMS_STATUS_SUBMIT_CANCELLED;
+			break;
+		default:
+			ofono_error("Unexpected sms state %d", sms->tx_state);
+
+			return;
+		}
+
+		__ofono_history_sms_send_status(modem, &entry->uuid,
+								time(NULL), hs);
+	}
+
+	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
+		struct message *m;
+
+		sms_tx_backup_free(sms->imsi, entry->id, entry->flags,
+					ofono_uuid_to_str(&entry->uuid));
+
+		m =3D g_hash_table_lookup(sms->messages, &entry->uuid);
+
+		if (m !=3D NULL) {
+			message_set_state(m, sms->tx_state);
+			g_hash_table_remove(sms->messages, &entry->uuid);
+			message_emit_removed(m,
+					OFONO_MESSAGE_MANAGER_INTERFACE);
+			message_dbus_unregister(m);
+		}
+	}
+
+	tx_queue_entry_destroy(entry);
+}
+
 static void tx_finished(const struct ofono_error *error, int mr, void *dat=
a)
 {
 	struct ofono_sms *sms =3D data;
-	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
 	struct tx_queue_entry *entry =3D g_queue_peek_head(sms->txq);
 	gboolean ok =3D error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR;
-	struct message *m =3D NULL;
 =

-	DBG("tx_finished");
+	DBG("tx_finished %p", entry);
 =

 	if (ok =3D=3D FALSE) {
 		/* Retry again when back in online mode */
@@ -554,6 +605,8 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 		if (sms->registered =3D=3D FALSE)
 			return;
 =

+		sms->tx_state =3D MESSAGE_STATE_FAILED;
+
 		if (!(entry->flags & OFONO_SMS_SUBMIT_FLAG_RETRY))
 			goto next_q;
 =

@@ -591,47 +644,13 @@ static void tx_finished(const struct ofono_error *err=
or, int mr, void *data)
 		return;
 	}
 =

-next_q:
-	entry =3D g_queue_pop_head(sms->txq);
+	sms->tx_state =3D MESSAGE_STATE_SENT;
 =

+next_q:
 	if (entry->cb)
 		entry->cb(ok, entry->data);
 =

-	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY) {
-		enum ofono_history_sms_status hs;
-
-		if (ok)
-			hs =3D OFONO_HISTORY_SMS_STATUS_SUBMITTED;
-		else
-			hs =3D OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED;
-
-		__ofono_history_sms_send_status(modem, &entry->uuid,
-						time(NULL), hs);
-	}
-
-	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
-		enum message_state ms;
-
-		sms_tx_backup_free(sms->imsi, entry->id, entry->flags,
-					ofono_uuid_to_str(&entry->uuid));
-
-		if (ok)
-			ms =3D MESSAGE_STATE_SENT;
-		else
-			ms =3D MESSAGE_STATE_FAILED;
-
-		m =3D g_hash_table_lookup(sms->messages, &entry->uuid);
-
-		if (m !=3D NULL) {
-			message_set_state(m, ms);
-			g_hash_table_remove(sms->messages, &entry->uuid);
-			message_emit_removed(m,
-					OFONO_MESSAGE_MANAGER_INTERFACE);
-			message_dbus_unregister(m);
-		}
-	}
-
-	tx_queue_entry_destroy(entry);
+	sms_tx_queue_remove_entry(sms, g_queue_peek_head_link(sms->txq));
 =

 	if (sms->registered =3D=3D FALSE)
 		return;
-- =

1.7.4


--===============3348662921222247101==--

