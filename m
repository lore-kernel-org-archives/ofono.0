Content-Type: multipart/mixed; boundary="===============0795800980898011814=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv1 2/5] service: Retrieve get_conversation() args
Date: Wed, 25 Apr 2012 11:01:50 +0200
Message-ID: <1335344513-2347-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1335344513-2347-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0795800980898011814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index 24c89b6..18c11f4 100644
--- a/src/service.c
+++ b/src/service.c
@@ -690,11 +690,48 @@ static DBusMessage *get_messages(DBusConnection *conn,
 	return reply;
 }

+static gboolean get_conversation_get_args(DBusMessage *dbus_msg,
+				const char **number, unsigned int *count)
+{
+	DBusMessageIter top_iter;
+
+	if (dbus_message_iter_init(dbus_msg, &top_iter) =3D=3D FALSE)
+		return FALSE;
+
+	if (dbus_message_iter_get_arg_type(&top_iter) !=3D DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&top_iter, number);
+	if (*number[0] =3D=3D '\0')
+		return FALSE;
+
+	if (valid_number_format(*number) =3D=3D FALSE)
+		return FALSE;
+
+	if (!dbus_message_iter_next(&top_iter))
+		return FALSE;
+
+	if (dbus_message_iter_get_arg_type(&top_iter) !=3D DBUS_TYPE_UINT32)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&top_iter, count);
+
+	return TRUE;
+}
+
 static DBusMessage *get_conversation(DBusConnection *conn,
 					DBusMessage *dbus_msg, void *data)
 {
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
+	const char *number;
+	unsigned int count;
+
+	if (get_conversation_get_args(dbus_msg, &number, &count) =3D=3D FALSE) {
+		mms_debug("Invalid arguments");
+
+		return __mms_error_invalid_args(dbus_msg);
+	}

 	reply =3D dbus_message_new_method_return(dbus_msg);
 	if (reply =3D=3D NULL)
--
1.7.4.1


--===============0795800980898011814==--

