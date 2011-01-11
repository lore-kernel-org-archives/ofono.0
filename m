Content-Type: multipart/mixed; boundary="===============7184288160225633536=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v5, 1/5] cdmamodem: Add CDMA MO Call support
Date: Mon, 10 Jan 2011 17:45:28 -0800
Message-ID: <1294710332-6028-2-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7184288160225633536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                   |    4 +-
 drivers/cdmamodem/cdmamodem.c |    3 +
 drivers/cdmamodem/cdmamodem.h |    3 +
 drivers/cdmamodem/voicecall.c |  160 +++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 169 insertions(+), 1 deletions(-)
 create mode 100644 drivers/cdmamodem/voicecall.c

diff --git a/Makefile.am b/Makefile.am
index b509757..5f54efe 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -247,7 +247,9 @@ endif
 =

 if CDMAMODEM
 builtin_modules +=3D cdmamodem
-builtin_sources +=3D drivers/cdmamodem/cdmamodem.h drivers/cdmamodem/cdmam=
odem.c
+builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
+			drivers/cdmamodem/cdmamodem.c \
+			drivers/cdmamodem/voicecall.c
 endif
 =

 builtin_modules +=3D g1
diff --git a/drivers/cdmamodem/cdmamodem.c b/drivers/cdmamodem/cdmamodem.c
index e7546e0..1c15da0 100644
--- a/drivers/cdmamodem/cdmamodem.c
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -34,11 +34,14 @@
 =

 static int cdmamodem_init(void)
 {
+	cdma_at_voicecall_init();
+
 	return 0;
 }
 =

 static void cdmamodem_exit(void)
 {
+	cdma_at_voicecall_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(cdmamodem, "CDMA AT modem driver", VERSION,
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
index 114d1fd..a5991cf 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -20,3 +20,6 @@
  */
 =

 #include <drivers/atmodem/atutil.h>
+
+extern void cdma_at_voicecall_init();
+extern void cdma_at_voicecall_exit();
diff --git a/drivers/cdmamodem/voicecall.c b/drivers/cdmamodem/voicecall.c
new file mode 100644
index 0000000..ba4d2d4
--- /dev/null
+++ b/drivers/cdmamodem/voicecall.c
@@ -0,0 +1,160 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
+#include <ofono/cdma-voicecall.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "cdmamodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+
+struct voicecall_driver {
+	GAtChat *chat;
+	unsigned int vendor;
+};
+
+static void at_template(const char *cmd, struct ofono_cdma_voicecall *vc,
+			GAtResultFunc result_cb, ofono_cdma_voicecall_cb_t cb,
+			void *data)
+{
+	struct voicecall_driver *vd =3D ofono_cdma_voicecall_get_data(vc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	cbd->user =3D vc;
+	cbd->cb =3D cb;
+	cbd->data =3D data;
+
+	if (g_at_chat_send(vd->chat, cmd, none_prefix,
+				result_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void generic_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_cdma_voicecall_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
+static void at_dial(struct ofono_cdma_voicecall *vc,
+			const struct ofono_cdma_phone_number *ph,
+			ofono_cdma_voicecall_cb_t cb, void *data)
+{
+	char buf[OFONO_CDMA_MAX_PHONE_NUMBER_LENGTH + 8];
+
+	snprintf(buf, sizeof(buf), "AT+CDV=3D%s", ph->number);
+	at_template(buf, vc, generic_cb, cb, data);
+}
+
+static void at_hangup_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct cb_data *cbd =3D user_data;
+
+	generic_cb(ok, result, user_data);
+
+	/* TODO: this should come from a modem solicited notification */
+	ofono_cdma_voicecall_disconnected(cbd->user,
+					OFONO_DISCONNECT_REASON_LOCAL_HANGUP,
+					NULL);
+}
+
+static void at_hangup(struct ofono_cdma_voicecall *vc,
+			ofono_cdma_voicecall_cb_t cb, void *data)
+{
+	/* Hangup active call */
+	at_template("AT+CHV", vc, at_hangup_cb, cb, data);
+}
+
+static int at_voicecall_probe(struct ofono_cdma_voicecall *vc,
+		unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct voicecall_driver *vd;
+
+	vd =3D g_try_new0(struct voicecall_driver, 1);
+	if (vd =3D=3D NULL)
+		return -ENOMEM;
+
+	vd->chat =3D g_at_chat_clone(chat);
+	vd->vendor =3D vendor;
+
+	ofono_cdma_voicecall_set_data(vc, vd);
+
+	ofono_cdma_voicecall_register(vc);
+
+	return 0;
+}
+
+static void at_voicecall_remove(struct ofono_cdma_voicecall *vc)
+{
+	struct voicecall_driver *vd =3D ofono_cdma_voicecall_get_data(vc);
+
+	ofono_cdma_voicecall_set_data(vc, NULL);
+
+	g_at_chat_unref(vd->chat);
+	g_free(vd);
+}
+
+static struct ofono_cdma_voicecall_driver driver =3D {
+	.name			=3D "cdmamodem",
+	.probe			=3D at_voicecall_probe,
+	.remove			=3D at_voicecall_remove,
+	.dial			=3D at_dial,
+	.hangup			=3D at_hangup,
+};
+
+void cdma_at_voicecall_init()
+{
+	ofono_cdma_voicecall_driver_register(&driver);
+}
+
+void cdma_at_voicecall_exit()
+{
+	ofono_cdma_voicecall_driver_unregister(&driver);
+}
-- =

1.7.0.4


--===============7184288160225633536==--

