Content-Type: multipart/mixed; boundary="===============0116989501344758275=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 2/4] service: Fill conversation list with messages
Date: Thu, 03 May 2012 15:20:01 +0200
Message-ID: <1336051203-15512-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1336051203-15512-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0116989501344758275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fill a GList with all messages of a conversation based on number param.
A message is a member of a conversation if the given number belongs to
its recipients list (this is what is_recipient() checks).
'-' and '.' are valid chars in a phone number but they have to be
ignored during checking. To be eligible, a message must have the number
in recipients list AND the number must ends the matched recipient in the
recipients list (ex: a message with "+33612345678/TYPE=3DPLMN" in its
recipients is member of a conversation where the given number is
"12345678" BUT not if the given number is "1234567").

---
 src/service.c |   94 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 93 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index a8e818a..93beceb 100644
--- a/src/service.c
+++ b/src/service.c
@@ -698,13 +698,91 @@ static DBusMessage *get_messages(DBusConnection *conn,
 	return reply;
 }

+static gboolean is_recipient(const char *recipients, const char *number)
+{
+	const char *subrecpts, *subnum;
+
+	/*
+	 * Search for "number" substring in "recipients" string,
+	 * ignoring '-' and '.' which are valid chars in a phone number
+	 */
+	while (*recipients !=3D '\0') {
+		subrecpts =3D recipients;
+		subnum =3D number;
+
+		while (*subrecpts !=3D '\0' && *subnum !=3D '\0') {
+			if (*subrecpts =3D=3D *subnum) {
+				subrecpts++;
+				subnum++;
+			} else {
+				if (*subrecpts =3D=3D '-' || *subrecpts =3D=3D '.') {
+					subrecpts++;
+					continue;
+				}
+
+				if (*subnum =3D=3D '-' || *subnum =3D=3D '.') {
+					subnum++;
+					continue;
+				}
+
+				if (*subrecpts !=3D *number)
+					subrecpts++;
+
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
+		if (*subnum =3D=3D '\0' && *subrecpts =3D=3D '/')
+			return TRUE;
+
+		recipients =3D subrecpts;
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

 	if (dbus_message_iter_init(dbus_msg, &iter) =3D=3D FALSE)
 		return __mms_error_invalid_args(dbus_msg);
@@ -736,6 +814,20 @@ static DBusMessage *get_conversation(DBusConnection *c=
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


--===============0116989501344758275==--

