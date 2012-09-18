Content-Type: multipart/mixed; boundary="===============9121771941559197801=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: [PATCH 09/11] samsungipcmodem: add gprs driver implementation
Date: Tue, 18 Sep 2012 20:18:53 +0200
Message-ID: <1347992335-9016-10-git-send-email-morphis@gravedo.de>
In-Reply-To: <1347992335-9016-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9121771941559197801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                               |    3 +-
 drivers/samsungipcmodem/gprs.c            |  215 +++++++++++++++++++++++++=
++++
 drivers/samsungipcmodem/samsungipcmodem.c |    2 +
 drivers/samsungipcmodem/samsungipcmodem.h |    2 +
 4 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 drivers/samsungipcmodem/gprs.c

diff --git a/Makefile.am b/Makefile.am
index 012c78d..1bfdf91 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -191,7 +191,8 @@ builtin_sources +=3D \
 	drivers/samsungipcmodem/devinfo.c \
 	drivers/samsungipcmodem/sim.c \
 	drivers/samsungipcmodem/network-registration.c \
-	drivers/samsungipcmodem/voicecall.c
+	drivers/samsungipcmodem/voicecall.c \
+	drivers/samsungipcmodem/gprs.c
 builtin_cflags +=3D @SAMSUNGIPC_CFLAGS@
 builtin_libadd +=3D @SAMSUNGIPC_LIBS@
 endif
diff --git a/drivers/samsungipcmodem/gprs.c b/drivers/samsungipcmodem/gprs.c
new file mode 100644
index 0000000..f728bc7
--- /dev/null
+++ b/drivers/samsungipcmodem/gprs.c
@@ -0,0 +1,215 @@
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
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs.h>
+
+#include <glib.h>
+
+#include "samsungipcmodem.h"
+#include "ipc.h"
+#include "util.h"
+
+struct gprs_data {
+	struct ipc_device *device;
+	guint status_watch;
+	guint hsdpa_status_watch;
+};
+
+static void samsungipc_set_attached(struct ofono_gprs *gprs, int attached,
+					ofono_gprs_cb_t cb, void *data)
+{
+	/* No attach/detach possible so always succeed here */
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
+static void gprs_attached_status_cb(uint16_t cmd, void *data, uint16_t len=
gth, uint8_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_status_cb_t cb =3D cbd->cb;
+	struct ipc_net_regist_response *resp =3D data;
+
+	if (error) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		goto done;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, resp->reg_state - 1, cbd->data);
+
+done:
+	g_free(cbd);
+}
+
+static void samsungipc_attached_status(struct ofono_gprs *gprs,
+				ofono_gprs_status_cb_t cb, void *data)
+{
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct cb_data *cbd;
+	struct ipc_net_regist_get *req;
+
+	DBG("");
+
+	req =3D g_try_new0(struct ipc_net_regist_get, 1);
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
+
+	ipc_net_regist_get_setup(req, IPC_NET_SERVICE_DOMAIN_GPRS);
+
+	if(ipc_device_enqueue_message(gd->device, IPC_NET_REGIST, IPC_TYPE_GET,
+						req, sizeof(struct ipc_net_regist_get),
+						gprs_attached_status_cb, cbd) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+
+	g_free(cbd);
+	g_free(req);
+}
+
+static void notify_gprs_status_cb(uint16_t cmd, void *data, uint16_t lengt=
h, void *user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct ipc_net_regist_response *resp =3D data;
+
+	if (resp->domain !=3D IPC_NET_SERVICE_DOMAIN_GPRS)
+		return;
+
+	ofono_gprs_status_notify(gprs, resp->reg_state - 1);
+}
+
+static void gprs_status_cb(uint16_t cmd, void *data, uint16_t length, uint=
8_t error, void *user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct ipc_net_regist_response *resp =3D data;
+
+	if (resp->domain !=3D IPC_NET_SERVICE_DOMAIN_GPRS || error)
+		return;
+
+	ofono_gprs_status_notify(gprs, resp->reg_state - 1);
+}
+
+static void notify_hsdpa_status_cb(uint16_t cmd, void *data, uint16_t leng=
th, void *user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct ipc_net_regist_get *req;
+
+	DBG("");
+
+	req =3D g_try_new0(struct ipc_net_regist_get, 1);
+	if (!req)
+		return;
+
+	ipc_net_regist_get_setup(req, IPC_NET_SERVICE_DOMAIN_GPRS);
+
+	if(ipc_device_enqueue_message(gd->device, IPC_NET_REGIST, IPC_TYPE_GET,
+						req, sizeof(struct ipc_net_regist_get),
+						gprs_status_cb, gprs) > 0)
+		return;
+
+	g_free(req);
+}
+
+static void initial_status_cb(uint16_t cmd, void *data, uint16_t length, v=
oid *user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct ipc_net_regist_response *resp =3D data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	if (resp->domain !=3D IPC_NET_SERVICE_DOMAIN_GPRS)
+		return;
+
+	ofono_gprs_register(gprs);
+
+	ofono_gprs_status_notify(gprs, resp->reg_state - 1);
+
+	ipc_device_remove_watch(gd->device, gd->status_watch);
+
+	gd->status_watch =3D ipc_device_add_notifcation_watch(gd->device, IPC_NET=
_REGIST,
+								notify_gprs_status_cb, gprs);
+}
+
+static int samsungipc_gprs_probe(struct ofono_gprs *gprs,
+				unsigned int vendor, void *user_data)
+{
+	struct gprs_data *gd;
+	struct ipc_client *client;
+	struct ipc_client_gprs_capabilities caps;
+
+	DBG("");
+
+	gd =3D g_new0(struct gprs_data, 1);
+	gd->device =3D user_data;
+
+	ofono_gprs_set_data(gprs, gd);
+
+	gd->status_watch =3D ipc_device_add_notifcation_watch(gd->device, IPC_NET=
_REGIST,
+												initial_status_cb, gprs);
+	gd->hsdpa_status_watch =3D ipc_device_add_notifcation_watch(gd->device, I=
PC_GPRS_HSDPA_STATUS,
+														notify_hsdpa_status_cb, gprs);
+
+	client =3D ipc_device_get_client(gd->device);
+	ipc_client_gprs_get_capabilities(client, &caps);
+
+	ofono_gprs_set_cid_range(gprs, 1, caps.cid_max);
+
+	return 0;
+}
+
+static void samsungipc_gprs_remove(struct ofono_gprs *gprs)
+{
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	DBG("");
+
+	ipc_device_remove_watch(gd->device, gd->status_watch);
+
+	ofono_gprs_set_data(gprs, NULL);
+
+	g_free(gd);
+}
+
+static struct ofono_gprs_driver driver =3D {
+	.name			=3D "samsungipcmodem",
+	.probe			=3D samsungipc_gprs_probe,
+	.remove			=3D samsungipc_gprs_remove,
+	.attached_status	=3D samsungipc_attached_status,
+	.set_attached	=3D samsungipc_set_attached,
+};
+
+void samsungipc_gprs_init(void)
+{
+	ofono_gprs_driver_register(&driver);
+}
+
+void samsungipc_gprs_exit(void)
+{
+	ofono_gprs_driver_unregister(&driver);
+}
diff --git a/drivers/samsungipcmodem/samsungipcmodem.c b/drivers/samsungipc=
modem/samsungipcmodem.c
index 72553a5..c99887d 100644
--- a/drivers/samsungipcmodem/samsungipcmodem.c
+++ b/drivers/samsungipcmodem/samsungipcmodem.c
@@ -34,11 +34,13 @@ static int samsungipcmodem_init(void)
 	samsungipc_sim_init();
 	samsungipc_netreg_init();
 	samsungipc_voicecall_init();
+	samsungipc_gprs_init();
 	return 0;
 }
 =

 static void samsungipcmodem_exit(void)
 {
+	samsungipc_gprs_exit();
 	samsungipc_voicecall_exit();
 	samsungipc_netreg_exit();
 	samsungipc_sim_exit();
diff --git a/drivers/samsungipcmodem/samsungipcmodem.h b/drivers/samsungipc=
modem/samsungipcmodem.h
index 092effd..2ee5f43 100644
--- a/drivers/samsungipcmodem/samsungipcmodem.h
+++ b/drivers/samsungipcmodem/samsungipcmodem.h
@@ -27,3 +27,5 @@ extern void samsungipc_netreg_init(void);
 extern void samsungipc_netreg_exit(void);
 extern void samsungipc_voicecall_init(void);
 extern void samsungipc_voicecall_exit(void);
+extern void samsungipc_gprs_init(void);
+extern void samsungipc_gprs_exit(void);
-- =

1.7.9.5


--===============9121771941559197801==--

