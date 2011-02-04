Content-Type: multipart/mixed; boundary="===============1470443199422683387=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 5/7] sms: allow message submission to be cancelled
Date: Fri, 04 Feb 2011 13:02:42 -0200
Message-ID: <1296831764-6554-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296831764-6554-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1470443199422683387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on patch from Yang Gu <gyagp0@gmail.com>
---
 src/sms.c |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 7db91cb..91b0a31 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -685,6 +685,8 @@ static gboolean tx_next(gpointer user_data)
 			|| (entry->num_pdus - entry->cur_pdu) > 1)
 		send_mms =3D 1;
 =

+	sms->tx_state =3D MESSAGE_STATE_PENDING;
+
 	sms->driver->submit(sms, pdu->pdu, pdu->pdu_len, pdu->tpdu_len,
 				send_mms, tx_finished, sms);
 =

@@ -970,6 +972,85 @@ static DBusMessage *sms_get_messages(DBusConnection *c=
onn, DBusMessage *msg,
 	return reply;
 }
 =

+static gboolean uuid_from_message_path(const char *path,
+						struct ofono_uuid *uuid)
+{
+	const char *uuidstr;
+
+	uuidstr =3D path + strlen(path) - OFONO_SHA1_UUID_LEN * 2;
+
+	if (decode_hex_own_buf(uuidstr, -1, NULL, 0, uuid->uuid) =3D=3D NULL)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gint entry_compare_by_uuid(gconstpointer a, gconstpointer b)
+{
+	const struct tx_queue_entry *entry =3D a;
+	const char *uuid =3D b;
+
+	return memcmp(&entry->uuid, uuid, sizeof(entry->uuid));
+}
+
+static DBusMessage *sms_cancel_message(DBusConnection *conn, DBusMessage *=
msg,
+								void *data)
+{
+	struct ofono_sms *sms =3D data;
+	char *path;
+	struct ofono_uuid uuid;
+	GList *l;
+	struct tx_queue_entry *entry;
+
+	if (sms->pending)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (path[0] =3D=3D '\0')
+		return __ofono_error_invalid_args(msg);
+
+	if (uuid_from_message_path(path, &uuid) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	l =3D g_queue_find_custom(sms->txq, uuid.uuid, entry_compare_by_uuid);
+
+	if (l =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	entry =3D l->data;
+
+	if (entry =3D=3D g_queue_peek_head(sms->txq)) {
+		/*
+		 * Fail if any pdu was already transmitted or if we are
+		 * waiting the answer from driver.
+		 */
+		if (entry->cur_pdu > 0 ||
+					sms->tx_state =3D=3D MESSAGE_STATE_PENDING)
+			return __ofono_error_failed(msg);
+
+		/*
+		 * Make sure we don't call tx_next() if there are no entries
+		 * and that next entry doesn't have to wait a 'retry time'
+		 * from this one.
+		 */
+		if (sms->tx_source) {
+			g_source_remove(sms->tx_source);
+			sms->tx_source =3D 0;
+
+			if (g_queue_get_length(sms->txq) > 1)
+				sms->tx_source =3D g_timeout_add(0, tx_next, sms);
+		}
+	}
+
+	sms->tx_state =3D MESSAGE_STATE_CANCELLED;
+	sms_tx_queue_remove_entry(sms, l);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable sms_manager_methods[] =3D {
 	{ "GetProperties",    "",    "a{sv}",        sms_get_properties,
 						G_DBUS_METHOD_FLAG_ASYNC },
@@ -977,6 +1058,7 @@ static GDBusMethodTable sms_manager_methods[] =3D {
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SendMessage",      "ss",  "o",             sms_send_message,
 						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "CancelMessage",    "o",   "",              sms_cancel_message },
 	{ "GetMessages",       "",    "a(oa{sv})",    sms_get_messages },
 	{ }
 };
-- =

1.7.4


--===============1470443199422683387==--

