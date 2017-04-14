Content-Type: multipart/mixed; boundary="===============4617552299865703126=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 04/13] gprs: _cid_activated is an 'attaching' state
Date: Fri, 14 Apr 2017 23:36:37 +0200
Message-ID: <20170414213646.32066-5-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4617552299865703126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ofono_gprs_status_notify is an asynchronous notification that messes
with the 'attached' state of the GPRS atom.  This method is normally
prevented from running while an attach is in progress because the
attachment machinery wants to finish up and make it's own determination
of attach state.

When automatic context activation is relevant, as for LTE networks,
the ofono_gprs_cid_activated machinery replaces the usual set_attach
machinery for attaching to the network.  The cid_activated variant,
however, does not guard against simulatenous invocations of
ofono_gprs_status_notify.  This causes a race whereby status_notify
sets the state to 'attached' before the context is fully constructed
and set to active.  If the connection manager sees the 'attached'
state before there are any 'active' contexts, it may decide to
activate a context manually which is not the correct behaviour for
this type of network.

This patch makes the *_cid_activated machinery an 'attaching' state,
introducing the same guards that set_attached has to prevent
ofono_gprs_status_notify from running concurrently.
---
 src/gprs.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index b6e11e8..0da9c32 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -982,6 +982,7 @@ static void pri_read_settings_callback(const struct ofo=
no_error *error,
 {
 	struct pri_context *pri_ctx =3D data;
 	struct ofono_gprs_context *gc =3D pri_ctx->context_driver;
+	struct ofono_gprs *gprs =3D pri_ctx->gprs;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	dbus_bool_t value;
 =

@@ -1006,11 +1007,18 @@ static void pri_read_settings_callback(const struct=
 ofono_error *error,
 =

 	value =3D pri_ctx->active;
 =

-	gprs_set_attached_property(pri_ctx->gprs, TRUE);
+	gprs->flags &=3D !GPRS_FLAG_ATTACHING;
+
+	gprs_set_attached_property(gprs, TRUE);
 =

 	ofono_dbus_signal_property_changed(conn, pri_ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
+
+	if (gprs->flags & GPRS_FLAG_RECHECK) {
+		gprs->flags &=3D ~GPRS_FLAG_RECHECK;
+		gprs_netreg_update(gprs);
+	}
 }
 =

 static DBusMessage *pri_set_apn(struct pri_context *ctx, DBusConnection *c=
onn,
@@ -2034,6 +2042,14 @@ void ofono_gprs_cid_activated(struct ofono_gprs  *gp=
rs, unsigned int cid,
 		pri_set_apn(pri_ctx, conn, NULL, apn);
 	}
 =

+	/* Prevent ofono_gprs_status_notify from changing the 'attached'
+	 * state until after the context has been set to 'active' in
+	 * the pri_read_settings_callback; this prevents a race where
+	 * the connection manager sees the modem as attached before there
+	 * is an active context.
+	 */
+	gprs->flags |=3D GPRS_FLAG_ATTACHING;
+
 	gc->driver->read_settings(gc, cid, pri_read_settings_callback, pri_ctx);
 }
 =

-- =

2.9.3


--===============4617552299865703126==--

