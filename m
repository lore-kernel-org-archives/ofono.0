Content-Type: multipart/mixed; boundary="===============1997163391554432913=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 1/4] service: Retrieve get_conversation() args
Date: Thu, 03 May 2012 15:20:00 +0200
Message-ID: <1336051203-15512-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1336051203-15512-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1997163391554432913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index 689a4e1..a8e818a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -703,6 +703,29 @@ static DBusMessage *get_conversation(DBusConnection *c=
onn,
 {
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
+	const char *number;
+	unsigned int count;
+
+	if (dbus_message_iter_init(dbus_msg, &iter) =3D=3D FALSE)
+		return __mms_error_invalid_args(dbus_msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __mms_error_invalid_args(dbus_msg);
+
+	dbus_message_iter_get_basic(&iter, &number);
+	if (number[0] =3D=3D '\0')
+		return __mms_error_invalid_args(dbus_msg);
+
+	if (valid_number_format(number) =3D=3D FALSE)
+		return __mms_error_invalid_args(dbus_msg);
+
+	if (!dbus_message_iter_next(&iter))
+		return __mms_error_invalid_args(dbus_msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_UINT32)
+		return __mms_error_invalid_args(dbus_msg);
+
+	dbus_message_iter_get_basic(&iter, &count);

 	reply =3D dbus_message_new_method_return(dbus_msg);
 	if (reply =3D=3D NULL)
--
1.7.4.1


--===============1997163391554432913==--

