Content-Type: multipart/mixed; boundary="===============7583930219178096842=="
MIME-Version: 1.0
From: Jimmy Gysens <jimmy.gysens_ext@softathome.com>
Subject: [PATCH] gprs: clean context properly
Date: Thu, 25 Jun 2020 11:30:08 +0200
Message-ID: <20200625093008.4840-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7583930219178096842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After a context is detached, the context is not properly cleared. In
addition to releasing the context:

- Reset the context settings (IP, DNS, interface, ...).
- Signal the Active flag as false.
---
 src/gprs.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index d9e24840..00cfb905 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1573,6 +1573,19 @@ static bool have_read_settings(struct ofono_gprs *gp=
rs)
 	return false;
 }
 =

+static void pri_context_signal_active(struct pri_context *ctx)
+{
+	DBusConnection *conn;
+	dbus_bool_t value;
+
+	value =3D ctx->active;
+	conn =3D ofono_dbus_get_connection();
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+}
+
 static void detach_active_contexts(struct ofono_gprs *gprs)
 {
 	GSList *l;
@@ -1596,7 +1609,9 @@ static void detach_active_contexts(struct ofono_gprs =
*gprs)
 			gc->driver->detach_shutdown(gc, ctx->context.cid);
 =

 		/* Make sure the context is properly cleared */
+		pri_reset_context_settings(ctx);
 		release_context(ctx);
+		pri_context_signal_active(ctx);
 	}
 }
 =

@@ -2251,8 +2266,6 @@ static void gprs_deactivate_for_all(const struct ofon=
o_error *error,
 {
 	struct pri_context *ctx =3D data;
 	struct ofono_gprs *gprs =3D ctx->gprs;
-	DBusConnection *conn;
-	dbus_bool_t value;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		__ofono_dbus_pending_reply(&gprs->pending,
@@ -2262,12 +2275,7 @@ static void gprs_deactivate_for_all(const struct ofo=
no_error *error,
 =

 	pri_reset_context_settings(ctx);
 	release_context(ctx);
-
-	value =3D ctx->active;
-	conn =3D ofono_dbus_get_connection();
-	ofono_dbus_signal_property_changed(conn, ctx->path,
-					OFONO_CONNECTION_CONTEXT_INTERFACE,
-					"Active", DBUS_TYPE_BOOLEAN, &value);
+	pri_context_signal_active(ctx);
 =

 	gprs_deactivate_next(gprs);
 }
-- =

2.17.1

--===============7583930219178096842==--

