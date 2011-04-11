Content-Type: multipart/mixed; boundary="===============6026969609849990970=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 05/20] atmodem: add generalised packet source
Date: Mon, 11 Apr 2011 13:20:03 +0300
Message-ID: <1302517218-2147-6-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6026969609849990970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

packet-context.c and packet-service.c file contents
are same as gprs-context.c and gprs.c. Just
renamed for a generalised solution.
---
 Makefile.am                      |    2 +
 drivers/atmodem/atmodem.c        |    4 +
 drivers/atmodem/atmodem.h        |    6 +
 drivers/atmodem/packet-context.c |  329 +++++++++++++++++++++++++++++
 drivers/atmodem/packet-service.c |  424 ++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 765 insertions(+), 0 deletions(-)
 create mode 100644 drivers/atmodem/packet-context.c
 create mode 100644 drivers/atmodem/packet-service.c

diff --git a/Makefile.am b/Makefile.am
index c1cc701..249c6c9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -181,6 +181,8 @@ builtin_sources +=3D $(gatchat_sources) \
 				drivers/atmodem/atutil.c \
 				drivers/atmodem/gprs.c \
 				drivers/atmodem/gprs-context.c \
+				drivers/atmodem/packet-service.c \
+				drivers/atmodem/packet-context.c \
 				drivers/atmodem/sim-auth.c \
 				drivers/atmodem/gnss.c
 =

diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index be93f41..28a5d4b 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -50,6 +50,8 @@ static int atmodem_init(void)
 	at_call_volume_init();
 	at_gprs_init();
 	at_gprs_context_init();
+	at_packet_service_init();
+	at_packet_context_init();
 	at_sim_auth_init();
 	at_gnss_init();
 =

@@ -75,6 +77,8 @@ static void atmodem_exit(void)
 	at_call_volume_exit();
 	at_gprs_exit();
 	at_gprs_context_exit();
+	at_packet_service_exit();
+	at_packet_context_exit();
 	at_gnss_exit();
 }
 =

diff --git a/drivers/atmodem/atmodem.h b/drivers/atmodem/atmodem.h
index 41f480f..067e998 100644
--- a/drivers/atmodem/atmodem.h
+++ b/drivers/atmodem/atmodem.h
@@ -69,6 +69,12 @@ extern void at_gprs_exit(void);
 extern void at_gprs_context_init(void);
 extern void at_gprs_context_exit(void);
 =

+extern void at_packet_service_init(void);
+extern void at_packet_service_exit(void);
+
+extern void at_packet_context_init(void);
+extern void at_packet_context_exit(void);
+
 extern void at_sim_auth_init(void);
 extern void at_sim_auth_exit(void);
 =

diff --git a/drivers/atmodem/packet-context.c b/drivers/atmodem/packet-cont=
ext.c
new file mode 100644
index 0000000..1182212
--- /dev/null
+++ b/drivers/atmodem/packet-context.c
@@ -0,0 +1,329 @@
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/stat.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/packet-context.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "gatppp.h"
+
+#include "atmodem.h"
+
+#define TUN_SYSFS_DIR "/sys/devices/virtual/misc/tun"
+
+#define STATIC_IP_NETMASK "255.255.255.255"
+
+static const char *none_prefix[] =3D { NULL };
+
+enum state {
+	STATE_IDLE,
+	STATE_ENABLING,
+	STATE_DISABLING,
+	STATE_ACTIVE,
+};
+
+struct packet_context_data {
+	GAtChat *chat;
+	unsigned int active_context;
+	char username[OFONO_PS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_PS_MAX_PASSWORD_LENGTH + 1];
+	GAtPPP *ppp;
+	enum state state;
+	ofono_packet_context_cb_t cb;
+	void *cb_data;                                  /* Callback data */
+};
+
+static void ppp_debug(const char *str, void *data)
+{
+	ofono_info("%s: %s", (const char *) data, str);
+}
+
+static void ppp_connect(const char *interface, const char *local,
+			const char *remote,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	struct ofono_packet_context *pc =3D user_data;
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
+	const char *dns[3];
+
+	DBG("");
+
+	dns[0] =3D dns1;
+	dns[1] =3D dns2;
+	dns[2] =3D 0;
+
+	ofono_info("IP: %s", local);
+	ofono_info("DNS: %s, %s", dns1, dns2);
+
+	pcd->state =3D STATE_ACTIVE;
+	ofono_packet_context_set_interface(pc, interface);
+	ofono_packet_context_set_ipv4_address(pc, local, TRUE);
+	ofono_packet_context_set_ipv4_netmask(pc, STATIC_IP_NETMASK);
+	ofono_packet_context_set_ipv4_dns_servers(pc, dns);
+
+	CALLBACK_WITH_SUCCESS(pcd->cb, pcd->cb_data);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct ofono_packet_context *pc =3D user_data;
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
+
+	DBG("");
+
+	g_at_ppp_unref(pcd->ppp);
+	pcd->ppp =3D NULL;
+
+	switch (pcd->state) {
+	case STATE_ENABLING:
+		CALLBACK_WITH_FAILURE(pcd->cb, pcd->cb_data);
+		break;
+	case STATE_DISABLING:
+		CALLBACK_WITH_SUCCESS(pcd->cb, pcd->cb_data);
+		break;
+	default:
+		ofono_packet_context_deactivated(pc, pcd->active_context);
+		break;
+	}
+
+	pcd->active_context =3D 0;
+	pcd->state =3D STATE_IDLE;
+	/*
+	 * If the channel of pcd->chat is NULL, it might cause
+	 * packet_context_remove get called and the packet context will be
+	 * removed.
+	 */
+	g_at_chat_resume(pcd->chat);
+}
+
+static gboolean setup_ppp(struct ofono_packet_context *pc)
+{
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
+	GAtIO *io;
+
+	DBG("");
+
+	io =3D g_at_chat_get_io(pcd->chat);
+
+	g_at_chat_suspend(pcd->chat);
+
+	/* open ppp */
+	pcd->ppp =3D g_at_ppp_new_from_io(io);
+
+	if (pcd->ppp =3D=3D NULL) {
+		g_at_chat_resume(pcd->chat);
+		return FALSE;
+	}
+
+	if (getenv("OFONO_PPP_DEBUG"))
+		g_at_ppp_set_debug(pcd->ppp, ppp_debug, "PPP");
+
+	g_at_ppp_set_credentials(pcd->ppp, pcd->username, pcd->password);
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(pcd->ppp, ppp_connect, pc);
+	g_at_ppp_set_disconnect_function(pcd->ppp, ppp_disconnect, pc);
+
+	/* open the ppp connection */
+	g_at_ppp_open(pcd->ppp);
+
+	return TRUE;
+}
+
+static void at_cgdata_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_packet_context *pc =3D user_data;
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+
+		ofono_info("Unable to enter data state");
+
+		pcd->active_context =3D 0;
+		pcd->state =3D STATE_IDLE;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		pcd->cb(&error, pcd->cb_data);
+		return;
+	}
+
+	setup_ppp(pc);
+}
+
+static void at_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_packet_context *pc =3D user_data;
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
+	char buf[64];
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+
+		pcd->active_context =3D 0;
+		pcd->state =3D STATE_IDLE;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		pcd->cb(&error, pcd->cb_data);
+		return;
+	}
+
+	sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", pcd->active_context);
+	if (g_at_chat_send(pcd->chat, buf, none_prefix,
+				at_cgdata_cb, pc, NULL) > 0)
+		return;
+
+	pcd->active_context =3D 0;
+	pcd->state =3D STATE_IDLE;
+
+	CALLBACK_WITH_FAILURE(pcd->cb, pcd->cb_data);
+}
+
+static void at_packet_context_activate(struct ofono_packet_context *pc,
+				const struct ofono_packet_context_param *ctx,
+				ofono_packet_context_cb_t cb, void *data)
+{
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
+	char buf[OFONO_PS_MAX_APN_LENGTH + 128];
+	int len;
+
+	/* IPv6 support not implemented */
+	if (ctx->proto !=3D OFONO_PACKET_PROTO_IP)
+		goto error;
+
+	DBG("cid %u", ctx->cid);
+
+	pcd->active_context =3D ctx->cid;
+	pcd->cb =3D cb;
+	pcd->cb_data =3D data;
+	memcpy(pcd->username, ctx->username, sizeof(ctx->username));
+	memcpy(pcd->password, ctx->password, sizeof(ctx->password));
+
+	pcd->state =3D STATE_ENABLING;
+
+	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
+
+	if (ctx->apn)
+		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
+				ctx->apn);
+
+	if (g_at_chat_send(pcd->chat, buf, none_prefix,
+				at_cgdcont_cb, pc, NULL) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void at_packet_context_deactivate(struct ofono_packet_context *pc,
+					unsigned int cid,
+					ofono_packet_context_cb_t cb, void *data)
+{
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
+
+	DBG("cid %u", cid);
+
+	pcd->state =3D STATE_DISABLING;
+	pcd->cb =3D cb;
+	pcd->cb_data =3D data;
+
+	g_at_ppp_shutdown(pcd->ppp);
+}
+
+static int at_packet_context_probe(struct ofono_packet_context *pc,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct packet_context_data *pcd;
+	struct stat st;
+
+	DBG("");
+
+	if (stat(TUN_SYSFS_DIR, &st) < 0) {
+		ofono_error("Missing support for TUN/TAP devices");
+		return -ENODEV;
+	}
+
+	pcd =3D g_try_new0(struct packet_context_data, 1);
+	if (pcd =3D=3D NULL)
+		return -ENOMEM;
+
+	pcd->chat =3D g_at_chat_clone(chat);
+
+	ofono_packet_context_set_data(pc, pcd);
+
+	return 0;
+}
+
+static void at_packet_context_remove(struct ofono_packet_context *pc)
+{
+	struct packet_context_data *pcd =3D ofono_packet_context_get_data(pc);
+
+	DBG("");
+
+	if (pcd->state !=3D STATE_IDLE && pcd->ppp) {
+		g_at_ppp_unref(pcd->ppp);
+		g_at_chat_resume(pcd->chat);
+	}
+
+	ofono_packet_context_set_data(pc, NULL);
+
+	g_at_chat_unref(pcd->chat);
+	g_free(pcd);
+}
+
+static struct ofono_packet_context_driver driver =3D {
+	.name			=3D "atmodem",
+	.probe			=3D at_packet_context_probe,
+	.remove			=3D at_packet_context_remove,
+	.activate_context	=3D at_packet_context_activate,
+	.deactivate_context	=3D at_packet_context_deactivate,
+};
+
+void at_packet_context_init(void)
+{
+	ofono_packet_context_driver_register(&driver);
+}
+
+void at_packet_context_exit(void)
+{
+	ofono_packet_context_driver_unregister(&driver);
+}
diff --git a/drivers/atmodem/packet-service.c b/drivers/atmodem/packet-serv=
ice.c
new file mode 100644
index 0000000..9999d9d
--- /dev/null
+++ b/drivers/atmodem/packet-service.c
@@ -0,0 +1,424 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/packet-service.h>
+#include <ofono/packet-context.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "atmodem.h"
+#include "vendor.h"
+
+static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
+static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
+struct packet_service_data {
+	GAtChat *chat;
+	int default_cid;
+	int default_context_type;
+	unsigned int vendor;
+};
+
+static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_packet_service_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
+static void at_packet_service_set_attached(struct ofono_packet_service *ps,
+						int attached,
+						ofono_packet_service_cb_t cb,
+						void *data)
+{
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+
+	snprintf(buf, sizeof(buf), "AT+CGATT=3D%i", attached ? 1 : 0);
+
+	if (g_at_chat_send(psd->chat, buf, none_prefix,
+				at_cgatt_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void at_cgreg_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_packet_service_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	int status;
+	struct packet_service_data *psd =3D cbd->user;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	if (at_util_parse_reg(result, "+CGREG:", NULL, &status,
+				NULL, NULL, NULL, psd->vendor) =3D=3D FALSE) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	cb(&error, status, cbd->data);
+}
+
+static void at_packet_service_registration_status(
+					struct ofono_packet_service *ps,
+					ofono_packet_service_status_cb_t cb,
+					void *data)
+{
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	cbd->user =3D psd;
+
+	switch (psd->vendor) {
+	case OFONO_VENDOR_GOBI:
+		/*
+		 * Send *CNTI=3D0 to find out the current tech, it will be
+		 * intercepted in gobi_cnti_notify in network registration
+		 */
+		g_at_chat_send(psd->chat, "AT*CNTI=3D0", none_prefix,
+				NULL, NULL, NULL);
+		break;
+	case OFONO_VENDOR_NOVATEL:
+		/*
+		 * Send $CNTI=3D0 to find out the current tech, it will be
+		 * intercepted in nw_cnti_notify in network registration
+		 */
+		g_at_chat_send(psd->chat, "AT$CNTI=3D0", none_prefix,
+				NULL, NULL, NULL);
+		break;
+	}
+
+	if (g_at_chat_send(psd->chat, "AT+CGREG?", cgreg_prefix,
+				at_cgreg_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void cgreg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	int status;
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+
+	if (at_util_parse_reg_unsolicited(result, "+CGREG:", &status,
+				NULL, NULL, NULL, psd->vendor) =3D=3D FALSE)
+		return;
+
+	ofono_packet_service_status_notify(ps, status);
+}
+
+static void cgev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	GAtResultIter iter;
+	const char *event;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGEV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
+		return;
+
+	if (g_str_equal(event, "NW DETACH") ||
+			g_str_equal(event, "ME DETACH")) {
+		ofono_packet_service_detached_notify(ps);
+		return;
+	}
+}
+
+static void xdatastat_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	GAtResultIter iter;
+	int stat;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XDATASTAT:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &stat))
+
+	DBG("stat %d", stat);
+
+	switch (stat) {
+	case 0:
+		ofono_packet_service_suspend_notify(ps,
+				PACKET_SERVICE_SUSPENDED_UNKNOWN_CAUSE);
+		break;
+	case 1:
+		ofono_packet_service_resume_notify(ps);
+		break;
+	}
+}
+
+static void cpsb_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	GAtResultIter iter;
+	gint bearer;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CPSB:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, NULL))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &bearer))
+		return;
+
+	ofono_packet_service_bearer_notify(ps, bearer);
+}
+
+static void packet_service_initialized(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+
+	g_at_chat_register(psd->chat, "+CGEV:", cgev_notify, FALSE, ps, NULL);
+	g_at_chat_register(psd->chat, "+CGREG:", cgreg_notify,
+						FALSE, ps, NULL);
+	g_at_chat_register(psd->chat, "+CPSB:", cpsb_notify, FALSE, ps, NULL);
+
+	g_at_chat_send(psd->chat, "AT+CPSB=3D1", none_prefix, NULL, NULL, NULL);
+
+	switch (psd->vendor) {
+	case OFONO_VENDOR_IFX:
+		/* Register for packet service suspend notifications */
+		g_at_chat_register(psd->chat, "+XDATASTAT:", xdatastat_notify,
+						FALSE, ps, NULL);
+		g_at_chat_send(psd->chat, "AT+XDATASTAT=3D1", none_prefix,
+						NULL, NULL, NULL);
+		break;
+	}
+
+	ofono_packet_service_register(ps);
+}
+
+static void at_cgreg_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+	gint range[2];
+	GAtResultIter iter;
+	int cgreg1 =3D 0;
+	int cgreg2 =3D 0;
+	const char *cmd;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGREG:"))
+		goto error;
+
+	if (!g_at_result_iter_open_list(&iter))
+		goto error;
+
+	while (g_at_result_iter_next_range(&iter, &range[0], &range[1])) {
+		if (1 >=3D range[0] && 1 <=3D range[1])
+			cgreg1 =3D 1;
+		if (2 >=3D range[0] && 2 <=3D range[1])
+			cgreg2 =3D 1;
+	}
+
+	g_at_result_iter_close_list(&iter);
+
+	if (cgreg2)
+		cmd =3D "AT+CGREG=3D2";
+	else if (cgreg1)
+		cmd =3D "AT+CGREG=3D1";
+	else
+		goto error;
+
+	g_at_chat_send(psd->chat, cmd, none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(psd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
+
+	switch (psd->vendor) {
+	case OFONO_VENDOR_MBM:
+		/* Ericsson MBM and ST-E modems don't support AT+CGEREP=3D2,1 */
+		g_at_chat_send(psd->chat, "AT+CGEREP=3D1,0", none_prefix,
+			packet_service_initialized, ps, NULL);
+		break;
+	case OFONO_VENDOR_NOKIA:
+		/* Nokia data cards don't support AT+CGEREP=3D1,0 either */
+		g_at_chat_send(psd->chat, "AT+CGEREP=3D1", none_prefix,
+			packet_service_initialized, ps, NULL);
+		break;
+	default:
+		g_at_chat_send(psd->chat, "AT+CGEREP=3D2,1", none_prefix,
+			packet_service_initialized, ps, NULL);
+		break;
+	}
+
+	return;
+
+error:
+	ofono_info("GPRS not supported on this device");
+	ofono_packet_service_remove(ps);
+}
+
+static void at_cgdcont_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+	GAtResultIter iter;
+	int min, max;
+	const char *pdp_type;
+	gboolean found =3D FALSE;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (!found && g_at_result_iter_next(&iter, "+CGDCONT:")) {
+		gboolean in_list =3D FALSE;
+
+		if (!g_at_result_iter_open_list(&iter))
+			continue;
+
+		if (g_at_result_iter_next_range(&iter, &min, &max) =3D=3D FALSE)
+			continue;
+
+		if (!g_at_result_iter_close_list(&iter))
+			continue;
+
+		if (g_at_result_iter_open_list(&iter))
+			in_list =3D TRUE;
+
+		if (!g_at_result_iter_next_string(&iter, &pdp_type))
+			continue;
+
+		if (in_list && !g_at_result_iter_close_list(&iter))
+			continue;
+
+		/* We look for IP PDPs */
+		if (g_str_equal(pdp_type, "IP"))
+			found =3D TRUE;
+	}
+
+	if (found =3D=3D FALSE)
+		goto error;
+
+	ofono_packet_service_set_cid_range(ps, min, max);
+
+	g_at_chat_send(psd->chat, "AT+CGREG=3D?", cgreg_prefix,
+			at_cgreg_test_cb, ps, NULL);
+
+	return;
+
+error:
+	ofono_info("Packet service not supported on this device");
+	ofono_packet_service_remove(ps);
+}
+
+static int at_packet_service_probe(struct ofono_packet_service *ps,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct packet_service_data *psd;
+
+	psd =3D g_try_new0(struct packet_service_data, 1);
+	if (psd =3D=3D NULL)
+		return -ENOMEM;
+
+	psd->chat =3D g_at_chat_clone(chat);
+	psd->vendor =3D vendor;
+
+	ofono_packet_service_set_data(ps, psd);
+
+	g_at_chat_send(psd->chat, "AT+CGDCONT=3D?", cgdcont_prefix,
+			at_cgdcont_test_cb, ps, NULL);
+
+	return 0;
+}
+
+static void at_packet_service_remove(struct ofono_packet_service *ps)
+{
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+
+	ofono_packet_service_set_data(ps, NULL);
+
+	g_at_chat_unref(psd->chat);
+	g_free(psd);
+}
+
+static struct ofono_packet_service_driver driver =3D {
+	.name			=3D "atmodem",
+	.probe			=3D at_packet_service_probe,
+	.remove			=3D at_packet_service_remove,
+	.set_attached		=3D at_packet_service_set_attached,
+	.attached_status	=3D at_packet_service_registration_status,
+};
+
+void at_packet_service_init(void)
+{
+	ofono_packet_service_driver_register(&driver);
+}
+
+void at_packet_service_exit(void)
+{
+	ofono_packet_service_driver_unregister(&driver);
+}
-- =

1.7.0.4


--===============6026969609849990970==--

