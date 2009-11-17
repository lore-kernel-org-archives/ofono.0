Content-Type: multipart/mixed; boundary="===============8411983970867154902=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 2/5] emit PropertyChanged Settings signal after
 active/deactive primary context
Date: Tue, 17 Nov 2009 23:49:10 +0800
Message-ID: <1258472953-2922-2-git-send-email-martin.xu@intel.com>
In-Reply-To: <1258472953-2922-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8411983970867154902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0253109..a8d8afa 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -82,9 +82,19 @@ struct ofono_gprs {
 	struct ofono_atom *atom;
 };
 =

+struct context_settings {
+	char *interface;
+	char *method;
+	char *address;
+	char *netmask;
+	char *dns;
+	char *gateway;
+};
+
 struct ofono_gprs_context {
 	struct ofono_gprs *gprs;
 	DBusMessage *pending;
+	struct context_settings settings;
 	const struct ofono_gprs_context_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -97,6 +107,7 @@ struct pri_context {
 	char name[MAX_CONTEXT_NAME_LENGTH + 1];
 	char *path;
 	char *key;
+	struct context_settings settings;
 	struct ofono_gprs_primary_context context;
 	struct ofono_gprs *gprs;
 };
@@ -190,6 +201,102 @@ static DBusMessage *pri_get_properties(DBusConnection=
 *conn,
 	return reply;
 }
 =

+static void context_settings_dup(struct context_settings *to,
+				struct context_settings *from)
+{
+	g_free(to->interface);
+	to->interface =3D g_strdup(from->interface);
+
+	g_free(to->method);
+	to->method =3D g_strdup(from->method);
+
+	g_free(to->address);
+	to->address =3D g_strdup(from->address);
+
+	g_free(to->netmask);
+	to->netmask =3D g_strdup(from->netmask);
+
+	g_free(to->dns);
+	to->dns =3D g_strdup(from->dns);
+
+	g_free(to->gateway);
+	to->gateway =3D g_strdup(from->gateway);
+}
+
+static void cleanup_context_settings(struct context_settings *settings)
+{
+	g_free(settings->interface);
+	settings->interface =3D NULL;
+
+	g_free(settings->method);
+	settings->method =3D NULL;
+
+	g_free(settings->address);
+	settings->address =3D NULL;
+
+	g_free(settings->netmask);
+	settings->netmask =3D NULL;
+
+	g_free(settings->dns);
+	settings->dns =3D NULL;
+
+	g_free(settings->gateway);
+	settings->gateway =3D NULL;
+}
+
+static char **get_settings(struct context_settings *settings)
+{
+	char **ret;
+
+	ret =3D g_new0(char *, 13);
+
+	ret[0] =3D g_strdup("Interface");
+	ret[1] =3D g_strdup(settings->interface);
+
+	ret[2] =3D g_strdup("Method");
+	ret[3] =3D g_strdup(settings->method);
+
+	ret[4] =3D g_strdup("Address");
+	ret[5] =3D g_strdup(settings->address);
+
+	ret[6] =3D g_strdup("Netmask");
+	ret[7] =3D g_strdup(settings->netmask);
+
+	ret[8] =3D g_strdup("DomainNameServers");
+	ret[9] =3D g_strdup(settings->dns);
+
+	ret[10] =3D g_strdup("GateWay");
+	ret[11] =3D g_strdup(settings->gateway);
+
+	return ret;
+}
+
+static void pri_context_settings_changed(struct pri_context *ctx)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	char **settings =3D get_settings(&ctx->settings);
+
+	ofono_dbus_signal_dict_property_changed(conn, ctx->path,
+						DATA_CONTEXT_INTERFACE,
+						"Settings",
+						DBUS_TYPE_STRING,
+						&settings);
+
+	g_strfreev(settings);
+}
+
+static void update_pri_context_settings(ofono_bool_t active,
+					struct ofono_gprs_context *gc,
+					struct pri_context *ctx)
+{
+	if (active)
+		context_settings_dup(&ctx->settings, &gc->settings);
+	else
+		cleanup_context_settings(&ctx->settings);
+
+	pri_context_settings_changed(ctx);
+}
+
 static void pri_set_active_callback(const struct ofono_error *error,
 					void *data)
 {
@@ -215,6 +322,9 @@ static void pri_set_active_callback(const struct ofono_=
error *error,
 				dbus_message_new_method_return(gc->pending));
 =

 	value =3D ctx->active;
+
+	update_pri_context_settings(value, gc, ctx);
+
 	ofono_dbus_signal_property_changed(conn, ctx->path,
 						DATA_CONTEXT_INTERFACE,
 						"Active", DBUS_TYPE_BOOLEAN,
@@ -510,6 +620,8 @@ static void pri_context_destroy(gpointer userdata)
 {
 	struct pri_context *ctx =3D userdata;
 =

+	cleanup_context_settings(&ctx->settings);
+
 	if (ctx->path)
 		g_free(ctx->path);
 =

@@ -1185,6 +1297,8 @@ static void gprs_context_remove(struct ofono_atom *at=
om)
 	if (gc->driver && gc->driver->remove)
 		gc->driver->remove(gc);
 =

+	cleanup_context_settings(&gc->settings);
+
 	g_free(gc);
 }
 =

@@ -1579,3 +1693,4 @@ void *ofono_gprs_get_data(struct ofono_gprs *gprs)
 {
 	return gprs->driver_data;
 }
+
-- =

1.6.1.3


--===============8411983970867154902==--

