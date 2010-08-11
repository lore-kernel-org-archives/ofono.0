Content-Type: multipart/mixed; boundary="===============1499598054161600909=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 08/16] gprs: Refactor to share remove_context method
Date: Wed, 11 Aug 2010 10:26:33 +0800
Message-ID: <1281493601-14351-9-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1499598054161600909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove duplicated code in gprs_deactivate_for_remove and
gprs_remove_context. So they could share the same remove_context method.
---
 src/gprs.c |   66 ++++++++++++++++++++++++++------------------------------=
---
 1 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 677ce81..f91d0dc 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1248,24 +1248,12 @@ static DBusMessage *gprs_create_context(DBusConnect=
ion *conn,
 					DBUS_TYPE_INVALID);
 }
 =

-static void gprs_deactivate_for_remove(const struct ofono_error *error,
-						void *data)
+static void remove_context(struct pri_context *ctx)
 {
-	struct pri_context *ctx =3D data;
 	struct ofono_gprs *gprs =3D ctx->gprs;
 	char **objpath_list;
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
@@ -1275,9 +1263,6 @@ static void gprs_deactivate_for_remove(const struct o=
fono_error *error,
 	context_dbus_unregister(ctx);
 	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
 =

-	__ofono_dbus_pending_reply(&gprs->pending,
-				dbus_message_new_method_return(gprs->pending));
-
 	objpath_list =3D gprs_contexts_path_list(gprs->contexts);
 =

 	if (objpath_list) {
@@ -1292,13 +1277,38 @@ static void gprs_deactivate_for_remove(const struct=
 ofono_error *error,
 	}
 }
 =

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
+		if (gprs->pending)
+			__ofono_dbus_pending_reply(&gprs->pending,
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
-	char **objpath_list;
 =

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 					DBUS_TYPE_INVALID))
@@ -1320,28 +1330,10 @@ static DBusMessage *gprs_remove_context(DBusConnect=
ion *conn,
 		return NULL;
 	}
 =

-	if (gprs->settings) {
-		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
-		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
-	}
-
-	DBG("Unregistering context: %s\n", ctx->path);
-	context_dbus_unregister(ctx);
-	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
+	remove_context(ctx);
 =

 	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
 =

-	objpath_list =3D gprs_contexts_path_list(gprs->contexts);
-
-	if (objpath_list) {
-		path =3D __ofono_atom_get_path(gprs->atom);
-		ofono_dbus_signal_array_property_changed(conn, path,
-					OFONO_DATA_CONNECTION_MANAGER_INTERFACE,
-					"PrimaryContexts",
-					DBUS_TYPE_OBJECT_PATH, &objpath_list);
-		g_strfreev(objpath_list);
-	}
-
 	return NULL;
 }
 =

-- =

1.7.0.4


--===============1499598054161600909==--

