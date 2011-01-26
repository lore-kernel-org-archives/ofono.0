Content-Type: multipart/mixed; boundary="===============1545898102235130559=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RFC 3/5] gprs: core support for IPv6
Date: Wed, 26 Jan 2011 18:22:48 +0200
Message-ID: <1296058970-11815-4-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1296058970-11815-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1545898102235130559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  916 ++++++++++++++++++++++++++++++++++++++++++++------------=
----
 1 files changed, 679 insertions(+), 237 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 37e7aee..6edeef6 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -54,6 +54,7 @@
 #define MAX_MESSAGE_CENTER_LENGTH 255
 #define MAX_CONTEXTS 256
 #define SUSPEND_TIMEOUT 8
+#define ACTIVATE_FAIL_DELAY 2
 =

 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
@@ -97,19 +98,11 @@ struct ofono_gprs {
 	struct ofono_atom *atom;
 };
 =

-struct ofono_gprs_context {
-	struct ofono_gprs *gprs;
-	enum ofono_gprs_context_type type;
-	ofono_bool_t inuse;
-	const struct ofono_gprs_context_driver *driver;
-	void *driver_data;
-	struct ofono_atom *atom;
-};
+struct pri_context;
 =

-struct context_settings {
-	enum ofono_gprs_context_type type;
+struct context_settings_ip {
 	char *interface;
-	gboolean static_ip;
+	enum ofono_gprs_addrconf_method method;
 	char *ip;
 	char *netmask;
 	char *gateway;
@@ -117,21 +110,43 @@ struct context_settings {
 	char *proxy;
 };
 =

+struct context_settings_ipv6 {
+	char *interface;
+	char *address;
+	char **dns;
+};
+
+struct ofono_gprs_context {
+	struct ofono_gprs *gprs;
+	struct pri_context *pri;
+	enum ofono_gprs_context_type type;
+	enum ofono_gprs_proto proto;
+	struct context_settings_ip *settings_ip;
+	struct context_settings_ipv6 *settings_ipv6;
+	guint timer;
+	unsigned int cid;
+	const struct ofono_gprs_context_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
 struct pri_context {
 	ofono_bool_t active;
 	enum ofono_gprs_context_type type;
 	char name[MAX_CONTEXT_NAME_LENGTH + 1];
 	char message_proxy[MAX_MESSAGE_PROXY_LENGTH + 1];
 	char message_center[MAX_MESSAGE_CENTER_LENGTH + 1];
+	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
+	enum ofono_gprs_proto proto;
 	unsigned int id;
 	char *path;
 	char *key;
-	struct context_settings *settings;
 	char *proxy_host;
 	uint16_t proxy_port;
 	DBusMessage *pending;
-	struct ofono_gprs_primary_context context;
-	struct ofono_gprs_context *context_driver;
+	GSList *bearers;
 	struct ofono_gprs *gprs;
 };
 =

@@ -240,11 +255,26 @@ static gboolean gprs_proto_from_string(const char *st=
r,
 	} else if (g_str_equal(str, "ipv6")) {
 		*proto =3D OFONO_GPRS_PROTO_IPV6;
 		return TRUE;
+	} else if (g_str_equal(str, "ipv4v6")) {
+		*proto =3D OFONO_GPRS_PROTO_IPV4V6;
+		return TRUE;
 	}
 =

 	return FALSE;
 }
 =

+static const char *gprs_addrconf_to_string(enum ofono_gprs_proto method)
+{
+	switch (method) {
+	case OFONO_GPRS_ADDRCONF_STATIC:
+		return "static";
+	case OFONO_GPRS_ADDRCONF_DHCP:
+		return "dhcp";
+	}
+
+	return NULL;
+}
+
 static unsigned int gprs_cid_alloc(struct ofono_gprs *gprs)
 {
 	return idmap_alloc(gprs->cid_map);
@@ -270,21 +300,37 @@ static struct pri_context *gprs_context_by_path(struc=
t ofono_gprs *gprs,
 	return NULL;
 }
 =

-static void context_settings_free(struct context_settings *settings)
+static void context_settings_free(struct ofono_gprs_context *gc)
+{
+	if (gc->settings_ip =3D=3D NULL)
+		return;
+
+	g_free(gc->settings_ip->interface);
+	g_free(gc->settings_ip->ip);
+	g_free(gc->settings_ip->netmask);
+	g_free(gc->settings_ip->gateway);
+	g_strfreev(gc->settings_ip->dns);
+	g_free(gc->settings_ip->proxy);
+	g_free(gc->settings_ip);
+	gc->settings_ip =3D NULL;
+}
+
+static void context_ipv6settings_free(struct ofono_gprs_context *gc)
 {
-	g_free(settings->interface);
-	g_free(settings->ip);
-	g_free(settings->netmask);
-	g_free(settings->gateway);
-	g_strfreev(settings->dns);
-	g_free(settings->proxy);
+	if (gc->settings_ipv6 =3D=3D NULL)
+		return;
 =

-	g_free(settings);
+	g_free(gc->settings_ipv6->interface);
+	g_free(gc->settings_ipv6->address);
+	g_strfreev(gc->settings_ipv6->dns);
+	g_free(gc->settings_ipv6);
+	gc->settings_ipv6 =3D NULL;
 }
 =

-static void context_settings_append_variant(struct context_settings *setti=
ngs,
+static void context_settings_append_variant(struct ofono_gprs_context *gc,
 						DBusMessageIter *iter)
 {
+	struct context_settings_ip *settings =3D gc->settings_ip;
 	DBusMessageIter variant;
 	DBusMessageIter array;
 	char typesig[5];
@@ -306,22 +352,21 @@ static void context_settings_append_variant(struct co=
ntext_settings *settings,
 	if (settings =3D=3D NULL)
 		goto done;
 =

-	ofono_dbus_dict_append(&array, "Interface",
-				DBUS_TYPE_STRING, &settings->interface);
+	if (settings->interface !=3D NULL)
+		ofono_dbus_dict_append(&array, "Interface",
+					DBUS_TYPE_STRING, &settings->interface);
 =

-	if (settings->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
+	if (gc->pri->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
 		if (settings->proxy)
 			ofono_dbus_dict_append(&array, "Proxy",
 					DBUS_TYPE_STRING, &settings->proxy);
 		goto done;
 	}
 =

-	if (settings->static_ip =3D=3D TRUE)
-		method =3D "static";
-	else
-		method =3D "dhcp";
-
-	ofono_dbus_dict_append(&array, "Method", DBUS_TYPE_STRING, &method);
+	method =3D gprs_addrconf_to_string(settings->method);
+	if (method !=3D NULL)
+		ofono_dbus_dict_append(&array, "Method", DBUS_TYPE_STRING,
+					&method);
 =

 	if (settings->ip)
 		ofono_dbus_dict_append(&array, "Address", DBUS_TYPE_STRING,
@@ -346,7 +391,7 @@ done:
 	dbus_message_iter_close_container(iter, &variant);
 }
 =

-static void context_settings_append_dict(struct context_settings *settings,
+static void context_settings_append_dict(struct ofono_gprs_context *gc,
 						DBusMessageIter *dict)
 {
 	DBusMessageIter entry;
@@ -357,14 +402,15 @@ static void context_settings_append_dict(struct conte=
xt_settings *settings,
 =

 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
 =

-	context_settings_append_variant(settings, &entry);
+	context_settings_append_variant(gc, &entry);
 =

 	dbus_message_iter_close_container(dict, &entry);
 }
 =

-static void pri_context_signal_settings(struct pri_context *ctx)
+static void context_signal_settings(struct ofono_gprs_context *gc)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct pri_context *ctx =3D gc->pri;
 	const char *path =3D ctx->path;
 	DBusMessage *signal;
 	DBusMessageIter iter;
@@ -374,6 +420,98 @@ static void pri_context_signal_settings(struct pri_con=
text *ctx)
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"PropertyChanged");
 =

+	DBG("signal =3D %p", signal);
+
+	if (signal =3D=3D NULL)
+		return;
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &prop);
+
+	context_settings_append_variant(gc, &iter);
+
+	g_dbus_send_message(conn, signal);
+}
+
+static void context_ipv6settings_append_variant(struct ofono_gprs_context =
*gc,
+						DBusMessageIter *iter)
+{
+	struct context_settings_ipv6 *settings =3D gc->settings_ipv6;
+	DBusMessageIter variant;
+	DBusMessageIter array;
+	char typesig[5];
+	char arraysig[6];
+
+	arraysig[0] =3D DBUS_TYPE_ARRAY;
+	arraysig[1] =3D typesig[0] =3D DBUS_DICT_ENTRY_BEGIN_CHAR;
+	arraysig[2] =3D typesig[1] =3D DBUS_TYPE_STRING;
+	arraysig[3] =3D typesig[2] =3D DBUS_TYPE_VARIANT;
+	arraysig[4] =3D typesig[3] =3D DBUS_DICT_ENTRY_END_CHAR;
+	arraysig[5] =3D typesig[4] =3D '\0';
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						arraysig, &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						typesig, &array);
+
+	if (settings =3D=3D NULL)
+		goto done;
+
+	if (settings->interface !=3D NULL)
+		ofono_dbus_dict_append(&array, "Interface",
+					DBUS_TYPE_STRING, &settings->interface);
+
+	if (settings->address !=3D NULL) {
+	  uint8_t addr[16];
+	  char *strll =3D alloca(INET6_ADDRSTRLEN);
+
+	  inet_pton(AF_INET6, settings->address, addr);
+	  memset(addr, 0, 8);
+	  addr[0] =3D 0xf0;
+	  addr[1] =3D 0x80;
+	  inet_ntop(AF_INET6, addr, strll, INET6_ADDRSTRLEN);
+	  ofono_dbus_dict_append(&array, "LinkLocal", DBUS_TYPE_STRING, &strll);
+	}
+
+	if (settings->dns !=3D NULL)
+		ofono_dbus_dict_append_array(&array, "DomainNameServers",
+					DBUS_TYPE_STRING, &settings->dns);
+done:
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+static void context_ipv6settings_append_dict(struct ofono_gprs_context *gc,
+						DBusMessageIter *dict)
+{
+	DBusMessageIter entry;
+	const char *key =3D "IPv6Settings";
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	context_ipv6settings_append_variant(gc, &entry);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void context_signal_ipv6settings(struct ofono_gprs_context *gc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct pri_context *ctx =3D gc->pri;
+	const char *path =3D ctx->path;
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	const char *prop =3D "IPv6Settings";
+
+	signal =3D dbus_message_new_signal(path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"PropertyChanged");
+
 	if (signal =3D=3D NULL)
 		return;
 =

@@ -381,11 +519,28 @@ static void pri_context_signal_settings(struct pri_co=
ntext *ctx)
 =

 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &prop);
 =

-	context_settings_append_variant(ctx->settings, &iter);
+	context_ipv6settings_append_variant(gc, &iter);
 =

 	g_dbus_send_message(conn, signal);
 }
 =

+static void pri_context_settings_append_dict(struct pri_context *ctx,
+						DBusMessageIter *dict)
+{
+	struct ofono_gprs_context *ip =3D NULL, *ipv6 =3D NULL;
+	GSList *l;
+
+	for (l =3D ctx->bearers; l; l =3D l->next) {
+		struct ofono_gprs_context *gc =3D l->data;
+
+		if (gc->settings_ip)
+			context_settings_append_dict(gc, dict);
+
+		if (gc->settings_ipv6)
+			context_ipv6settings_append_dict(gc, dict);
+	}
+}
+
 static void pri_parse_proxy(struct pri_context *ctx, const char *proxy)
 {
 	char *scheme, *host, *port, *path;
@@ -552,78 +707,62 @@ static void pri_setproxy(const char *interface, const=
 char *proxy)
 =

 static void pri_reset_context_settings(struct pri_context *ctx)
 {
-	char *interface;
-
-	if (ctx->settings =3D=3D NULL)
-		return;
-
-	interface =3D ctx->settings->interface;
-	ctx->settings->interface =3D NULL;
-
-	context_settings_free(ctx->settings);
-	ctx->settings =3D NULL;
-
-	pri_context_signal_settings(ctx);
-
 	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
-		pri_setaddr(interface, NULL);
-
 		g_free(ctx->proxy_host);
 		ctx->proxy_host =3D NULL;
 		ctx->proxy_port =3D 0;
 	}
-
-	pri_ifupdown(interface, FALSE);
-
-	g_free(interface);
 }
 =

-static void pri_update_context_settings(struct pri_context *ctx,
-					const char *interface,
-					ofono_bool_t static_ip,
-					const char *ip, const char *netmask,
-					const char *gateway, const char **dns)
+static void pri_update_context_settings(struct pri_context *ctx)
 {
-	if (ctx->settings)
-		context_settings_free(ctx->settings);
+	struct ofono_gprs_context *ip =3D NULL, *ipv6 =3D NULL;
+	GSList *l;
 =

-	ctx->settings =3D g_try_new0(struct context_settings, 1);
-	if (ctx->settings =3D=3D NULL)
-		return;
+	for (l =3D ctx->bearers; l; l =3D l->next) {
+		struct ofono_gprs_context *gc =3D l->data;
 =

-	ctx->settings->type =3D ctx->type;
+		if (gc->settings_ip !=3D NULL)
+			ip =3D gc;
 =

-	ctx->settings->interface =3D g_strdup(interface);
-	ctx->settings->static_ip =3D static_ip;
-	ctx->settings->ip =3D g_strdup(ip);
-	ctx->settings->netmask =3D g_strdup(netmask);
-	ctx->settings->gateway =3D g_strdup(gateway);
-	ctx->settings->dns =3D g_strdupv((char **)dns);
+		if (gc->settings_ipv6 !=3D NULL)
+			ipv6 =3D gc;
+	}
 =

-	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS && ctx->message_proxy)
-		ctx->settings->proxy =3D g_strdup(ctx->message_proxy);
+	if (ip !=3D NULL) {
+		pri_ifupdown(ip->settings_ip->interface, TRUE);
 =

-	pri_ifupdown(interface, TRUE);
+		if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS &&
+				ctx->message_proxy !=3D NULL) {
+			ip->settings_ip->proxy =3D g_strdup(ctx->message_proxy);
+			pri_parse_proxy(ctx, ctx->message_proxy);
 =

-	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
-		pri_parse_proxy(ctx, ctx->message_proxy);
+			DBG("proxy %s port %u", ctx->proxy_host,
+				ctx->proxy_port);
+
+			pri_setaddr(ip->settings_ip->interface,
+					ip->settings_ip->ip);
 =

-		DBG("proxy %s port %u", ctx->proxy_host, ctx->proxy_port);
+			if (ctx->proxy_host)
+				pri_setproxy(ip->settings_ip->interface,
+						ctx->proxy_host);
 =

-		pri_setaddr(interface, ip);
+		}
 =

-		if (ctx->proxy_host)
-			pri_setproxy(interface, ctx->proxy_host);
+		context_signal_settings(ip);
 	}
 =

-	pri_context_signal_settings(ctx);
+	if (ipv6 !=3D NULL) {
+		pri_ifupdown(ipv6->settings_ipv6->interface, TRUE);
+		context_signal_ipv6settings(ipv6);
+	}
 }
 =

 static void append_context_properties(struct pri_context *ctx,
 					DBusMessageIter *dict)
 {
 	const char *type =3D gprs_context_type_to_string(ctx->type);
-	const char *proto =3D gprs_proto_to_string(ctx->context.proto);
+	const char *proto =3D gprs_proto_to_string(ctx->proto);
 	const char *name =3D ctx->name;
 	dbus_bool_t value;
 	const char *strvalue;
@@ -637,15 +776,15 @@ static void append_context_properties(struct pri_cont=
ext *ctx,
 =

 	ofono_dbus_dict_append(dict, "Protocol", DBUS_TYPE_STRING, &proto);
 =

-	strvalue =3D ctx->context.apn;
+	strvalue =3D ctx->apn;
 	ofono_dbus_dict_append(dict, "AccessPointName", DBUS_TYPE_STRING,
 				&strvalue);
 =

-	strvalue =3D ctx->context.username;
+	strvalue =3D ctx->username;
 	ofono_dbus_dict_append(dict, "Username", DBUS_TYPE_STRING,
 				&strvalue);
 =

-	strvalue =3D ctx->context.password;
+	strvalue =3D ctx->password;
 	ofono_dbus_dict_append(dict, "Password", DBUS_TYPE_STRING,
 				&strvalue);
 =

@@ -659,7 +798,7 @@ static void append_context_properties(struct pri_contex=
t *ctx,
 					DBUS_TYPE_STRING, &strvalue);
 	}
 =

-	context_settings_append_dict(ctx->settings, dict);
+	pri_context_settings_append_dict(ctx, dict);
 }
 =

 static DBusMessage *pri_get_properties(DBusConnection *conn,
@@ -685,44 +824,243 @@ static DBusMessage *pri_get_properties(DBusConnectio=
n *conn,
 	return reply;
 }
 =

-static void pri_activate_callback(const struct ofono_error *error,
-					const char *interface,
-					ofono_bool_t static_ip,
-					const char *ip, const char *netmask,
-					const char *gateway, const char **dns,
-					void *data)
+static void pri_context_activated(struct pri_context *ctx)
 {
-	struct pri_context *ctx =3D data;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	dbus_bool_t value;
 =

-	DBG("%p %s", ctx, interface);
+	ctx->active =3D TRUE;
+	__ofono_dbus_pending_reply(&ctx->pending,
+				dbus_message_new_method_return(ctx->pending));
+
+	pri_update_context_settings(ctx);
+
+	value =3D ctx->active;
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+}
+
+static struct ofono_gprs_context *assign_packet_bearer(struct pri_context =
*ctx)
+{
+	struct ofono_gprs *gprs =3D ctx->gprs;
+	struct idmap *cidmap =3D gprs->cid_map;
+	unsigned int cid_min, cid;
+	GSList *l;
+
+	if (cidmap =3D=3D NULL)
+		return NULL;
+
+	cid_min =3D idmap_get_min(cidmap);
+
+	cid =3D gprs_cid_alloc(gprs);
+	if (cid =3D=3D 0)
+		return NULL;
+
+	for (l =3D gprs->context_drivers; l; l =3D l->next) {
+		struct ofono_gprs_context *gc =3D l->data;
+
+		if (gc->pri !=3D NULL)
+			continue;
+
+		if (gc->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_ANY ||
+				gc->type =3D=3D ctx->type) {
+			gc->cid =3D cid;
+			gc->pri =3D ctx;
+			ctx->bearers =3D g_slist_prepend(ctx->bearers, gc);
+			return gc;
+		}
+	}
+
+	return NULL;
+}
+
+static void release_packet_bearer(struct ofono_gprs_context *gc)
+{
+	struct pri_context *ctx;
+	ofono_bool_t ip, ipv6;
+
+	if (gc =3D=3D NULL)
+		return;
+
+	ctx =3D gc->pri;
+
+	if (gc->settings_ip !=3D NULL) {
+		if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS)
+			pri_setaddr(gc->settings_ip->interface, NULL);
+
+		pri_ifupdown(gc->settings_ip->interface, FALSE);
+		context_settings_free(gc);
+
+		if (ctx->active =3D=3D TRUE)
+			context_signal_settings(gc);
+	}
+
+	if (gc->settings_ipv6 !=3D NULL) {
+		pri_ifupdown(gc->settings_ipv6->interface, FALSE);
+		context_ipv6settings_free(gc);
+
+		if (ctx->active =3D=3D TRUE)
+			context_signal_ipv6settings(gc);
+	}
+
+	if (gc->timer) {
+		g_source_remove(gc->timer);
+		gc->timer =3D 0;
+	}
+
+	gprs_cid_release(ctx->gprs, gc->cid);
+	gc->cid =3D 0;
+	ctx->bearers =3D g_slist_remove(ctx->bearers, gc);
+	gc->pri =3D NULL;
+}
+
+static void pri_activate_error(struct pri_context *ctx)
+{
+	__ofono_dbus_pending_reply(&ctx->pending,
+				__ofono_error_failed(ctx->pending));
+
+	while (ctx->bearers !=3D NULL)
+		release_packet_bearer(ctx->bearers->data);
+}
+
+static gboolean pri_activate_next(gpointer data);
+
+static void pri_activate_context_callback(const struct ofono_error *error,
+					ofono_bool_t single_bearers,
+					void *data)
+{
+	struct ofono_gprs_context *gc =3D data;
+	struct pri_context *ctx =3D gc->pri;
+	enum ofono_gprs_proto proto =3D gc->proto;
+	int bearers =3D g_slist_length(ctx->bearers);
+
+	if (ctx =3D=3D NULL)
+		return;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("Activating context failed with error: %s",
+
+		if (bearers > 1) {
+			DBG("Activating second bearer failed with error: %s",
 				telephony_error_to_str(error));
-		__ofono_dbus_pending_reply(&ctx->pending,
-					__ofono_error_failed(ctx->pending));
+			release_packet_bearer(gc);
+			pri_context_activated(ctx);
+			return;
+		}
 =

-		gprs_cid_release(ctx->gprs, ctx->context.cid);
-		ctx->context.cid =3D 0;
-		ctx->context_driver->inuse =3D FALSE;
-		ctx->context_driver =3D NULL;
+		DBG("Activating bearer failed with error: %s",
+				telephony_error_to_str(error));
+
+		if (ctx->proto !=3D OFONO_GPRS_PROTO_IPV4V6 ||
+				proto =3D=3D OFONO_GPRS_PROTO_IPV6) {
+			pri_activate_error(ctx);
+			return;
+		}
+
+		/* Retry first bearer with different protocol */
+		if (proto =3D=3D OFONO_GPRS_PROTO_IPV4V6)
+			gc->proto =3D OFONO_GPRS_PROTO_IP;
+		else
+			gc->proto =3D OFONO_GPRS_PROTO_IPV6;
 =

+		gc->timer =3D g_timeout_add_seconds(ACTIVATE_FAIL_DELAY,
+							pri_activate_next, gc);
 		return;
 	}
 =

-	ctx->active =3D TRUE;
+	if (ctx->proto !=3D OFONO_GPRS_PROTO_IPV4V6 || single_bearers =3D=3D FALS=
E ||
+			bearers > 1 || gc->proto =3D=3D OFONO_GPRS_PROTO_IPV6) {
+		pri_context_activated(ctx);
+		return;
+	}
+
+	/* Activate second bearer */
+	if (gc->settings_ip =3D=3D NULL)
+		proto =3D OFONO_GPRS_PROTO_IP;
+	else
+		proto =3D OFONO_GPRS_PROTO_IPV6;
+
+	gc =3D assign_packet_bearer(ctx);
+	if (gc =3D=3D NULL) {
+		/* No suitable driver. Go with a single bearer. */
+		pri_context_activated(ctx);
+		return;
+	}
+
+	gc->proto =3D proto;
+	gc->timer =3D g_timeout_add_seconds(0, pri_activate_next, gc);
+}
+
+static gboolean pri_activate_next(gpointer data)
+{
+	struct ofono_gprs_context *gc =3D data;
+	struct pri_context *ctx =3D gc->pri;
+
+	gc->timer =3D 0;
+	gc->driver->activate_primary_new(gc, gc->cid, ctx->apn,	gc->proto,
+						ctx->username, ctx->password,
+						pri_activate_context_callback,
+						gc);
+	return FALSE;
+}
+
+/* Backward compatibility hack (to be removed) =3D=3D> */
+
+static void pri_activate_callback_shim(const struct ofono_error *error,
+				const char *interface, ofono_bool_t static_ip,
+				const char *address, const char *netmask,
+				const char *gw, const char **dns, void *data)
+{
+	struct ofono_gprs_context *gc =3D data;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_gprs_context_set_ip_interface(gc, interface);
+		ofono_gprs_context_set_ip_addrconf(gc, static_ip ?
+						OFONO_GPRS_ADDRCONF_STATIC :
+						OFONO_GPRS_ADDRCONF_DHCP);
+		ofono_gprs_context_set_ip_address(gc, address);
+		ofono_gprs_context_set_ip_netmask(gc, netmask);
+		ofono_gprs_context_set_ip_gateway(gc, gw);
+		ofono_gprs_context_set_ip_dns_servers(gc, dns);
+	}
+
+	pri_activate_context_callback(error, FALSE, data);
+}
+
+static void activate_primary_shim(struct ofono_gprs_context *gc,
+					unsigned int id,
+					const char *apn,
+					enum ofono_gprs_proto proto,
+					const char *username,
+					const char *password,
+					void *data)
+{
+	struct ofono_gprs_primary_context context;
+
+	memset(&context, 0, sizeof(context));
+	context.cid =3D gc->cid;
+	strncpy(context.apn, apn, OFONO_GPRS_MAX_APN_LENGTH);
+	strncpy(context.username, username, OFONO_GPRS_MAX_USERNAME_LENGTH);
+	strncpy(context.password, password, OFONO_GPRS_MAX_PASSWORD_LENGTH);
+	context.proto =3D proto;
+
+	gc->driver->activate_primary(gc, &context, pri_activate_callback_shim,
+					data);
+}
+
+/* <=3D=3D end of backward compatiblity hack */
+
+static void pri_context_deactivated(struct pri_context *ctx)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t value;
+
+	ctx->active =3D FALSE;
+
 	__ofono_dbus_pending_reply(&ctx->pending,
 				dbus_message_new_method_return(ctx->pending));
 =

-	/*
-	 * If we don't have the interface, don't bother emitting any settings,
-	 * as nobody can make use of them
-	 */
-	if (interface !=3D NULL)
-		pri_update_context_settings(ctx, interface, static_ip,
-						ip, netmask, gateway, dns);
+	pri_reset_context_settings(ctx);
 =

 	value =3D ctx->active;
 	ofono_dbus_signal_property_changed(conn, ctx->path,
@@ -730,11 +1068,11 @@ static void pri_activate_callback(const struct ofono=
_error *error,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
 }
 =

-static void pri_deactivate_callback(const struct ofono_error *error, void =
*data)
+static void pri_deactivate_callback(const struct ofono_error *error,
+						void *data)
 {
-	struct pri_context *ctx =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	dbus_bool_t value;
+	struct ofono_gprs_context *gc =3D data;
+	struct pri_context *ctx =3D gc->pri;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Deactivating context failed with error: %s",
@@ -744,21 +1082,16 @@ static void pri_deactivate_callback(const struct ofo=
no_error *error, void *data)
 		return;
 	}
 =

-	gprs_cid_release(ctx->gprs, ctx->context.cid);
-	ctx->context.cid =3D 0;
-	ctx->active =3D FALSE;
-	ctx->context_driver->inuse =3D FALSE;
-	ctx->context_driver =3D NULL;
-
-	__ofono_dbus_pending_reply(&ctx->pending,
-				dbus_message_new_method_return(ctx->pending));
+	release_packet_bearer(gc);
 =

-	pri_reset_context_settings(ctx);
+	if (ctx->bearers !=3D NULL) {
+		gc =3D ctx->bearers->data;
+		gc->driver->deactivate_primary(gc, gc->cid,
+					pri_deactivate_callback, gc);
+		return;
+	}
 =

-	value =3D ctx->active;
-	ofono_dbus_signal_property_changed(conn, ctx->path,
-					OFONO_CONNECTION_CONTEXT_INTERFACE,
-					"Active", DBUS_TYPE_BOOLEAN, &value);
+	pri_context_deactivated(ctx);
 }
 =

 static DBusMessage *pri_set_apn(struct pri_context *ctx, DBusConnection *c=
onn,
@@ -769,13 +1102,13 @@ static DBusMessage *pri_set_apn(struct pri_context *=
ctx, DBusConnection *conn,
 	if (strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH)
 		return __ofono_error_invalid_format(msg);
 =

-	if (g_str_equal(apn, ctx->context.apn))
+	if (g_str_equal(apn, ctx->apn))
 		return dbus_message_new_method_return(msg);
 =

 	if (is_valid_apn(apn) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	strcpy(ctx->context.apn, apn);
+	strcpy(ctx->apn, apn);
 =

 	if (settings) {
 		g_key_file_set_string(settings, ctx->key,
@@ -802,10 +1135,10 @@ static DBusMessage *pri_set_username(struct pri_cont=
ext *ctx,
 	if (strlen(username) > OFONO_GPRS_MAX_USERNAME_LENGTH)
 		return __ofono_error_invalid_format(msg);
 =

-	if (g_str_equal(username, ctx->context.username))
+	if (g_str_equal(username, ctx->username))
 		return dbus_message_new_method_return(msg);
 =

-	strcpy(ctx->context.username, username);
+	strcpy(ctx->username, username);
 =

 	if (settings) {
 		g_key_file_set_string(settings, ctx->key,
@@ -832,10 +1165,10 @@ static DBusMessage *pri_set_password(struct pri_cont=
ext *ctx,
 	if (strlen(password) > OFONO_GPRS_MAX_PASSWORD_LENGTH)
 		return __ofono_error_invalid_format(msg);
 =

-	if (g_str_equal(password, ctx->context.password))
+	if (g_str_equal(password, ctx->password))
 		return dbus_message_new_method_return(msg);
 =

-	strcpy(ctx->context.password, password);
+	strcpy(ctx->password, password);
 =

 	if (settings) {
 		g_key_file_set_string(settings, ctx->key,
@@ -891,10 +1224,10 @@ static DBusMessage *pri_set_proto(struct pri_context=
 *ctx,
 	if (gprs_proto_from_string(str, &proto) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	if (ctx->context.proto =3D=3D proto)
+	if (ctx->proto =3D=3D proto)
 		return dbus_message_new_method_return(msg);
 =

-	ctx->context.proto =3D proto;
+	ctx->proto =3D proto;
 =

 	if (settings) {
 		g_key_file_set_string(settings, ctx->key, "Protocol", str);
@@ -995,42 +1328,11 @@ static DBusMessage *pri_set_message_center(struct pr=
i_context *ctx,
 	return NULL;
 }
 =

-static gboolean assign_context(struct pri_context *ctx)
-{
-	struct idmap *cidmap =3D ctx->gprs->cid_map;
-	unsigned int cid_min;
-	GSList *l;
-
-	if (cidmap =3D=3D NULL)
-		return FALSE;
-
-	cid_min =3D idmap_get_min(cidmap);
-
-	ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);
-	if (ctx->context.cid =3D=3D 0)
-		return FALSE;
-
-	for (l =3D ctx->gprs->context_drivers; l; l =3D l->next) {
-		struct ofono_gprs_context *gc =3D l->data;
-
-		if (gc->inuse =3D=3D TRUE)
-			continue;
-
-		if (gc->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_ANY ||
-						gc->type =3D=3D ctx->type) {
-			ctx->context_driver =3D gc;
-			ctx->context_driver->inuse =3D TRUE;
-			return TRUE;
-		}
-	}
-
-	return FALSE;
-}
-
 static DBusMessage *pri_set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct pri_context *ctx =3D data;
+	struct ofono_gprs *gprs =3D ctx->gprs;
 	DBusMessageIter iter;
 	DBusMessageIter var;
 	const char *property;
@@ -1052,9 +1354,9 @@ static DBusMessage *pri_set_property(DBusConnection *=
conn,
 	dbus_message_iter_recurse(&iter, &var);
 =

 	if (g_str_equal(property, "Active")) {
-		struct ofono_gprs_context *gc;
+		struct ofono_gprs_context *gc =3D NULL;
 =

-		if (ctx->gprs->pending)
+		if (gprs->pending)
 			return __ofono_error_busy(msg);
 =

 		if (ctx->pending)
@@ -1068,31 +1370,49 @@ static DBusMessage *pri_set_property(DBusConnection=
 *conn,
 		if (ctx->active =3D=3D (ofono_bool_t) value)
 			return dbus_message_new_method_return(msg);
 =

-		if (value && !ctx->gprs->attached)
+		if (value && !gprs->attached)
 			return __ofono_error_not_attached(msg);
 =

-		if (ctx->gprs->flags & GPRS_FLAG_ATTACHING)
+		if (gprs->flags & GPRS_FLAG_ATTACHING)
 			return __ofono_error_attach_in_progress(msg);
 =

-		if (value) {
-			if (assign_context(ctx) =3D=3D FALSE)
-				return __ofono_error_not_implemented(msg);
-		}
+		if (value)
+			gc =3D assign_packet_bearer(ctx);
+		else if (ctx->bearers !=3D NULL)
+			gc =3D ctx->bearers->data;
 =

-		gc =3D ctx->context_driver;
 		if (gc =3D=3D NULL || gc->driver =3D=3D NULL ||
-				gc->driver->activate_primary =3D=3D NULL ||
+				(gc->driver->activate_primary =3D=3D NULL &&
+				gc->driver->activate_primary_new =3D=3D NULL) ||
 				gc->driver->deactivate_primary =3D=3D NULL)
 			return __ofono_error_not_implemented(msg);
 =

 		ctx->pending =3D dbus_message_ref(msg);
 =

-		if (value)
-			gc->driver->activate_primary(gc, &ctx->context,
-						pri_activate_callback, ctx);
-		else
-			gc->driver->deactivate_primary(gc, ctx->context.cid,
-						pri_deactivate_callback, ctx);
+		if (value) {
+			gc->proto =3D ctx->proto;
+			/* Backward compatiblity hack (to be removed) =3D=3D> */
+			if (gc->driver->activate_primary_new =3D=3D NULL)
+				activate_primary_shim(gc,
+						gc->cid,
+						ctx->apn,
+						gc->proto,
+						ctx->username,
+						ctx->password,
+						gc);
+			else
+			/* <=3D=3D end of backward compatiblity hack */
+				gc->driver->activate_primary_new(gc,
+						gc->cid,
+						ctx->apn,
+						gc->proto,
+						ctx->username,
+						ctx->password,
+						pri_activate_context_callback,
+						gc);
+		} else
+			gc->driver->deactivate_primary(gc, gc->cid,
+						pri_deactivate_callback, gc);
 =

 		return NULL;
 	}
@@ -1207,10 +1527,7 @@ static void pri_context_destroy(gpointer userdata)
 {
 	struct pri_context *ctx =3D userdata;
 =

-	if (ctx->settings) {
-		context_settings_free(ctx->settings);
-		ctx->settings =3D NULL;
-	}
+	pri_reset_context_settings(ctx);
 =

 	g_free(ctx->proxy_host);
 =

@@ -1344,13 +1661,10 @@ static void gprs_attached_update(struct ofono_gprs =
*gprs)
 			if (ctx->active =3D=3D FALSE)
 				continue;
 =

-			gprs_cid_release(gprs, ctx->context.cid);
-			ctx->context.cid =3D 0;
 			ctx->active =3D FALSE;
-			ctx->context_driver->inuse =3D FALSE;
-			ctx->context_driver =3D NULL;
 =

-			pri_reset_context_settings(ctx);
+			while (ctx->bearers !=3D NULL)
+				release_packet_bearer(ctx->bearers->data);
 =

 			value =3D FALSE;
 			ofono_dbus_signal_property_changed(conn, ctx->path,
@@ -1597,15 +1911,15 @@ static void write_context_settings(struct ofono_gpr=
s *gprs,
 	g_key_file_set_string(gprs->settings, context->key,
 				"Name", context->name);
 	g_key_file_set_string(gprs->settings, context->key,
-				"AccessPointName", context->context.apn);
+				"AccessPointName", context->apn);
 	g_key_file_set_string(gprs->settings, context->key,
-				"Username", context->context.username);
+				"Username", context->username);
 	g_key_file_set_string(gprs->settings, context->key,
-				"Password", context->context.password);
+				"Password", context->password);
 	g_key_file_set_string(gprs->settings, context->key, "Type",
 				gprs_context_type_to_string(context->type));
 	g_key_file_set_string(gprs->settings, context->key, "Protocol",
-				gprs_proto_to_string(context->context.proto));
+				gprs_proto_to_string(context->proto));
 }
 =

 static struct pri_context *add_context(struct ofono_gprs *gprs,
@@ -1711,7 +2025,8 @@ static DBusMessage *gprs_add_context(DBusConnection *=
conn,
 static void gprs_deactivate_for_remove(const struct ofono_error *error,
 						void *data)
 {
-	struct pri_context *ctx =3D data;
+	struct ofono_gprs_context *gc =3D data;
+	struct pri_context *ctx =3D gc->pri;
 	struct ofono_gprs *gprs =3D ctx->gprs;
 	DBusConnection *conn;
 	char *path;
@@ -1726,10 +2041,14 @@ static void gprs_deactivate_for_remove(const struct=
 ofono_error *error,
 		return;
 	}
 =

-	gprs_cid_release(gprs, ctx->context.cid);
-	ctx->context.cid =3D 0;
-	ctx->context_driver->inuse =3D FALSE;
-	ctx->context_driver =3D NULL;
+	release_packet_bearer(gc);
+
+	if (ctx->bearers !=3D NULL) {
+		gc =3D ctx->bearers->data;
+		gc->driver->deactivate_primary(gc, gc->cid,
+					gprs_deactivate_for_remove, gc);
+		return;
+	}
 =

 	if (gprs->settings) {
 		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
@@ -1776,15 +2095,16 @@ static DBusMessage *gprs_remove_context(DBusConnect=
ion *conn,
 		return __ofono_error_not_found(msg);
 =

 	if (ctx->active) {
-		struct ofono_gprs_context *gc =3D ctx->context_driver;
+		struct ofono_gprs_context *gc;
 =

 		/* This context is already being messed with */
 		if (ctx->pending)
 			return __ofono_error_busy(msg);
 =

 		gprs->pending =3D dbus_message_ref(msg);
-		gc->driver->deactivate_primary(gc, ctx->context.cid,
-					gprs_deactivate_for_remove, ctx);
+		gc =3D ctx->bearers->data;
+		gc->driver->deactivate_primary(gc, gc->cid,
+					gprs_deactivate_for_remove, gc);
 		return NULL;
 	}
 =

@@ -1810,7 +2130,8 @@ static DBusMessage *gprs_remove_context(DBusConnectio=
n *conn,
 static void gprs_deactivate_for_all(const struct ofono_error *error,
 					void *data)
 {
-	struct pri_context *ctx =3D data;
+	struct ofono_gprs_context *gc =3D data;
+	struct pri_context *ctx =3D gc->pri;
 	struct ofono_gprs *gprs =3D ctx->gprs;
 	DBusConnection *conn;
 	dbus_bool_t value;
@@ -1821,12 +2142,16 @@ static void gprs_deactivate_for_all(const struct of=
ono_error *error,
 		return;
 	}
 =

-	gprs_cid_release(gprs, ctx->context.cid);
-	ctx->active =3D FALSE;
-	ctx->context.cid =3D 0;
-	ctx->context_driver->inuse =3D FALSE;
-	ctx->context_driver =3D NULL;
+	release_packet_bearer(gc);
+
+	if (ctx->bearers !=3D NULL) {
+		gc =3D ctx->bearers->data;
+		gc->driver->deactivate_primary(gc, gc->cid,
+						gprs_deactivate_for_all, gc);
+		return;
+	}
 =

+	ctx->active =3D FALSE;
 	pri_reset_context_settings(ctx);
 =

 	value =3D ctx->active;
@@ -1850,9 +2175,9 @@ static void gprs_deactivate_next(struct ofono_gprs *g=
prs)
 		if (ctx->active =3D=3D FALSE)
 			continue;
 =

-		gc =3D ctx->context_driver;
-		gc->driver->deactivate_primary(gc, ctx->context.cid,
-					gprs_deactivate_for_all, ctx);
+		gc =3D ctx->bearers->data;
+		gc->driver->deactivate_primary(gc, gc->cid,
+						gprs_deactivate_for_all, gc);
 =

 		return;
 	}
@@ -2062,34 +2387,23 @@ void ofono_gprs_context_deactivated(struct ofono_gp=
rs_context *gc,
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	GSList *l;
-	struct pri_context *ctx;
+	struct pri_context *ctx =3D gc->pri;
 	dbus_bool_t value;
 =

-	if (gc->gprs =3D=3D NULL)
+	if (gc->gprs =3D=3D NULL || ctx =3D=3D NULL || ctx->active =3D=3D FALSE)
 		return;
 =

-	for (l =3D gc->gprs->contexts; l; l =3D l->next) {
-		ctx =3D l->data;
-
-		if (ctx->context.cid !=3D cid)
-			continue;
-
-		if (ctx->active =3D=3D FALSE)
-			break;
-
-		gprs_cid_release(ctx->gprs, ctx->context.cid);
-		ctx->context.cid =3D 0;
-		ctx->active =3D FALSE;
-		ctx->context_driver->inuse =3D FALSE;
-		ctx->context_driver =3D NULL;
+	release_packet_bearer(gc);
 =

-		pri_reset_context_settings(ctx);
+	if (ctx->bearers !=3D NULL)
+		return;
 =

-		value =3D FALSE;
-		ofono_dbus_signal_property_changed(conn, ctx->path,
+	ctx->active =3D FALSE;
+	pri_reset_context_settings(ctx);
+	value =3D FALSE;
+	ofono_dbus_signal_property_changed(conn, ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
-	}
 }
 =

 int ofono_gprs_context_driver_register(const struct ofono_gprs_context_dri=
ver *d)
@@ -2120,6 +2434,9 @@ static void gprs_context_remove(struct ofono_atom *at=
om)
 	if (gc =3D=3D NULL)
 		return;
 =

+	if (gc->pri !=3D NULL)
+		release_packet_bearer(gc);
+
 	if (gc->driver && gc->driver->remove)
 		gc->driver->remove(gc);
 =

@@ -2192,6 +2509,131 @@ void ofono_gprs_context_set_type(struct ofono_gprs_=
context *gc,
 	gc->type =3D type;
 }
 =

+static struct context_settings_ip *get_ip_settings(struct ofono_gprs_conte=
xt *gc)
+{
+	if (gc =3D=3D NULL)
+		return NULL;
+
+	if (gc->settings_ip =3D=3D NULL)
+		gc->settings_ip =3D g_try_new0(struct context_settings_ip, 1);
+
+	return gc->settings_ip;
+}
+
+void ofono_gprs_context_set_ip_interface(struct ofono_gprs_context *gc,
+					const char *interface)
+{
+	struct context_settings_ip *settings =3D get_ip_settings(gc);
+
+	if (settings =3D=3D NULL || settings->interface !=3D NULL)
+		return;
+
+	settings->interface =3D g_strdup(interface);
+}
+
+void ofono_gprs_context_set_ip_addrconf(struct ofono_gprs_context *gc,
+					enum ofono_gprs_addrconf_method method)
+{
+	struct context_settings_ip *settings =3D get_ip_settings(gc);
+
+	if (settings =3D=3D NULL || settings->method !=3D OFONO_GPRS_ADDRCONF_NON=
E)
+		return;
+
+	settings->method =3D method;
+}
+
+void ofono_gprs_context_set_ip_address(struct ofono_gprs_context *gc,
+					const char *address)
+{
+	struct context_settings_ip *settings =3D get_ip_settings(gc);
+
+	if (settings =3D=3D NULL || settings->ip !=3D NULL)
+		return;
+
+	settings->ip =3D g_strdup(address);
+}
+
+void ofono_gprs_context_set_ip_netmask(struct ofono_gprs_context *gc,
+					const char *netmask)
+{
+	struct context_settings_ip *settings =3D get_ip_settings(gc);
+
+	if (settings =3D=3D NULL || settings->netmask !=3D NULL)
+		return;
+
+	settings->netmask =3D g_strdup(netmask);
+}
+
+void ofono_gprs_context_set_ip_gateway(struct ofono_gprs_context *gc,
+					const char *gateway)
+{
+	struct context_settings_ip *settings =3D get_ip_settings(gc);
+
+	if (settings =3D=3D NULL || settings->gateway !=3D NULL)
+		return;
+
+	settings->gateway =3D g_strdup(gateway);
+}
+
+void ofono_gprs_context_set_ip_dns_servers(struct ofono_gprs_context *gc,
+						const char **dns)
+{
+	struct context_settings_ip *settings =3D get_ip_settings(gc);
+
+	if (settings =3D=3D NULL || settings->dns !=3D NULL)
+		return;
+
+	settings->dns =3D g_strdupv((char **)dns);
+}
+
+static struct context_settings_ipv6 *get_ipv6_settings(struct ofono_gprs_c=
ontext *gc)
+{
+	if (gc =3D=3D NULL)
+		return NULL;
+
+	if (gc->settings_ipv6 =3D=3D NULL) {
+		gc->settings_ipv6 =3D g_try_new0(struct context_settings_ipv6, 1);
+
+		if (gc->settings_ipv6 =3D=3D NULL)
+			return NULL;
+	}
+
+	return gc->settings_ipv6;
+}
+
+void ofono_gprs_context_set_ipv6_interface(struct ofono_gprs_context *gc,
+					const char *interface)
+{
+	struct context_settings_ipv6 *settings =3D get_ipv6_settings(gc);
+
+	if (settings =3D=3D NULL || settings->interface !=3D NULL)
+		return;
+
+	settings->interface =3D g_strdup(interface);
+}
+
+void ofono_gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
+						const char *address)
+{
+	struct context_settings_ipv6 *settings =3D get_ipv6_settings(gc);
+
+	if (settings =3D=3D NULL || settings->address !=3D NULL)
+		return;
+
+	settings->address =3D g_strdup(address);
+}
+
+void ofono_gprs_context_set_ipv6_dns_servers(struct ofono_gprs_context *gc,
+						const char **dns)
+{
+	struct context_settings_ipv6 *settings =3D get_ipv6_settings(gc);
+
+	if (settings =3D=3D NULL || settings->dns !=3D NULL)
+		return;
+
+	settings->dns =3D g_strdupv((char **)dns);
+}
+
 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -2431,10 +2873,10 @@ static gboolean load_context(struct ofono_gprs *gpr=
s, const char *group)
 =

 	idmap_take(gprs->pid_map, id);
 	context->id =3D id;
-	strcpy(context->context.username, username);
-	strcpy(context->context.password, password);
-	strcpy(context->context.apn, apn);
-	context->context.proto =3D proto;
+	strcpy(context->username, username);
+	strcpy(context->password, password);
+	strcpy(context->apn, apn);
+	context->proto =3D proto;
 =

 	if (msgproxy !=3D NULL)
 		strcpy(context->message_proxy, msgproxy);
-- =

1.7.1


--===============1545898102235130559==--

