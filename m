Content-Type: multipart/mixed; boundary="===============4776997455426859203=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 18/23] SMS: rename tx_queue_entry->msg to ->dbus_msg for
 clarity
Date: Fri, 25 Jun 2010 16:15:40 -0700
Message-ID: <ad54f59b5a99b32e255a0c1506f2a09e75f0162b.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4776997455426859203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

'msg' gets too confusing: is it the SMS message, a D-Bus message?
---
 src/sms.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index faaacbe..4ad9e61 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -134,7 +134,7 @@ struct tx_queue_entry {
 	unsigned char cur_pdu;
 	unsigned int msg_id;
 	unsigned int retry;
-	DBusMessage *msg;
+	DBusMessage *dbus_msg;
 	gboolean status_report;
 	struct sms_address receiver;
 	char *name;
@@ -436,10 +436,10 @@ static DBusMessage *dbus_sms_msg_cancel(
 		return __ofono_error_invalid_args(msg);
 	sms_msg_cancel(sms_msg,
 		       do_network_cancel ? SMS_MSG_CANCEL_IN_NETWORK : 0);
-	sms_msg->msg =3D dbus_message_ref(msg);
+	sms_msg->dbus_msg =3D dbus_message_ref(msg);
 	__ofono_dbus_pending_reply(
-		&sms_msg->msg,
-		dbus_message_new_method_return(sms_msg->msg));
+		&sms_msg->dbus_msg,
+		dbus_message_new_method_return(sms_msg->dbus_msg));
 	return NULL;
 }
 =

@@ -507,9 +507,9 @@ static void tx_queue_entry_destroy(struct tx_queue_entr=
y *entry)
 	g_free(entry->pdus);
 	g_free(entry->name);
 	entry->state =3D __OFONO_SMS_TX_ST_INVALID;
-	if (entry->msg) {
-		dbus_message_unref(entry->msg);
-		entry->msg =3D NULL;
+	if (entry->dbus_msg) {
+		dbus_message_unref(entry->dbus_msg);
+		entry->dbus_msg =3D NULL;
 	}
 }
 =

@@ -543,8 +543,8 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 =

 		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_CANCELING);
 		entry =3D g_queue_pop_head(sms->txq);
-		__ofono_dbus_pending_reply(&entry->msg,
-					__ofono_error_failed(entry->msg));
+		__ofono_dbus_pending_reply(&entry->dbus_msg,
+					__ofono_error_failed(entry->dbus_msg));
 =

 		__ofono_history_sms_send_status(modem, entry->msg_id,
 					time(NULL),
@@ -578,8 +578,9 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 	}
 =

 	entry =3D g_queue_pop_head(sms->txq);
-	__ofono_dbus_pending_reply(&entry->msg,
-				dbus_message_new_method_return(entry->msg));
+	__ofono_dbus_pending_reply(
+		&entry->dbus_msg,
+		dbus_message_new_method_return(entry->dbus_msg));
 	__ofono_history_sms_send_status(modem, entry->msg_id,
 					time(NULL),
 					OFONO_HISTORY_SMS_STATUS_SUBMITTED);
@@ -817,7 +818,7 @@ static DBusMessage *dbus_SendMessage(DBusConnection *co=
nn, DBusMessage *msg,
 	if (sms_msg =3D=3D NULL)
 		return __ofono_error_invalid_format(msg);
 	/* Unreferenced upon tx_queue_entry_destroy() */
-	sms_msg->msg =3D dbus_message_ref(msg);
+	sms_msg->dbus_msg =3D dbus_message_ref(msg);
 	return NULL;
 }
 =

-- =

1.6.6.1


--===============4776997455426859203==--

