Content-Type: multipart/mixed; boundary="===============0490945673313438647=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH 4/4] Revert "gprs: _cid_activated is an 'attaching' state"
Date: Wed, 14 Aug 2019 20:24:44 +0200
Message-ID: <20190814182444.13508-4-richard.rojfors@gmail.com>
In-Reply-To: <20190814182444.13508-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0490945673313438647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

This reverts commit 1fd419e5b4b3a87673f8e0219edb0f3ed9fca774.

Since gprs_attached_update now guarantees that we
will not get attached without having a context activated
in LTE, this is not needed anymore. It also potentially
interferes in case the driver was actually attaching.
---
 src/gprs.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index eb6cd30b..6bdc125d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -913,7 +913,6 @@ static void pri_read_settings_callback(const struct ofo=
no_error *error,
 {
 	struct pri_context *pri_ctx =3D data;
 	struct ofono_gprs_context *gc =3D pri_ctx->context_driver;
-	struct ofono_gprs *gprs =3D pri_ctx->gprs;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	dbus_bool_t value;
 =

@@ -938,18 +937,11 @@ static void pri_read_settings_callback(const struct o=
fono_error *error,
 =

 	value =3D pri_ctx->active;
 =

-	gprs->flags &=3D ~GPRS_FLAG_ATTACHING;
-
-	gprs_set_attached_property(gprs, TRUE);
+	gprs_set_attached_property(pri_ctx->gprs, TRUE);
 =

 	ofono_dbus_signal_property_changed(conn, pri_ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
-
-	if (gprs->flags & GPRS_FLAG_RECHECK) {
-		gprs->flags &=3D ~GPRS_FLAG_RECHECK;
-		gprs_netreg_update(gprs);
-	}
 }
 =

 static DBusMessage *pri_set_apn(struct pri_context *ctx, DBusConnection *c=
onn,
@@ -2039,14 +2031,6 @@ void ofono_gprs_cid_activated(struct ofono_gprs  *gp=
rs, unsigned int cid,
 					DBUS_TYPE_STRING, &apn);
 	}
 =

-	/* Prevent ofono_gprs_status_notify from changing the 'attached'
-	 * state until after the context has been set to 'active' in
-	 * the pri_read_settings_callback; this prevents a race where
-	 * the connection manager sees the modem as attached before there
-	 * is an active context.
-	 */
-	gprs->flags |=3D GPRS_FLAG_ATTACHING;
-
 	gc->driver->read_settings(gc, cid, pri_read_settings_callback, pri_ctx);
 }
 =

-- =

2.20.1


--===============0490945673313438647==--

