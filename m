Content-Type: multipart/mixed; boundary="===============8984895571734385454=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv1 3/5] service: Fill conversation list with messages
Date: Wed, 25 Apr 2012 11:01:51 +0200
Message-ID: <1335344513-2347-4-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1335344513-2347-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8984895571734385454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index 18c11f4..2787c3a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -719,13 +719,85 @@ static gboolean get_conversation_get_args(DBusMessage=
 *dbus_msg,
 	return TRUE;
 }

+static gboolean is_recipient(const char *recipients, const char *number)
+{
+	const char *rec, *num;
+
+	while (*recipients !=3D '\0') {
+		rec =3D recipients;
+		num =3D number;
+
+		while (*rec !=3D '\0' && *num !=3D '\0') {
+			if (*rec =3D=3D *num) {
+				rec++;
+				num++;
+			} else {
+				if (*rec =3D=3D '-' || *rec =3D=3D '.') {
+					rec++;
+					continue;
+				}
+
+				if (*num =3D=3D '-' || *num =3D=3D '.') {
+					num++;
+					continue;
+				}
+
+				rec++;
+				break;
+			}
+		}
+
+		/*
+		 * Phone numbers in recipients end with /TYPE=3DPLMN, so the
+		 * wanted number is found if the whole string number is found
+		 * and if the matched phone number ends with the wanted number
+		 * (i.e.: "/TYPE=3DPLMN" must follow).
+		 */
+		if (*num =3D=3D '\0' && *rec =3D=3D '/')
+			return TRUE;
+
+		recipients =3D rec;
+	}
+
+	return FALSE;
+}
+
+static GList *fill_conversation(const struct mms_service *service,
+				GList *conversation, const char *number)
+{
+	GHashTableIter table_iter;
+	gpointer key, value;
+
+	g_hash_table_iter_init(&table_iter, service->messages);
+	while (g_hash_table_iter_next(&table_iter, &key, &value)) {
+		struct mms_message *msg =3D value;
+		char *recipients;
+
+		if (msg->type =3D=3D MMS_MESSAGE_TYPE_SEND_REQ)
+			recipients =3D msg->sr.to;
+		else if (msg->type =3D=3D MMS_MESSAGE_TYPE_RETRIEVE_CONF)
+			recipients =3D msg->rc.from;
+		else
+			continue;
+
+		if (is_recipient(recipients, number) =3D=3D TRUE)
+			conversation =3D g_list_prepend(conversation, value);
+	}
+
+	return conversation;
+}
+
 static DBusMessage *get_conversation(DBusConnection *conn,
 					DBusMessage *dbus_msg, void *data)
 {
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
+	const struct mms_service *service =3D data;
+	struct mms_message *msg;
+	GList *msg_elt =3D NULL;
+	GList *conversation =3D NULL;
 	const char *number;
-	unsigned int count;
+	unsigned int count, i;

 	if (get_conversation_get_args(dbus_msg, &number, &count) =3D=3D FALSE) {
 		mms_debug("Invalid arguments");
@@ -742,6 +814,20 @@ static DBusMessage *get_conversation(DBusConnection *c=
onn,
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
 							"(oa{sv})", &array);

+	conversation =3D fill_conversation(service, conversation, number);
+	if (conversation =3D=3D NULL)
+		goto out;
+
+	i =3D 0;
+
+	for (msg_elt =3D g_list_first(conversation); msg_elt !=3D NULL;
+					msg_elt =3D g_list_next(msg_elt), i++) {
+		if (count !=3D 0 && i =3D=3D count)
+			break;
+		msg =3D msg_elt->data;
+		append_message_entry(msg->path, service, msg, &array);
+	}
+out:
 	dbus_message_iter_close_container(&iter, &array);

 	return reply;
--
1.7.4.1


--===============8984895571734385454==--

