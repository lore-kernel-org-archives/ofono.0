Content-Type: multipart/mixed; boundary="===============6026951947810184254=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 09/11] Core support for packet switched bearer reporting
Date: Tue, 11 Jan 2011 16:08:37 +0200
Message-ID: <1294754919-9687-9-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294754919-9687-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6026951947810184254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 7de8ec0..e5ccb01 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -107,6 +107,7 @@ struct context_settings {
 =

 struct pri_context {
 	ofono_bool_t active;
+	int bearer;
 	enum ofono_gprs_context_type type;
 	char name[MAX_CONTEXT_NAME_LENGTH + 1];
 	char message_proxy[MAX_MESSAGE_PROXY_LENGTH + 1];
@@ -596,6 +597,13 @@ static void append_context_properties(struct pri_conte=
xt *ctx,
 	value =3D ctx->active;
 	ofono_dbus_dict_append(dict, "Active", DBUS_TYPE_BOOLEAN, &value);
 =

+	if (ctx->active) {
+		const char *bearer =3D packet_bearer_to_string(ctx->bearer);
+
+		ofono_dbus_dict_append(dict, "Bearer",
+					DBUS_TYPE_STRING, &bearer);
+	}
+
 	ofono_dbus_dict_append(dict, "Type", DBUS_TYPE_STRING, &type);
 =

 	ofono_dbus_dict_append(dict, "Protocol", DBUS_TYPE_STRING, &proto);
@@ -710,6 +718,7 @@ static void pri_deactivate_callback(const struct ofono_=
error *error, void *data)
 	gprs_cid_release(ctx->gprs, ctx->context.cid);
 	ctx->context.cid =3D 0;
 	ctx->active =3D FALSE;
+	ctx->bearer =3D -1;
 	ctx->context_driver->inuse =3D FALSE;
 	ctx->context_driver =3D NULL;
 =

@@ -1310,6 +1319,7 @@ static void gprs_attached_update(struct ofono_gprs *g=
prs)
 			gprs_cid_release(gprs, ctx->context.cid);
 			ctx->context.cid =3D 0;
 			ctx->active =3D FALSE;
+			ctx->bearer =3D -1;
 			ctx->context_driver->inuse =3D FALSE;
 			ctx->context_driver =3D NULL;
 =

@@ -1593,6 +1603,7 @@ static struct pri_context *add_context(struct ofono_g=
prs *gprs,
 		return NULL;
 	}
 =

+	context->bearer =3D -1;
 	context->id =3D id;
 =

 	DBG("Registering new context");
@@ -1785,6 +1796,7 @@ static void gprs_deactivate_for_all(const struct ofon=
o_error *error,
 =

 	gprs_cid_release(gprs, ctx->context.cid);
 	ctx->active =3D FALSE;
+	ctx->bearer =3D -1;
 	ctx->context.cid =3D 0;
 	ctx->context_driver->inuse =3D FALSE;
 	ctx->context_driver =3D NULL;
@@ -2003,6 +2015,31 @@ void ofono_gprs_add_context(struct ofono_gprs *gprs,
 	__ofono_atom_register(gc->atom, gprs_context_unregister);
 }
 =

+void ofono_gprs_bearer_notify(struct ofono_gprs *gprs,
+				unsigned int cid, int bearer)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	GSList *l;
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+		const char *value;
+
+		if (ctx->context.cid !=3D cid)
+			continue;
+
+		if (ctx->bearer =3D=3D bearer)
+			break;
+
+		value =3D packet_bearer_to_string(bearer);
+
+		ctx->bearer =3D bearer;
+		ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Bearer", DBUS_TYPE_STRING, &value);
+	}
+}
+
 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
 					unsigned int cid)
 {
@@ -2026,6 +2063,7 @@ void ofono_gprs_context_deactivated(struct ofono_gprs=
_context *gc,
 		gprs_cid_release(ctx->gprs, ctx->context.cid);
 		ctx->context.cid =3D 0;
 		ctx->active =3D FALSE;
+		ctx->bearer =3D -1;
 		ctx->context_driver->inuse =3D FALSE;
 		ctx->context_driver =3D NULL;
 =

-- =

1.7.1


--===============6026951947810184254==--

