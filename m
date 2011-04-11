Content-Type: multipart/mixed; boundary="===============0099802622402678142=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 04/20] build: add generalised packet files
Date: Mon, 11 Apr 2011 13:20:02 +0300
Message-ID: <1302517218-2147-5-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0099802622402678142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

packet.c and ps-provision.c are just the copy-paste
of gprs.c and gprs-provision.c files with generic
naming convention.
---
 Makefile.am        |    4 +-
 src/ofono.h        |   14 +
 src/packet.c       | 2939 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ps-provision.c |  101 ++
 4 files changed, 3056 insertions(+), 2 deletions(-)
 create mode 100644 src/packet.c
 create mode 100644 src/ps-provision.c

diff --git a/Makefile.am b/Makefile.am
index ac65d4d..c1cc701 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -379,7 +379,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/phonebook.c src/history.c src/message-waiting.c \
 			src/simutil.h src/simutil.c src/storage.h \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
-			src/gprs.c src/idmap.h src/idmap.c \
+			src/gprs.c src/idmap.h src/idmap.c src/packet.c \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
@@ -388,7 +388,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/message.h src/message.c src/gprs-provision.c \
 			src/emulator.c src/location-reporting.c \
 			src/cdma-connman.c src/gnss.c \
-			src/gnssagent.c src/gnssagent.h
+			src/gnssagent.c src/gnssagent.h src/ps-provision.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/ofono.h b/src/ofono.h
index 156bc40..206c593 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -122,6 +122,8 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPES_CALL_VOLUME,
 	OFONO_ATOM_TYPE_GPRS,
 	OFONO_ATOM_TYPE_GPRS_CONTEXT,
+	OFONO_ATOM_TYPE_PACKET_SERVICE,
+	OFONO_ATOM_TYPE_PACKET_CONTEXT,
 	OFONO_ATOM_TYPE_RADIO_SETTINGS,
 	OFONO_ATOM_TYPE_AUDIO_SETTINGS,
 	OFONO_ATOM_TYPE_STK,
@@ -239,6 +241,8 @@ gboolean __ofono_call_settings_is_busy(struct ofono_cal=
l_settings *cs);
 #include <ofono/phonebook.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/packet-service.h>
+#include <ofono/packet-context.h>
 #include <ofono/radio-settings.h>
 #include <ofono/audio-settings.h>
 #include <ofono/ctm.h>
@@ -463,5 +467,15 @@ void __ofono_gprs_provision_free_settings(
 				struct ofono_gprs_provision_data *settings,
 				int count);
 =

+#include <ofono/ps-provision.h>
+
+ofono_bool_t __ofono_ps_provision_get_settings(const char *mcc,
+				const char *mnc, const char *spn,
+				struct ofono_ps_provision_data **settings,
+				int *count);
+void __ofono_ps_provision_free_settings(
+				struct ofono_ps_provision_data *settings,
+				int count);
+
 #include <ofono/emulator.h>
 #include <ofono/gnss.h>
diff --git a/src/packet.c b/src/packet.c
new file mode 100644
index 0000000..1acbf76
--- /dev/null
+++ b/src/packet.c
@@ -0,0 +1,2939 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <net/route.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+
+#include "common.h"
+#include "storage.h"
+#include "idmap.h"
+#include "simutil.h"
+#include "util.h"
+
+#define PS_FLAG_ATTACHING 0x1
+#define PS_FLAG_RECHECK 0x2
+
+#define SETTINGS_STORE "ps"
+#define SETTINGS_GROUP "Settings"
+#define MAX_CONTEXT_NAME_LENGTH 127
+#define MAX_MESSAGE_PROXY_LENGTH 255
+#define MAX_MESSAGE_CENTER_LENGTH 255
+#define MAX_CONTEXTS 256
+#define SUSPEND_TIMEOUT 8
+
+static GSList *g_drivers =3D NULL;
+static GSList *g_context_drivers =3D NULL;
+
+struct ofono_packet_service {
+	GSList *contexts;
+	ofono_bool_t attached;
+	ofono_bool_t driver_attached;
+	ofono_bool_t roaming_allowed;
+	ofono_bool_t powered;
+	ofono_bool_t suspended;
+	int status;
+	int flags;
+	int bearer;
+	guint suspend_timeout;
+	struct idmap *pid_map;
+	unsigned int last_context_id;
+	struct idmap *cid_map;
+	int netreg_status;
+	struct ofono_netreg *netreg;
+	unsigned int netreg_watch;
+	unsigned int status_watch;
+	GKeyFile *settings;
+	char *imsi;
+	DBusMessage *pending;
+	GSList *context_drivers;
+	const struct ofono_packet_service_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+	struct ofono_sim_context *sim_context;
+};
+
+struct ipv4_settings {
+	gboolean static_ip;
+	char *ip;
+	char *netmask;
+	char *gateway;
+	char **dns;
+	char *proxy;
+};
+
+struct ipv6_settings {
+	char *ip;
+	unsigned char prefix_len;
+	char *gateway;
+	char **dns;
+};
+
+struct context_settings {
+	char *interface;
+	struct ipv4_settings *ipv4;
+	struct ipv6_settings *ipv6;
+};
+
+struct ofono_packet_context {
+	struct ofono_packet_service *ps;
+	enum ofono_packet_context_type type;
+	ofono_bool_t inuse;
+	const struct ofono_packet_context_driver *driver;
+	void *driver_data;
+	struct context_settings *settings;
+	struct ofono_atom *atom;
+};
+
+struct context {
+	ofono_bool_t active;
+	enum ofono_packet_context_type type;
+	char name[MAX_CONTEXT_NAME_LENGTH + 1];
+	char message_proxy[MAX_MESSAGE_PROXY_LENGTH + 1];
+	char message_center[MAX_MESSAGE_CENTER_LENGTH + 1];
+	unsigned int id;
+	char *path;
+	char *key;
+	char *proxy_host;
+	uint16_t proxy_port;
+	DBusMessage *pending;
+	struct ofono_packet_context_param context;
+	struct ofono_packet_context *context_driver;
+	struct ofono_packet_service *ps;
+};
+
+static void ps_netreg_update(struct ofono_packet_service *ps);
+static void ps_deactivate_next(struct ofono_packet_service *ps);
+
+static const char *packet_context_default_name(enum ofono_packet_context_t=
ype type)
+{
+	switch (type) {
+	case OFONO_PACKET_CONTEXT_TYPE_ANY:
+		return NULL;
+	case OFONO_PACKET_CONTEXT_TYPE_INTERNET:
+		return "Internet";
+	case OFONO_PACKET_CONTEXT_TYPE_MMS:
+		return "MMS";
+	case OFONO_PACKET_CONTEXT_TYPE_WAP:
+		return "WAP";
+	case OFONO_PACKET_CONTEXT_TYPE_IMS:
+		return "IMS";
+	}
+
+	return NULL;
+}
+
+static const char *packet_context_type_to_string(
+					enum ofono_packet_context_type type)
+{
+	switch (type) {
+	case OFONO_PACKET_CONTEXT_TYPE_ANY:
+		return NULL;
+	case OFONO_PACKET_CONTEXT_TYPE_INTERNET:
+		return "internet";
+	case OFONO_PACKET_CONTEXT_TYPE_MMS:
+		return "mms";
+	case OFONO_PACKET_CONTEXT_TYPE_WAP:
+		return "wap";
+	case OFONO_PACKET_CONTEXT_TYPE_IMS:
+		return "ims";
+	}
+
+	return NULL;
+}
+
+static gboolean packet_context_string_to_type(const char *str,
+					enum ofono_packet_context_type *out)
+{
+	if (g_str_equal(str, "internet")) {
+		*out =3D OFONO_PACKET_CONTEXT_TYPE_INTERNET;
+		return TRUE;
+	} else if (g_str_equal(str, "wap")) {
+		*out =3D OFONO_PACKET_CONTEXT_TYPE_WAP;
+		return TRUE;
+	} else if (g_str_equal(str, "mms")) {
+		*out =3D OFONO_PACKET_CONTEXT_TYPE_MMS;
+		return TRUE;
+	} else if (g_str_equal(str, "ims")) {
+		*out =3D OFONO_PACKET_CONTEXT_TYPE_IMS;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static const char *packet_proto_to_string(enum ofono_packet_proto proto)
+{
+	switch (proto) {
+	case OFONO_PACKET_PROTO_IP:
+		return "ip";
+	case OFONO_PACKET_PROTO_IPV6:
+		return "ipv6";
+	case OFONO_PACKET_PROTO_IPV4V6:
+		return "dual";
+	};
+
+	return NULL;
+}
+
+static gboolean packet_proto_from_string(const char *str,
+					enum ofono_packet_proto *proto)
+{
+	if (g_str_equal(str, "ip")) {
+		*proto =3D OFONO_PACKET_PROTO_IP;
+		return TRUE;
+	} else if (g_str_equal(str, "ipv6")) {
+		*proto =3D OFONO_PACKET_PROTO_IPV6;
+		return TRUE;
+	} else if (g_str_equal(str, "dual")) {
+		*proto =3D OFONO_PACKET_PROTO_IPV4V6;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static unsigned int ps_cid_alloc(struct ofono_packet_service *ps)
+{
+	return idmap_alloc(ps->cid_map);
+}
+
+static void ps_cid_release(struct ofono_packet_service *ps, unsigned int i=
d)
+{
+	idmap_put(ps->cid_map, id);
+}
+
+static gboolean assign_context(struct context *ctx)
+{
+	struct idmap *cidmap =3D ctx->ps->cid_map;
+	unsigned int cid_min;
+	GSList *l;
+
+	if (cidmap =3D=3D NULL)
+		return FALSE;
+
+	cid_min =3D idmap_get_min(cidmap);
+
+	ctx->context.cid =3D ps_cid_alloc(ctx->ps);
+	if (ctx->context.cid =3D=3D 0)
+		return FALSE;
+
+	for (l =3D ctx->ps->context_drivers; l; l =3D l->next) {
+		struct ofono_packet_context *pc =3D l->data;
+
+		if (pc->inuse =3D=3D TRUE)
+			continue;
+
+		if (pc->driver =3D=3D NULL)
+			continue;
+
+		if (pc->driver->activate_context =3D=3D NULL ||
+				pc->driver->deactivate_context =3D=3D NULL)
+			continue;
+
+		if (pc->type !=3D OFONO_PACKET_CONTEXT_TYPE_ANY &&
+				pc->type !=3D ctx->type)
+			continue;
+
+		ctx->context_driver =3D pc;
+		ctx->context_driver->inuse =3D TRUE;
+
+		if (ctx->context.proto =3D=3D OFONO_PACKET_PROTO_IPV4V6 ||
+				ctx->context.proto =3D=3D OFONO_PACKET_PROTO_IP)
+			pc->settings->ipv4 =3D g_new0(struct ipv4_settings, 1);
+
+		if (ctx->context.proto =3D=3D OFONO_PACKET_PROTO_IPV4V6 ||
+				ctx->context.proto =3D=3D OFONO_PACKET_PROTO_IPV6)
+			pc->settings->ipv6 =3D g_new0(struct ipv6_settings, 1);
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static void release_context(struct context *ctx)
+{
+	if (ctx =3D=3D NULL || ctx->ps =3D=3D NULL || ctx->context_driver =3D=3D =
NULL)
+		return;
+
+	ps_cid_release(ctx->ps, ctx->context.cid);
+	ctx->context.cid =3D 0;
+	ctx->context_driver->inuse =3D FALSE;
+	ctx->context_driver =3D NULL;
+	ctx->active =3D FALSE;
+}
+
+static struct context *packet_context_by_path(
+					struct ofono_packet_service *ps,
+					const char *ctx_path)
+{
+	GSList *l;
+
+	for (l =3D ps->contexts; l; l =3D l->next) {
+		struct context *ctx =3D l->data;
+
+		if (g_str_equal(ctx_path, ctx->path))
+			return ctx;
+	}
+
+	return NULL;
+}
+
+static void context_settings_free(struct context_settings *settings)
+{
+	if (settings->ipv4) {
+		g_free(settings->ipv4->ip);
+		g_free(settings->ipv4->netmask);
+		g_free(settings->ipv4->gateway);
+		g_strfreev(settings->ipv4->dns);
+		g_free(settings->ipv4->proxy);
+
+		g_free(settings->ipv4);
+		settings->ipv4 =3D NULL;
+	}
+
+	if (settings->ipv6) {
+		g_free(settings->ipv6->ip);
+		g_free(settings->ipv6->gateway);
+		g_strfreev(settings->ipv6->dns);
+
+		g_free(settings->ipv6);
+		settings->ipv6 =3D NULL;
+	}
+
+	g_free(settings->interface);
+	settings->interface =3D NULL;
+}
+
+static void context_settings_append_ipv4(struct context_settings *settings,
+						DBusMessageIter *iter)
+{
+	DBusMessageIter variant;
+	DBusMessageIter array;
+	char typesig[5];
+	char arraysig[6];
+	const char *method;
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
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						typesig, &array);
+	if (settings =3D=3D NULL || settings->ipv4 =3D=3D NULL)
+		goto done;
+
+	ofono_dbus_dict_append(&array, "Interface",
+				DBUS_TYPE_STRING, &settings->interface);
+
+	/* If we have a Proxy, no other settings are relevant */
+	if (settings->ipv4->proxy) {
+		ofono_dbus_dict_append(&array, "Proxy", DBUS_TYPE_STRING,
+					&settings->ipv4->proxy);
+		goto done;
+	}
+
+	if (settings->ipv4->static_ip =3D=3D TRUE)
+		method =3D "static";
+	else
+		method =3D "dhcp";
+
+	ofono_dbus_dict_append(&array, "Method", DBUS_TYPE_STRING, &method);
+
+	if (settings->ipv4->ip)
+		ofono_dbus_dict_append(&array, "Address", DBUS_TYPE_STRING,
+					&settings->ipv4->ip);
+
+	if (settings->ipv4->netmask)
+		ofono_dbus_dict_append(&array, "Netmask", DBUS_TYPE_STRING,
+					&settings->ipv4->netmask);
+
+	if (settings->ipv4->gateway)
+		ofono_dbus_dict_append(&array, "Gateway", DBUS_TYPE_STRING,
+					&settings->ipv4->gateway);
+
+	if (settings->ipv4->dns)
+		ofono_dbus_dict_append_array(&array, "DomainNameServers",
+						DBUS_TYPE_STRING,
+						&settings->ipv4->dns);
+
+done:
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+static void context_settings_append_ipv4_dict(struct context_settings *set=
tings,
+						DBusMessageIter *dict)
+{
+	DBusMessageIter entry;
+	const char *key =3D "Settings";
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	context_settings_append_ipv4(settings, &entry);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void context_settings_append_ipv6(struct context_settings *settings,
+						DBusMessageIter *iter)
+{
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
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						typesig, &array);
+	if (settings =3D=3D NULL || settings->ipv6 =3D=3D NULL)
+		goto done;
+
+	ofono_dbus_dict_append(&array, "Interface",
+				DBUS_TYPE_STRING, &settings->interface);
+
+	if (settings->ipv6->ip)
+		ofono_dbus_dict_append(&array, "Address", DBUS_TYPE_STRING,
+					&settings->ipv6->ip);
+
+	if (settings->ipv6->prefix_len)
+		ofono_dbus_dict_append(&array, "PrefixLength", DBUS_TYPE_BYTE,
+					&settings->ipv6->prefix_len);
+
+	if (settings->ipv6->gateway)
+		ofono_dbus_dict_append(&array, "Gateway", DBUS_TYPE_STRING,
+					&settings->ipv6->gateway);
+
+	if (settings->ipv6->dns)
+		ofono_dbus_dict_append_array(&array, "DomainNameServers",
+						DBUS_TYPE_STRING,
+						&settings->ipv6->dns);
+
+done:
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+static void context_settings_append_ipv6_dict(struct context_settings *set=
tings,
+						DBusMessageIter *dict)
+{
+	DBusMessageIter entry;
+	const char *key =3D "IPv6.Settings";
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	context_settings_append_ipv6(settings, &entry);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void signal_settings(struct context *ctx, const char *prop,
+		void (*append)(struct context_settings *, DBusMessageIter *))
+
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ctx->path;
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	struct context_settings *settings;
+
+	signal =3D dbus_message_new_signal(path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"PropertyChanged");
+
+	if (signal =3D=3D NULL)
+		return;
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &prop);
+
+	if (ctx->context_driver)
+		settings =3D ctx->context_driver->settings;
+	else
+		settings =3D NULL;
+
+	append(settings, &iter);
+	g_dbus_send_message(conn, signal);
+}
+
+static void context_signal_settings(struct context *ctx,
+					gboolean ipv4, gboolean ipv6)
+{
+	if (ipv4)
+		signal_settings(ctx, "Settings",
+				context_settings_append_ipv4);
+
+	if (ipv6)
+		signal_settings(ctx, "IPv6.Settings",
+				context_settings_append_ipv6);
+}
+
+static void parse_proxy(struct context *ctx, const char *proxy)
+{
+	char *scheme, *host, *port, *path;
+
+	scheme =3D g_strdup(proxy);
+	if (scheme =3D=3D NULL)
+		return;
+
+	host =3D strstr(scheme, "://");
+	if (host !=3D NULL) {
+		*host =3D '\0';
+		host +=3D 3;
+
+		if (strcasecmp(scheme, "https") =3D=3D 0)
+			ctx->proxy_port =3D 443;
+		else if (strcasecmp(scheme, "http") =3D=3D 0)
+			ctx->proxy_port =3D 80;
+		else {
+			g_free(scheme);
+			return;
+		}
+	} else {
+		host =3D scheme;
+		ctx->proxy_port =3D 80;
+	}
+
+	path =3D strchr(host, '/');
+	if (path !=3D NULL)
+		*(path++) =3D '\0';
+
+	port =3D strrchr(host, ':');
+	if (port !=3D NULL) {
+		char *end;
+		int tmp =3D strtol(port + 1, &end, 10);
+
+		if (*end =3D=3D '\0') {
+			*port =3D '\0';
+			ctx->proxy_port =3D tmp;
+		}
+	}
+
+	g_free(ctx->proxy_host);
+	ctx->proxy_host =3D g_strdup(host);
+
+	g_free(scheme);
+}
+
+static void ifupdown(const char *interface, ofono_bool_t active)
+{
+	struct ifreq ifr;
+	int sk;
+
+	if (interface =3D=3D NULL)
+		return;
+
+	sk =3D socket(PF_INET, SOCK_DGRAM, 0);
+	if (sk < 0)
+		return;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, interface, IFNAMSIZ);
+
+	if (ioctl(sk, SIOCGIFFLAGS, &ifr) < 0)
+		goto done;
+
+	if (active =3D=3D TRUE) {
+		if (ifr.ifr_flags & IFF_UP)
+			goto done;
+		ifr.ifr_flags |=3D IFF_UP;
+	} else {
+		if (!(ifr.ifr_flags & IFF_UP))
+			goto done;
+		ifr.ifr_flags &=3D ~IFF_UP;
+	}
+
+	if (ioctl(sk, SIOCSIFFLAGS, &ifr) < 0)
+		ofono_error("Failed to change interface flags");
+
+done:
+	close(sk);
+}
+
+static void set_ipv4_addr(const char *interface, const char *address)
+{
+	struct ifreq ifr;
+	struct sockaddr_in addr;
+	int sk;
+
+	if (interface =3D=3D NULL)
+		return;
+
+	sk =3D socket(PF_INET, SOCK_DGRAM, 0);
+	if (sk < 0)
+		return;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, interface, IFNAMSIZ);
+
+	if (ioctl(sk, SIOCGIFFLAGS, &ifr) < 0)
+		goto done;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D address ? inet_addr(address) : INADDR_ANY;
+	memcpy(&ifr.ifr_addr, &addr, sizeof(ifr.ifr_addr));
+
+	if (ioctl(sk, SIOCSIFADDR, &ifr) < 0) {
+		ofono_error("Failed to set interface address");
+		goto done;
+	}
+
+	if (address =3D=3D NULL)
+		goto done;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D inet_addr("255.255.255.255");
+	memcpy(&ifr.ifr_netmask, &addr, sizeof(ifr.ifr_netmask));
+
+	if (ioctl(sk, SIOCSIFNETMASK, &ifr) < 0)
+		ofono_error("Failed to set interface netmask");
+
+done:
+	close(sk);
+}
+
+static void setproxy(const char *interface, const char *proxy)
+{
+	struct rtentry rt;
+	struct sockaddr_in addr;
+	int sk;
+
+	if (interface =3D=3D NULL)
+		return;
+
+	sk =3D socket(PF_INET, SOCK_DGRAM, 0);
+	if (sk < 0)
+		return;
+
+	memset(&rt, 0, sizeof(rt));
+	rt.rt_flags =3D RTF_UP | RTF_HOST;
+	rt.rt_dev =3D (char *) interface;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D inet_addr(proxy);
+	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D INADDR_ANY;
+	memcpy(&rt.rt_gateway, &addr, sizeof(rt.rt_gateway));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D INADDR_ANY;
+	memcpy(&rt.rt_genmask, &addr, sizeof(rt.rt_genmask));
+
+	if (ioctl(sk, SIOCADDRT, &rt) < 0)
+		ofono_error("Failed to add proxy host route");
+
+	close(sk);
+}
+
+static void reset_context_settings(struct context *ctx)
+{
+	struct context_settings *settings;
+	char *interface;
+	gboolean signal_ipv4;
+	gboolean signal_ipv6;
+
+	if (ctx->context_driver =3D=3D NULL)
+		return;
+
+	settings =3D ctx->context_driver->settings;
+
+	interface =3D settings->interface;
+	settings->interface =3D NULL;
+
+	signal_ipv4 =3D settings->ipv4 !=3D NULL;
+	signal_ipv6 =3D settings->ipv6 !=3D NULL;
+
+	context_settings_free(settings);
+
+	context_signal_settings(ctx, signal_ipv4, signal_ipv6);
+
+	if (ctx->type =3D=3D OFONO_PACKET_CONTEXT_TYPE_MMS) {
+		set_ipv4_addr(interface, NULL);
+
+		g_free(ctx->proxy_host);
+		ctx->proxy_host =3D NULL;
+		ctx->proxy_port =3D 0;
+	}
+
+	ifupdown(interface, FALSE);
+
+	g_free(interface);
+}
+
+static void update_mms_context_settings(struct context *ctx)
+{
+	struct ofono_packet_context *pc =3D ctx->context_driver;
+	struct context_settings *settings =3D pc->settings;
+
+	if (ctx->message_proxy)
+		settings->ipv4->proxy =3D g_strdup(ctx->message_proxy);
+
+	parse_proxy(ctx, ctx->message_proxy);
+
+	DBG("proxy %s port %u", ctx->proxy_host, ctx->proxy_port);
+
+	set_ipv4_addr(settings->interface, settings->ipv4->ip);
+
+	if (ctx->proxy_host)
+		setproxy(settings->interface, ctx->proxy_host);
+}
+
+static void append_context_properties(struct context *ctx,
+					DBusMessageIter *dict)
+{
+	const char *type =3D packet_context_type_to_string(ctx->type);
+	const char *proto =3D packet_proto_to_string(ctx->context.proto);
+	const char *name =3D ctx->name;
+	dbus_bool_t value;
+	const char *strvalue;
+	struct context_settings *settings;
+
+	ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);
+
+	value =3D ctx->active;
+	ofono_dbus_dict_append(dict, "Active", DBUS_TYPE_BOOLEAN, &value);
+
+	ofono_dbus_dict_append(dict, "Type", DBUS_TYPE_STRING, &type);
+
+	ofono_dbus_dict_append(dict, "Protocol", DBUS_TYPE_STRING, &proto);
+
+	strvalue =3D ctx->context.apn;
+	ofono_dbus_dict_append(dict, "AccessPointName", DBUS_TYPE_STRING,
+				&strvalue);
+
+	strvalue =3D ctx->context.username;
+	ofono_dbus_dict_append(dict, "Username", DBUS_TYPE_STRING,
+				&strvalue);
+
+	strvalue =3D ctx->context.password;
+	ofono_dbus_dict_append(dict, "Password", DBUS_TYPE_STRING,
+				&strvalue);
+
+	if (ctx->type =3D=3D OFONO_PACKET_CONTEXT_TYPE_MMS) {
+		strvalue =3D ctx->message_proxy;
+		ofono_dbus_dict_append(dict, "MessageProxy",
+					DBUS_TYPE_STRING, &strvalue);
+
+		strvalue =3D ctx->message_center;
+		ofono_dbus_dict_append(dict, "MessageCenter",
+					DBUS_TYPE_STRING, &strvalue);
+	}
+
+	if (ctx->context_driver)
+		settings =3D ctx->context_driver->settings;
+	else
+		settings =3D NULL;
+
+	context_settings_append_ipv4_dict(settings, dict);
+	context_settings_append_ipv6_dict(settings, dict);
+}
+
+static DBusMessage *get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct context *ctx =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+	append_context_properties(ctx, &dict);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void activate_callback(const struct ofono_error *error, void *data)
+{
+	struct context *ctx =3D data;
+	struct ofono_packet_context *pc =3D ctx->context_driver;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t value;
+
+	DBG("%p", ctx);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Activating context failed with error: %s",
+				telephony_error_to_str(error));
+		__ofono_dbus_pending_reply(&ctx->pending,
+					__ofono_error_failed(ctx->pending));
+		context_settings_free(ctx->context_driver->settings);
+		release_context(ctx);
+		return;
+	}
+
+	ctx->active =3D TRUE;
+	__ofono_dbus_pending_reply(&ctx->pending,
+				dbus_message_new_method_return(ctx->pending));
+
+	if (pc->settings->interface !=3D NULL) {
+		ifupdown(pc->settings->interface, TRUE);
+
+		if (ctx->type =3D=3D OFONO_PACKET_CONTEXT_TYPE_MMS &&
+				pc->settings->ipv4)
+			update_mms_context_settings(ctx);
+
+		context_signal_settings(ctx, pc->settings->ipv4 !=3D NULL,
+						pc->settings->ipv6 !=3D NULL);
+	}
+
+	value =3D ctx->active;
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+}
+
+static void deactivate_callback(const struct ofono_error *error, void *dat=
a)
+{
+	struct context *ctx =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t value;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Deactivating context failed with error: %s",
+				telephony_error_to_str(error));
+		__ofono_dbus_pending_reply(&ctx->pending,
+					__ofono_error_failed(ctx->pending));
+		return;
+	}
+
+	__ofono_dbus_pending_reply(&ctx->pending,
+				dbus_message_new_method_return(ctx->pending));
+
+	reset_context_settings(ctx);
+	release_context(ctx);
+
+	value =3D ctx->active;
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+}
+
+static DBusMessage *set_apn(struct context *ctx, DBusConnection *conn,
+				DBusMessage *msg, const char *apn)
+{
+	GKeyFile *settings =3D ctx->ps->settings;
+
+	if (strlen(apn) > OFONO_PS_MAX_APN_LENGTH)
+		return __ofono_error_invalid_format(msg);
+
+	if (g_str_equal(apn, ctx->context.apn))
+		return dbus_message_new_method_return(msg);
+
+	if (is_valid_apn(apn) =3D=3D FALSE)
+		return __ofono_error_invalid_format(msg);
+
+	strcpy(ctx->context.apn, apn);
+
+	if (settings) {
+		g_key_file_set_string(settings, ctx->key,
+					"AccessPointName", apn);
+		storage_sync(ctx->ps->imsi, SETTINGS_STORE, settings);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"AccessPointName",
+					DBUS_TYPE_STRING, &apn);
+
+	return NULL;
+}
+
+static DBusMessage *set_username(struct context *ctx,
+					DBusConnection *conn, DBusMessage *msg,
+					const char *username)
+{
+	GKeyFile *settings =3D ctx->ps->settings;
+
+	if (strlen(username) > OFONO_PS_MAX_USERNAME_LENGTH)
+		return __ofono_error_invalid_format(msg);
+
+	if (g_str_equal(username, ctx->context.username))
+		return dbus_message_new_method_return(msg);
+
+	strcpy(ctx->context.username, username);
+
+	if (settings) {
+		g_key_file_set_string(settings, ctx->key,
+					"Username", username);
+		storage_sync(ctx->ps->imsi, SETTINGS_STORE, settings);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Username",
+					DBUS_TYPE_STRING, &username);
+
+	return NULL;
+}
+
+static DBusMessage *set_password(struct context *ctx,
+					DBusConnection *conn, DBusMessage *msg,
+					const char *password)
+{
+	GKeyFile *settings =3D ctx->ps->settings;
+
+	if (strlen(password) > OFONO_PS_MAX_PASSWORD_LENGTH)
+		return __ofono_error_invalid_format(msg);
+
+	if (g_str_equal(password, ctx->context.password))
+		return dbus_message_new_method_return(msg);
+
+	strcpy(ctx->context.password, password);
+
+	if (settings) {
+		g_key_file_set_string(settings, ctx->key,
+					"Password", password);
+		storage_sync(ctx->ps->imsi, SETTINGS_STORE, settings);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Password",
+					DBUS_TYPE_STRING, &password);
+
+	return NULL;
+}
+
+static DBusMessage *set_type(struct context *ctx, DBusConnection *conn,
+					DBusMessage *msg, const char *type)
+{
+	GKeyFile *settings =3D ctx->ps->settings;
+	enum ofono_packet_context_type context_type;
+
+	if (packet_context_string_to_type(type, &context_type) =3D=3D FALSE)
+		return __ofono_error_invalid_format(msg);
+
+	if (ctx->type =3D=3D context_type)
+		return dbus_message_new_method_return(msg);
+
+	ctx->type =3D context_type;
+
+	if (settings) {
+		g_key_file_set_string(settings, ctx->key, "Type", type);
+		storage_sync(ctx->ps->imsi, SETTINGS_STORE, settings);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Type", DBUS_TYPE_STRING, &type);
+
+	return NULL;
+}
+
+static DBusMessage *set_proto(struct context *ctx,
+					DBusConnection *conn,
+					DBusMessage *msg, const char *str)
+{
+	GKeyFile *settings =3D ctx->ps->settings;
+	enum ofono_packet_proto proto;
+
+	if (packet_proto_from_string(str, &proto) =3D=3D FALSE)
+		return __ofono_error_invalid_format(msg);
+
+	if (ctx->context.proto =3D=3D proto)
+		return dbus_message_new_method_return(msg);
+
+	ctx->context.proto =3D proto;
+
+	if (settings) {
+		g_key_file_set_string(settings, ctx->key, "Protocol", str);
+		storage_sync(ctx->ps->imsi, SETTINGS_STORE, settings);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Protocol", DBUS_TYPE_STRING, &str);
+
+	return NULL;
+}
+
+static DBusMessage *set_name(struct context *ctx, DBusConnection *conn,
+					DBusMessage *msg, const char *name)
+{
+	GKeyFile *settings =3D ctx->ps->settings;
+
+	if (strlen(name) > MAX_CONTEXT_NAME_LENGTH)
+		return __ofono_error_invalid_format(msg);
+
+	if (ctx->name && g_str_equal(ctx->name, name))
+		return dbus_message_new_method_return(msg);
+
+	strcpy(ctx->name, name);
+
+	if (settings) {
+		g_key_file_set_string(settings, ctx->key, "Name", ctx->name);
+		storage_sync(ctx->ps->imsi, SETTINGS_STORE, settings);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Name", DBUS_TYPE_STRING, &name);
+
+	return NULL;
+}
+
+static DBusMessage *set_message_proxy(struct context *ctx,
+					DBusConnection *conn,
+					DBusMessage *msg, const char *proxy)
+{
+	GKeyFile *settings =3D ctx->ps->settings;
+
+	if (strlen(proxy) > MAX_MESSAGE_PROXY_LENGTH)
+		return __ofono_error_invalid_format(msg);
+
+	if (ctx->message_proxy && g_str_equal(ctx->message_proxy, proxy))
+		return dbus_message_new_method_return(msg);
+
+	strcpy(ctx->message_proxy, proxy);
+
+	if (settings) {
+		g_key_file_set_string(settings, ctx->key, "MessageProxy",
+							ctx->message_proxy);
+		storage_sync(ctx->ps->imsi, SETTINGS_STORE, settings);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+				OFONO_CONNECTION_CONTEXT_INTERFACE,
+				"MessageProxy", DBUS_TYPE_STRING, &proxy);
+
+	return NULL;
+}
+
+static DBusMessage *set_message_center(struct context *ctx,
+					DBusConnection *conn,
+					DBusMessage *msg, const char *center)
+{
+	GKeyFile *settings =3D ctx->ps->settings;
+
+	if (strlen(center) > MAX_MESSAGE_CENTER_LENGTH)
+		return __ofono_error_invalid_format(msg);
+
+	if (ctx->message_center && g_str_equal(ctx->message_center, center))
+		return dbus_message_new_method_return(msg);
+
+	strcpy(ctx->message_center, center);
+
+	if (settings) {
+		g_key_file_set_string(settings, ctx->key, "MessageCenter",
+							ctx->message_center);
+		storage_sync(ctx->ps->imsi, SETTINGS_STORE, settings);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+				OFONO_CONNECTION_CONTEXT_INTERFACE,
+				"MessageCenter", DBUS_TYPE_STRING, &center);
+
+	return NULL;
+}
+
+static DBusMessage *set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct context *ctx =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+	dbus_bool_t value;
+	const char *str;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (g_str_equal(property, "Active")) {
+		struct ofono_packet_context *pc;
+
+		if (ctx->ps->pending)
+			return __ofono_error_busy(msg);
+
+		if (ctx->pending)
+			return __ofono_error_busy(msg);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (ctx->active =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		if (value && !ctx->ps->attached)
+			return __ofono_error_not_attached(msg);
+
+		if (ctx->ps->flags & PS_FLAG_ATTACHING)
+			return __ofono_error_attach_in_progress(msg);
+
+		if (value && assign_context(ctx) =3D=3D FALSE)
+			return __ofono_error_not_implemented(msg);
+
+		pc =3D ctx->context_driver;
+
+		ctx->pending =3D dbus_message_ref(msg);
+
+		if (value)
+			pc->driver->activate_context(pc, &ctx->context,
+						activate_callback, ctx);
+		else
+			pc->driver->deactivate_context(pc, ctx->context.cid,
+						deactivate_callback, ctx);
+
+		return NULL;
+	}
+
+	/* All other properties are read-only when context is active */
+	if (ctx->active =3D=3D TRUE)
+		return __ofono_error_in_use(msg);
+
+	if (!strcmp(property, "AccessPointName")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return set_apn(ctx, conn, msg, str);
+	} else if (!strcmp(property, "Type")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return set_type(ctx, conn, msg, str);
+	} else if (!strcmp(property, "Protocol")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return set_proto(ctx, conn, msg, str);
+	} else if (!strcmp(property, "Username")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return set_username(ctx, conn, msg, str);
+	} else if (!strcmp(property, "Password")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return set_password(ctx, conn, msg, str);
+	} else if (!strcmp(property, "Name")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return set_name(ctx, conn, msg, str);
+	}
+
+	if (ctx->type !=3D OFONO_PACKET_CONTEXT_TYPE_MMS)
+		return __ofono_error_invalid_args(msg);
+
+	if (!strcmp(property, "MessageProxy")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return set_message_proxy(ctx, conn, msg, str);
+	} else if (!strcmp(property, "MessageCenter")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return set_message_center(ctx, conn, msg, str);
+	}
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static GDBusMethodTable context_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	get_properties },
+	{ "SetProperty",	"sv",	"",		set_property,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable context_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+static struct context *context_create(struct ofono_packet_service *ps,
+					const char *name,
+					enum ofono_packet_context_type type)
+{
+	struct context *context =3D g_try_new0(struct context, 1);
+
+	if (context =3D=3D NULL)
+		return NULL;
+
+	if (name =3D=3D NULL) {
+		name =3D packet_context_default_name(type);
+		if (name =3D=3D NULL) {
+			g_free(context);
+			return NULL;
+		}
+	}
+
+	context->ps =3D ps;
+	strcpy(context->name, name);
+	context->type =3D type;
+
+	return context;
+}
+
+static void context_destroy(gpointer userdata)
+{
+	struct context *ctx =3D userdata;
+
+	g_free(ctx->proxy_host);
+	g_free(ctx->path);
+	g_free(ctx);
+}
+
+static gboolean context_dbus_register(struct context *ctx)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	char path[256];
+	const char *basepath;
+
+	basepath =3D __ofono_atom_get_path(ctx->ps->atom);
+
+	snprintf(path, sizeof(path), "%s/context%u", basepath, ctx->id);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					context_methods, context_signals,
+					NULL, ctx, context_destroy)) {
+		ofono_error("Could not register PrimaryContext %s", path);
+		idmap_put(ctx->ps->pid_map, ctx->id);
+		context_destroy(ctx);
+
+		return FALSE;
+	}
+
+	ctx->path =3D g_strdup(path);
+	ctx->key =3D ctx->path + strlen(basepath) + 1;
+
+	return TRUE;
+}
+
+static gboolean context_dbus_unregister(struct context *ctx)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	char path[256];
+
+	strcpy(path, ctx->path);
+	idmap_put(ctx->ps->pid_map, ctx->id);
+
+	return g_dbus_unregister_interface(conn, path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE);
+}
+
+static void update_suspended_property(struct ofono_packet_service *ps,
+				ofono_bool_t suspended)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(ps->atom);
+	dbus_bool_t value =3D suspended;
+
+	if (ps->suspend_timeout) {
+		g_source_remove(ps->suspend_timeout);
+		ps->suspend_timeout =3D 0;
+	}
+
+	if (ps->suspended =3D=3D suspended)
+		return;
+
+	DBG("%s GPRS service %s", __ofono_atom_get_path(ps->atom),
+		suspended ? "suspended" : "resumed");
+
+	ps->suspended =3D suspended;
+
+	if (ps->attached)
+		ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CONNECTION_MANAGER_INTERFACE,
+					"Suspended", DBUS_TYPE_BOOLEAN, &value);
+}
+
+static gboolean suspend_timeout(gpointer data)
+{
+       struct ofono_packet_service *ps =3D data;
+
+       ps->suspend_timeout =3D 0;
+       update_suspended_property(ps, TRUE);
+       return FALSE;
+}
+
+void ofono_packet_service_suspend_notify(struct ofono_packet_service *ps,
+						int cause)
+{
+	switch (cause) {
+	case PACKET_SERVICE_SUSPENDED_DETACHED:
+	case PACKET_SERVICE_SUSPENDED_CALL:
+	case PACKET_SERVICE_SUSPENDED_NO_COVERAGE:
+		update_suspended_property(ps, TRUE);
+		break;
+
+	case PACKET_SERVICE_SUSPENDED_SIGNALLING:
+	case PACKET_SERVICE_SUSPENDED_UNKNOWN_CAUSE:
+		if (ps->suspend_timeout)
+			g_source_remove(ps->suspend_timeout);
+		ps->suspend_timeout =3D g_timeout_add_seconds(SUSPEND_TIMEOUT,
+							suspend_timeout,
+							ps);
+		break;
+	}
+}
+
+void ofono_packet_service_resume_notify(struct ofono_packet_service *ps)
+{
+	update_suspended_property(ps, FALSE);
+}
+
+static void ps_attached_update(struct ofono_packet_service *ps)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	ofono_bool_t attached;
+	dbus_bool_t value;
+
+	attached =3D ps->driver_attached &&
+		(ps->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
+			ps->status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
+
+	if (attached =3D=3D ps->attached)
+		return;
+
+	ps->attached =3D attached;
+
+	if (ps->attached =3D=3D FALSE) {
+		GSList *l;
+		struct context *ctx;
+
+		for (l =3D ps->contexts; l; l =3D l->next) {
+			ctx =3D l->data;
+
+			if (ctx->active =3D=3D FALSE)
+				continue;
+
+			reset_context_settings(ctx);
+			release_context(ctx);
+
+			value =3D FALSE;
+			ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+		}
+
+		ps->bearer =3D -1;
+	}
+
+	path =3D __ofono_atom_get_path(ps->atom);
+	value =3D attached;
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CONNECTION_MANAGER_INTERFACE,
+				"Attached", DBUS_TYPE_BOOLEAN, &value);
+}
+
+static void registration_status_cb(const struct ofono_error *error,
+					int status, void *data)
+{
+	struct ofono_packet_service *ps =3D data;
+
+	DBG("%s error %d status %d", __ofono_atom_get_path(ps->atom),
+		error->type, status);
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		ofono_packet_service_status_notify(ps, status);
+
+	if (ps->flags & PS_FLAG_RECHECK) {
+		ps->flags &=3D ~PS_FLAG_RECHECK;
+		ps_netreg_update(ps);
+	}
+}
+
+static void ps_attach_callback(const struct ofono_error *error,
+						void *data)
+{
+	struct ofono_packet_service *ps =3D data;
+
+	DBG("%s error =3D %d", __ofono_atom_get_path(ps->atom), error->type);
+
+	ps->flags &=3D ~PS_FLAG_ATTACHING;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		ps->driver_attached =3D !ps->driver_attached;
+
+	if (ps->driver->attached_status) {
+		ps->driver->attached_status(ps, registration_status_cb,
+						ps);
+		return;
+	}
+
+	ps_attached_update(ps);
+
+	if (ps->flags & PS_FLAG_RECHECK) {
+		ps->flags &=3D ~PS_FLAG_RECHECK;
+		ps_netreg_update(ps);
+	}
+}
+
+static void ps_netreg_removed(struct ofono_packet_service *ps)
+{
+	ps->netreg =3D NULL;
+
+	ps->flags &=3D ~(PS_FLAG_RECHECK | PS_FLAG_ATTACHING);
+	ps->status_watch =3D 0;
+	ps->netreg_status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+	ps->driver_attached =3D FALSE;
+
+	ps_attached_update(ps);
+}
+
+static void ps_netreg_update(struct ofono_packet_service *ps)
+{
+	ofono_bool_t attach;
+
+	attach =3D ps->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERE=
D;
+
+	attach =3D attach || (ps->roaming_allowed &&
+		ps->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
+
+	attach =3D attach && ps->powered;
+
+	if (ps->driver_attached =3D=3D attach)
+		return;
+
+	if (ps->flags & PS_FLAG_ATTACHING) {
+		ps->flags |=3D PS_FLAG_RECHECK;
+		return;
+	}
+
+	ps->flags |=3D PS_FLAG_ATTACHING;
+
+	ps->driver->set_attached(ps, attach, ps_attach_callback,
+									ps);
+	ps->driver_attached =3D attach;
+}
+
+static void netreg_status_changed(int status, int lac, int ci, int tech,
+					const char *mcc, const char *mnc,
+					void *data)
+{
+	struct ofono_packet_service *ps =3D data;
+
+	DBG("%d", status);
+
+	if (ps->netreg_status =3D=3D status)
+		return;
+
+	ps->netreg_status =3D status;
+
+	ps_netreg_update(ps);
+}
+
+static DBusMessage *ps_get_properties(DBusConnection *conn, DBusMessage *m=
sg,
+					void *data)
+{
+	struct ofono_packet_service *ps =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t value;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	value =3D ps->attached;
+	ofono_dbus_dict_append(&dict, "Attached", DBUS_TYPE_BOOLEAN, &value);
+
+	if (ps->bearer !=3D -1) {
+		const char *bearer =3D packet_bearer_to_string(ps->bearer);
+
+		ofono_dbus_dict_append(&dict, "Bearer",
+					DBUS_TYPE_STRING, &bearer);
+	}
+
+	value =3D ps->roaming_allowed;
+	ofono_dbus_dict_append(&dict, "RoamingAllowed",
+				DBUS_TYPE_BOOLEAN, &value);
+
+	value =3D ps->powered;
+	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
+
+	if (ps->attached) {
+		value =3D ps->suspended;
+		ofono_dbus_dict_append(&dict, "Suspended",
+				DBUS_TYPE_BOOLEAN, &value);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *ps_set_property(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_packet_service *ps =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+	dbus_bool_t value;
+	const char *path;
+
+	if (ps->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (!strcmp(property, "RoamingAllowed")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (ps->roaming_allowed =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		ps->roaming_allowed =3D value;
+
+		if (ps->settings) {
+			g_key_file_set_integer(ps->settings, SETTINGS_GROUP,
+						"RoamingAllowed",
+						ps->roaming_allowed);
+			storage_sync(ps->imsi, SETTINGS_STORE,
+					ps->settings);
+		}
+
+		ps_netreg_update(ps);
+	} else if (!strcmp(property, "Powered")) {
+		if (ps->driver->set_attached =3D=3D NULL)
+			return __ofono_error_not_implemented(msg);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (ps->powered =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		ps->powered =3D value;
+
+		if (ps->settings) {
+			g_key_file_set_integer(ps->settings, SETTINGS_GROUP,
+						"Powered", ps->powered);
+			storage_sync(ps->imsi, SETTINGS_STORE,
+					ps->settings);
+		}
+
+		ps_netreg_update(ps);
+	} else {
+		return __ofono_error_invalid_args(msg);
+	}
+
+	path =3D __ofono_atom_get_path(ps->atom);
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CONNECTION_MANAGER_INTERFACE,
+					property, DBUS_TYPE_BOOLEAN, &value);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static void write_context_settings(struct ofono_packet_service *ps,
+					struct context *context)
+{
+	g_key_file_set_string(ps->settings, context->key,
+				"Name", context->name);
+	g_key_file_set_string(ps->settings, context->key,
+				"AccessPointName", context->context.apn);
+	g_key_file_set_string(ps->settings, context->key,
+				"Username", context->context.username);
+	g_key_file_set_string(ps->settings, context->key,
+				"Password", context->context.password);
+	g_key_file_set_string(ps->settings, context->key, "Type",
+				packet_context_type_to_string(context->type));
+	g_key_file_set_string(ps->settings, context->key, "Protocol",
+				packet_proto_to_string(context->context.proto));
+
+	if (context->type =3D=3D OFONO_PACKET_CONTEXT_TYPE_MMS) {
+		g_key_file_set_string(ps->settings, context->key,
+					"MessageProxy",
+					context->message_proxy);
+		g_key_file_set_string(ps->settings, context->key,
+					"MessageCenter",
+					context->message_center);
+	}
+}
+
+static struct context *add_context(struct ofono_packet_service *ps,
+					const char *name,
+					enum ofono_packet_context_type type)
+{
+	unsigned int id;
+	struct context *context;
+
+	if (ps->last_context_id)
+		id =3D idmap_alloc_next(ps->pid_map, ps->last_context_id);
+	else
+		id =3D idmap_alloc(ps->pid_map);
+
+	if (id > idmap_get_max(ps->pid_map))
+		return NULL;
+
+	context =3D context_create(ps, name, type);
+	if (context =3D=3D NULL) {
+		idmap_put(ps->pid_map, id);
+		ofono_error("Unable to allocate context struct");
+		return NULL;
+	}
+
+	context->id =3D id;
+
+	DBG("Registering new context");
+
+	if (!context_dbus_register(context)) {
+		ofono_error("Unable to register primary context");
+		return NULL;
+	}
+
+	ps->last_context_id =3D id;
+
+	if (ps->settings) {
+		write_context_settings(ps, context);
+		storage_sync(ps->imsi, SETTINGS_STORE, ps->settings);
+	}
+
+	ps->contexts =3D g_slist_append(ps->contexts, context);
+
+	return context;
+}
+
+static DBusMessage *ps_add_context(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_packet_service *ps =3D data;
+	struct context *context;
+	const char *typestr;
+	const char *name;
+	const char *path;
+	enum ofono_packet_context_type type;
+	DBusMessage *signal;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &typestr,
+					DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	if (packet_context_string_to_type(typestr, &type) =3D=3D FALSE)
+		return __ofono_error_invalid_format(msg);
+
+	name =3D packet_context_default_name(type);
+	if (name =3D=3D NULL)
+		name =3D typestr;
+
+	context =3D add_context(ps, name, type);
+	if (context =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	path =3D context->path;
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID);
+
+	path =3D __ofono_atom_get_path(ps->atom);
+	signal =3D dbus_message_new_signal(path,
+					OFONO_CONNECTION_MANAGER_INTERFACE,
+					"ContextAdded");
+
+	if (signal) {
+		DBusMessageIter iter;
+		DBusMessageIter dict;
+
+		dbus_message_iter_init_append(signal, &iter);
+
+		path =3D context->path;
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+						&path);
+
+		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+		append_context_properties(context, &dict);
+		dbus_message_iter_close_container(&iter, &dict);
+
+		g_dbus_send_message(conn, signal);
+	}
+
+	return NULL;
+}
+
+static void ps_deactivate_for_remove(const struct ofono_error *error,
+						void *data)
+{
+	struct context *ctx =3D data;
+	struct ofono_packet_service *ps =3D ctx->ps;
+	DBusConnection *conn;
+	char *path;
+	const char *atompath;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Removing context failed with error: %s",
+				telephony_error_to_str(error));
+
+		__ofono_dbus_pending_reply(&ps->pending,
+					__ofono_error_failed(ps->pending));
+		return;
+	}
+
+	reset_context_settings(ctx);
+	release_context(ctx);
+
+	if (ps->settings) {
+		g_key_file_remove_group(ps->settings, ctx->key, NULL);
+		storage_sync(ps->imsi, SETTINGS_STORE, ps->settings);
+	}
+
+	/* Make a backup copy of path for signal emission below */
+	path =3D g_strdup(ctx->path);
+
+	context_dbus_unregister(ctx);
+	ps->contexts =3D g_slist_remove(ps->contexts, ctx);
+
+	__ofono_dbus_pending_reply(&ps->pending,
+				dbus_message_new_method_return(ps->pending));
+
+	atompath =3D __ofono_atom_get_path(ps->atom);
+	conn =3D ofono_dbus_get_connection();
+	g_dbus_emit_signal(conn, atompath, OFONO_CONNECTION_MANAGER_INTERFACE,
+				"ContextRemoved", DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+	g_free(path);
+}
+
+static DBusMessage *ps_remove_context(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_packet_service *ps =3D data;
+	struct context *ctx;
+	const char *path;
+	const char *atompath;
+
+	if (ps->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	if (path[0] =3D=3D '\0')
+		return __ofono_error_invalid_format(msg);
+
+	ctx =3D packet_context_by_path(ps, path);
+	if (ctx =3D=3D NULL)
+		return __ofono_error_not_found(msg);
+
+	if (ctx->active) {
+		struct ofono_packet_context *pc =3D ctx->context_driver;
+
+		/* This context is already being messed with */
+		if (ctx->pending)
+			return __ofono_error_busy(msg);
+
+		ps->pending =3D dbus_message_ref(msg);
+		pc->driver->deactivate_context(pc, ctx->context.cid,
+					ps_deactivate_for_remove, ctx);
+		return NULL;
+	}
+
+	if (ps->settings) {
+		g_key_file_remove_group(ps->settings, ctx->key, NULL);
+		storage_sync(ps->imsi, SETTINGS_STORE, ps->settings);
+	}
+
+	DBG("Unregistering context: %s", ctx->path);
+	context_dbus_unregister(ctx);
+	ps->contexts =3D g_slist_remove(ps->contexts, ctx);
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	atompath =3D __ofono_atom_get_path(ps->atom);
+	g_dbus_emit_signal(conn, atompath, OFONO_CONNECTION_MANAGER_INTERFACE,
+				"ContextRemoved", DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+
+	return NULL;
+}
+
+static void ps_deactivate_for_all(const struct ofono_error *error,
+					void *data)
+{
+	struct context *ctx =3D data;
+	struct ofono_packet_service *ps =3D ctx->ps;
+	DBusConnection *conn;
+	dbus_bool_t value;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		__ofono_dbus_pending_reply(&ps->pending,
+					__ofono_error_failed(ps->pending));
+		return;
+	}
+
+	reset_context_settings(ctx);
+	release_context(ctx);
+
+	value =3D ctx->active;
+	conn =3D ofono_dbus_get_connection();
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+
+	ps_deactivate_next(ps);
+}
+
+static void ps_deactivate_next(struct ofono_packet_service *ps)
+{
+	GSList *l;
+	struct context *ctx;
+	struct ofono_packet_context *pc;
+
+	for (l =3D ps->contexts; l; l =3D l->next) {
+		ctx =3D l->data;
+
+		if (ctx->active =3D=3D FALSE)
+			continue;
+
+		pc =3D ctx->context_driver;
+		pc->driver->deactivate_context(pc, ctx->context.cid,
+					ps_deactivate_for_all, ctx);
+
+		return;
+	}
+
+	__ofono_dbus_pending_reply(&ps->pending,
+				dbus_message_new_method_return(ps->pending));
+}
+
+static DBusMessage *ps_deactivate_all(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_packet_service *ps =3D data;
+	GSList *l;
+	struct context *ctx;
+
+	if (ps->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	for (l =3D ps->contexts; l; l =3D l->next) {
+		ctx =3D l->data;
+
+		if (ctx->pending)
+			return __ofono_error_busy(msg);
+	}
+
+	ps->pending =3D dbus_message_ref(msg);
+
+	ps_deactivate_next(ps);
+
+	return NULL;
+}
+
+static DBusMessage *ps_get_contexts(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_packet_service *ps =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter array;
+	DBusMessageIter entry, dict;
+	const char *path;
+	GSList *l;
+	struct context *ctx;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_OBJECT_PATH_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_STRUCT_END_CHAR_AS_STRING,
+					&array);
+
+	for (l =3D ps->contexts; l; l =3D l->next) {
+		ctx =3D l->data;
+
+		path =3D ctx->path;
+
+		dbus_message_iter_open_container(&array, DBUS_TYPE_STRUCT,
+							NULL, &entry);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+						&path);
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+		append_context_properties(ctx, &dict);
+		dbus_message_iter_close_container(&entry, &dict);
+		dbus_message_iter_close_container(&array, &entry);
+	}
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
+}
+
+static GDBusMethodTable manager_methods[] =3D {
+	{ "GetProperties",     "",     "a{sv}",     ps_get_properties },
+	{ "SetProperty",       "sv",   "",          ps_set_property },
+	{ "AddContext",        "s",    "o",         ps_add_context,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RemoveContext",     "o",    "",          ps_remove_context,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "DeactivateAll",     "",     "",          ps_deactivate_all,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetContexts",       "",     "a(oa{sv})", ps_get_contexts },
+	{ }
+};
+
+static GDBusSignalTable manager_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ "ContextAdded",	"oa{sv}" },
+	{ "ContextRemoved",     "o" },
+	{ }
+};
+
+void ofono_packet_service_detached_notify(struct ofono_packet_service *ps)
+{
+	DBG("%s", __ofono_atom_get_path(ps->atom));
+
+	ps->driver_attached =3D FALSE;
+	ps_attached_update(ps);
+
+	/*
+	 * TODO: The network forced a detach, we should wait for some time
+	 * and try to re-attach.  This might also be related to a suspend
+	 * event while voicecall is active.
+	 */
+}
+
+void ofono_packet_service_status_notify(struct ofono_packet_service *ps, i=
nt status)
+{
+	DBG("%s status %d", __ofono_atom_get_path(ps->atom), status);
+
+	ps->status =3D status;
+
+	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
+			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
+		ps_attached_update(ps);
+		return;
+	}
+
+	/* We registered without being powered */
+	if (ps->powered =3D=3D FALSE)
+		goto detach;
+
+	if (ps->roaming_allowed =3D=3D FALSE &&
+			status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING)
+		goto detach;
+
+	ps->driver_attached =3D TRUE;
+	ps_attached_update(ps);
+
+	return;
+
+detach:
+	ps->flags |=3D PS_FLAG_ATTACHING;
+	ps->driver->set_attached(ps, FALSE, ps_attach_callback, ps);
+}
+
+void ofono_packet_service_set_cid_range(struct ofono_packet_service *ps,
+				unsigned int min, unsigned int max)
+{
+	if (ps =3D=3D NULL)
+		return;
+
+	if (ps->cid_map)
+		idmap_free(ps->cid_map);
+
+	ps->cid_map =3D idmap_new_from_range(min, max);
+}
+
+static void packet_context_unregister(struct ofono_atom *atom)
+{
+	struct ofono_packet_context *pc =3D __ofono_atom_get_data(atom);
+
+	if (pc->ps =3D=3D NULL)
+		return;
+
+	if (pc->settings) {
+		context_settings_free(pc->settings);
+		g_free(pc->settings);
+		pc->settings =3D NULL;
+	}
+
+	pc->ps->context_drivers =3D g_slist_remove(pc->ps->context_drivers,
+							pc);
+	pc->ps =3D NULL;
+}
+
+void ofono_packet_service_add_context(struct ofono_packet_service *ps,
+				struct ofono_packet_context *pc)
+{
+	if (pc->driver =3D=3D NULL)
+		return;
+
+	pc->ps =3D ps;
+	pc->settings =3D g_new0(struct context_settings, 1);
+
+	ps->context_drivers =3D g_slist_append(ps->context_drivers, pc);
+	__ofono_atom_register(pc->atom, packet_context_unregister);
+}
+
+void ofono_packet_service_bearer_notify(struct ofono_packet_service *ps, i=
nt bearer)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *value;
+
+	if (ps->bearer =3D=3D bearer)
+		return;
+
+	ps->bearer =3D bearer;
+	path =3D __ofono_atom_get_path(ps->atom);
+	value =3D packet_bearer_to_string(bearer);
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Bearer", DBUS_TYPE_STRING, &value);
+}
+
+void ofono_packet_context_deactivated(struct ofono_packet_context *pc,
+					unsigned int cid)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	GSList *l;
+	struct context *ctx;
+	dbus_bool_t value;
+
+	if (pc->ps =3D=3D NULL)
+		return;
+
+	for (l =3D pc->ps->contexts; l; l =3D l->next) {
+		ctx =3D l->data;
+
+		if (ctx->context.cid !=3D cid)
+			continue;
+
+		if (ctx->active =3D=3D FALSE)
+			break;
+
+		reset_context_settings(ctx);
+		release_context(ctx);
+
+		value =3D FALSE;
+		ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+	}
+}
+
+int ofono_packet_context_driver_register(const struct ofono_packet_context=
_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_context_drivers =3D g_slist_prepend(g_context_drivers, (void *) d);
+
+	return 0;
+}
+
+void ofono_packet_context_driver_unregister(const struct ofono_packet_cont=
ext_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_context_drivers =3D g_slist_remove(g_context_drivers, (void *) d);
+}
+
+static void packet_context_remove(struct ofono_atom *atom)
+{
+	struct ofono_packet_context *pc =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (pc =3D=3D NULL)
+		return;
+
+	if (pc->driver && pc->driver->remove)
+		pc->driver->remove(pc);
+
+	g_free(pc);
+}
+
+struct ofono_packet_context *ofono_packet_context_create(struct ofono_mode=
m *modem,
+						unsigned int vendor,
+						const char *driver, void *data)
+{
+	struct ofono_packet_context *pc;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	pc =3D g_try_new0(struct ofono_packet_context, 1);
+	if (pc =3D=3D NULL)
+		return NULL;
+
+	pc->type =3D OFONO_PACKET_CONTEXT_TYPE_ANY;
+
+	pc->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_PACKET_CONTEXT,
+						packet_context_remove, pc);
+
+	for (l =3D g_context_drivers; l; l =3D l->next) {
+		const struct ofono_packet_context_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(pc, vendor, data) < 0)
+			continue;
+
+		pc->driver =3D drv;
+		break;
+	}
+
+	return pc;
+}
+
+void ofono_packet_context_remove(struct ofono_packet_context *pc)
+{
+	if (pc =3D=3D NULL)
+		return;
+
+	__ofono_atom_free(pc->atom);
+}
+
+void ofono_packet_context_set_data(struct ofono_packet_context *pc, void *=
data)
+{
+	pc->driver_data =3D data;
+}
+
+void *ofono_packet_context_get_data(struct ofono_packet_context *pc)
+{
+	return pc->driver_data;
+}
+
+struct ofono_modem *ofono_packet_context_get_modem(struct ofono_packet_con=
text *pc)
+{
+	return __ofono_atom_get_modem(pc->atom);
+}
+
+void ofono_packet_context_set_type(struct ofono_packet_context *pc,
+                                        enum ofono_packet_context_type typ=
e)
+{
+	DBG("type %d", type);
+
+	pc->type =3D type;
+}
+
+void ofono_packet_context_set_interface(struct ofono_packet_context *pc,
+					const char *interface)
+{
+	struct context_settings *settings =3D pc->settings;
+
+	g_free(settings->interface);
+	settings->interface =3D g_strdup(interface);
+}
+
+void ofono_packet_context_set_ipv4_address(struct ofono_packet_context *pc,
+						const char *address,
+						gboolean static_ip)
+{
+	struct context_settings *settings =3D pc->settings;
+
+	if (settings->ipv4 =3D=3D NULL)
+		return;
+
+	g_free(settings->ipv4->ip);
+	settings->ipv4->ip =3D g_strdup(address);
+	settings->ipv4->static_ip =3D static_ip;
+}
+
+void ofono_packet_context_set_ipv4_netmask(struct ofono_packet_context *pc,
+						const char *netmask)
+{
+	struct context_settings *settings =3D pc->settings;
+
+	if (settings->ipv4 =3D=3D NULL)
+		return;
+
+	g_free(settings->ipv4->netmask);
+	settings->ipv4->netmask =3D g_strdup(netmask);
+}
+
+void ofono_packet_context_set_ipv4_gateway(struct ofono_packet_context *pc,
+						const char *gateway)
+{
+	struct context_settings *settings =3D pc->settings;
+
+	if (settings->ipv4 =3D=3D NULL)
+		return;
+
+	g_free(settings->ipv4->gateway);
+	settings->ipv4->gateway =3D g_strdup(gateway);
+}
+
+void ofono_packet_context_set_ipv4_dns_servers(struct ofono_packet_context=
 *pc,
+						const char **dns)
+{
+	struct context_settings *settings =3D pc->settings;
+
+	if (settings->ipv4 =3D=3D NULL)
+		return;
+
+	g_strfreev(settings->ipv4->dns);
+	settings->ipv4->dns =3D g_strdupv((char **) dns);
+}
+
+void ofono_packet_context_set_ipv6_address(struct ofono_packet_context *pc,
+						const char *address)
+{
+	struct context_settings *settings =3D pc->settings;
+
+	if (settings->ipv6 =3D=3D NULL)
+		return;
+
+	g_free(settings->ipv6->ip);
+	settings->ipv6->ip =3D g_strdup(address);
+}
+
+void ofono_packet_context_set_ipv6_prefix_length(struct ofono_packet_conte=
xt *pc,
+						unsigned char length)
+{
+	struct context_settings *settings =3D pc->settings;
+
+	if (settings->ipv6 =3D=3D NULL)
+		return;
+
+	settings->ipv6->prefix_len =3D length;
+}
+
+void ofono_packet_context_set_ipv6_gateway(struct ofono_packet_context *pc,
+						const char *gateway)
+{
+	struct context_settings *settings =3D pc->settings;
+
+	if (settings->ipv6 =3D=3D NULL)
+		return;
+
+	g_free(settings->ipv6->gateway);
+	settings->ipv6->gateway =3D g_strdup(gateway);
+}
+
+void ofono_packet_context_set_ipv6_dns_servers(struct ofono_packet_context=
 *pc,
+						const char **dns)
+{
+	struct context_settings *settings =3D pc->settings;
+
+	if (settings->ipv6 =3D=3D NULL)
+		return;
+
+	g_strfreev(settings->ipv6->dns);
+	settings->ipv6->dns =3D g_strdupv((char **) dns);
+}
+
+int ofono_packet_service_driver_register(
+				const struct ofono_packet_service_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
+
+	return 0;
+}
+
+void ofono_packet_service_driver_unregister(
+				const struct ofono_packet_service_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
+static void free_contexts(struct ofono_packet_service *ps)
+{
+	GSList *l;
+
+	if (ps->settings) {
+		storage_close(ps->imsi, SETTINGS_STORE,
+				ps->settings, TRUE);
+
+		g_free(ps->imsi);
+		ps->imsi =3D NULL;
+		ps->settings =3D NULL;
+	}
+
+	for (l =3D ps->contexts; l; l =3D l->next) {
+		struct context *context =3D l->data;
+
+		context_dbus_unregister(context);
+	}
+
+	g_slist_free(ps->contexts);
+}
+
+static void packet_service_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_packet_service *ps =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	free_contexts(ps);
+
+	if (ps->cid_map) {
+		idmap_free(ps->cid_map);
+		ps->cid_map =3D NULL;
+	}
+
+	if (ps->netreg_watch) {
+		if (ps->status_watch) {
+			__ofono_netreg_remove_status_watch(ps->netreg,
+							ps->status_watch);
+			ps->status_watch =3D 0;
+		}
+
+		__ofono_modem_remove_atom_watch(modem, ps->netreg_watch);
+		ps->netreg_watch =3D 0;
+		ps->netreg =3D NULL;
+	}
+
+	ofono_modem_remove_interface(modem,
+					OFONO_CONNECTION_MANAGER_INTERFACE);
+	g_dbus_unregister_interface(conn, path,
+					OFONO_CONNECTION_MANAGER_INTERFACE);
+}
+
+static void packet_service_remove(struct ofono_atom *atom)
+{
+	struct ofono_packet_service *ps =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (ps =3D=3D NULL)
+		return;
+
+	if (ps->suspend_timeout)
+		g_source_remove(ps->suspend_timeout);
+
+	if (ps->pid_map) {
+		idmap_free(ps->pid_map);
+		ps->pid_map =3D NULL;
+	}
+
+	g_slist_free(ps->context_drivers);
+
+	if (ps->driver && ps->driver->remove)
+		ps->driver->remove(ps);
+
+	if (ps->sim_context)
+		ofono_sim_context_free(ps->sim_context);
+
+	g_free(ps);
+}
+
+struct ofono_packet_service *ofono_packet_service_create(
+					struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data)
+{
+	struct ofono_packet_service *ps;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	ps =3D g_try_new0(struct ofono_packet_service, 1);
+	if (ps =3D=3D NULL)
+		return NULL;
+
+	ps->atom =3D __ofono_modem_add_atom(modem,
+						OFONO_ATOM_TYPE_PACKET_SERVICE,
+						packet_service_remove, ps);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_packet_service_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(ps, vendor, data) < 0)
+			continue;
+
+		ps->driver =3D drv;
+		break;
+	}
+
+	ps->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+	ps->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+	ps->pid_map =3D idmap_new(MAX_CONTEXTS);
+
+	return ps;
+}
+
+static void netreg_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_packet_service *ps =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		ps_netreg_removed(ps);
+		return;
+	}
+
+	ps->netreg =3D __ofono_atom_get_data(atom);
+	ps->netreg_status =3D ofono_netreg_get_status(ps->netreg);
+	ps->status_watch =3D __ofono_netreg_add_status_watch(ps->netreg,
+					netreg_status_changed, ps, NULL);
+
+	ps_netreg_update(ps);
+}
+
+static gboolean load_context(struct ofono_packet_service *ps, const char *=
group)
+{
+	char *name =3D NULL;
+	char *typestr =3D NULL;
+	char *protostr =3D NULL;
+	char *username =3D NULL;
+	char *password =3D NULL;
+	char *apn =3D NULL;
+	char *msgproxy =3D NULL;
+	char *msgcenter =3D NULL;
+	gboolean ret =3D FALSE;
+	gboolean legacy =3D FALSE;
+	struct context *context;
+	enum ofono_packet_context_type type;
+	enum ofono_packet_proto proto;
+	unsigned int id;
+
+	if (sscanf(group, "context%d", &id) !=3D 1) {
+		if (sscanf(group, "primarycontext%d", &id) !=3D 1)
+			goto error;
+
+		legacy =3D TRUE;
+	}
+
+	if (id < 1 || id > MAX_CONTEXTS)
+		goto error;
+
+	name =3D g_key_file_get_string(ps->settings, group, "Name", NULL);
+	if (name =3D=3D NULL)
+		goto error;
+
+	typestr =3D g_key_file_get_string(ps->settings, group, "Type", NULL);
+	if (typestr =3D=3D NULL)
+		goto error;
+
+	if (packet_context_string_to_type(typestr, &type) =3D=3D FALSE)
+		goto error;
+
+	protostr =3D g_key_file_get_string(ps->settings, group,
+							"Protocol", NULL);
+	if (protostr =3D=3D NULL)
+		protostr =3D g_strdup("ip");
+
+	if (packet_proto_from_string(protostr, &proto) =3D=3D FALSE)
+		goto error;
+
+	username =3D g_key_file_get_string(ps->settings, group,
+						"Username", NULL);
+	if (username =3D=3D NULL)
+		goto error;
+
+	if (strlen(username) > OFONO_PS_MAX_USERNAME_LENGTH)
+		goto error;
+
+	password =3D g_key_file_get_string(ps->settings, group,
+						"Password", NULL);
+	if (password =3D=3D NULL)
+		goto error;
+
+	if (strlen(password) > OFONO_PS_MAX_PASSWORD_LENGTH)
+		goto error;
+
+	apn =3D g_key_file_get_string(ps->settings, group,
+					"AccessPointName", NULL);
+	if (apn =3D=3D NULL)
+		goto error;
+
+	if (strlen(apn) > OFONO_PS_MAX_APN_LENGTH)
+		goto error;
+
+	if (type =3D=3D OFONO_PACKET_CONTEXT_TYPE_MMS) {
+		msgproxy =3D g_key_file_get_string(ps->settings, group,
+						"MessageProxy", NULL);
+
+		msgcenter =3D g_key_file_get_string(ps->settings, group,
+						"MessageCenter", NULL);
+	}
+
+	/*
+	 * Accept empty (just created) APNs, but don't allow other
+	 * invalid ones
+	 */
+	if (apn[0] !=3D '\0' && is_valid_apn(apn) =3D=3D FALSE)
+		goto error;
+
+	context =3D context_create(ps, name, type);
+	if (context =3D=3D NULL)
+		goto error;
+
+	idmap_take(ps->pid_map, id);
+	context->id =3D id;
+	strcpy(context->context.username, username);
+	strcpy(context->context.password, password);
+	strcpy(context->context.apn, apn);
+	context->context.proto =3D proto;
+
+	if (msgproxy !=3D NULL)
+		strcpy(context->message_proxy, msgproxy);
+
+	if (msgcenter !=3D NULL)
+		strcpy(context->message_center, msgcenter);
+
+	if (context_dbus_register(context) =3D=3D FALSE)
+		goto error;
+
+	ps->last_context_id =3D id;
+
+	ps->contexts =3D g_slist_append(ps->contexts, context);
+	ret =3D TRUE;
+
+	if (legacy) {
+		write_context_settings(ps, context);
+		g_key_file_remove_group(ps->settings, group, NULL);
+	}
+
+error:
+	g_free(name);
+	g_free(typestr);
+	g_free(protostr);
+	g_free(username);
+	g_free(password);
+	g_free(apn);
+	g_free(msgproxy);
+	g_free(msgcenter);
+
+	return ret;
+}
+
+static void ps_load_settings(struct ofono_packet_service *ps,
+						const char *imsi)
+{
+	GError *error;
+	gboolean legacy =3D FALSE;
+	char **groups;
+	int i;
+
+	ps->settings =3D storage_open(imsi, SETTINGS_STORE);
+
+	if (ps->settings =3D=3D NULL)
+		return;
+
+	ps->imsi =3D g_strdup(imsi);
+
+	error =3D NULL;
+	ps->powered =3D g_key_file_get_boolean(ps->settings, SETTINGS_GROUP,
+						"Powered", &error);
+
+	/*
+	 * If any error occurs, simply switch to defaults.
+	 * Default to Powered =3D True
+	 * and RoamingAllowed =3D False
+	 */
+	if (error) {
+		g_error_free(error);
+		ps->powered =3D TRUE;
+		g_key_file_set_boolean(ps->settings, SETTINGS_GROUP,
+					"Powered", ps->powered);
+	}
+
+	error =3D NULL;
+	ps->roaming_allowed =3D g_key_file_get_boolean(ps->settings,
+							SETTINGS_GROUP,
+							"RoamingAllowed",
+							&error);
+
+	if (error) {
+		g_error_free(error);
+		ps->roaming_allowed =3D FALSE;
+		g_key_file_set_boolean(ps->settings, SETTINGS_GROUP,
+					"RoamingAllowed",
+					ps->roaming_allowed);
+	}
+
+	groups =3D g_key_file_get_groups(ps->settings, NULL);
+
+	for (i =3D 0; groups[i]; i++) {
+		if (g_str_equal(groups[i], SETTINGS_GROUP))
+			continue;
+
+		if (!g_str_has_prefix(groups[i], "context")) {
+			if (!g_str_has_prefix(groups[i], "primarycontext"))
+				goto remove;
+
+			legacy =3D TRUE;
+		}
+
+		if (load_context(ps, groups[i]) =3D=3D TRUE)
+			continue;
+
+remove:
+		g_key_file_remove_group(ps->settings, groups[i], NULL);
+	}
+
+	g_strfreev(groups);
+
+	if (legacy)
+		storage_sync(imsi, SETTINGS_STORE, ps->settings);
+}
+
+static void provision_context(const struct ofono_ps_provision_data *ap,
+				struct ofono_packet_service *ps)
+{
+	unsigned int id;
+	struct context *context =3D NULL;
+
+	/* Sanity check */
+	if (ap =3D=3D NULL)
+		return;
+
+	if (ap->name =3D=3D NULL || strlen(ap->name) > MAX_CONTEXT_NAME_LENGTH)
+		return;
+
+	if (ap->apn =3D=3D NULL || strlen(ap->apn) > OFONO_PS_MAX_APN_LENGTH)
+		return;
+
+	if (is_valid_apn(ap->apn) =3D=3D FALSE)
+		return;
+
+	if (ap->username &&
+			strlen(ap->username) > OFONO_PS_MAX_USERNAME_LENGTH)
+		return;
+
+	if (ap->password &&
+			strlen(ap->password) > OFONO_PS_MAX_PASSWORD_LENGTH)
+		return;
+
+	if (ap->message_proxy &&
+			strlen(ap->message_proxy) > MAX_MESSAGE_PROXY_LENGTH)
+		return;
+
+	if (ap->message_center &&
+			strlen(ap->message_center) > MAX_MESSAGE_CENTER_LENGTH)
+		return;
+
+	if (ps->last_context_id)
+		id =3D idmap_alloc_next(ps->pid_map, ps->last_context_id);
+	else
+		id =3D idmap_alloc(ps->pid_map);
+
+	if (id > idmap_get_max(ps->pid_map))
+		return;
+
+	context =3D context_create(ps, ap->name, ap->type);
+	if (context =3D=3D NULL) {
+		idmap_put(ps->pid_map, id);
+		return;
+	}
+
+	context->id =3D id;
+
+	if (ap->username !=3D NULL)
+		strcpy(context->context.username, ap->username);
+
+	if (ap->password !=3D NULL)
+		strcpy(context->context.password, ap->password);
+
+	strcpy(context->context.apn, ap->apn);
+	context->context.proto =3D ap->proto;
+
+	if (ap->type =3D=3D OFONO_PACKET_CONTEXT_TYPE_MMS) {
+		if (ap->message_proxy !=3D NULL)
+			strcpy(context->message_proxy, ap->message_proxy);
+
+		if (ap->message_center !=3D NULL)
+			strcpy(context->message_center, ap->message_center);
+	}
+
+	if (context_dbus_register(context) =3D=3D FALSE)
+		return;
+
+	ps->last_context_id =3D id;
+
+	if (ps->settings) {
+		write_context_settings(ps, context);
+		storage_sync(ps->imsi, SETTINGS_STORE, ps->settings);
+	}
+
+	ps->contexts =3D g_slist_append(ps->contexts, context);
+}
+
+static void provision_contexts(struct ofono_packet_service *ps, const char=
 *mcc,
+				const char *mnc, const char *spn)
+{
+	struct ofono_ps_provision_data *settings;
+	int count;
+	int i;
+
+	if (__ofono_ps_provision_get_settings(mcc, mnc, spn,
+						&settings, &count) =3D=3D FALSE) {
+		ofono_warn("Provisioning failed");
+		return;
+	}
+
+	for (i =3D 0; i < count; i++)
+		provision_context(&settings[i], ps);
+
+	__ofono_ps_provision_free_settings(settings, count);
+}
+
+static void ofono_packet_service_finish_register(
+					struct ofono_packet_service *ps)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(ps->atom);
+	const char *path =3D __ofono_atom_get_path(ps->atom);
+
+	if (ps->contexts =3D=3D NULL) /* Automatic provisioning failed */
+		add_context(ps, NULL, OFONO_PACKET_CONTEXT_TYPE_INTERNET);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_CONNECTION_MANAGER_INTERFACE,
+					manager_methods, manager_signals, NULL,
+					ps, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_CONNECTION_MANAGER_INTERFACE);
+
+		free_contexts(ps);
+		return;
+	}
+
+	ofono_modem_add_interface(modem,
+				OFONO_CONNECTION_MANAGER_INTERFACE);
+
+	ps->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_NETREG,
+					netreg_watch, ps, NULL);
+
+	__ofono_atom_register(ps->atom, packet_service_unregister);
+}
+
+static void sim_spn_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_packet_service *ps	=3D userdata;
+	char *spn =3D NULL;
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
+
+	if (ok)
+		spn =3D sim_string_to_utf8(data + 1, length - 1);
+
+	sim_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(ps->atom),
+						OFONO_ATOM_TYPE_SIM);
+	if (sim_atom) {
+		sim =3D __ofono_atom_get_data(sim_atom);
+		provision_contexts(ps, ofono_sim_get_mcc(sim),
+					ofono_sim_get_mnc(sim), spn);
+	}
+
+	g_free(spn);
+	ofono_packet_service_finish_register(ps);
+}
+
+void ofono_packet_service_register(struct ofono_packet_service *ps)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(ps->atom);
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
+
+	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+
+	if (sim_atom) {
+		const char *imsi;
+		sim =3D __ofono_atom_get_data(sim_atom);
+
+		imsi =3D ofono_sim_get_imsi(sim);
+		ps_load_settings(ps, imsi);
+	}
+
+	if (ps->contexts =3D=3D NULL && sim !=3D NULL) {
+		/* Get Service Provider Name from SIM for provisioning */
+		ps->sim_context =3D ofono_sim_context_create(sim);
+
+		if (ofono_sim_read(ps->sim_context, SIM_EFSPN_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					sim_spn_read_cb, ps) >=3D 0)
+			return;
+	}
+
+	ofono_packet_service_finish_register(ps);
+}
+
+void ofono_packet_service_remove(struct ofono_packet_service *ps)
+{
+	__ofono_atom_free(ps->atom);
+}
+
+void ofono_packet_service_set_data(struct ofono_packet_service *ps,
+					void *data)
+{
+	ps->driver_data =3D data;
+}
+
+void *ofono_packet_service_get_data(struct ofono_packet_service *ps)
+{
+	return ps->driver_data;
+}
diff --git a/src/ps-provision.c b/src/ps-provision.c
new file mode 100644
index 0000000..aa4621f
--- /dev/null
+++ b/src/ps-provision.c
@@ -0,0 +1,101 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include <glib.h>
+#include "ofono.h"
+
+static GSList *g_drivers =3D NULL;
+
+void  __ofono_ps_provision_free_settings(
+				struct ofono_ps_provision_data *settings,
+				int count)
+{
+	int i;
+
+	for (i =3D 0; i < count; i++) {
+		g_free(settings[i].name);
+		g_free(settings[i].apn);
+		g_free(settings[i].username);
+		g_free(settings[i].password);
+		g_free(settings[i].message_proxy);
+		g_free(settings[i].message_center);
+	}
+
+	g_free(settings);
+}
+
+ofono_bool_t __ofono_ps_provision_get_settings(const char *mcc,
+				const char *mnc, const char *spn,
+				struct ofono_ps_provision_data **settings,
+				int *count)
+{
+	GSList *d;
+
+	if (mcc =3D=3D NULL || strlen(mcc) =3D=3D 0 || mnc =3D=3D NULL || strlen(=
mnc) =3D=3D 0)
+		return FALSE;
+
+	for (d =3D g_drivers; d !=3D NULL; d =3D d->next) {
+		const struct ofono_ps_provision_driver *driver =3D d->data;
+
+		if (driver->get_settings =3D=3D NULL)
+			continue;
+
+		DBG("Calling provisioning plugin '%s'", driver->name);
+
+		if (driver->get_settings(mcc, mnc, spn, settings, count) < 0)
+			continue;
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static gint compare_priority(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_ps_provision_driver *plugin1 =3D a;
+	const struct ofono_ps_provision_driver *plugin2 =3D b;
+
+	return plugin2->priority - plugin1->priority;
+}
+
+int ofono_ps_provision_driver_register(
+			const struct ofono_ps_provision_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_insert_sorted(g_drivers, (void *) driver,
+						compare_priority);
+	return 0;
+}
+
+void ofono_ps_provision_driver_unregister(
+			const struct ofono_ps_provision_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, driver);
+}
-- =

1.7.0.4


--===============0099802622402678142==--

