Content-Type: multipart/mixed; boundary="===============9044227194847785801=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: [PATCH 10/11] samsungipcmodem: add gprs-context driver implementation
Date: Tue, 18 Sep 2012 20:18:54 +0200
Message-ID: <1347992335-9016-11-git-send-email-morphis@gravedo.de>
In-Reply-To: <1347992335-9016-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9044227194847785801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                               |    3 +-
 drivers/samsungipcmodem/gprs-context.c    |  311 +++++++++++++++++++++++++=
++++
 drivers/samsungipcmodem/samsungipcmodem.c |    2 +
 drivers/samsungipcmodem/samsungipcmodem.h |    2 +
 4 files changed, 317 insertions(+), 1 deletion(-)
 create mode 100644 drivers/samsungipcmodem/gprs-context.c

diff --git a/Makefile.am b/Makefile.am
index 1bfdf91..769f848 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -192,7 +192,8 @@ builtin_sources +=3D \
 	drivers/samsungipcmodem/sim.c \
 	drivers/samsungipcmodem/network-registration.c \
 	drivers/samsungipcmodem/voicecall.c \
-	drivers/samsungipcmodem/gprs.c
+	drivers/samsungipcmodem/gprs.c \
+	drivers/samsungipcmodem/gprs-context.c
 builtin_cflags +=3D @SAMSUNGIPC_CFLAGS@
 builtin_libadd +=3D @SAMSUNGIPC_LIBS@
 endif
diff --git a/drivers/samsungipcmodem/gprs-context.c b/drivers/samsungipcmod=
em/gprs-context.c
new file mode 100644
index 0000000..aae1365
--- /dev/null
+++ b/drivers/samsungipcmodem/gprs-context.c
@@ -0,0 +1,311 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2012 Simon Busch <morphis@gravedo.de>. All rights rese=
rved.
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
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+
+#include <glib.h>
+
+#include "samsungipcmodem.h"
+#include "ipc.h"
+#include "util.h"
+
+#define IP_MAX_LENGTH	15
+
+struct gprs_context_data {
+	struct ipc_device *device;
+	unsigned int active_context;
+	unsigned int enabled;
+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
+};
+
+static void notify_gprs_ip_configuration_cb(uint16_t cmd, void *data, uint=
16_t length,
+										void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
+	struct ofono_gprs_context *gc =3D cbd->user;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ipc_gprs_ip_configuration *resp =3D data;
+	struct ipc_client *client;
+	char local[IP_MAX_LENGTH];
+	char dns1[IP_MAX_LENGTH];
+	char dns2[IP_MAX_LENGTH];
+	char gateway[IP_MAX_LENGTH];
+	char subnetmask[IP_MAX_LENGTH];
+	const char *dns[3];
+	char *interface;
+
+	snprintf(local, IP_MAX_LENGTH, "%i.%i.%i.%i", resp->ip[0], resp->ip[1],
+			 resp->ip[2], resp->ip[3]);
+	snprintf(dns1, IP_MAX_LENGTH, "%i.%i.%i.%i", resp->dns1[0], resp->dns1[1],
+			 resp->dns1[2], resp->dns1[3]);
+	snprintf(dns2, IP_MAX_LENGTH, "%i.%i.%i.%i", resp->dns2[0], resp->dns2[1],
+			 resp->dns2[2], resp->dns2[3]);
+	snprintf(local, IP_MAX_LENGTH, "%i.%i.%i.%i", resp->gateway[0], resp->gat=
eway[1],
+			 resp->gateway[2], resp->gateway[3]);
+	snprintf(local, IP_MAX_LENGTH, "%i.%i.%i.%i", resp->subnet_mask[0], resp-=
>subnet_mask[1],
+			 resp->subnet_mask[2], resp->subnet_mask[3]);
+
+	dns[0] =3D dns1;
+	dns[1] =3D dns2;
+	dns[2] =3D 0;
+
+	client =3D ipc_device_get_client(gcd->device);
+	interface =3D ipc_client_gprs_get_iface(client, gcd->active_context);
+
+	ofono_gprs_context_set_interface(gc, interface);
+	ofono_gprs_context_set_ipv4_address(gc, local, TRUE);
+	ofono_gprs_context_set_ipv4_netmask(gc, subnetmask);
+	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
+	ofono_gprs_context_set_ipv4_gateway(gc, gateway);
+
+	gcd->enabled =3D 1;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+	g_free(cbd);
+	g_free(interface);
+}
+
+static void pdp_context_activate_cb(uint16_t cmd, void *data, uint16_t len=
gth, uint8_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_gprs_context *gc =3D cbd->user;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	if (error) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		gcd->active_context =3D 0;
+		g_free(cbd);
+		return;
+	}
+
+	ipc_device_add_notifcation_watch(gcd->device, IPC_GPRS_IP_CONFIGURATION,
+								notify_gprs_ip_configuration_cb, cbd);
+}
+
+static void define_pdp_context_cb(uint16_t cmd, void *data, uint16_t lengt=
h, uint8_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
+	struct ofono_gprs_context *gc =3D cbd->user;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ipc_gen_phone_res *resp =3D data;
+	struct ipc_gprs_pdp_context_set *req;
+
+	if (error || ipc_gen_phone_res_check(resp) < 0)
+		goto error;
+
+	req =3D g_try_new0(struct ipc_gprs_pdp_context_set, 1);
+	if (!req)
+		goto error;
+
+	ipc_gprs_pdp_context_setup(req, 1, /* activate the context */
+					gcd->active_context, gcd->username, gcd->password);
+
+	if(ipc_device_enqueue_message(gcd->device, IPC_GPRS_DEFINE_PDP_CONTEXT, I=
PC_TYPE_SET,
+						req, sizeof(struct ipc_gprs_pdp_context_set),
+						pdp_context_activate_cb, cbd) > 0)
+		return;
+
+error:
+	gcd->active_context =3D 0;
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	g_free(cbd);
+}
+
+static void samsungipc_gprs_activate_primary(struct ofono_gprs_context *gc,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ipc_gprs_define_pdp_context *req;
+	struct cb_data *cbd;
+
+	req =3D g_try_new0(struct ipc_gprs_define_pdp_context, 1);
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
+	cbd->user =3D gc;
+
+	/* IPv6 support not implemented */
+	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP)
+		goto error;
+
+	DBG("cid %u", ctx->cid);
+
+	gcd->active_context =3D ctx->cid;
+	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
+	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
+
+	req->cid =3D ctx->cid;
+	req->enable =3D 1; /* enable the context */
+	strncpy((char*) req->apn, ctx->apn, 124);
+
+	if(ipc_device_enqueue_message(gcd->device, IPC_GPRS_DEFINE_PDP_CONTEXT, I=
PC_TYPE_SET,
+						req, sizeof(struct ipc_gprs_define_pdp_context),
+						define_pdp_context_cb, cbd) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void pdp_context_deactivate_cb(uint16_t cmd, void *data, uint16_t l=
ength, uint8_t error, void *user_data)
+{
+	struct ipc_gen_phone_res *resp =3D data;
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
+	struct gprs_context_data *gcd =3D cbd->user;
+
+	if (error || ipc_gen_phone_res_check(resp) < 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		goto done;
+	}
+
+	gcd->enabled =3D 0;
+	gcd->active_context =3D 0;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+done:
+	g_free(cbd);
+}
+
+static void samsungipc_gprs_deactivate_primary(struct ofono_gprs_context *=
gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ipc_gprs_pdp_context_set *req;
+	struct cb_data *cbd;
+
+	DBG("cid %u", cid);
+
+	req =3D g_try_new0(struct ipc_gprs_pdp_context_set, 1);
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
+	cbd->user =3D gcd;
+
+	ipc_gprs_pdp_context_setup(req, 0, /* deactivate the context */
+					cid, NULL, NULL);
+
+	if(ipc_device_enqueue_message(gcd->device, IPC_GPRS_DEFINE_PDP_CONTEXT, I=
PC_TYPE_SET,
+						req, sizeof(struct ipc_gprs_pdp_context_set),
+						pdp_context_deactivate_cb, cbd) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void samsungipc_gprs_detach_shutdown(struct ofono_gprs_context *gc,
+					unsigned int cid)
+{
+	DBG("cid %u", cid);
+}
+
+static void notify_gprs_status_cb(uint16_t cmd, void *data, uint16_t lengt=
h, void *user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ipc_gprs_call_status *resp =3D data;
+
+	if (gcd->enabled &&
+		(resp->state =3D=3D IPC_GPRS_STATE_NOT_ENABLED ||
+		 resp->state =3D=3D IPC_GPRS_STATE_DISABLED)) {
+		ofono_gprs_context_deactivated(gc, gcd->active_context);
+	}
+}
+
+static int samsungipc_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int vendor, void *data)
+{
+	struct gprs_context_data *gcd;
+
+	DBG("");
+
+	gcd =3D g_try_new0(struct gprs_context_data, 1);
+	if (gcd =3D=3D NULL)
+		return -ENOMEM;
+
+	gcd->device =3D data;
+	gcd->active_context =3D 0;
+	gcd->enabled =3D 0;
+
+	ofono_gprs_context_set_data(gc, gcd);
+
+	ipc_device_add_notifcation_watch(gcd->device, IPC_GPRS_CALL_STATUS,
+								notify_gprs_status_cb, gc);
+
+	return 0;
+}
+
+static void samsungipc_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	ofono_gprs_context_set_data(gc, NULL);
+
+	g_free(gcd);
+}
+
+static struct ofono_gprs_context_driver driver =3D {
+	.name			=3D "samsungipcmodem",
+	.probe			=3D samsungipc_gprs_context_probe,
+	.remove			=3D samsungipc_gprs_context_remove,
+	.activate_primary	=3D samsungipc_gprs_activate_primary,
+	.deactivate_primary	=3D samsungipc_gprs_deactivate_primary,
+	.detach_shutdown	=3D samsungipc_gprs_detach_shutdown,
+};
+
+void samsungipc_gprs_context_init(void)
+{
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void samsungipc_gprs_context_exit(void)
+{
+	ofono_gprs_context_driver_unregister(&driver);
+}
diff --git a/drivers/samsungipcmodem/samsungipcmodem.c b/drivers/samsungipc=
modem/samsungipcmodem.c
index c99887d..df55cf5 100644
--- a/drivers/samsungipcmodem/samsungipcmodem.c
+++ b/drivers/samsungipcmodem/samsungipcmodem.c
@@ -35,11 +35,13 @@ static int samsungipcmodem_init(void)
 	samsungipc_netreg_init();
 	samsungipc_voicecall_init();
 	samsungipc_gprs_init();
+	samsungipc_gprs_context_exit();
 	return 0;
 }
 =

 static void samsungipcmodem_exit(void)
 {
+	samsungipc_gprs_context_exit();
 	samsungipc_gprs_exit();
 	samsungipc_voicecall_exit();
 	samsungipc_netreg_exit();
diff --git a/drivers/samsungipcmodem/samsungipcmodem.h b/drivers/samsungipc=
modem/samsungipcmodem.h
index 2ee5f43..fe1f64b 100644
--- a/drivers/samsungipcmodem/samsungipcmodem.h
+++ b/drivers/samsungipcmodem/samsungipcmodem.h
@@ -29,3 +29,5 @@ extern void samsungipc_voicecall_init(void);
 extern void samsungipc_voicecall_exit(void);
 extern void samsungipc_gprs_init(void);
 extern void samsungipc_gprs_exit(void);
+extern void samsungipc_gprs_context_init(void);
+extern void samsungipc_gprs_context_exit(void);
-- =

1.7.9.5


--===============9044227194847785801==--

