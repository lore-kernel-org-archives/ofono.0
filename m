Content-Type: multipart/mixed; boundary="===============5355688891176907527=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 1/6] dbus: Add new D-Bus error message NotRegistered
Date: Wed, 02 Nov 2011 11:37:56 +0100
Message-ID: <1320230281-20743-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320230281-20743-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5355688891176907527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c  |    7 +++++++
 src/ofono.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index a96b595..be2833d 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -349,6 +349,13 @@ DBusMessage *__ofono_error_attach_in_progress(DBusMess=
age *msg)
 				"GPRS Attach is in progress");
 }
 =

+DBusMessage *__ofono_error_not_registered(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg,
+				OFONO_ERROR_INTERFACE ".NotRegistered",
+				"CDMA modem is not registered to the network");
+}
+
 DBusMessage *__ofono_error_canceled(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".Canceled",
diff --git a/src/ofono.h b/src/ofono.h
index bd45560..bfb534d 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -59,6 +59,7 @@ DBusMessage *__ofono_error_sim_not_ready(DBusMessage *msg=
);
 DBusMessage *__ofono_error_in_use(DBusMessage *msg);
 DBusMessage *__ofono_error_not_attached(DBusMessage *msg);
 DBusMessage *__ofono_error_attach_in_progress(DBusMessage *msg);
+DBusMessage *__ofono_error_not_registered(DBusMessage *msg);
 DBusMessage *__ofono_error_canceled(DBusMessage *msg);
 DBusMessage *__ofono_error_access_denied(DBusMessage *msg);
 DBusMessage *__ofono_error_emergency_active(DBusMessage *msg);
-- =

1.7.1


--===============5355688891176907527==--

