Content-Type: multipart/mixed; boundary="===============3272698014876203819=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 8/8] Fix gprs_netreg_update behaviour if PPP connection active
Date: Fri, 15 Feb 2019 14:11:42 +0200
Message-ID: <20190215121142.28163-9-philippedeswert@gmail.com>
In-Reply-To: <20190215121142.28163-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3272698014876203819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tommi Rekosuo <tommi.rekosuo@treon.fi>

If a PPP connection is active, the modem can't detach before
the PPP connection has been disabled. This can happen if
RoamingAllowed is changed when connection is active.
This leaves connman in undefined state as the context
'Active' state is not propagated properly and connman
still thinks we are connected.
---
 src/gprs.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index f1146d06..9df273b1 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1547,18 +1547,26 @@ static void release_active_contexts(struct ofono_gp=
rs *gprs)
 {
 	GSList *l;
 	struct pri_context *ctx;
+	DBusConnection *conn;
+	dbus_bool_t value;
 =

 	for (l =3D gprs->contexts; l; l =3D l->next) {
 		struct ofono_gprs_context *gc;
 =

 		ctx =3D l->data;
 =

-		if (ctx->active =3D=3D FALSE)
+		DBG("Context id: %d", ctx->context.cid);
+
+		if (ctx->active =3D=3D FALSE) {
+			DBG("Context not active");
 			continue;
+		}
 =

 		/* This context is already being messed with */
-		if (ctx->pending)
+		if (ctx->pending) {
+			DBG("Context in pending state");
 			continue;
+		}
 =

 		gc =3D ctx->context_driver;
 =

@@ -1567,6 +1575,11 @@ static void release_active_contexts(struct ofono_gpr=
s *gprs)
 =

 		/* Make sure the context is properly cleared */
 		release_context(ctx);
+		value =3D ctx->active;
+		conn =3D ofono_dbus_get_connection();
+		ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
 	}
 }
 =

@@ -1688,6 +1701,13 @@ static void gprs_netreg_update(struct ofono_gprs *gp=
rs)
 		return;
 	}
 =

+	/* If PPP session if active it needs to be disconnected
+	 * before the driver can send at commands */
+	if (!attach) {
+		DBG("Release active contexts");
+		release_active_contexts(gprs);
+	}
+
 	gprs->flags |=3D GPRS_FLAG_ATTACHING;
 =

 	gprs->driver_attached =3D attach;
-- =

2.20.1


--===============3272698014876203819==--

