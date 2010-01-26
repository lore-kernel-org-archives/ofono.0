Content-Type: multipart/mixed; boundary="===============0207891673337062855=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [PATCH] Add STE modem support for GPRS PDP Contexts
Date: Tue, 26 Jan 2010 21:13:27 +0100
Message-ID: <1264536807-10462-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0207891673337062855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 Makefile.am                     |    3 +-
 drivers/stemodem/gprs-context.c |  610 +++++++++++++++++++++++++++++++++++=
++++
 drivers/stemodem/stemodem.c     |    3 +
 drivers/stemodem/stemodem.h     |    4 +
 plugins/ste.c                   |    2 +-
 5 files changed, 620 insertions(+), 2 deletions(-)
 create mode 100644 drivers/stemodem/gprs-context.c

diff --git a/Makefile.am b/Makefile.am
index de7d5cf..125f1f5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -156,7 +156,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/stemodem/stemodem.h \
 			drivers/stemodem/stemodem.c \
 			drivers/stemodem/caif_socket.h \
-			drivers/stemodem/if_caif.h
+			drivers/stemodem/if_caif.h \
+			drivers/stemodem/gprs-context.c
 =

 builtin_modules +=3D modemconf
 builtin_sources +=3D plugins/modemconf.c
diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
new file mode 100644
index 0000000..99559a1
--- /dev/null
+++ b/drivers/stemodem/gprs-context.c
@@ -0,0 +1,610 @@
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
+#include "caif_socket.h"
+#include "if_caif.h"
+
+#define MAX_CAIF_DEVICES 7
+#define MAX_DNS 2
+#define MAX_ELEM 20
+
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
+struct eppsd_response {
+	char *_current;
+	char ip_address[MAX_ELEM];
+	char subnet_mask[MAX_ELEM];
+	char mtu[MAX_ELEM];
+	char default_gateway[MAX_ELEM];
+	char dns_server1[MAX_ELEM];
+	char dns_server2[MAX_ELEM];
+	char p_cscf_server[MAX_ELEM];
+};
+
+static void start_element_handler (GMarkupParseContext *context,
+		const gchar *element_name, const gchar **attribute_names,
+		const gchar **attribute_values, gpointer user_data,
+		GError **error)
+{
+	struct eppsd_response *rsp =3D user_data;
+	rsp->_current =3D NULL;
+
+	if (!strcmp(element_name, "ip_address"))
+		rsp->_current =3D rsp->ip_address;
+	else if (!strcmp(element_name, "subnet_mask"))
+		rsp->_current =3D rsp->subnet_mask;
+	else if (!strcmp(element_name, "mtu"))
+		rsp->_current =3D rsp->mtu;
+	else if (!strcmp(element_name, "default_gateway"))
+		rsp->_current =3D rsp->default_gateway;
+	else if (!strcmp(element_name, "dns_server") &&
+		rsp->dns_server1[0] =3D=3D '\0')
+		rsp->_current =3D rsp->dns_server1;
+	else if (!strcmp(element_name, "dns_server"))
+		rsp->_current =3D rsp->dns_server2;
+	else if (!strcmp(element_name, "p_cscf_server"))
+		rsp->_current =3D rsp->p_cscf_server;
+}
+
+static void end_element_handler (GMarkupParseContext *context,
+		const gchar *element_name, gpointer user_data,
+		GError **error)
+{
+	struct eppsd_response *rsp =3D user_data;
+	rsp->_current =3D NULL;
+}
+
+static void text_handler (GMarkupParseContext *context,
+		const gchar *text, gsize text_len,
+		gpointer user_data, GError **error)
+{
+	struct eppsd_response *rsp =3D user_data;
+
+	if (rsp->_current) {
+		strncpy(rsp->_current, text, MAX_ELEM);
+		rsp->_current[MAX_ELEM] =3D 0;
+	}
+}
+
+static void error_handler (GMarkupParseContext *context,
+		GError *error, gpointer user_data)
+{
+	ofono_debug("Error parsing xml response from eppsd: %s\n",
+		error->message);
+}
+
+static GMarkupParser parser =3D {
+	start_element_handler,
+	end_element_handler,
+	text_handler,
+	NULL,
+	error_handler
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
+static struct conn_info *conn_info_create(unsigned int device,
+					  unsigned int channel_id)
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
+			      GAtResult *result, gpointer user_data)
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
+	gsize length;
+	char *res_string;
+	const char *dns[MAX_DNS + 1];
+	struct eppsd_response rsp;
+	GMarkupParseContext *context =3D NULL;
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
+	rsp._current =3D NULL;
+	context =3D g_markup_parse_context_new(&parser, 0, &rsp, NULL);
+	memset(&rsp, 0, sizeof(rsp));
+
+	g_at_result_iter_init(&iter, result);
+	for (i =3D 0; i < g_at_result_num_response_lines(result); i++) {
+		g_at_result_iter_next(&iter, NULL);
+		res_string =3D strdup(g_at_result_iter_raw_line(&iter));
+		length =3D strlen(res_string);
+
+		if (!g_markup_parse_context_parse(context, res_string,
+			length, NULL))
+				goto error;
+	}
+
+	if (!g_markup_parse_context_end_parse(context, NULL))
+		goto error;
+
+	g_markup_parse_context_free(context);
+
+	dns[0] =3D rsp.dns_server1;
+	dns[1] =3D rsp.dns_server2;
+	dns[2] =3D NULL;
+
+	sprintf(conn->interface, "caif%u", conn->device);
+
+	if (!caif_if_create(conn->interface, conn->channel_id)) {
+		ofono_error("Failed to create caif interface %s.",
+			conn->interface);
+		CALLBACK_WITH_SUCCESS(cb, NULL, FALSE, rsp.ip_address,
+				rsp.subnet_mask, rsp.default_gateway,
+				dns, cbd->data);
+	} else {
+		CALLBACK_WITH_SUCCESS(cb, conn->interface,
+				FALSE, rsp.ip_address, rsp.subnet_mask,
+				rsp.default_gateway, dns, cbd->data);
+	}
+	return;
+
+error:
+	ofono_debug("ste_eppsd_up_cb error");
+
+	if (context)
+		g_markup_parse_context_free(context);
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
+				ofono_gprs_context_up_cb_t cb, void *data)
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
+			      gpointer user_data)
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
diff --git a/drivers/stemodem/stemodem.c b/drivers/stemodem/stemodem.c
index 7a49682..53207db 100644
--- a/drivers/stemodem/stemodem.c
+++ b/drivers/stemodem/stemodem.c
@@ -36,11 +36,14 @@
 =

 static int stemodem_init(void)
 {
+	ste_gprs_context_init();
+
 	return 0;
 }
 =

 static void stemodem_exit(void)
 {
+	ste_gprs_context_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(stemodem, "STE modem driver", VERSION,
diff --git a/drivers/stemodem/stemodem.h b/drivers/stemodem/stemodem.h
index 67a8ac4..e55a2c3 100644
--- a/drivers/stemodem/stemodem.h
+++ b/drivers/stemodem/stemodem.h
@@ -21,3 +21,7 @@
  */
 =

 #include <drivers/atmodem/atutil.h>
+
+extern void ste_gprs_context_init();
+extern void ste_gprs_context_exit();
+
diff --git a/plugins/ste.c b/plugins/ste.c
index f2666eb..81853c4 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -218,7 +218,7 @@ static void ste_post_sim(struct ofono_modem *modem)
 =

 	gprs =3D ofono_gprs_create(modem,
 			OFONO_VENDOR_STE, "atmodem", data->chat);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
-- =

1.6.3.3


--===============0207891673337062855==--

