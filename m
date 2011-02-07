Content-Type: multipart/mixed; boundary="===============7590437425378630770=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 3/7] gprs: let the modems automatically attach when activating
 a context
Date: Mon, 07 Feb 2011 16:03:08 +0200
Message-ID: <1297087392-31030-3-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201102071602.20179.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7590437425378630770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If some really stupid modem does not support attach on demand, this
really should be worked around in the specific driver (at least
AT and ISI modems support this).
---
 src/dbus.c  |   13 -------------
 src/gprs.c  |    6 ------
 src/ofono.h |    2 --
 3 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index 01d43cf..a635121 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -336,19 +336,6 @@ DBusMessage *__ofono_error_in_use(DBusMessage *msg)
 			"The resource is currently in use");
 }
 =

-DBusMessage *__ofono_error_not_attached(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".NotAttached",
-			"GPRS is not attached");
-}
-
-DBusMessage *__ofono_error_attach_in_progress(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg,
-				OFONO_ERROR_INTERFACE ".AttachInProgress",
-				"GPRS Attach is in progress");
-}
-
 DBusMessage *__ofono_error_canceled(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".Canceled",
diff --git a/src/gprs.c b/src/gprs.c
index b6003f7..0a137b2 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1067,12 +1067,6 @@ static DBusMessage *pri_set_property(DBusConnection =
*conn,
 		if (ctx->active =3D=3D (ofono_bool_t) value)
 			return dbus_message_new_method_return(msg);
 =

-		if (value && !ctx->gprs->attached)
-			return __ofono_error_not_attached(msg);
-
-		if (ctx->gprs->flags & GPRS_FLAG_ATTACHING)
-			return __ofono_error_attach_in_progress(msg);
-
 		if (value) {
 			if (assign_context(ctx) =3D=3D FALSE)
 				return __ofono_error_not_implemented(msg);
diff --git a/src/ofono.h b/src/ofono.h
index 6ba0187..bf2e6fe 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -54,8 +54,6 @@ DBusMessage *__ofono_error_not_available(DBusMessage *msg=
);
 DBusMessage *__ofono_error_timed_out(DBusMessage *msg);
 DBusMessage *__ofono_error_sim_not_ready(DBusMessage *msg);
 DBusMessage *__ofono_error_in_use(DBusMessage *msg);
-DBusMessage *__ofono_error_not_attached(DBusMessage *msg);
-DBusMessage *__ofono_error_attach_in_progress(DBusMessage *msg);
 DBusMessage *__ofono_error_canceled(DBusMessage *msg);
 DBusMessage *__ofono_error_access_denied(DBusMessage *msg);
 =

-- =

1.7.1


--===============7590437425378630770==--

