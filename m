Content-Type: multipart/mixed; boundary="===============3541618353334271464=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 1/3] Speedup: Add speedup driver to handle USSD
Date: Mon, 16 Apr 2012 17:10:21 +0200
Message-ID: <1334589023-3633-2-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1334589023-3633-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3541618353334271464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/speedupmodem/speedupmodem.c |   49 ++++++++
 drivers/speedupmodem/speedupmodem.h |   25 ++++
 drivers/speedupmodem/ussd.c         |  224 +++++++++++++++++++++++++++++++=
++++
 3 files changed, 298 insertions(+), 0 deletions(-)
 create mode 100644 drivers/speedupmodem/speedupmodem.c
 create mode 100644 drivers/speedupmodem/speedupmodem.h
 create mode 100644 drivers/speedupmodem/ussd.c

diff --git a/drivers/speedupmodem/speedupmodem.c b/drivers/speedupmodem/spe=
edupmodem.c
new file mode 100644
index 0000000..d31c324
--- /dev/null
+++ b/drivers/speedupmodem/speedupmodem.c
@@ -0,0 +1,49 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
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
+#include <glib.h>
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+
+#include "speedupmodem.h"
+
+static int speedupmodem_init(void)
+{
+	speedup_ussd_init();
+
+	return 0;
+}
+
+static void speedupmodem_exit(void)
+{
+	speedup_ussd_exit();
+}
+
+OFONO_PLUGIN_DEFINE(speedupmodem, "SpeedUp modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			speedupmodem_init, speedupmodem_exit)
diff --git a/drivers/speedupmodem/speedupmodem.h b/drivers/speedupmodem/spe=
edupmodem.h
new file mode 100644
index 0000000..38ad013
--- /dev/null
+++ b/drivers/speedupmodem/speedupmodem.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+extern void speedup_ussd_init(void);
+extern void speedup_ussd_exit(void);
diff --git a/drivers/speedupmodem/ussd.c b/drivers/speedupmodem/ussd.c
new file mode 100644
index 0000000..02d3487
--- /dev/null
+++ b/drivers/speedupmodem/ussd.c
@@ -0,0 +1,224 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
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
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/ussd.h>
+#include "util.h"
+
+#include "gatchat.h"
+
+#include "speedupmodem.h"
+
+static const char *cusd_prefix[] =3D { "+CUSD:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
+struct ussd_data {
+	GAtChat *chat;
+};
+
+static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
+{
+	GAtResultIter iter;
+	int status, dcs;
+	const char *content;
+	unsigned char msg[160];
+	const unsigned char *msg_ptr =3D NULL;
+	long msg_len;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CUSD:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &content))
+		goto out;
+
+	if (!g_at_result_iter_next_number(&iter, &dcs))
+		dcs =3D 0;
+
+	msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, msg);
+
+out:
+	ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? msg_len : 0);
+}
+
+static void cusd_request_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_ussd_cb_t cb =3D cbd->cb;
+	struct ofono_ussd *ussd =3D cbd->user;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+
+	cusd_parse(result, ussd);
+}
+
+static void speedup_ussd_request(struct ofono_ussd *ussd, int dcs,
+				const unsigned char *pdu, int len,
+				ofono_ussd_cb_t cb, void *user_data)
+{
+	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char buf[512], coded_buf[182];
+	long written;
+
+	cbd->user =3D ussd;
+
+	unpack_7bit_own_buf(pdu, len, 0, TRUE, sizeof(coded_buf),
+				&written, 0, (unsigned char *)coded_buf);
+	if (written < 1)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d", (int) written,
+			coded_buf, dcs);
+
+	if (g_at_chat_send(data->chat, buf, cusd_prefix,
+				cusd_request_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
+static void cusd_cancel_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_ussd_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	/*
+	 * All errors and notifications arrive unexpected and
+	 * thus just reset the state here. This is safer than
+	 * getting stuck in a dead-lock.
+	 */
+	error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+	error.error =3D 0;
+
+	cb(&error, cbd->data);
+}
+
+static void speedup_ussd_cancel(struct ofono_ussd *ussd,
+				ofono_ussd_cb_t cb, void *user_data)
+{
+	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+	cbd->user =3D data;
+
+	if (g_at_chat_send(data->chat, "AT+CUSD=3D2", none_prefix,
+				cusd_cancel_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
+static void cusd_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_ussd *ussd =3D user_data;
+
+	cusd_parse(result, ussd);
+}
+
+static void cusd_register(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_ussd *ussd =3D user_data;
+	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
+
+	if (!ok) {
+		ofono_error("Could not enable CUSD notifications");
+		return;
+	}
+
+	g_at_chat_register(data->chat, "+CUSD:", cusd_notify,
+						FALSE, ussd, NULL);
+
+	ofono_ussd_register(ussd);
+}
+
+static int speedup_ussd_probe(struct ofono_ussd *ussd,
+					unsigned int vendor, void *user)
+{
+	GAtChat *chat =3D user;
+	struct ussd_data *data;
+
+	data =3D g_try_new0(struct ussd_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	data->chat =3D g_at_chat_clone(chat);
+
+	ofono_ussd_set_data(ussd, data);
+
+	g_at_chat_send(data->chat, "AT+CUSD=3D1", none_prefix,
+					cusd_register, ussd, NULL);
+
+	return 0;
+}
+
+static void speedup_ussd_remove(struct ofono_ussd *ussd)
+{
+	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
+
+	ofono_ussd_set_data(ussd, NULL);
+
+	g_at_chat_unref(data->chat);
+	g_free(data);
+}
+
+static struct ofono_ussd_driver driver =3D {
+	.name		=3D "speedupmodem",
+	.probe		=3D speedup_ussd_probe,
+	.remove		=3D speedup_ussd_remove,
+	.request	=3D speedup_ussd_request,
+	.cancel		=3D speedup_ussd_cancel,
+};
+
+void speedup_ussd_init(void)
+{
+	ofono_ussd_driver_register(&driver);
+}
+
+void speedup_ussd_exit(void)
+{
+	ofono_ussd_driver_unregister(&driver);
+}
-- =

1.7.5.4


--===============3541618353334271464==--

