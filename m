Content-Type: multipart/mixed; boundary="===============7969149391642903468=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND PATCH 04/13] gprs: core support for IPv6
Date: Mon, 14 Feb 2011 13:50:36 +0200
Message-ID: <1297684245-9737-5-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1297684245-9737-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7969149391642903468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  285 +++++++++++++++++++++++++++++++++++++++++++++-----------=
----
 1 files changed, 213 insertions(+), 72 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index b478f88..e19c5ca 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -34,6 +34,8 @@
 #include <net/route.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
 =

 #include <glib.h>
 #include <gdbus.h>
@@ -100,10 +102,12 @@ struct ofono_gprs {
 	struct ofono_sim_context *sim_context;
 };
 =

+struct pri_context;
+
 struct ofono_gprs_context {
 	struct ofono_gprs *gprs;
+	struct pri_context *pri;
 	enum ofono_gprs_context_type type;
-	ofono_bool_t inuse;
 	const struct ofono_gprs_context_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -112,10 +116,11 @@ struct ofono_gprs_context {
 struct context_settings {
 	enum ofono_gprs_context_type type;
 	char *interface;
-	gboolean static_ip;
+	enum ofono_gprs_addrconf method;
 	char *ip;
 	char *netmask;
 	char *gateway;
+	char *ipv6;
 	char **dns;
 	char *proxy;
 };
@@ -227,6 +232,8 @@ static const char *gprs_proto_to_string(enum ofono_gprs=
_proto proto)
 		return "ip";
 	case OFONO_GPRS_PROTO_IPV6:
 		return "ipv6";
+	case OFONO_GPRS_PROTO_IPV4V6:
+		return "ipv4v6";
 	};
 =

 	return NULL;
@@ -241,11 +248,28 @@ static gboolean gprs_proto_from_string(const char *st=
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

+static const char *gprs_addrconf_to_string(enum ofono_gprs_addrconf method)
+{
+	switch (method) {
+	case OFONO_GPRS_ADDRCONF_NONE:
+		return NULL;
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
@@ -274,13 +298,13 @@ static gboolean assign_context(struct pri_context *ct=
x)
 	for (l =3D ctx->gprs->context_drivers; l; l =3D l->next) {
 		struct ofono_gprs_context *gc =3D l->data;
 =

-		if (gc->inuse =3D=3D TRUE)
+		if (gc->pri !=3D NULL)
 			continue;
 =

 		if (gc->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_ANY ||
 						gc->type =3D=3D ctx->type) {
 			ctx->context_driver =3D gc;
-			ctx->context_driver->inuse =3D TRUE;
+			gc->pri =3D ctx;
 			return TRUE;
 		}
 	}
@@ -295,7 +319,7 @@ static void release_context(struct pri_context *ctx)
 =

 	gprs_cid_release(ctx->gprs, ctx->context.cid);
 	ctx->context.cid =3D 0;
-	ctx->context_driver->inuse =3D FALSE;
+	ctx->context_driver->pri =3D NULL;
 	ctx->context_driver =3D NULL;
 }
 =

@@ -314,14 +338,22 @@ static struct pri_context *gprs_context_by_path(struc=
t ofono_gprs *gprs,
 	return NULL;
 }
 =

-static void context_settings_free(struct context_settings *settings)
+static void pri_context_settings_free(struct pri_context *ctx)
 {
+	struct context_settings *settings =3D ctx->settings;
+
+	if (settings =3D=3D NULL)
+		return;
+
+	ctx->settings =3D NULL;
+
 	g_free(settings->interface);
 	g_free(settings->ip);
 	g_free(settings->netmask);
 	g_free(settings->gateway);
 	g_strfreev(settings->dns);
 	g_free(settings->proxy);
+	g_free(settings->ipv6);
 =

 	g_free(settings);
 }
@@ -360,12 +392,10 @@ static void context_settings_append_variant(struct co=
ntext_settings *settings,
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
@@ -379,6 +409,10 @@ static void context_settings_append_variant(struct con=
text_settings *settings,
 		ofono_dbus_dict_append(&array, "Gateway", DBUS_TYPE_STRING,
 					&settings->gateway);
 =

+	if (settings->ipv6 !=3D NULL)
+		ofono_dbus_dict_append(&array, "IPv6Address", DBUS_TYPE_STRING,
+					&settings->ipv6);
+
 	if (settings->dns)
 		ofono_dbus_dict_append_array(&array, "DomainNameServers",
 						DBUS_TYPE_STRING,
@@ -556,6 +590,65 @@ done:
 	close(sk);
 }
 =

+static void pri_setipv6(const char *interface, const char *address,
+			ofono_bool_t up)
+{
+	struct ifreq ifr;
+	struct nlmsghdr *nlh;
+	struct ifaddrmsg *ifa;
+	struct rtattr *rta;
+	struct sockaddr_nl sa =3D {.nl_family =3D AF_NETLINK };
+	int sk;
+	char buf[256];
+
+	if (interface =3D=3D NULL)
+		return;
+
+	sk =3D socket(PF_INET6, SOCK_DGRAM, 0);
+	if (sk < 0)
+		return;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, interface, IFNAMSIZ);
+
+	if (ioctl(sk, SIOCGIFINDEX, &ifr) < 0)
+		goto done;
+
+	close(sk);
+
+	sk =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	if (sk < 0)
+		return;
+
+	nlh =3D (struct nlmsghdr *)buf;
+
+	nlh->nlmsg_type =3D up ? RTM_NEWADDR : RTM_DELADDR;
+	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	nlh->nlmsg_pid =3D getpid();
+	nlh->nlmsg_seq =3D 0;
+
+	ifa =3D NLMSG_DATA(nlh);
+
+	ifa->ifa_family =3D AF_INET6;
+	ifa->ifa_prefixlen =3D 64;
+	ifa->ifa_flags =3D IFA_F_PERMANENT | IFA_F_NODAD;
+	ifa->ifa_scope =3D RT_SCOPE_LINK;
+	ifa->ifa_index =3D ifr.ifr_ifindex;
+
+	rta =3D IFA_RTA(ifa);
+
+	rta->rta_type =3D IFA_ADDRESS;
+	rta->rta_len =3D RTA_LENGTH(sizeof(struct in6_addr));
+	inet_pton(AF_INET6, address, RTA_DATA(rta));
+
+	nlh->nlmsg_len =3D NLMSG_LENGTH(sizeof(*ifa) + rta->rta_len);
+
+	sendto(sk, nlh, nlh->nlmsg_len, 0, (struct sockaddr *)&sa, sizeof(sa));
+
+done:
+	close(sk);
+}
+
 static void pri_setproxy(const char *interface, const char *proxy)
 {
 	struct rtentry rt;
@@ -596,68 +689,54 @@ static void pri_setproxy(const char *interface, const=
 char *proxy)
 =

 static void pri_reset_context_settings(struct pri_context *ctx)
 {
-	char *interface;
+	struct context_settings *settings =3D ctx->settings;
 =

-	if (ctx->settings =3D=3D NULL)
+	if (settings =3D=3D NULL)
 		return;
 =

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
+		pri_setaddr(settings->interface, NULL);
 =

 		g_free(ctx->proxy_host);
 		ctx->proxy_host =3D NULL;
 		ctx->proxy_port =3D 0;
 	}
 =

-	pri_ifupdown(interface, FALSE);
+	if (settings->ipv6 !=3D NULL)
+		pri_setipv6(settings->interface, settings->ipv6, FALSE);
 =

-	g_free(interface);
+	pri_ifupdown(settings->interface, FALSE);
+
+	pri_context_settings_free(ctx);
+	pri_context_signal_settings(ctx);
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
+	struct context_settings *settings =3D ctx->settings;
 =

-	ctx->settings =3D g_try_new0(struct context_settings, 1);
-	if (ctx->settings =3D=3D NULL)
+	if (settings =3D=3D NULL || settings->interface =3D=3D NULL)
 		return;
 =

-	ctx->settings->type =3D ctx->type;
-
-	ctx->settings->interface =3D g_strdup(interface);
-	ctx->settings->static_ip =3D static_ip;
-	ctx->settings->ip =3D g_strdup(ip);
-	ctx->settings->netmask =3D g_strdup(netmask);
-	ctx->settings->gateway =3D g_strdup(gateway);
-	ctx->settings->dns =3D g_strdupv((char **)dns);
+	settings->type =3D ctx->type;
 =

 	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS && ctx->message_proxy)
-		ctx->settings->proxy =3D g_strdup(ctx->message_proxy);
+		settings->proxy =3D g_strdup(ctx->message_proxy);
+
+	if (settings->ipv6 !=3D NULL)
+		pri_setipv6(settings->interface, settings->ipv6, TRUE);
 =

-	pri_ifupdown(interface, TRUE);
+	pri_ifupdown(settings->interface, TRUE);
 =

 	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
 		pri_parse_proxy(ctx, ctx->message_proxy);
 =

 		DBG("proxy %s port %u", ctx->proxy_host, ctx->proxy_port);
 =

-		pri_setaddr(interface, ip);
+		pri_setaddr(settings->interface, settings->ip);
 =

 		if (ctx->proxy_host)
-			pri_setproxy(interface, ctx->proxy_host);
+			pri_setproxy(settings->interface, ctx->proxy_host);
 	}
 =

 	pri_context_signal_settings(ctx);
@@ -729,25 +808,19 @@ static DBusMessage *pri_get_properties(DBusConnection=
 *conn,
 	return reply;
 }
 =

-static void pri_activate_callback(const struct ofono_error *error,
-					const char *interface,
-					ofono_bool_t static_ip,
-					const char *ip, const char *netmask,
-					const char *gateway, const char **dns,
-					void *data)
+static void pri_activate_callback(const struct ofono_error *error, void *d=
ata)
 {
 	struct pri_context *ctx =3D data;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	dbus_bool_t value;
 =

-	DBG("%p %s", ctx, interface);
-
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Activating context failed with error: %s",
 				telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&ctx->pending,
 					__ofono_error_failed(ctx->pending));
 		release_context(ctx);
+		pri_context_settings_free(ctx);
 		return;
 	}
 =

@@ -755,14 +828,7 @@ static void pri_activate_callback(const struct ofono_e=
rror *error,
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
-
+	pri_update_context_settings(ctx);
 	value =3D ctx->active;
 	ofono_dbus_signal_property_changed(conn, ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
@@ -1079,15 +1145,22 @@ static DBusMessage *pri_set_property(DBusConnection=
 *conn,
 			return __ofono_error_attach_in_progress(msg);
 =

 		if (value) {
-			if (assign_context(ctx) =3D=3D FALSE)
-				return __ofono_error_not_implemented(msg);
+			pri_context_settings_free(ctx);
+			ctx->settings =3D g_try_new0(struct context_settings, 1);
+			if (ctx->settings =3D=3D NULL)
+				return __ofono_error_failed(msg);
+
+			assign_context(ctx);
 		}
 =

 		gc =3D ctx->context_driver;
 		if (gc =3D=3D NULL || gc->driver =3D=3D NULL ||
 				gc->driver->activate_primary =3D=3D NULL ||
-				gc->driver->deactivate_primary =3D=3D NULL)
+				gc->driver->deactivate_primary =3D=3D NULL) {
+			release_context(ctx);
+			pri_context_settings_free(ctx);
 			return __ofono_error_not_implemented(msg);
+		}
 =

 		ctx->pending =3D dbus_message_ref(msg);
 =

@@ -1211,15 +1284,9 @@ static void pri_context_destroy(gpointer userdata)
 {
 	struct pri_context *ctx =3D userdata;
 =

-	if (ctx->settings) {
-		context_settings_free(ctx->settings);
-		ctx->settings =3D NULL;
-	}
-
+	pri_context_settings_free(ctx);
 	g_free(ctx->proxy_host);
-
 	g_free(ctx->path);
-
 	g_free(ctx);
 }
 =

@@ -2120,6 +2187,8 @@ static void gprs_context_remove(struct ofono_atom *at=
om)
 	if (gc =3D=3D NULL)
 		return;
 =

+	release_context(gc->pri);
+
 	if (gc->driver && gc->driver->remove)
 		gc->driver->remove(gc);
 =

@@ -2192,6 +2261,78 @@ void ofono_gprs_context_set_type(struct ofono_gprs_c=
ontext *gc,
 	gc->type =3D type;
 }
 =

+void ofono_gprs_context_set_interface(struct ofono_gprs_context *gc,
+					const char *interface)
+{
+	struct context_settings *settings =3D gc->pri->settings;
+
+	g_free(settings->interface);
+	settings->interface =3D g_strdup(interface);
+}
+
+void ofono_gprs_context_set_ip_addrconf(struct ofono_gprs_context *gc,
+					enum ofono_gprs_addrconf method)
+{
+	struct context_settings *settings =3D gc->pri->settings;
+
+	settings->method =3D method;
+}
+
+void ofono_gprs_context_set_ip_address(struct ofono_gprs_context *gc,
+					const char *address)
+{
+	struct context_settings *settings =3D gc->pri->settings;
+
+	g_free(settings->ip);
+	settings->ip =3D g_strdup(address);
+}
+
+void ofono_gprs_context_set_ip_netmask(struct ofono_gprs_context *gc,
+					const char *netmask)
+{
+	struct context_settings *settings =3D gc->pri->settings;
+
+	g_free(settings->netmask);
+	settings->netmask =3D g_strdup(netmask);
+}
+
+void ofono_gprs_context_set_ip_gateway(struct ofono_gprs_context *gc,
+					const char *gateway)
+{
+	struct context_settings *settings =3D gc->pri->settings;
+
+	g_free(settings->gateway);
+	settings->gateway =3D g_strdup(gateway);
+}
+
+void ofono_gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
+						const char *address)
+{
+	struct context_settings *settings =3D gc->pri->settings;
+	uint8_t *addr =3D alloca(sizeof(struct in6_addr));
+	char *straddr =3D alloca(INET6_ADDRSTRLEN);
+
+	if (!inet_pton(AF_INET6, address, addr))
+		return;
+
+	memset(addr, 0, 8);
+	addr[0] =3D 0xfe;
+	addr[1] =3D 0x80;
+	inet_ntop(AF_INET6, addr, straddr, INET6_ADDRSTRLEN);
+
+	g_free(settings->ipv6);
+	settings->ipv6 =3D g_strdup(straddr);
+}
+
+void ofono_gprs_context_set_dns_servers(struct ofono_gprs_context *gc,
+						const char **dns)
+{
+	struct context_settings *settings =3D gc->pri->settings;
+
+	g_strfreev(settings->dns);
+	settings->dns =3D g_strdupv((char **)dns);
+}
+
 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
-- =

1.7.1


--===============7969149391642903468==--

