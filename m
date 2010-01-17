Content-Type: multipart/mixed; boundary="===============8303024163499379516=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Sun, 17 Jan 2010 18:28:32 +0100
Message-ID: <1263749312-6567-4-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1263749312-6567-3-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8303024163499379516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Brandeland <sjur.brandeland@stericsson.com>

Added implementation for STE modem; STE modem driver, and STE specific
drivers for gprs, network registration and voice call. =


This patch uses CAIF sockets. CAIF patch for net-next-2.6 will be
contributed on netdev(a)vger.kernel.org soon.

---
 Makefile.am                             |   11 +
 drivers/stemodem/gprs-context.c         |  612 +++++++++++++++++++++++++++=
+++
 drivers/stemodem/network-registration.c |  225 +++++++++++
 drivers/stemodem/stemodem.c             |  109 ++++++
 drivers/stemodem/stemodem.h             |   33 ++
 drivers/stemodem/voicecall.c            |  615 +++++++++++++++++++++++++++=
++++
 plugins/ste.c                           |  246 ++++++++++++
 7 files changed, 1851 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 276b478..bae8dcf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -129,6 +129,14 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/calypsomodem/calypsomodem.c \
 			drivers/calypsomodem/voicecall.c
 =

+builtin_modules +=3D stemodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/stemodem/stemodem.h \
+			drivers/stemodem/stemodem.c \
+			drivers/stemodem/voicecall.c \
+			drivers/stemodem/network-registration.c \
+			drivers/stemodem/gprs-context.c
+
 builtin_modules +=3D hfpmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/hfpmodem.h \
@@ -168,6 +176,9 @@ builtin_sources +=3D plugins/g1.c
 builtin_modules +=3D calypso
 builtin_sources +=3D plugins/calypso.c
 =

+builtin_modules +=3D ste
+builtin_sources +=3D plugins/ste.c
+
 builtin_modules +=3D mbm
 builtin_sources +=3D plugins/mbm.c
 =

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
new file mode 100644
index 0000000..1d5d8db
--- /dev/null
+++ b/drivers/stemodem/gprs-context.c
@@ -0,0 +1,612 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include <ofono/gprs.h>
+
+#include <linux/types.h>
+#include <net/if.h>
+#include <sys/ioctl.h>
+#include <arpa/inet.h>
+#include <linux/caif/caif_socket.h>
+#include <linux/caif/if_caif.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "stemodem.h"
+
+#define MAX_CAIF_DEVICES 7
+#define MAX_DNS 5
+#define AUTH_BUF_LENGTH (OFONO_GPRS_MAX_USERNAME_LENGTH + \
+			OFONO_GPRS_MAX_PASSWORD_LENGTH + 128)
+
+static const char *cgact_prefix[] =3D { "+CGACT:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
+static GSList *g_caif_devices;
+
+struct gprs_context_data {
+	GAtChat *chat;
+	unsigned int active_context;
+	char *username;
+	char *password;
+};
+
+struct conn_info {
+	unsigned int cid;
+	unsigned int device;
+	unsigned int channel_id;
+	char *interface;
+};
+
+static gint conn_compare_by_cid(gconstpointer a, gconstpointer b)
+{
+	const struct conn_info *conn =3D a;
+	unsigned int used =3D GPOINTER_TO_UINT(b);
+
+	if (used !=3D conn->cid)
+		return 1;
+
+	return 0;
+}
+
+/* TODO: should parse_xml function to be moved to e.g. atutil? */
+static char *parse_xml(char * xml, char* tag)
+{
+    char *begin;
+    char *end;
+    int len;
+    char *res =3D NULL;
+    char *start =3D (char *)g_malloc(strlen(tag)+3);
+    char *stop =3D (char *)g_malloc(strlen(tag)+4);
+
+    sprintf(start, "<%s>", tag);
+    sprintf(stop, "</%s>", tag);
+
+    begin =3D strstr(xml, start);
+	if (begin =3D=3D NULL)
+		goto error;
+
+	end =3D strstr(begin, stop);
+	if (end =3D=3D NULL)
+		goto error;
+
+	begin +=3D strlen(start);
+	len =3D end - begin;
+	res =3D (char *)g_malloc(len+1);
+	strncpy(res, begin, len);
+	res[len] =3D 0;
+
+error:
+	free(start);
+	free(stop);
+	return res;
+}
+
+static struct conn_info *conn_info_create(
+							unsigned int device,
+							unsigned int channel_id)
+{
+	struct conn_info *connection =3D g_try_new0(struct conn_info, 1);
+
+	if (!connection)
+		return NULL;
+
+	connection->cid =3D 0;
+	connection->device =3D device;
+	connection->channel_id =3D channel_id;
+
+	return connection;
+}
+
+/* Creates a new or removes an existing IP interface for CAIF.
+ * Sets the ip address, subnet mask and MTU size at creation.
+ *
+*/
+static gboolean caif_if_create_remove(const char *interface,
+					const char *ip, const char *mtu,
+					const char *mask, unsigned int connid,
+					gboolean create)
+{
+	int s;
+	struct sockaddr_in sin;
+	static struct ifcaif_param param;
+	static struct ifreq ifr;
+
+	param.ipv4_connid =3D connid;
+	ifr.ifr_data =3D (void *) &param;
+	strcpy(ifr.ifr_name, interface);
+
+	s =3D socket(AF_CAIF, SOCK_SEQPACKET, CAIFPROTO_AT);
+	if (s < 0) {
+		ofono_debug("Failed to create socket for CAIF interface");
+		goto error;
+	}
+
+	if (create) {
+		if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
+			ofono_debug("Failed to create IP interface for CAIF");
+			goto error;
+		}
+
+		s =3D socket(PF_INET, SOCK_DGRAM, 0);
+		if (s < 0) {
+			ofono_debug("Failed to create socket.");
+			goto error;
+		}
+
+		/* Set IP address */
+		memset(&sin, 0, sizeof(struct sockaddr));
+		sin.sin_family =3D AF_INET;
+
+		if (inet_pton(AF_INET, ip, &sin.sin_addr) <=3D 0) {
+			ofono_debug("inet_pton failed, will not be"
+				"able to set the IP address");
+			goto error;
+		}
+		memcpy(&ifr.ifr_addr, &sin, sizeof(struct sockaddr));
+
+		if (ioctl(s, SIOCSIFADDR, &ifr) < 0) {
+			ofono_debug("Failed to set IP address for"
+			" interface: %s", ifr.ifr_name);
+			goto error;
+		}
+
+		/* Set subnet mask */
+		memset(&sin, 0, sizeof(struct sockaddr));
+		sin.sin_family =3D AF_INET;
+
+		if (inet_pton(AF_INET, mask, &sin.sin_addr) <=3D 0) {
+			ofono_debug("inet_pton failed, will not be"
+				"able to set the subnet mask");
+		} else {
+			memcpy(&ifr.ifr_addr, &sin, sizeof(struct sockaddr));
+
+			if (ioctl(s, SIOCSIFNETMASK, &ifr) < 0)
+				ofono_debug("Failed to set subnet mask for"
+					"interface: %s", ifr.ifr_name);
+		}
+
+		/* Set MTU */
+		ifr.ifr_mtu =3D atoi(mtu);
+
+		if (ioctl(s, SIOCSIFMTU, &ifr) < 0)
+			ofono_debug("Failed to set MTU for interface: %s",
+				ifr.ifr_name);
+	} else {
+		if (ioctl(s, SIOCGIFINDEX, &ifr) =3D=3D 0) {
+			if (ioctl(s, SIOCCAIFNETREMOVE, &ifr) < 0) {
+				ofono_debug("Failed to remove IP interface"
+					"for CAIF");
+				goto error;
+			}
+		} else {
+			ofono_debug("Did not find interface (%s) to remove",
+					interface);
+			goto error;
+		}
+	}
+
+	return TRUE;
+
+error:
+	return FALSE;
+}
+
+static void ste_eppsd_down_cb(gboolean ok,
+					GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
+	struct ofono_gprs_context *gc =3D cbd->user;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_error error;
+	struct conn_info *conn;
+	GSList *l;
+
+	dump_response("ste_eppsd_down_cb", ok, result);
+
+	if (!ok)
+		goto error;
+
+	l =3D g_slist_find_custom(g_caif_devices,
+				GUINT_TO_POINTER(gcd->active_context),
+				conn_compare_by_cid);
+
+	if (!l) {
+		ofono_debug("Did not find data (used caif device) for"
+					"connection with cid; %d",
+					gcd->active_context);
+		goto error;
+	}
+	conn =3D l->data;
+	if (!caif_if_create_remove(conn->interface, NULL,
+		NULL, NULL, conn->channel_id, FALSE)) {
+		ofono_debug("Failed to remove caif interface %s.",
+			conn->interface);
+	}
+	conn->cid =3D 0;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void ste_eppsd_up_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	struct ofono_gprs_context *gc =3D cbd->user;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct conn_info *conn =3D NULL;
+	GAtResultIter iter;
+	GSList *l;
+	int i;
+	int numdns =3D 0;
+	char *res_string;
+	const char *ip =3D NULL;
+	const char *netmask =3D NULL;
+	const char *gateway =3D NULL;
+	const char *mtu =3D NULL;
+	const char *dns[MAX_DNS + 1];
+	const char *str;
+
+	dump_response("ste_eppsd_up_cb", ok, result);
+
+	l =3D g_slist_find_custom(g_caif_devices,
+				GUINT_TO_POINTER(gcd->active_context),
+				conn_compare_by_cid);
+
+	if (!l) {
+		ofono_debug("Did not find data (device and channel id)"
+					"for connection with cid; %d",
+					gcd->active_context);
+		goto error;
+	}
+	conn =3D l->data;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+	for (i =3D 0; i < g_at_result_num_response_lines(result); i++) {
+		g_at_result_iter_next(&iter, NULL);
+		res_string =3D strdup(g_at_result_iter_raw_line(&iter));
+
+		if (strstr(res_string, "ip_address")) {
+			ip =3D g_strdup(parse_xml(res_string,
+						"ip_address"));
+		} else if ((strstr(res_string, "subnet_mask"))) {
+			netmask =3D g_strdup(parse_xml(res_string,
+						"subnet_mask"));
+		} else if ((strstr(res_string, "mtu"))) {
+			mtu =3D g_strdup(parse_xml(res_string,
+						"mtu"));
+		} else if ((strstr(res_string, "default_gateway"))) {
+			gateway =3D g_strdup(parse_xml(res_string,
+						"default_gateway"));
+		} else if ((strstr(res_string, "dns_server"))) {
+			str =3D g_strdup(parse_xml(res_string,
+						"dns_server"));
+
+			if (numdns < MAX_DNS)
+				dns[numdns++] =3D str;
+		}
+	}
+	dns[numdns] =3D NULL;
+
+	conn->interface =3D g_malloc(10);
+	if (!conn->interface)
+		goto error;
+
+	sprintf(conn->interface, "caif%u", conn->device);
+
+	if (!caif_if_create_remove(conn->interface, ip,
+			mtu, netmask, conn->channel_id, TRUE)) {
+		ofono_error("Failed to create caif interface %s.",
+			conn->interface);
+		conn->interface =3D NULL;
+	}
+
+	/* Set back to strict syntax check */
+	g_at_chat_set_syntax(gcd->chat, g_at_syntax_new_gsmv1());
+
+	CALLBACK_WITH_SUCCESS(cb, conn->interface,
+				FALSE, ip, netmask, gateway, dns, cbd->data);
+	return;
+
+error:
+	ofono_debug("ste_eppsd_up_cb error");
+
+	if (conn)
+		conn->cid =3D 0;
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+}
+
+static void ste_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	struct ofono_gprs_context *gc =3D cbd->user;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct cb_data *ncbd =3D NULL;
+	struct conn_info *conn;
+	char buf[AUTH_BUF_LENGTH];
+	GSList *l;
+
+	dump_response("cgdcont_cb", ok, result);
+
+	if (!ok) {
+		struct ofono_error error;
+
+		gcd->active_context =3D 0;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		return;
+	}
+
+	/* Set username and password */
+	sprintf(buf, "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"", gcd->active_context,
+		gcd->username, gcd->password);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				NULL, NULL, NULL) =3D=3D 0)
+		goto error;
+
+	ncbd =3D g_memdup(cbd, sizeof(struct cb_data));
+
+	/* Need to change to gsm_permissive syntax in order to
+	 * parse the response from EPPSD (xml) */
+	g_at_chat_set_syntax(gcd->chat, g_at_syntax_new_gsm_permissive());
+
+	l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(0),
+				conn_compare_by_cid);
+
+	if (!l) {
+		ofono_debug("at_cgdcont_cb, no more available devices");
+		goto error;
+	}
+	conn =3D l->data;
+	conn->cid =3D gcd->active_context;
+	sprintf(buf, "AT*EPPSD=3D1,%u,%u", conn->channel_id, conn->cid);
+
+	if (g_at_chat_send(gcd->chat, buf, NULL,
+				ste_eppsd_up_cb, ncbd, g_free) > 0)
+		return;
+error:
+	if (ncbd)
+		g_free(ncbd);
+
+	gcd->active_context =3D 0;
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL,
+						NULL, NULL, cbd->data);
+}
+
+static void ste_gprs_activate_primary(struct ofono_gprs_context *gc,
+				const struct ofono_gprs_primary_context *ctx,
+				 ofono_gprs_context_up_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
+	int len;
+
+	if (!cbd)
+		goto error;
+
+	gcd->active_context =3D ctx->cid;
+	gcd->username =3D g_strdup(ctx->username);
+	gcd->password =3D g_strdup(ctx->password);
+	cbd->user =3D gc;
+
+	len =3D sprintf(buf, "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
+
+	if (ctx->apn)
+		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
+				ctx->apn);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				ste_cgdcont_cb, cbd, g_free) > 0)
+		return;
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+}
+
+static void ste_gprs_deactivate_primary(struct ofono_gprs_context *gc,
+					unsigned int id,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct conn_info *conn;
+	char buf[64];
+	GSList *l;
+
+	if (!cbd)
+		goto error;
+
+	gcd->active_context =3D id;
+	cbd->user =3D gc;
+
+	l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(id),
+				conn_compare_by_cid);
+
+	if (!l) {
+		ofono_debug("at_gprs_deactivate_primary, did not find"
+			"data (channel id) for connection with cid; %d", id);
+		goto error;
+	}
+	conn =3D l->data;
+
+	sprintf(buf, "AT*EPPSD=3D0,%u,%u", conn->channel_id, id);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				ste_eppsd_down_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void ste_cgact_read_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	gint cid, state;
+	GAtResultIter iter;
+
+	dump_response("cgact_read_cb", ok, result);
+
+	if (!ok)
+		return;
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CGACT:")) {
+
+		if (!g_at_result_iter_next_number(&iter, &cid))
+			continue;
+
+		if ((unsigned int) cid !=3D gcd->active_context)
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &state))
+			continue;
+
+		if (state =3D=3D 1)
+			continue;
+
+		ofono_gprs_context_deactivated(gc, gcd->active_context);
+		gcd->active_context =3D 0;
+
+		break;
+	}
+}
+
+static void cgev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtResultIter iter;
+	const char *event;
+
+	dump_response("cgev_notify", TRUE, result);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGEV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
+		return;
+
+	if (g_str_has_prefix(event, "NW REACT ") ||
+			g_str_has_prefix(event, "NW DEACT ") ||
+			g_str_has_prefix(event, "ME DEACT ")) {
+		/* Ask what primary contexts are active now */
+
+		g_at_chat_send(gcd->chat, "AT+CGACT?", cgact_prefix,
+				ste_cgact_read_cb, gc, NULL);
+
+		return;
+	}
+}
+
+static int ste_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct gprs_context_data *gcd;
+	struct conn_info *ci;
+	int i;
+
+	gcd =3D g_new0(struct gprs_context_data, 1);
+	gcd->chat =3D chat;
+
+	g_at_chat_register(gcd->chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
+
+	ofono_gprs_context_set_data(gc, gcd);
+
+	for (i =3D 0; i < MAX_CAIF_DEVICES; i++) {
+		ci =3D conn_info_create(i, i+1);
+		if (ci)
+			g_caif_devices =3D g_slist_append(g_caif_devices, ci);
+	}
+
+	return 0;
+}
+
+static void ste_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	g_slist_foreach(g_caif_devices, (GFunc) g_free, NULL);
+	g_slist_free(g_caif_devices);
+	g_caif_devices =3D NULL;
+
+	ofono_gprs_context_set_data(gc, NULL);
+	g_free(gcd);
+}
+
+static struct ofono_gprs_context_driver driver =3D {
+	.name			=3D "stemodem",
+	.probe			=3D ste_gprs_context_probe,
+	.remove			=3D ste_gprs_context_remove,
+	.activate_primary	=3D ste_gprs_activate_primary,
+	.deactivate_primary	=3D ste_gprs_deactivate_primary,
+};
+
+void ste_gprs_context_init()
+{
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void ste_gprs_context_exit()
+{
+	ofono_gprs_context_driver_unregister(&driver);
+}
diff --git a/drivers/stemodem/network-registration.c b/drivers/stemodem/net=
work-registration.c
new file mode 100644
index 0000000..4eeb239
--- /dev/null
+++ b/drivers/stemodem/network-registration.c
@@ -0,0 +1,225 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen@stericsson.com.
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/netreg.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "stemodem.h"
+
+static const char *cind_prefix[] =3D { "+CIND:", NULL };
+
+struct netreg_data {
+	GAtChat *chat;
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+};
+
+static void ciev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	int strength, ind;
+	GAtResultIter iter;
+
+	dump_response("ciev_notify", TRUE, result);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &ind))
+		return;
+
+	if (ind =3D=3D 2) { /* signal strength indication */
+		if (!g_at_result_iter_next_number(&iter, &strength))
+			return;
+
+		strength =3D (strength * 100) / 5;
+		ofono_netreg_strength_notify(netreg, strength);
+	}
+}
+
+static void cind_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_strength_cb_t cb =3D cbd->cb;
+	int strength;
+	GAtResultIter iter;
+	struct ofono_error error;
+
+	dump_response("cind_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIND:")) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	/* Skip battery charge level, which is the first reported  */
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &strength);
+
+	strength =3D (strength * 100) / 5;
+
+	cb(&error, strength, cbd->data);
+}
+
+static void ste_signal_strength(struct ofono_netreg *netreg,
+				ofono_netreg_strength_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (!cbd)
+		goto error;
+
+	if (g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
+				cind_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void creg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	GAtResultIter iter;
+	int status;
+	int lac =3D -1, ci =3D -1, tech =3D -1;
+	const char *str;
+
+	dump_response("creg_notify", TRUE, result);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CREG:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &status);
+
+	if (g_at_result_iter_next_string(&iter, &str) =3D=3D TRUE)
+		lac =3D strtol(str, NULL, 16);
+	else
+		goto out;
+
+	if (g_at_result_iter_next_string(&iter, &str) =3D=3D TRUE)
+		ci =3D strtol(str, NULL, 16);
+	else
+		goto out;
+
+	g_at_result_iter_next_number(&iter, &tech);
+
+out:
+	ofono_debug("creg_notify: %d, %d, %d, %d", status, lac, ci, tech);
+
+	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
+}
+
+static void ste_network_registration_initialized(gboolean ok, GAtResult *r=
esult,
+							gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	if (!ok) {
+		ofono_error("Unable to initialize Network Registration");
+		ofono_netreg_remove(netreg);
+		return;
+	}
+
+	g_at_chat_register(nd->chat, "+CREG:",
+				creg_notify, FALSE, netreg, NULL);
+
+	g_at_chat_register(nd->chat, "+CIEV:",
+				ciev_notify, FALSE, netreg, NULL);
+
+	ofono_netreg_register(netreg);
+}
+
+static int ste_netreg_probe(struct ofono_netreg *netreg, unsigned int vend=
or,
+				void *data)
+{
+	GAtChat *chat =3D data;
+	struct netreg_data *nd;
+
+	nd =3D g_new0(struct netreg_data, 1);
+
+	nd->chat =3D chat;
+	ofono_netreg_set_data(netreg, nd);
+
+	g_at_chat_send(chat, "AT+CMER=3D3,0,0,1", NULL, NULL, NULL, NULL);
+
+	g_at_chat_send(chat, "AT+CREG=3D2", NULL,
+				ste_network_registration_initialized,
+				netreg, NULL);
+	return 0;
+}
+
+static struct ofono_netreg_driver driver =3D {
+	.name				=3D "stemodem",
+	.probe				=3D ste_netreg_probe,
+	.remove				=3D NULL,
+	.registration_status 	=3D NULL,
+	.current_operator 		=3D NULL,
+	.list_operators			=3D NULL,
+	.register_auto			=3D NULL,
+	.register_manual		=3D NULL,
+	.deregister			=3D NULL,
+	.strength			=3D ste_signal_strength,
+};
+
+void ste_netreg_init()
+{
+	ofono_netreg_driver_register(&driver);
+}
+
+void ste_netreg_exit()
+{
+	ofono_netreg_driver_unregister(&driver);
+}
diff --git a/drivers/stemodem/stemodem.c b/drivers/stemodem/stemodem.c
new file mode 100644
index 0000000..0d840ea
--- /dev/null
+++ b/drivers/stemodem/stemodem.c
@@ -0,0 +1,109 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
+ * =

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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+#include <gatchat.h>
+#include <ofono/log.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+#include <ofono/voicecall.h>
+#include <ofono/netreg.h>
+
+#include "stemodem.h"
+
+static int stemodem_init(void)
+{
+	/* Initialize voicecall driver */
+	struct ofono_voicecall_driver *at_vcdrv;
+	struct ofono_voicecall_driver *ste_vcdrv;
+	struct ofono_netreg_driver *at_netdrv;
+	struct ofono_netreg_driver *ste_netdrv;
+
+	ste_voicecall_init();
+
+	at_vcdrv =3D ofono_voicecall_driver_get("atmodem");
+	ste_vcdrv =3D ofono_voicecall_driver_get("stemodem");
+
+	if (at_vcdrv && ste_vcdrv) {
+		ste_vcdrv->remove =3D at_vcdrv->remove;
+		ste_vcdrv->swap_without_accept =3D at_vcdrv->swap_without_accept;
+		ste_vcdrv->send_tones =3D at_vcdrv->send_tones;
+	} else {
+		if (!ste_vcdrv)
+			ofono_debug("Could not get ofono_voicecall_driver"
+					"from stemodem");
+		if (!at_vcdrv)
+			ofono_debug("Could not get ofono_voicecall_driver"
+					"from atmodem");
+	}
+
+	/* Initialize netreg driver */
+	ste_netreg_init();
+
+	at_netdrv =3D ofono_netreg_driver_get("atmodem");
+	ste_netdrv =3D ofono_netreg_driver_get("stemodem");
+
+	if (at_netdrv && ste_netdrv) {
+		ste_netdrv->remove =3D at_netdrv->remove;
+		ste_netdrv->registration_status =3D
+			at_netdrv->registration_status;
+		ste_netdrv->current_operator =3D at_netdrv->current_operator;
+		ste_netdrv->list_operators =3D at_netdrv->list_operators;
+		ste_netdrv->register_auto =3D at_netdrv->register_auto;
+		ste_netdrv->register_manual =3D at_netdrv->register_manual;
+	} else {
+		if (!ste_netdrv)
+			ofono_debug("Could not get ofono_netreg_driver driver"
+					"from stemodem");
+		if (!at_netdrv)
+			ofono_debug("Could not get ofono_netreg_driver driver"
+					"from atemodem");
+	}
+
+	/* Initialize gprs driver */
+	ste_gprs_context_init();
+
+	return 0;
+}
+
+static void stemodem_exit(void)
+{
+	ste_voicecall_exit();
+	ste_netreg_exit();
+	ste_gprs_context_exit();
+}
+
+/* atmodem must be registered before stemodem (for the ofono_netreg_driver=
_get
+ * to return correct information). This is achieved by setting priority low
+ * for stemodem; OFONO_PLUGIN_PRIORITY_LOW */
+
+OFONO_PLUGIN_DEFINE(stemodem, "STE modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_LOW,
+			stemodem_init, stemodem_exit)
diff --git a/drivers/stemodem/stemodem.h b/drivers/stemodem/stemodem.h
new file mode 100644
index 0000000..83bdcaa
--- /dev/null
+++ b/drivers/stemodem/stemodem.h
@@ -0,0 +1,33 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
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
+#include <drivers/atmodem/atutil.h>
+
+extern void ste_voicecall_init();
+extern void ste_voicecall_exit();
+
+extern void	ste_netreg_init();
+extern void	ste_netreg_exit();
+
+extern void	ste_gprs_context_init();
+extern void	ste_gprs_context_exit();
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
new file mode 100644
index 0000000..c00fc61
--- /dev/null
+++ b/drivers/stemodem/voicecall.c
@@ -0,0 +1,615 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/voicecall.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "common.h"
+
+#include "stemodem.h"
+
+enum call_status_ste {
+	STE_CALL_STATUS_IDLE =3D 0,
+	STE_CALL_STATUS_CALLING =3D 1,
+	STE_CALL_STATUS_CONNECTING =3D 2,
+	STE_CALL_STATUS_ACTIVE =3D 3,
+	STE_CALL_STATUS_HOLD =3D 4,
+	STE_CALL_STATUS_WAITING =3D 5,
+	STE_CALL_STATUS_ALERTING =3D 6,
+	STE_CALL_STATUS_BUSY =3D 7
+};
+
+static const char *none_prefix[] =3D { NULL };
+
+struct voicecall_data {
+	GSList *calls;
+	unsigned int local_release;
+	GAtChat *chat;
+};
+
+struct release_id_req {
+	struct ofono_voicecall *vc;
+	ofono_voicecall_cb_t cb;
+	void *data;
+	int id;
+};
+
+struct change_state_req {
+	struct ofono_voicecall *vc;
+	ofono_voicecall_cb_t cb;
+	void *data;
+	int affected_types;
+};
+
+/* Translate from the ECAV-based STE-status to CLCC based status */
+static int call_status_ste_to_ofono(int status)
+{
+	switch (status) {
+	case STE_CALL_STATUS_IDLE:
+		return CALL_STATUS_DISCONNECTED;
+	case STE_CALL_STATUS_CALLING:
+		return CALL_STATUS_DIALING;
+	case STE_CALL_STATUS_CONNECTING:
+		return CALL_STATUS_ALERTING;
+	case STE_CALL_STATUS_ACTIVE:
+		return CALL_STATUS_ACTIVE;
+	case STE_CALL_STATUS_HOLD:
+		return CALL_STATUS_HELD;
+	case STE_CALL_STATUS_WAITING:
+		return CALL_STATUS_WAITING;
+	case STE_CALL_STATUS_ALERTING:
+		return CALL_STATUS_INCOMING;
+	case STE_CALL_STATUS_BUSY:
+		return CALL_STATUS_DISCONNECTED;
+	default:
+		return CALL_STATUS_DISCONNECTED;
+	}
+}
+
+static gint call_compare(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *ca =3D a;
+	const struct ofono_call *cb =3D b;
+
+	if (ca->id < cb->id)
+		return -1;
+
+	if (ca->id > cb->id)
+		return 1;
+
+	return 0;
+}
+
+static gint call_compare_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *call =3D a;
+	unsigned int id =3D GPOINTER_TO_UINT(b);
+
+	if (id < call->id)
+		return -1;
+
+	if (id > call->id)
+		return 1;
+
+	return 0;
+}
+
+static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
+					int direction, int status,
+					const char *num, int num_type, int clip)
+{
+	struct voicecall_data *d =3D ofono_voicecall_get_data(vc);
+	struct ofono_call *call;
+
+	/* Generate a call structure for the waiting call */
+	call =3D g_try_new0(struct ofono_call, 1);
+	if (!call)
+		return NULL;
+
+	call->type =3D type;
+	call->direction =3D direction;
+	call->status =3D status;
+
+	if (clip !=3D 2) {
+		strncpy(call->phone_number.number, num,
+			OFONO_MAX_PHONE_NUMBER_LENGTH);
+		call->phone_number.type =3D num_type;
+	}
+
+	call->clip_validity =3D clip;
+
+	d->calls =3D g_slist_insert_sorted(d->calls, call, call_compare);
+
+	return call;
+}
+
+static void ste_generic_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct change_state_req *req =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+	struct ofono_error error;
+
+	dump_response("ste_generic_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok && req->affected_types) {
+		GSList *l;
+		struct ofono_call *call;
+
+		for (l =3D vd->calls; l; l =3D l->next) {
+			call =3D l->data;
+
+			if (req->affected_types & (0x1 << call->status))
+				vd->local_release |=3D (0x1 << call->id);
+		}
+	}
+
+	/* We have to callback after we schedule a poll if required */
+	req->cb(&error, req->data);
+}
+
+static void release_id_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct release_id_req *req =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+	struct ofono_error error;
+
+	dump_response("release_id_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok)
+		vd->local_release =3D 0x1 << req->id;
+
+	/* We have to callback after we schedule a poll if required */
+	req->cb(&error, req->data);
+}
+
+static void atd_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_error error;
+	ofono_voicecall_cb_t cb =3D cbd->cb;
+
+	dump_response("atd_cb", ok, result);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto out;
+
+out:
+	cb(&error, cbd->data);
+}
+
+static void ste_dial(struct ofono_voicecall *vc,
+			const struct ofono_phone_number *ph,
+			enum ofono_clir_option clir, enum ofono_cug_option cug,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[256];
+
+	if (!cbd)
+		goto error;
+
+	cbd->user =3D vc;
+
+	if (ph->type =3D=3D 145)
+		sprintf(buf, "ATD+%s", ph->number);
+	else
+		sprintf(buf, "ATD%s", ph->number);
+
+	switch (clir) {
+	case OFONO_CLIR_OPTION_INVOCATION:
+		strcat(buf, "I");
+		break;
+	case OFONO_CLIR_OPTION_SUPPRESSION:
+		strcat(buf, "i");
+		break;
+	default:
+		break;
+	}
+
+	switch (cug) {
+	case OFONO_CUG_OPTION_INVOCATION:
+		strcat(buf, "G");
+		break;
+	default:
+		break;
+	}
+
+	strcat(buf, ";");
+
+	if (g_at_chat_send(vd->chat, buf, none_prefix,
+				atd_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void ste_template(const char *cmd, struct ofono_voicecall *vc,
+			GAtResultFunc result_cb, unsigned int affected_types,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct change_state_req *req =3D g_try_new0(struct change_state_req, 1);
+
+	if (!req)
+		goto error;
+
+	req->vc =3D vc;
+	req->cb =3D cb;
+	req->data =3D data;
+	req->affected_types =3D affected_types;
+
+	if (g_at_chat_send(vd->chat, cmd, none_prefix,
+				result_cb, req, g_free) > 0)
+		return;
+
+error:
+	if (req)
+		g_free(req);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void ste_answer(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	ste_template("ATA", vc, ste_generic_cb, 0, cb, data);
+}
+
+static void ste_hangup(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	/* Hangup all calls */
+	ste_template("AT+CHUP", vc, ste_generic_cb, 0x3f, cb, data);
+}
+
+static void ste_hold_all_active(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	ste_template("AT+CHLD=3D2", vc, ste_generic_cb, 0, cb, data);
+}
+
+static void ste_release_all_held(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int held_status =3D 0x1 << 1;
+	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, held_status, cb, data);
+}
+
+static void ste_set_udub(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, incoming_or_waiting,
+			cb, data);
+}
+
+static void ste_release_all_active(struct ofono_voicecall *vc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	ste_template("AT+CHLD=3D1", vc, ste_generic_cb, 0x1, cb, data);
+}
+
+static void ste_release_specific(struct ofono_voicecall *vc, int id,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct release_id_req *req =3D g_try_new0(struct release_id_req, 1);
+	char buf[32];
+	struct ofono_call *call;
+	GSList *l;
+	int ac =3D 0;
+
+	if (!req)
+		goto error;
+
+	req->vc =3D vc;
+	req->cb =3D cb;
+	req->data =3D data;
+	req->id =3D id;
+
+	/* Count active calls. If there is more than one active call
+	 * we cannot use ATH, as it will terminate all calls.
+	 * The reason for using ATH and not CHLD is that
+	 * emergency calls can not be terminated with AT+CHLD.
+	 */
+	for (l =3D vd->calls; l; l =3D l->next) {
+		call =3D l->data;
+
+		if (call->status =3D=3D CALL_STATUS_ACTIVE)
+			ac++;
+	}
+
+	l =3D g_slist_find_custom(vd->calls, GUINT_TO_POINTER(id),
+				call_compare_by_id);
+	if (l =3D=3D NULL) {
+		ofono_error("Hangup request for unknow call");
+		goto error;
+	}
+	call =3D l->data;
+	/* Check the state of the call, as AT+CHLD does not terminate
+	 * calls in state Dialing, Alerting and Incoming */
+	if (call->status =3D=3D CALL_STATUS_DIALING ||
+	    call->status =3D=3D CALL_STATUS_ALERTING ||
+	    call->status =3D=3D CALL_STATUS_INCOMING)
+		sprintf(buf, "ATH");
+
+	/* Waiting call can not be terminated by at+chld=3D1x,
+	 * have to use at+chld =3D 0, but that will also terminate
+	 * other held calls. Bug in STE's AT module.
+	 */
+	else if (call->status =3D=3D CALL_STATUS_WAITING)
+		sprintf(buf, "AT+CHLD=3D0");
+
+	else {
+		/* A held call can not be released by ATH, need to use CHLD */
+		if (ac > 1 || call->status =3D=3D CALL_STATUS_HELD)
+			sprintf(buf, "AT+CHLD=3D1%d", id);
+		else /* This is the last call, ok to use ATH. */
+			sprintf(buf, "ATH");
+	}
+
+	if (g_at_chat_send(vd->chat, buf, none_prefix,
+				release_id_cb, req, g_free) > 0)
+		return;
+
+error:
+	if (req)
+		g_free(req);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void ste_private_chat(struct ofono_voicecall *vc, int id,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	char buf[32];
+
+	sprintf(buf, "AT+CHLD=3D2%d", id);
+	ste_template(buf, vc, ste_generic_cb, 0, cb, data);
+}
+
+static void ste_create_multiparty(struct ofono_voicecall *vc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	ste_template("AT+CHLD=3D3", vc, ste_generic_cb, 0, cb, data);
+}
+
+static void ste_transfer(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	/* Held & Active */
+	unsigned int transfer =3D 0x1 | 0x2;
+
+	/* Transfer can puts held & active calls together and disconnects
+	 * from both.  However, some networks support transfering of
+	 * dialing/ringing calls as well.
+	 */
+	transfer |=3D 0x4 | 0x8;
+
+	ste_template("AT+CHLD=3D4", vc, ste_generic_cb, transfer, cb, data);
+}
+
+static void ste_deflect(struct ofono_voicecall *vc,
+			const struct ofono_phone_number *ph,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	char buf[128];
+	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+
+	sprintf(buf, "AT+CTFR=3D\"%s\",%d", ph->number, ph->type);
+	ste_template(buf, vc, ste_generic_cb, incoming_or_waiting, cb, data);
+}
+
+static void ecav_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	const char *num;
+	int id;
+	int status;
+	int call_type;
+	int num_type;
+	struct ofono_call *new_call;
+	struct ofono_call *existing_call =3D NULL;
+	GSList *l;
+
+	/* Parse ECAV */
+	dump_response("ecav_notify", TRUE, result);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "*ECAV:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &id))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &call_type))
+		return;
+
+	/* Skip process id and exit cause */
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+
+	status =3D call_status_ste_to_ofono(status);
+	if (status =3D=3D CALL_STATUS_DIALING ||
+	    status =3D=3D CALL_STATUS_WAITING ||
+	    status =3D=3D CALL_STATUS_INCOMING) {
+		if (!g_at_result_iter_next_string(&iter, &num))
+			return;
+
+		if (!g_at_result_iter_next_number(&iter, &num_type))
+			return;
+	}
+
+	/* Handle the call according to the status.
+	 * If it doesn't exists we make a new one
+	 */
+	l =3D g_slist_find_custom(vd->calls, GUINT_TO_POINTER(id),
+				call_compare_by_id);
+	if (l)
+		existing_call =3D l->data;
+
+	if (l =3D=3D NULL && status !=3D CALL_STATUS_DIALING &&
+					 status !=3D CALL_STATUS_WAITING &&
+					 status !=3D CALL_STATUS_INCOMING) {
+		ofono_error("ECAV notification for unknow call. "
+					"id: %d, status: %d", id, status);
+		return;
+	}
+
+	switch (status) {
+	case CALL_STATUS_DISCONNECTED: {
+		enum ofono_disconnect_reason reason;
+		existing_call->status =3D status;
+
+		if (vd->local_release & (0x1 << existing_call->id))
+			reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
+		else
+			reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+
+		if (call_type =3D=3D BEARER_CLASS_VOICE)
+			ofono_voicecall_disconnected(vc,
+					existing_call->id, reason, NULL);
+		vd->calls =3D g_slist_remove(vd->calls, l->data);
+		break;
+	}
+	case CALL_STATUS_DIALING:
+	case CALL_STATUS_WAITING:
+	case CALL_STATUS_INCOMING: {
+		int clip_validity;
+		int direction;
+
+		if (status =3D=3D CALL_STATUS_DIALING)
+			direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
+		else
+			direction =3D CALL_DIRECTION_MOBILE_TERMINATED;
+
+		if ((strlen(num)) > 0)
+			clip_validity =3D CLIP_VALIDITY_VALID;
+		else
+			clip_validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
+
+		new_call =3D create_call(vc, call_type, direction,
+							status, num, num_type,
+							clip_validity);
+
+		if (!new_call) {
+			ofono_error("Unable to malloc."
+				"Call management is fubar");
+			return;
+		}
+		new_call->id =3D id;
+
+		if (call_type =3D=3D BEARER_CLASS_VOICE)
+			ofono_voicecall_notify(vc, new_call);
+		break;
+	}
+	case CALL_STATUS_ALERTING:
+	case CALL_STATUS_ACTIVE:
+	case CALL_STATUS_HELD:
+		existing_call->status =3D status;
+
+		if (call_type =3D=3D BEARER_CLASS_VOICE)
+			ofono_voicecall_notify(vc, existing_call);
+		break;
+	default:
+		break;
+	}
+}
+
+static int ste_voicecall_probe(struct ofono_voicecall *vc, unsigned int ve=
ndor,
+				void *data)
+{
+	GAtChat *chat =3D data;
+	struct voicecall_data *vd;
+
+	vd =3D g_new0(struct voicecall_data, 1);
+	vd->chat =3D chat;
+
+	ofono_voicecall_set_data(vc, vd);
+
+	g_at_chat_send(chat, "AT*ECAM=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_register(chat, "*ECAV:", ecav_notify, FALSE, vc, NULL);
+	ofono_voicecall_register(vc);
+
+	return 0;
+}
+
+static struct ofono_voicecall_driver driver =3D {
+	.name			=3D "stemodem",
+	.probe			=3D ste_voicecall_probe,
+	.remove			=3D NULL,
+	.dial			=3D ste_dial,
+	.answer			=3D ste_answer,
+	.hangup			=3D ste_hangup,
+	.hold_all_active	=3D ste_hold_all_active,
+	.release_all_held	=3D ste_release_all_held,
+	.set_udub		    =3D ste_set_udub,
+	.release_all_active	=3D ste_release_all_active,
+	.release_specific	=3D ste_release_specific,
+	.private_chat		=3D ste_private_chat,
+	.create_multiparty	=3D ste_create_multiparty,
+	.transfer		    =3D ste_transfer,
+	.deflect		    =3D ste_deflect,
+	.swap_without_accept =3D NULL,
+	.send_tones		    =3D NULL
+};
+
+void ste_voicecall_init()
+{
+	ofono_voicecall_driver_register(&driver);
+}
+
+void ste_voicecall_exit()
+{
+	ofono_voicecall_driver_unregister(&driver);
+}
diff --git a/plugins/ste.c b/plugins/ste.c
new file mode 100644
index 0000000..72477a5
--- /dev/null
+++ b/plugins/ste.c
@@ -0,0 +1,246 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
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
+#include <errno.h>
+#include <stdlib.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-barring.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-meter.h>
+#include <ofono/call-settings.h>
+#include <ofono/devinfo.h>
+#include <ofono/message-waiting.h>
+#include <ofono/netreg.h>
+#include <ofono/phonebook.h>
+#include <ofono/sim.h>
+#include <ofono/sms.h>
+#include <ofono/ssn.h>
+#include <ofono/ussd.h>
+#include <ofono/call-volume.h>
+#include <ofono/voicecall.h>
+#include <drivers/atmodem/vendor.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <linux/caif/caif_socket.h>
+#include <unistd.h>
+
+struct ste_data {
+	GAtChat *chat;
+};
+
+static int ste_probe(struct ofono_modem *modem)
+{
+	struct ste_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct ste_data, 1);
+
+	if (!data)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+	return 0;
+}
+
+static void ste_remove(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_at_chat_unref(data->chat);
+	g_free(data);
+}
+
+static void ste_debug(const char *str, void *user_data)
+{
+	ofono_info("%s", str);
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	if (!ok)
+		ofono_modem_set_powered(modem, FALSE);
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static int ste_enable(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	int fd;
+	struct sockaddr_caif addr =3D {
+		.family =3D AF_CAIF,
+		.u.at.type =3D CAIF_ATTYPE_PLAIN
+	};
+
+	DBG("%p", modem);
+
+	/* Create a CAIF socket for AT Service */
+	fd =3D socket(AF_CAIF, SOCK_SEQPACKET, CAIFPROTO_AT);
+
+	/* Connect to the AT Service at the modem */
+	connect(fd, (struct sockaddr *) &addr, sizeof(addr));
+	channel =3D g_io_channel_unix_new(fd);
+
+	if (!channel)  {
+		close(fd);
+		return -EIO;
+	}
+	g_io_channel_set_close_on_unref(channel, TRUE);
+
+	syntax =3D g_at_syntax_new_gsmv1();
+
+	data->chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (!data->chat)
+		return -ENOMEM;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->chat, ste_debug, NULL);
+
+	g_at_chat_send(data->chat, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_enable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_shutdown(data->chat);
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int ste_disable(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (!data->chat)
+		return 0;
+
+	g_at_chat_cancel_all(data->chat);
+	g_at_chat_unregister_all(data->chat);
+	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL,
+					cfun_disable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void ste_pre_sim(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
+	ofono_sim_create(modem, 0, "atmodem", data->chat);
+	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
+}
+
+static void ste_post_sim(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+	ofono_ussd_create(modem, 0, "atmodem", data->chat);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
+	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
+	ofono_netreg_create(modem, 0, "stemodem", data->chat);
+	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
+	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
+	ofono_ssn_create(modem, 0, "atmodem", data->chat);
+	ofono_sms_create(modem, 0, "atmodem", data->chat);
+	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
+
+	gprs =3D ofono_gprs_create(modem,
+			OFONO_VENDOR_STE, "atmodem", data->chat);
+	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+
+	mw =3D ofono_message_waiting_create(modem);
+
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver ste_driver =3D {
+	.name		=3D "ste",
+	.probe		=3D ste_probe,
+	.remove		=3D ste_remove,
+	.enable		=3D ste_enable,
+	.disable	=3D ste_disable,
+	.pre_sim	=3D ste_pre_sim,
+	.post_sim	=3D ste_post_sim,
+};
+
+static int ste_init(void)
+{
+	return ofono_modem_driver_register(&ste_driver);
+}
+
+static void ste_exit(void)
+{
+	ofono_modem_driver_unregister(&ste_driver);
+}
+
+OFONO_PLUGIN_DEFINE(ste, "ST-Ericsson modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, ste_init, ste_exit)
-- =

1.6.0.4


--===============8303024163499379516==--

