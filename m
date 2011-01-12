Content-Type: multipart/mixed; boundary="===============8734949907818650284=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 14/21] gprs: Refactor to share remove_context method
Date: Wed, 12 Jan 2011 18:15:57 +0100
Message-ID: <1294852564-1258-15-git-send-email-frederic.dalleau@intel.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8734949907818650284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zhenhua Zhang <zhenhua.zhang@intel.com>

Remove duplicated code in gprs_deactivate_for_remove and
gprs_remove_context. So they could share the same remove_context method.
---
 src/gprs.c |   59 +++++++++++++++++++++++++++++---------------------------=
---
 1 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 830e143..05e1c70 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1652,26 +1652,14 @@ static DBusMessage *gprs_add_context(DBusConnection=
 *conn,
 	return NULL;
 }
 =

-static void gprs_deactivate_for_remove(const struct ofono_error *error,
-						void *data)
+static void remove_context(struct pri_context *ctx)
 {
-	struct pri_context *ctx =3D data;
 	struct ofono_gprs *gprs =3D ctx->gprs;
 	DBusConnection *conn;
 	char *path;
 	const char *atompath;
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("Removing context failed with error: %s",
-				telephony_error_to_str(error));
-
-		__ofono_dbus_pending_reply(&gprs->pending,
-					__ofono_error_failed(gprs->pending));
-		return;
-	}
-
-	gprs_cid_release(gprs, ctx->context.cid);
-	ctx->context.cid =3D 0;
+	DBG("%s", ctx->path);
 =

 	if (gprs->settings) {
 		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
@@ -1684,9 +1672,6 @@ static void gprs_deactivate_for_remove(const struct o=
fono_error *error,
 	context_dbus_unregister(ctx);
 	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
 =

-	__ofono_dbus_pending_reply(&gprs->pending,
-				dbus_message_new_method_return(gprs->pending));
-
 	atompath =3D __ofono_atom_get_path(gprs->atom);
 	conn =3D ofono_dbus_get_connection();
 	g_dbus_emit_signal(conn, atompath, OFONO_CONNECTION_MANAGER_INTERFACE,
@@ -1695,13 +1680,38 @@ static void gprs_deactivate_for_remove(const struct=
 ofono_error *error,
 	g_free(path);
 }
 =

+
+static void gprs_deactivate_for_remove(const struct ofono_error *error,
+						void *data)
+{
+	struct pri_context *ctx =3D data;
+	struct ofono_gprs *gprs =3D ctx->gprs;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Removing context failed with error: %s",
+				telephony_error_to_str(error));
+
+		__ofono_dbus_pending_reply(&gprs->pending,
+					__ofono_error_failed(gprs->pending));
+		return;
+	}
+
+	gprs_cid_release(gprs, ctx->context.cid);
+	ctx->context.cid =3D 0;
+
+	remove_context(ctx);
+
+	if (gprs->pending)
+		__ofono_dbus_pending_reply(&gprs->pending,
+				dbus_message_new_method_return(gprs->pending));
+}
+
 static DBusMessage *gprs_remove_context(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_gprs *gprs =3D data;
 	struct pri_context *ctx;
 	const char *path;
-	const char *atompath;
 =

 	if (gprs->pending)
 		return __ofono_error_busy(msg);
@@ -1730,22 +1740,11 @@ static DBusMessage *gprs_remove_context(DBusConnect=
ion *conn,
 		return NULL;
 	}
 =

-	if (gprs->settings) {
-		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
-		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
-	}
-
 	DBG("Unregistering context: %s", ctx->path);
-	context_dbus_unregister(ctx);
-	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
+	remove_context(ctx);
 =

 	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
 =

-	atompath =3D __ofono_atom_get_path(gprs->atom);
-	g_dbus_emit_signal(conn, atompath, OFONO_CONNECTION_MANAGER_INTERFACE,
-				"ContextRemoved", DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-
 	return NULL;
 }
 =

-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============8734949907818650284==--

