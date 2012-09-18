Content-Type: multipart/mixed; boundary="===============6251729170124251982=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: [PATCH 11/11] samsungipc: Add initial implementation of the Samsung
 IPC modem plugin
Date: Tue, 18 Sep 2012 20:18:55 +0200
Message-ID: <1347992335-9016-12-git-send-email-morphis@gravedo.de>
In-Reply-To: <1347992335-9016-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6251729170124251982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    3 +
 plugins/samsungipc.c |  414 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 417 insertions(+)
 create mode 100644 plugins/samsungipc.c

diff --git a/Makefile.am b/Makefile.am
index 769f848..ba2e51e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -392,6 +392,9 @@ builtin_sources +=3D plugins/stemgr.c
 if SAMSUNGIPCMODEM
 builtin_modules +=3D samsungmgr
 builtin_sources +=3D plugins/samsungmgr.c
+
+builtin_modules +=3D samsungipc
+builtin_sources +=3D plugins/samsungipc.c
 endif
 =

 builtin_modules +=3D caif
diff --git a/plugins/samsungipc.c b/plugins/samsungipc.c
new file mode 100644
index 0000000..98d13eb
--- /dev/null
+++ b/plugins/samsungipc.c
@@ -0,0 +1,414 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2012 Simon Busch <morphis@gravedo.de>
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
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+#include <ofono/message-waiting.h>
+#include <ofono/netreg.h>
+#include <ofono/sim.h>
+#include <ofono/phonebook.h>
+#include <ofono/voicecall.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/sms.h>
+
+#include "drivers/samsungipcmodem/ipc.h"
+#include "drivers/samsungipcmodem/util.h"
+
+#include <samsung-ipc.h>
+
+struct samsungipc_data {
+	struct ipc_device *device;
+	struct ipc_client *client;
+	ofono_bool_t in_forwarding_mode;
+	uint16_t state;
+	guint power_state_watch;
+};
+
+static void samsungipc_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static int samsungipc_probe(struct ofono_modem *modem)
+{
+	struct samsungipc_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct samsungipc_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	data->in_forwarding_mode =3D FALSE;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void samsungipc_remove(struct ofono_modem *modem)
+{
+	struct samsungipc_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_free(data);
+}
+
+static int connect_socket(const char *address, int port)
+{
+	struct sockaddr_in addr;
+	int sk;
+	int err;
+
+	sk =3D socket(PF_INET, SOCK_STREAM, 0);
+	if (sk < 0)
+		return -EINVAL;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D inet_addr(address);
+	addr.sin_port =3D htons(port);
+
+	err =3D connect(sk, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0) {
+		close(sk);
+		return -errno;
+	}
+
+	return sk;
+}
+
+static int modem_data_read(void *buf, unsigned int size, void *user_data)
+{
+	struct samsungipc_data *data =3D user_data;
+	int ret, fd;
+
+	fd =3D ipc_device_get_fd(data->device);
+	if (fd < 0)
+		return -1;
+
+	ret =3D read(fd, buf, size);
+	if (ret < 0)
+		return -1;
+
+	return ret;
+}
+
+static int modem_data_write(void *buf, unsigned int size, void *user_data)
+{
+	struct samsungipc_data *data =3D user_data;
+	int ret, fd;
+
+	fd =3D ipc_device_get_fd(data->device);
+	if (fd < 0)
+		return -1;
+
+	ret =3D write(fd, buf, size);
+	if (ret < 0)
+		return -1;
+
+	return ret;
+}
+
+static void retrieve_power_state_cb(uint16_t cmd, void *data, uint16_t len=
gth, uint8_t error, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct samsungipc_data *ipcdata =3D ofono_modem_get_data(modem);
+	uint16_t state;
+
+	if (error) {
+		ofono_error("Received error instead of power state response");
+		return;
+	}
+
+	state =3D IPC_PWR_R(*((uint16_t*) data));
+
+	switch (state) {
+	case IPC_PWR_R(IPC_PWR_PHONE_STATE_NORMAL):
+		ofono_error("Modem is already in NORMAL power state; thats wrong!");
+		// FIXME shutdown everything here or switch to LPM/perform a modem reset?
+		break;
+	case IPC_PWR_R(IPC_PWR_PHONE_STATE_LPM):
+		ofono_modem_set_powered(modem, TRUE);
+		ipcdata->state =3D IPC_PWR_PHONE_STATE_LPM;
+		break;
+	}
+}
+
+static void log_handler(const char *message, void *user_data)
+{
+	ofono_debug("IPC: %s", message);
+}
+
+static int samsungipc_enable(struct ofono_modem *modem)
+{
+	struct samsungipc_data *data =3D ofono_modem_get_data(modem);
+	const char *address;
+	int port, fd;
+
+	DBG("%p", modem);
+
+	data->client =3D ipc_client_new(IPC_CLIENT_TYPE_FMT);
+	if (getenv("OFONO_IPC_DEBUG"))
+		ipc_client_set_log_handler(data->client, log_handler, data);
+
+	/* if address and port are set we are using a remote device */
+	address =3D ofono_modem_get_string(modem, "Address");
+	if (address !=3D NULL) {
+		port =3D ofono_modem_get_integer(modem, "Port");
+		if (port < 0)
+			return -EINVAL;
+
+		data->in_forwarding_mode =3D TRUE;
+
+		fd =3D connect_socket(address, port);
+		if (fd < 0)
+			return fd;
+
+		ipc_client_set_io_handlers(data->client, modem_data_read, data,
+							modem_data_write, data);
+
+		ipc_device_set_close_on_unref(data->device, true);
+	}
+	else {
+		ipc_client_create_handlers_common_data(data->client);
+		ipc_client_open(data->client);
+		fd =3D ipc_client_get_handlers_common_data_fd(data->client);
+
+		if (fd < 0) {
+			ipc_client_close(data->client);
+			ipc_client_destroy_handlers_common_data(data->client);
+			return fd;
+		}
+	}
+
+	data->device =3D ipc_device_new(fd, data->client);
+	ipc_device_set_debug(data->device, samsungipc_debug, "IPC: ");
+
+	ipc_device_enqueue_message(data->device, IPC_PWR_PHONE_STATE, IPC_TYPE_GE=
T,
+						NULL, 0, retrieve_power_state_cb, modem);
+
+	return -EINPROGRESS;
+}
+
+static int samsungipc_disable(struct ofono_modem *modem)
+{
+	struct samsungipc_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ipc_client_close(data->client);
+
+	if (data->in_forwarding_mode)
+		ipc_client_destroy_handlers_common_data(data->client);
+
+	ipc_device_unref(data->device);
+
+	return 0;
+}
+
+static void samsungipc_pre_sim(struct ofono_modem *modem)
+{
+	struct samsungipc_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "samsungipcmodem", data->device);
+	ofono_sim_create(modem, 0, "samsungipcmodem", data->device);
+}
+
+static void samsungipc_post_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static void notify_power_state_cb(uint16_t cmd, void *data, uint16_t lengt=
h, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct samsungipc_data *sid =3D cbd->user;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+	ipc_device_remove_watch(sid->device, sid->power_state_watch);
+
+	g_free(cbd);
+}
+
+static void set_device_rf_power_state_cb(uint16_t cmd, void *data, uint16_=
t length, uint8_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+	struct samsungipc_data *sid =3D cbd->user;
+	struct ipc_gen_phone_res *resp =3D data;
+
+	if (error || ipc_gen_phone_res_check(resp) < 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+		return;
+	}
+
+	sid->power_state_watch =3D ipc_device_add_notifcation_watch(sid->device, =
IPC_PWR_PHONE_STATE,
+														notify_power_state_cb, cbd);
+}
+
+static void set_device_rf_power_state(struct ofono_modem *modem, uint16_t =
state, struct cb_data *cbd)
+{
+	struct samsungipc_data *sid =3D ofono_modem_get_data(modem);
+	uint8_t *msg;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	msg =3D g_try_new0(uint8_t, 2);
+	if (!msg)
+		return;
+
+	memcpy(msg, &state, sizeof(uint16_t));
+
+	switch (state) {
+	case IPC_PWR_PHONE_STATE_NORMAL:
+		ipc_device_enqueue_message(sid->device, IPC_PWR_PHONE_STATE, IPC_TYPE_EX=
EC, msg, 2,
+							set_device_rf_power_state_cb, cbd);
+
+		ofono_debug("Done sending power state change to NORMAL level");
+
+		break;
+	case IPC_PWR_PHONE_STATE_LPM:
+		/* We will not get any response for this request! */
+		ipc_device_enqueue_message(sid->device, IPC_PWR_PHONE_STATE, IPC_TYPE_EX=
EC, msg, 2,
+							NULL, NULL);
+
+		ofono_debug("Done sending power state change to LPM level");
+
+		/* FIXME maybe retrieving power state from modem to make sure it's set? =
*/
+
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		g_free(cbd);
+
+		break;
+	default:
+		/* Not supported power state */
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+
+		break;
+	}
+}
+
+static void samsungipc_set_online(struct ofono_modem *modem, ofono_bool_t =
online,
+							ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct samsungipc_data *sid =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd;
+	uint16_t state;
+
+	state =3D online ? IPC_PWR_PHONE_STATE_NORMAL : IPC_PWR_PHONE_STATE_LPM;
+
+	cbd =3D cb_data_new(cb, user_data);
+	cbd->user =3D sid;
+
+	set_device_rf_power_state(modem, state, cbd);
+}
+
+static void samsungipc_post_online(struct ofono_modem *modem)
+{
+	struct samsungipc_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, 0, "samsungipcmodem", data->device);
+	ofono_voicecall_create(modem, 0, "samsungipcmodem", data->device);
+	gprs =3D ofono_gprs_create(modem, 0, "samsungipcmodem", data->device);
+	gc =3D ofono_gprs_context_create(modem, 0, "samsungipcmodem", data->devic=
e);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+}
+
+static struct ofono_modem_driver samsungipc_driver =3D {
+	.name		=3D "samsungipc",
+	.probe		=3D samsungipc_probe,
+	.remove		=3D samsungipc_remove,
+	.enable		=3D samsungipc_enable,
+	.disable	=3D samsungipc_disable,
+	.pre_sim	=3D samsungipc_pre_sim,
+	.post_sim	=3D samsungipc_post_sim,
+	.set_online	=3D samsungipc_set_online,
+	.post_online	=3D samsungipc_post_online,
+};
+
+static int samsungipc_init(void)
+{
+	int err;
+	char *remote;
+	struct ofono_modem *modem;
+
+	err =3D ofono_modem_driver_register(&samsungipc_driver);
+	if (err < 0)
+		return err;
+
+	remote =3D getenv("OFONO_SAMSUNGIPC_REMOTE");
+	if (remote !=3D NULL) {
+		modem =3D ofono_modem_create(NULL, "samsungipc");
+		if (modem =3D=3D NULL)
+			return -1;
+
+		ofono_modem_set_string(modem, "Address", remote);
+		ofono_modem_set_integer(modem, "Port", 3001);
+
+		ofono_modem_register(modem);
+	}
+
+	return 0;
+}
+
+static void samsungipc_exit(void)
+{
+	ofono_modem_driver_unregister(&samsungipc_driver);
+}
+
+OFONO_PLUGIN_DEFINE(samsungipc, "Samsung IPC driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, samsungipc_init, samsungipc_exit)
-- =

1.7.9.5


--===============6251729170124251982==--

