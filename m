Content-Type: multipart/mixed; boundary="===============3038047484733012459=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 1/2] dbus: Add Terminated error
Date: Thu, 06 Sep 2012 16:21:45 +0200
Message-ID: <1346941306-3168-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3038047484733012459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c  |    8 ++++++++
 src/ofono.h |    1 +
 2 files changed, 9 insertions(+)

diff --git a/src/dbus.c b/src/dbus.c
index 3f5c12d..1f9f9ba 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -409,6 +409,14 @@ DBusMessage *__ofono_error_not_recognized(DBusMessage =
*msg)
 					"String not recognized as USSD/SS");
 }
 =

+DBusMessage *__ofono_error_terminated_by_network(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
+					".Terminated",
+					"Operation is terminated by the"
+					" network");
+}
+
 DBusMessage *__ofono_error_from_error(const struct ofono_error *error,
 						DBusMessage *msg)
 {
diff --git a/src/ofono.h b/src/ofono.h
index aca81b4..e20d8fa 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -66,6 +66,7 @@ DBusMessage *__ofono_error_emergency_active(DBusMessage *=
msg);
 DBusMessage *__ofono_error_incorrect_password(DBusMessage *msg);
 DBusMessage *__ofono_error_not_allowed(DBusMessage *msg);
 DBusMessage *__ofono_error_not_recognized(DBusMessage *msg);
+DBusMessage *__ofono_error_terminated_by_network(DBusMessage *msg);
 =

 DBusMessage *__ofono_error_from_error(const struct ofono_error *error,
 						DBusMessage *msg);
-- =

1.7.9.5


--===============3038047484733012459==--

