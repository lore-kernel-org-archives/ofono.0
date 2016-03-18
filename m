Content-Type: multipart/mixed; boundary="===============8246385151894947004=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 3/5] gprs: implement ofono_gprs_cid_activated
Date: Fri, 18 Mar 2016 11:47:05 +0100
Message-ID: <1458298030-30455-4-git-send-email-dragos@endocode.com>
In-Reply-To: <1458298030-30455-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8246385151894947004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It works by looking for a context with the same APN and tries to use
that. Otherwise it will create it's own.

Then it assigns a gprs context driver and calls it's read_settings if
it exists.
---
 src/gprs.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 114 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index e956a23..500902e 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -293,6 +293,11 @@ static void gprs_cid_release(struct ofono_gprs *gprs, =
unsigned int id)
 	idmap_put(gprs->cid_map, id);
 }
 =

+static gboolean gprs_cid_taken(struct ofono_gprs *gprs, unsigned int id)
+{
+	return idmap_find(gprs->cid_map, id) !=3D 0;
+}
+
 static gboolean assign_context(struct pri_context *ctx, int use_cid)
 {
 	struct idmap *cidmap =3D ctx->gprs->cid_map;
@@ -943,6 +948,39 @@ static void pri_deactivate_callback(const struct ofono=
_error *error, void *data)
 					"Active", DBUS_TYPE_BOOLEAN, &value);
 }
 =

+static void pri_read_settings_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct pri_context *pri_ctx =3D data;
+	struct ofono_gprs_context *gc =3D pri_ctx->context_driver;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t value;
+
+	DBG("%p", pri_ctx);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Reading context settings failed with error: %s",
+				telephony_error_to_str(error));
+		context_settings_free(pri_ctx->context_driver->settings);
+		release_context(pri_ctx);
+		return;
+	}
+
+	pri_ctx->active =3D TRUE;
+
+	if (gc->settings->interface !=3D NULL) {
+		pri_ifupdown(gc->settings->interface, TRUE);
+
+		pri_context_signal_settings(pri_ctx, gc->settings->ipv4 !=3D NULL,
+						gc->settings->ipv6 !=3D NULL);
+	}
+
+	value =3D pri_ctx->active;
+	ofono_dbus_signal_property_changed(conn, pri_ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+}
+
 static DBusMessage *pri_set_apn(struct pri_context *ctx, DBusConnection *c=
onn,
 				DBusMessage *msg, const char *apn)
 {
@@ -1840,6 +1878,35 @@ static void write_context_settings(struct ofono_gprs=
 *gprs,
 	}
 }
 =

+static struct pri_context *find_usable_context(struct ofono_gprs *gprs,
+					const char *apn)
+{
+	GSList *l;
+	struct pri_context *pri_ctx;
+
+	/* Look for matching APN: */
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		pri_ctx =3D l->data;
+
+		/* Looking only at prefix for the LTE case when a user APN is
+		 * web.provider.com but it apepars as
+		 * web.provider.com.mncX.mccY.gprs .
+		 */
+		if (g_str_has_prefix(apn, pri_ctx->context.apn))
+			return pri_ctx;
+	}
+
+	/* Look for a provision failed pri context: */
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		pri_ctx =3D l->data;
+
+		if (pri_ctx->context.apn =3D=3D NULL)
+			return pri_ctx;
+	}
+
+	return NULL;
+}
+
 static struct pri_context *add_context(struct ofono_gprs *gprs,
 					const char *name,
 					enum ofono_gprs_context_type type)
@@ -1883,6 +1950,53 @@ static struct pri_context *add_context(struct ofono_=
gprs *gprs,
 	return context;
 }
 =

+void ofono_gprs_cid_activated(struct ofono_gprs  *gprs, unsigned int cid,
+				const char *apn)
+{
+	struct pri_context *pri_ctx;
+	struct ofono_gprs_context *gc;
+
+	DBG("");
+
+	if (gprs_cid_taken(gprs, cid)) {
+		DBG("cid %u already activated", cid);
+		return;
+	}
+
+	pri_ctx =3D find_usable_context(gprs, apn);
+
+	if (!pri_ctx) {
+		pri_ctx =3D add_context(gprs, apn,
+					OFONO_GPRS_CONTEXT_TYPE_INTERNET);
+		if (!pri_ctx) {
+			ofono_error("Can't find/create automatic context %d "
+					"with APN %s.", cid, apn);
+			return;
+		}
+	}
+
+	if (assign_context(pri_ctx, cid) =3D=3D FALSE) {
+		ofono_warn("Can't assign context to driver for APN.");
+		release_context(pri_ctx);
+		return;
+	}
+
+	gc =3D pri_ctx->context_driver;
+
+	if (gc->driver->read_settings =3D=3D NULL) {
+		ofono_warn("Context activated for driver that doesn't support "
+				"automatic context activation.");
+		release_context(pri_ctx);
+	}
+
+	if (pri_ctx->context.apn =3D=3D NULL) {
+		DBusConnection *conn =3D ofono_dbus_get_connection();
+		pri_set_apn(pri_ctx, conn, NULL, apn);
+	}
+
+	gc->driver->read_settings(gc, cid, pri_read_settings_callback, pri_ctx);
+}
+
 static void send_context_added_signal(struct ofono_gprs *gprs,
 					struct pri_context *context,
 					DBusConnection *conn)
-- =

2.5.0


--===============8246385151894947004==--

