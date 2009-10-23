Content-Type: multipart/mixed; boundary="===============3010383669051097404=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 1/1] Create network registration driver for hfpmodem
Date: Fri, 23 Oct 2009 19:36:11 -0200
Message-ID: <1256333771-10572-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1256333771-10572-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3010383669051097404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This driver handles phone informations about registration status, signal
strength and roaming status listening +CIEV commands.
It also gets the Network Operator name with +COPS commands.
---
 Makefile.am                             |    3 +-
 drivers/hfpmodem/hfpmodem.c             |    2 +
 drivers/hfpmodem/hfpmodem.h             |    3 +
 drivers/hfpmodem/network-registration.c |  172 +++++++++++++++++++++++++++=
++++
 plugins/hfp.c                           |    1 +
 5 files changed, 180 insertions(+), 1 deletions(-)
 create mode 100644 drivers/hfpmodem/network-registration.c

diff --git a/Makefile.am b/Makefile.am
index 561eeb0..332e10b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -123,7 +123,8 @@ builtin_modules +=3D hfpmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/hfpmodem.h \
 			drivers/hfpmodem/hfpmodem.c \
-			drivers/hfpmodem/voicecall.c
+			drivers/hfpmodem/voicecall.c \
+			drivers/hfpmodem/network-registration.c
 =

 builtin_modules +=3D modemconf
 builtin_sources +=3D plugins/modemconf.c
diff --git a/drivers/hfpmodem/hfpmodem.c b/drivers/hfpmodem/hfpmodem.c
index 03b5ea0..58ae03d 100644
--- a/drivers/hfpmodem/hfpmodem.c
+++ b/drivers/hfpmodem/hfpmodem.c
@@ -42,6 +42,7 @@
 static int hfpmodem_init(void)
 {
 	hfp_voicecall_init();
+	hfp_netreg_init();
 =

 	return 0;
 }
@@ -49,6 +50,7 @@ static int hfpmodem_init(void)
 static void hfpmodem_exit(void)
 {
 	hfp_voicecall_exit();
+	hfp_netreg_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(hfpmodem, "Hands-Free Profile Driver", VERSION,
diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index 6c6ab6f..3b30d83 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -61,6 +61,9 @@ struct hfp_data {
 	gint cind_val[HFP_INDICATOR_LAST];
 };
 =

+extern void hfp_netreg_init();
+extern void hfp_netreg_exit();
+
 extern void hfp_voicecall_init();
 extern void hfp_voicecall_exit();
 =

diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
new file mode 100644
index 0000000..c23d07e
--- /dev/null
+++ b/drivers/hfpmodem/network-registration.c
@@ -0,0 +1,172 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2009 ProFUSION embedded systems. All rights reserved.
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
+#include <ofono/netreg.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "hfpmodem.h"
+
+#define OFONO_MAX_HFP_OPERATOR_NAME_LENGTH 16
+
+static const char *cops_prefix[] =3D { "+COPS:", NULL };
+
+struct netreg_data {
+	GAtChat *chat;
+	unsigned char cind_pos[HFP_INDICATOR_LAST];
+	int cind_val[HFP_INDICATOR_LAST];
+	char operator[16];
+};
+
+static void cops_name_notify(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	GAtResultIter iter;
+	int format;
+	const char *name;
+
+	if (!ok) {
+		ofono_error("Unable to get name of the registered Network");
+		ofono_netreg_remove(netreg);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+COPS:"))
+		return;
+
+	g_at_result_iter_skip_next(&iter);
+
+	ok =3D g_at_result_iter_next_number(&iter, &format);
+
+	if (ok =3D=3D FALSE || format !=3D 0)
+		return;
+
+	if (g_at_result_iter_next_string(&iter, &name) =3D=3D FALSE)
+		return;
+
+	strncpy(nd->operator, name, OFONO_MAX_HFP_OPERATOR_NAME_LENGTH);
+	nd->operator[OFONO_MAX_HFP_OPERATOR_NAME_LENGTH] =3D '\0';
+}
+
+static void cops_notify(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	if (!ok) {
+		ofono_error("Unable to get name of the registered Network");
+		ofono_netreg_remove(netreg);
+		return;
+	}
+
+	g_at_chat_send(nd->chat, "AT+COPS?", cops_prefix,
+				cops_name_notify, netreg, NULL);
+}
+
+static void ciev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	GAtResultIter iter;
+	int index, value;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &index))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	if (index =3D=3D nd->cind_pos[HFP_INDICATOR_SERVICE])
+		nd->cind_val[HFP_INDICATOR_SERVICE] =3D value;
+	else if (index =3D=3D nd->cind_pos[HFP_INDICATOR_ROAM])
+		nd->cind_val[HFP_INDICATOR_ROAM] =3D value;
+	else if (index =3D=3D nd->cind_pos[HFP_INDICATOR_SIGNAL])
+		nd->cind_val[HFP_INDICATOR_SIGNAL] =3D value;
+
+	return;
+}
+
+static int hfp_netreg_probe(struct ofono_netreg *netreg, unsigned int vend=
or,
+				void *user_data)
+{
+	struct hfp_data *data =3D user_data;
+	struct netreg_data *nd;
+
+	nd =3D g_new0(struct netreg_data, 1);
+	nd->chat =3D data->chat;
+	memcpy(nd->cind_pos, data->cind_pos, HFP_INDICATOR_LAST);
+	memcpy(nd->cind_val, data->cind_val, HFP_INDICATOR_LAST);
+
+	ofono_netreg_set_data(netreg, nd);
+
+	g_at_chat_send(nd->chat, "AT+COPS=3D3,0", NULL,
+				cops_notify, netreg, NULL);
+	g_at_chat_register(nd->chat, "+CIEV:", ciev_notify, FALSE,
+			netreg, NULL);
+
+	return 0;
+}
+
+static void hfp_netreg_remove(struct ofono_netreg *netreg)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	g_free(nd);
+}
+
+static struct ofono_netreg_driver driver =3D {
+	.name				=3D "hfpmodem",
+	.probe				=3D hfp_netreg_probe,
+	.remove				=3D hfp_netreg_remove,
+};
+
+void hfp_netreg_init()
+{
+	ofono_netreg_driver_register(&driver);
+}
+
+void hfp_netreg_exit()
+{
+	ofono_netreg_driver_unregister(&driver);
+}
diff --git a/plugins/hfp.c b/plugins/hfp.c
index 5e94a05..be812cd 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -311,6 +311,7 @@ static void hfp_pre_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 	ofono_voicecall_create(modem, 0, "hfpmodem", data);
+	ofono_netreg_create(modem, 0, "hfpmodem", data);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
-- =

1.6.4.4


--===============3010383669051097404==--

