Content-Type: multipart/mixed; boundary="===============2736303642178971813=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 5/7] cdmamodem: Add Signal Strength Support
Date: Tue, 08 Feb 2011 13:04:58 -0800
Message-ID: <1297199100-2712-6-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2736303642178971813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                              |    3 +-
 drivers/cdmamodem/cdmamodem.c            |    2 +
 drivers/cdmamodem/cdmamodem.h            |    2 +
 drivers/cdmamodem/network-registration.c |  211 ++++++++++++++++++++++++++=
++++
 4 files changed, 217 insertions(+), 1 deletions(-)
 create mode 100644 drivers/cdmamodem/network-registration.c

diff --git a/Makefile.am b/Makefile.am
index c245b4c..272e28d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -257,7 +257,8 @@ builtin_modules +=3D cdmamodem
 builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
 			drivers/cdmamodem/cdmamodem.c \
 			drivers/cdmamodem/voicecall.c \
-			drivers/cdmamodem/devinfo.c
+			drivers/cdmamodem/devinfo.c \
+			drivers/cdmamodem/network-registration.c
 endif
 =

 builtin_modules +=3D g1
diff --git a/drivers/cdmamodem/cdmamodem.c b/drivers/cdmamodem/cdmamodem.c
index 9eddd88..492f1f0 100644
--- a/drivers/cdmamodem/cdmamodem.c
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -36,6 +36,7 @@ static int cdmamodem_init(void)
 {
 	cdma_voicecall_init();
 	cdma_devinfo_init();
+	cdma_netreg_init();
 =

 	return 0;
 }
@@ -44,6 +45,7 @@ static void cdmamodem_exit(void)
 {
 	cdma_voicecall_exit();
 	cdma_devinfo_exit();
+	cdma_netreg_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(cdmamodem, "CDMA AT modem driver", VERSION,
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
index 4365bec..a1fbf65 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -25,3 +25,5 @@ extern void cdma_voicecall_init(void);
 extern void cdma_voicecall_exit(void);
 extern void cdma_devinfo_init(void);
 extern void cdma_devinfo_exit(void);
+extern void cdma_netreg_init(void);
+extern void cdma_netreg_exit(void);
diff --git a/drivers/cdmamodem/network-registration.c b/drivers/cdmamodem/n=
etwork-registration.c
new file mode 100644
index 0000000..4135fe1
--- /dev/null
+++ b/drivers/cdmamodem/network-registration.c
@@ -0,0 +1,211 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Nokia Corporation. All rights reserved.
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
+#include <ofono/cdma-netreg.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "cdmamodem.h"
+
+/* Time interval in seconds between CSQ polls */
+#define CSQ_INTERVAL 5
+
+struct cdma_netreg_data {
+	GAtChat *chat;
+	unsigned int vendor;
+	unsigned int csq_source;
+};
+
+static gboolean cdma_get_next_number(const char *line, gint *number)
+{
+	int pos;
+	int end;
+	int len;
+	int value =3D 0;
+
+	len =3D strlen(line);
+
+	pos =3D 0;
+	end =3D pos;
+
+	while (line[end] >=3D '0' && line[end] <=3D '9') {
+		value =3D value * 10 + (int)(line[end] - '0');
+		end +=3D 1;
+	}
+
+	if (pos =3D=3D end)
+		return FALSE;
+
+	pos =3D skip_to_next_field(line, end, len);
+
+	if (number)
+		*number =3D value;
+
+	return TRUE;
+}
+
+static void cdma_csq_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_cdma_netreg_strength_cb_t cb =3D cbd->cb;
+	const char *prefix =3D cbd->user;
+	struct ofono_error error;
+	const char *attr;
+	int strength =3D -1;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	if (at_util_parse_attr(result, prefix, &attr) =3D=3D FALSE) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	cdma_get_next_number(attr, &strength);
+
+	DBG("csq_cb: %d", strength);
+
+	cb(&error, at_util_convert_signal_strength(strength), cbd->data);
+}
+
+static void cdma_signal_strength(struct ofono_cdma_netreg *netreg,
+				ofono_cdma_netreg_strength_cb_t cb, void *data)
+{
+	struct cdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	cbd->user =3D "AT+CSQ";
+
+	if (g_at_chat_send(nd->chat, "AT+CSQ", NULL,
+				cdma_csq_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static gboolean cdma_poll_csq(gpointer user_data);
+
+static void cdma_poll_csq_cb(const struct ofono_error *error, int strength,
+				void *data)
+{
+	struct ofono_cdma_netreg *netreg =3D data;
+	struct cdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+
+	if(error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		ofono_cdma_netreg_strength_notify(netreg, strength);
+
+	/* Initiate the next poll */
+	nd->csq_source =3D g_timeout_add_seconds(CSQ_INTERVAL, cdma_poll_csq, net=
reg);
+}
+
+static gboolean cdma_poll_csq(gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	struct cdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cdma_poll_csq_cb, netreg);
+
+	cbd->user =3D "AT+CSQ";
+
+	g_at_chat_send(nd->chat, "AT+CSQ", NULL, cdma_csq_cb, cbd, g_free);
+
+	nd->csq_source =3D 0;
+
+	return FALSE;
+}
+
+static gboolean cdma_netreg_register(gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	struct cdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+
+	ofono_cdma_netreg_register(netreg);
+
+	nd->csq_source =3D g_timeout_add_seconds(CSQ_INTERVAL, cdma_poll_csq, net=
reg);
+
+	return FALSE;
+}
+
+static int cdma_netreg_probe(struct ofono_cdma_netreg *netreg,
+				unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct cdma_netreg_data *nd;
+
+	nd =3D g_new0(struct cdma_netreg_data, 1);
+
+	nd->chat =3D g_at_chat_clone(chat);
+	nd->vendor =3D vendor;
+
+	ofono_cdma_netreg_set_data(netreg, nd);
+	g_idle_add(cdma_netreg_register, netreg);
+
+	return 0;
+}
+
+static void cdma_netreg_remove(struct ofono_cdma_netreg *netreg)
+{
+	struct cdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+
+	if (nd->csq_source)
+		g_source_remove(nd->csq_source);
+
+	ofono_cdma_netreg_set_data(netreg, NULL);
+
+	g_at_chat_unref(nd->chat);
+	g_free(nd);
+}
+
+static struct ofono_cdma_netreg_driver driver =3D {
+	.name				=3D "cdmamodem",
+	.probe				=3D cdma_netreg_probe,
+	.remove				=3D cdma_netreg_remove,
+	.strength			=3D cdma_signal_strength,
+};
+
+void cdma_netreg_init(void)
+{
+	ofono_cdma_netreg_driver_register(&driver);
+}
+
+void cdma_netreg_exit(void)
+{
+	ofono_cdma_netreg_driver_unregister(&driver);
+}
-- =

1.7.0.4


--===============2736303642178971813==--

