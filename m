Content-Type: multipart/mixed; boundary="===============2400887523841012889=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [RFC v2 7/7] STE-plugin: GPRS driver.
Date: Tue, 19 Jan 2010 17:11:53 +0100
Message-ID: <1263917513-6756-8-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1263917513-6756-7-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2400887523841012889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Updates after review:
Removed setting of IP-address, netmask etc. when creating the IP interface.
Split caif_if_create_remove() into , caif_if_create() and caif_if_remove().
Declared interface as array in conn_info struct, and removed memory allocat=
ion.
Removed switching of syntax runtime (from strict to permissive and back aga=
in).
Removed return statement from cgev_notify()

Remaining issues:
Use glib xml parser.
---
 drivers/stemodem/gprs-context.c |  579 +++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 579 insertions(+), 0 deletions(-)
 create mode 100644 drivers/stemodem/gprs-context.c

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
new file mode 100644
index 0000000..b2148d8
--- /dev/null
+++ b/drivers/stemodem/gprs-context.c
@@ -0,0 +1,579 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
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
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "stemodem.h"
+
+/* Use the local CAIF header files until is included in linux kernel */
+#ifdef PF_CAIF
+#include <linux/caif/caif_socket.h>
+#include <linux/caif/if_caif.h>
+#else
+#include "gcaif/caif_socket.h"
+#include "gcaif/if_caif.h"
+#endif
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
+	char interface[10];
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
+static char *parse_xml(char *xml, char *tag)
+{
+    char *begin;
+    char *end;
+    int len;
+    char *res =3D NULL;
+    char *start =3D g_malloc(strlen(tag) + 3);
+    char *stop =3D g_malloc(strlen(tag) + 4);
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
+/* Creates a new IP interface for CAIF.
+ *
+*/
+static gboolean caif_if_create(const char *interface,
+	unsigned int connid)
+{
+	int s;
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
+	if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
+		ofono_debug("Failed to create IP interface for CAIF");
+		goto error;
+	}
+
+return TRUE;
+
+error:
+	return FALSE;
+}
+
+/* Removes IP interface for CAIF.
+ *
+*/
+static gboolean caif_if_remove(const char *interface,
+	unsigned int connid)
+{
+	int s;
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
+	if (ioctl(s, SIOCGIFINDEX, &ifr) =3D=3D 0) {
+		if (ioctl(s, SIOCCAIFNETREMOVE, &ifr) < 0) {
+			ofono_debug("Failed to remove IP interface"
+				"for CAIF");
+			goto error;
+		}
+	} else {
+		ofono_debug("Did not find interface (%s) to remove",
+				interface);
+		goto error;
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
+	if (!caif_if_remove(conn->interface, conn->channel_id)) {
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
+	sprintf(conn->interface, "caif%u", conn->device);
+
+	if (!caif_if_create(conn->interface, conn->channel_id)) {
+		ofono_error("Failed to create caif interface %s.",
+			conn->interface);
+		CALLBACK_WITH_SUCCESS(cb, NULL, FALSE, ip, netmask,
+			gateway, dns, cbd->data);
+	} else {
+		CALLBACK_WITH_SUCCESS(cb, conn->interface,
+				FALSE, ip, netmask, gateway, dns, cbd->data);
+	}
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
-- =

1.6.0.4


--===============2400887523841012889==--

