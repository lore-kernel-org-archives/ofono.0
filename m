Content-Type: multipart/mixed; boundary="===============7516861689961818789=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: [PATCH 05/11] samsungipcmodem: add devinfo driver implementation
Date: Tue, 18 Sep 2012 20:18:49 +0200
Message-ID: <1347992335-9016-6-git-send-email-morphis@gravedo.de>
In-Reply-To: <1347992335-9016-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7516861689961818789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                               |    3 +-
 drivers/samsungipcmodem/devinfo.c         |  214 +++++++++++++++++++++++++=
++++
 drivers/samsungipcmodem/samsungipcmodem.c |    2 +
 drivers/samsungipcmodem/samsungipcmodem.h |    3 +
 4 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 drivers/samsungipcmodem/devinfo.c

diff --git a/Makefile.am b/Makefile.am
index 4c13ec0..a6f8ce5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -187,7 +187,8 @@ builtin_sources +=3D \
 	drivers/samsungipcmodem/samsungipcmodem.c \
 	drivers/samsungipcmodem/samsungipcmodem.h \
 	drivers/samsungipcmodem/ipc.c \
-	drivers/samsungipcmodem/ipc.h
+	drivers/samsungipcmodem/ipc.h \
+	drivers/samsungipcmodem/devinfo.c
 builtin_cflags +=3D @SAMSUNGIPC_CFLAGS@
 builtin_libadd +=3D @SAMSUNGIPC_LIBS@
 endif
diff --git a/drivers/samsungipcmodem/devinfo.c b/drivers/samsungipcmodem/de=
vinfo.c
new file mode 100644
index 0000000..4db3e83
--- /dev/null
+++ b/drivers/samsungipcmodem/devinfo.c
@@ -0,0 +1,214 @@
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
+#include <string.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+
+#include <glib.h>
+
+#include "samsungipcmodem.h"
+#include "ipc.h"
+#include "util.h"
+
+struct devinfo_data {
+	struct ipc_device *device;
+};
+
+static void samsungipc_query_manufacturer(struct ofono_devinfo *devinfo,
+				ofono_devinfo_query_cb_t cb, void *user_data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+
+	g_free(cbd);
+}
+
+static void samsungipc_query_model(struct ofono_devinfo *devinfo,
+				ofono_devinfo_query_cb_t cb, void *user_data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+
+	g_free(cbd);
+}
+
+static void misc_me_version_cb(uint16_t cmd, void *data, uint16_t length, =
uint8_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_devinfo_query_cb_t cb =3D cbd->cb;
+	struct ipc_misc_me_version *version =3D data;
+	char *str;
+
+	if (error) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		return;
+	}
+
+	str =3D g_try_new0(char, 32);
+	if (!str) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		return;
+	}
+
+	strncpy(str, version->sw_version, 32);
+	str[32] =3D '\0';
+
+	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
+}
+
+static void samsungipc_query_revision(struct ofono_devinfo *devinfo,
+				ofono_devinfo_query_cb_t cb, void *user_data)
+{
+	struct devinfo_data *data =3D ofono_devinfo_get_data(devinfo);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	uint8_t *msg;
+
+	msg =3D g_try_new0(uint8_t, 1);
+	msg[0] =3D 0xff;
+
+	if(ipc_device_enqueue_message(data->device, IPC_MISC_ME_VERSION, IPC_TYPE=
_GET,
+						msg, 1, misc_me_version_cb, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void misc_me_sn_cb(uint16_t cmd, void *data, uint16_t length, uint8=
_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_devinfo_query_cb_t cb =3D cbd->cb;
+	struct ipc_misc_me_sn *sn =3D data;
+	char *str;
+
+	if (error) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		return;
+	}
+
+	str =3D g_try_new0(char, sn->length);
+	if (!str) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		return;
+	}
+
+	strncpy(str, sn->data, sn->length);
+	str[sn->length] =3D '\0';
+
+	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
+}
+
+static void samsungipc_query_serial(struct ofono_devinfo *devinfo,
+				ofono_devinfo_query_cb_t cb, void *user_data)
+{
+	struct devinfo_data *data =3D ofono_devinfo_get_data(devinfo);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	uint8_t *msg;
+
+	msg =3D g_try_new0(uint8_t, 1);
+	msg[0] =3D IPC_MISC_ME_SN_SERIAL_NUM;
+
+	if (ipc_device_enqueue_message(data->device, IPC_MISC_ME_SN, IPC_TYPE_GET,
+						msg, 1, misc_me_sn_cb, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void reachable_cb(uint16_t cmd, void *data, uint16_t length, uint8_=
t error, void *user_data)
+{
+	struct ofono_devinfo *info =3D user_data;
+
+	if (error) {
+		ofono_devinfo_remove(info);
+		return;
+	}
+
+	ofono_devinfo_register(info);
+}
+
+static int samsungipc_devinfo_probe(struct ofono_devinfo *devinfo,
+				unsigned int vendor, void *user_data)
+{
+	struct devinfo_data *data;
+	struct ipc_device *device =3D user_data;
+	uint8_t *msg;
+
+	DBG("");
+
+	data =3D g_new0(struct devinfo_data, 1);
+
+	data->device =3D device;
+
+	ofono_devinfo_set_data(devinfo, data);
+
+	/* Just issue a IPC_MISC_ME_VERSION request here to check modem availabil=
ity and
+	 * defer ofono_devinfo_register call */
+	msg =3D g_try_new0(uint8_t, 1);
+	msg[0] =3D 0xff;
+	ipc_device_enqueue_message(data->device, IPC_MISC_ME_VERSION, IPC_TYPE_GE=
T,
+						msg, 1, reachable_cb, devinfo);
+
+	return 0;
+}
+
+static void samsungipc_devinfo_remove(struct ofono_devinfo *devinfo)
+{
+	struct devinfo_data *data =3D ofono_devinfo_get_data(devinfo);
+
+	DBG("");
+
+	ofono_devinfo_set_data(devinfo, NULL);
+
+	g_free(data);
+}
+
+static struct ofono_devinfo_driver driver =3D {
+	.name				=3D "samsungipcmodem",
+	.probe				=3D samsungipc_devinfo_probe,
+	.remove				=3D samsungipc_devinfo_remove,
+	.query_manufacturer	=3D samsungipc_query_manufacturer,
+	.query_model		=3D samsungipc_query_model,
+	.query_revision		=3D samsungipc_query_revision,
+	.query_serial		=3D samsungipc_query_serial,
+};
+
+void samsungipc_devinfo_init(void)
+{
+	ofono_devinfo_driver_register(&driver);
+}
+
+void samsungipc_devinfo_exit(void)
+{
+	ofono_devinfo_driver_unregister(&driver);
+}
diff --git a/drivers/samsungipcmodem/samsungipcmodem.c b/drivers/samsungipc=
modem/samsungipcmodem.c
index c302dfd..32a00de 100644
--- a/drivers/samsungipcmodem/samsungipcmodem.c
+++ b/drivers/samsungipcmodem/samsungipcmodem.c
@@ -30,11 +30,13 @@
 =

 static int samsungipcmodem_init(void)
 {
+	samsungipc_devinfo_init();
 	return 0;
 }
 =

 static void samsungipcmodem_exit(void)
 {
+	samsungipc_devinfo_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(samsungipcmodem, "Samsung IPC modem driver", VERSION,
diff --git a/drivers/samsungipcmodem/samsungipcmodem.h b/drivers/samsungipc=
modem/samsungipcmodem.h
index 3f9b386..64fe7eb 100644
--- a/drivers/samsungipcmodem/samsungipcmodem.h
+++ b/drivers/samsungipcmodem/samsungipcmodem.h
@@ -18,3 +18,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
  */
+
+extern void samsungipc_devinfo_init(void);
+extern void samsungipc_devinfo_exit(void);
-- =

1.7.9.5


--===============7516861689961818789==--

