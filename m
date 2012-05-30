Content-Type: multipart/mixed; boundary="===============3766707183339925901=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 1/2] dbus: Add __ofono_error_from_error utility function
Date: Wed, 30 May 2012 15:53:09 +0200
Message-ID: <1338385990-27526-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3766707183339925901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c  |   42 ++++++++++++++++++++++++++++++++++++++++++
 src/ofono.h |    3 +++
 2 files changed, 45 insertions(+)

diff --git a/src/dbus.c b/src/dbus.c
index 5cccc32..4ae6969 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -32,6 +32,21 @@
 =

 static DBusConnection *g_connection;
 =

+struct error_mapping_entry {
+	int error;
+	DBusMessage *(*ofono_error_func)(DBusMessage *);
+};
+
+struct error_mapping_entry cme_errors_mapping[] =3D {
+	{ 3,	__ofono_error_not_allowed },
+	{ 4,	__ofono_error_not_supported },
+	{ 16,	__ofono_error_incorrect_password },
+	{ 30,	__ofono_error_not_registered },
+	{ 31,	__ofono_error_timed_out },
+	{ 32,	__ofono_error_access_denied },
+	{ 50,	__ofono_error_invalid_args },
+};
+
 static void append_variant(DBusMessageIter *iter,
 				int type, void *value)
 {
@@ -388,6 +403,33 @@ DBusMessage *__ofono_error_not_allowed(DBusMessage *ms=
g)
 					"Operation is not allowed");
 }
 =

+DBusMessage *__ofono_error_from_error(const struct ofono_error *error,
+						DBusMessage *msg)
+{
+	struct error_mapping_entry *e;
+	int maxentries;
+	int i;
+
+	switch (error->type) {
+	case OFONO_ERROR_TYPE_CME:
+		e =3D cme_errors_mapping;
+		maxentries =3D sizeof(cme_errors_mapping) /
+					sizeof(struct error_mapping_entry);
+		for (i =3D 0; i < maxentries; i++)
+			if (e[i].error =3D=3D error->error)
+				return e[i].ofono_error_func(msg);
+		break;
+	case OFONO_ERROR_TYPE_CMS:
+		return __ofono_error_failed(msg);
+	case OFONO_ERROR_TYPE_CEER:
+		return __ofono_error_failed(msg);
+	default:
+		return __ofono_error_failed(msg);
+	}
+
+	return __ofono_error_failed(msg);
+}
+
 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
diff --git a/src/ofono.h b/src/ofono.h
index 81d5f71..f0e1072 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -66,6 +66,9 @@ DBusMessage *__ofono_error_emergency_active(DBusMessage *=
msg);
 DBusMessage *__ofono_error_incorrect_password(DBusMessage *msg);
 DBusMessage *__ofono_error_not_allowed(DBusMessage *msg);
 =

+DBusMessage *__ofono_error_from_error(const struct ofono_error *error,
+						DBusMessage *msg);
+
 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
 =

 gboolean __ofono_dbus_valid_object_path(const char *path);
-- =

1.7.9.5


--===============3766707183339925901==--

