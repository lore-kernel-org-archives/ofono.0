Content-Type: multipart/mixed; boundary="===============8258344991054573398=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] atmodem: sim-auth atom driver.
Date: Mon, 17 Jan 2011 18:38:54 +0100
Message-ID: <1295285934-9306-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1295285934-9306-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8258344991054573398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

At the moment implementing only application discovery.
---
 Makefile.am                |    3 +-
 drivers/atmodem/atmodem.c  |    2 +
 drivers/atmodem/atmodem.h  |    3 +
 drivers/atmodem/sim-auth.c |  173 ++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 180 insertions(+), 1 deletions(-)
 create mode 100644 drivers/atmodem/sim-auth.c

diff --git a/Makefile.am b/Makefile.am
index a0b7264..1397170 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -170,7 +170,8 @@ builtin_sources +=3D $(gatchat_sources) \
 				drivers/atmodem/atutil.h \
 				drivers/atmodem/atutil.c \
 				drivers/atmodem/gprs.c \
-				drivers/atmodem/gprs-context.c
+				drivers/atmodem/gprs-context.c \
+				drivers/atmodem/sim-auth.c
 =

 builtin_modules +=3D nwmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index c88f6b2..e140281 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -51,12 +51,14 @@ static int atmodem_init(void)
 	at_call_volume_init();
 	at_gprs_init();
 	at_gprs_context_init();
+	at_sim_auth_init();
 =

 	return 0;
 }
 =

 static void atmodem_exit(void)
 {
+	at_sim_auth_exit();
 	at_stk_exit();
 	at_sim_exit();
 	at_sms_exit();
diff --git a/drivers/atmodem/atmodem.h b/drivers/atmodem/atmodem.h
index c7f0eed..1b7cf67 100644
--- a/drivers/atmodem/atmodem.h
+++ b/drivers/atmodem/atmodem.h
@@ -71,3 +71,6 @@ extern void at_gprs_exit(void);
 =

 extern void at_gprs_context_init(void);
 extern void at_gprs_context_exit(void);
+
+extern void at_sim_auth_init(void);
+extern void at_sim_auth_exit(void);
diff --git a/drivers/atmodem/sim-auth.c b/drivers/atmodem/sim-auth.c
new file mode 100644
index 0000000..a7a64ed
--- /dev/null
+++ b/drivers/atmodem/sim-auth.c
@@ -0,0 +1,173 @@
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+
+#include <glib.h>
+
+#include <ofono/modem.h>
+#include <ofono/sim-auth.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "simutil.h"
+#include "vendor.h"
+
+#include "atmodem.h"
+
+struct sim_auth_data {
+	GAtChat *chat;
+	unsigned int vendor;
+};
+
+static const char *cuad_prefix[] =3D { "+CUAD:", NULL };
+
+static void at_discover_apps_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_list_apps_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	GSList *list =3D NULL, *i;
+	struct ofono_sim_app_record *buffer;
+	int j, n;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, 0, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CUAD:")) {
+		const guint8 *obj_str;
+		gint len;
+
+		if (!g_at_result_iter_next_hexstring(&iter, &obj_str, &len))
+			goto error;
+
+		i =3D sim_parse_app_template_entries(obj_str, len);
+		if (i =3D=3D NULL)
+			goto error;
+
+		list =3D g_slist_concat(i, list);
+	}
+
+	n =3D g_slist_length(list);
+	buffer =3D g_new(struct ofono_sim_app_record, n);
+
+	for (i =3D list, j =3D n - 1; i !=3D NULL; i =3D i->next, i--)
+		memcpy(&buffer[j], i->data, sizeof(*buffer));
+
+	cb(&error, buffer, n, cbd->data);
+
+	g_free(buffer);
+	goto done;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+
+done:
+	while (list) {
+		i =3D list;
+		list =3D list->next;
+
+		g_free(((struct ofono_sim_app_record *) i->data)->label);
+		g_free(i->data);
+		g_slist_free_1(i);
+	}
+}
+
+static void at_discover_apps(struct ofono_sim_auth *sa,
+				ofono_sim_list_apps_cb_t cb,
+				void *data)
+{
+	struct sim_auth_data *sad =3D ofono_sim_auth_get_data(sa);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (cbd && g_at_chat_send(sad->chat, "AT+CUAD", cuad_prefix,
+					at_discover_apps_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+}
+
+static gboolean at_sim_auth_register(gpointer user)
+{
+	struct ofono_sim_auth *sa =3D user;
+
+	ofono_sim_auth_register(sa);
+
+	return FALSE;
+}
+
+static int at_sim_auth_probe(struct ofono_sim_auth *sa, unsigned int vendo=
r,
+				void *data)
+{
+	GAtChat *chat =3D data;
+	struct sim_auth_data *sad;
+
+	sad =3D g_new0(struct sim_auth_data, 1);
+	sad->chat =3D g_at_chat_clone(chat);
+	sad->vendor =3D vendor;
+
+	ofono_sim_auth_set_data(sa, sad);
+	g_idle_add(at_sim_auth_register, sa);
+
+	return 0;
+}
+
+static void at_sim_auth_remove(struct ofono_sim_auth *sa)
+{
+	struct sim_auth_data *sad =3D ofono_sim_auth_get_data(sa);
+
+	ofono_sim_auth_set_data(sa, NULL);
+
+	g_at_chat_unref(sad->chat);
+	g_free(sad);
+}
+
+static struct ofono_sim_auth_driver driver =3D {
+	.name		=3D "atmodem",
+	.probe		=3D at_sim_auth_probe,
+	.remove		=3D at_sim_auth_remove,
+	.list_apps	=3D at_discover_apps,
+};
+
+void at_sim_auth_init(void)
+{
+	ofono_sim_auth_driver_register(&driver);
+}
+
+void at_sim_auth_exit(void)
+{
+	ofono_sim_auth_driver_unregister(&driver);
+}
-- =

1.7.1.86.g0e460.dirty


--===============8258344991054573398==--

