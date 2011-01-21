Content-Type: multipart/mixed; boundary="===============3977310101112413465=="
MIME-Version: 1.0
From: christian.lam@nokia.com
Subject: [PATCH 5/7] cdmamodem: add CDMA Connection Manager support
Date: Fri, 21 Jan 2011 15:06:48 -0800
Message-ID: <1295651210-22922-6-git-send-email-christian.lam@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3977310101112413465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christian Lam <christian.lam@nokia.com>

---
 Makefile.am                   |    3 +-
 drivers/cdmamodem/cdmamodem.c |    4 +-
 drivers/cdmamodem/cdmamodem.h |    4 +-
 drivers/cdmamodem/connman.c   |  283 +++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 291 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cdmamodem/connman.c

diff --git a/Makefile.am b/Makefile.am
index dc50a83..e077557 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -254,7 +254,8 @@ builtin_modules +=3D cdmamodem
 builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
 			drivers/cdmamodem/cdmamodem.c \
 			drivers/cdmamodem/voicecall.c \
-			drivers/cdmamodem/devinfo.c
+			drivers/cdmamodem/devinfo.c \
+			drivers/cdmamodem/connman.c
 endif
 =

 builtin_modules +=3D g1
diff --git a/drivers/cdmamodem/cdmamodem.c b/drivers/cdmamodem/cdmamodem.c
index 9eddd88..1b19a4a 100644
--- a/drivers/cdmamodem/cdmamodem.c
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -2,7 +2,7 @@
  *
  *  oFono - Open Source Telephony
  *
- *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
+ *  Copyright (C) 2010-2011 Nokia Corporation. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -36,6 +36,7 @@ static int cdmamodem_init(void)
 {
 	cdma_voicecall_init();
 	cdma_devinfo_init();
+	cdma_connman_init();
 =

 	return 0;
 }
@@ -44,6 +45,7 @@ static void cdmamodem_exit(void)
 {
 	cdma_voicecall_exit();
 	cdma_devinfo_exit();
+	cdma_connman_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(cdmamodem, "CDMA AT modem driver", VERSION,
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
index 4365bec..90e2848 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -2,7 +2,7 @@
  *
  *  oFono - Open Source Telephony
  *
- *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
+ *  Copyright (C) 2010-2011 Nokia Corporation. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -25,3 +25,5 @@ extern void cdma_voicecall_init(void);
 extern void cdma_voicecall_exit(void);
 extern void cdma_devinfo_init(void);
 extern void cdma_devinfo_exit(void);
+extern void cdma_connman_init(void);
+extern void cdma_connman_exit(void);
diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
new file mode 100644
index 0000000..d563413
--- /dev/null
+++ b/drivers/cdmamodem/connman.c
@@ -0,0 +1,283 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010-2011 Nokia Corporation. All rights reserved.
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
+#include <ofono/cdma-connman.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "gatppp.h"
+
+#include "cdmamodem.h"
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
+struct connman_data {
+	GAtChat *chat;
+	GAtPPP *ppp;
+	enum state state;
+	union {
+		ofono_cdma_connman_cb_t down_cb;	/* Down callback */
+		ofono_cdma_connman_up_cb_t up_cb;	/* Up callback */
+	};
+	void *cb_data;					/* Callback data */
+};
+
+static void ppp_debug(const char *str, void *data)
+{
+	ofono_info("%s: %s", (const char *) data, str);
+}
+
+static void ppp_connect(const char *interface, const char *local,
+					const char *remote,
+					const char *dns1, const char *dns2,
+					gpointer user_data)
+{
+	struct ofono_cdma_connman *cm =3D user_data;
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
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
+	cd->state =3D STATE_ACTIVE;
+	CALLBACK_WITH_SUCCESS(cd->up_cb, interface, TRUE, local,
+					STATIC_IP_NETMASK, NULL,
+					dns, cd->cb_data);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct ofono_cdma_connman *cm =3D user_data;
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
+
+	DBG("");
+
+	g_at_ppp_unref(cd->ppp);
+	cd->ppp =3D NULL;
+
+	switch (cd->state) {
+	case STATE_ENABLING:
+		CALLBACK_WITH_FAILURE(cd->up_cb, NULL, FALSE, NULL,
+					NULL, NULL, NULL, cd->cb_data);
+		break;
+	case STATE_DISABLING:
+		CALLBACK_WITH_SUCCESS(cd->down_cb, cd->cb_data);
+		break;
+	default:
+		/* TODO: Handle network initiated disconnection */
+		break;
+	}
+
+	cd->state =3D STATE_IDLE;
+	g_at_chat_resume(cd->chat);
+}
+
+static gboolean setup_ppp(struct ofono_cdma_connman *cm)
+{
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
+	GAtIO *io;
+
+	DBG("");
+
+	io =3D g_at_chat_get_io(cd->chat);
+
+	g_at_chat_suspend(cd->chat);
+
+	/* open ppp */
+	cd->ppp =3D g_at_ppp_new_from_io(io);
+
+	if (cd->ppp =3D=3D NULL) {
+		g_at_chat_resume(cd->chat);
+		return FALSE;
+	}
+
+	if (getenv("OFONO_PPP_DEBUG"))
+		g_at_ppp_set_debug(cd->ppp, ppp_debug, "PPP");
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(cd->ppp, ppp_connect, cm);
+	g_at_ppp_set_disconnect_function(cd->ppp, ppp_disconnect, cm);
+
+	/* open the ppp connection */
+	g_at_ppp_open(cd->ppp);
+
+	return TRUE;
+}
+
+static void atd_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_connman *cm =3D user_data;
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
+
+	DBG("ok %d", ok);
+
+	if (ok =3D=3D FALSE) {
+		struct ofono_error error;
+
+		ofono_info("Unable to enter data state");
+
+		cd->state =3D STATE_IDLE;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		cd->up_cb(&error, NULL, 0, NULL, NULL, NULL, NULL,
+				cd->cb_data);
+		return;
+	}
+
+	setup_ppp(cm);
+}
+
+static void cdma_connman_activate(struct ofono_cdma_connman *cm,
+					ofono_cdma_connman_up_cb_t cb,
+					void *data)
+{
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
+	char buf[64];
+
+	DBG("");
+
+	cd->up_cb =3D cb;
+	cd->cb_data =3D data;
+	cd->state =3D STATE_ENABLING;
+
+	sprintf(buf, "ATD#777");
+
+	if (g_at_chat_send(cd->chat, buf, none_prefix,
+				atd_cb, cm, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+}
+
+static void cdma_connman_deactivate(struct ofono_cdma_connman *cm,
+					ofono_cdma_connman_cb_t cb,
+					void *data)
+{
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
+
+	DBG("");
+
+	cd->state =3D STATE_DISABLING;
+	cd->down_cb =3D cb;
+	cd->cb_data =3D data;
+
+	g_at_ppp_shutdown(cd->ppp);
+}
+
+static void at_c0_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_connman *cm =3D user_data;
+
+	DBG("ok %d", ok);
+
+	if (ok =3D=3D FALSE) {
+		ofono_info("Unable to configure circuit 109");
+		ofono_cdma_connman_remove(cm);
+		return;
+	}
+
+	ofono_cdma_connman_register(cm);
+}
+
+static int cdma_connman_probe(struct ofono_cdma_connman *cm,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct connman_data *cd;
+
+	DBG("");
+
+	cd =3D g_try_new0(struct connman_data, 1);
+	if (cd =3D=3D NULL)
+		return -ENOMEM;
+
+	cd->chat =3D g_at_chat_clone(chat);
+
+	ofono_cdma_connman_set_data(cm, cd);
+
+	g_at_chat_send(cd->chat, "AT&C0", none_prefix, at_c0_cb, cm, NULL);
+
+	return 0;
+}
+
+static void cdma_connman_remove(struct ofono_cdma_connman *cm)
+{
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
+
+	DBG("");
+
+	if (cd->state !=3D STATE_IDLE && cd->ppp) {
+		g_at_ppp_unref(cd->ppp);
+		g_at_chat_resume(cd->chat);
+	}
+
+	ofono_cdma_connman_set_data(cm, NULL);
+
+	g_at_chat_unref(cd->chat);
+	g_free(cd);
+}
+
+static struct ofono_cdma_connman_driver driver =3D {
+	.name			=3D "cdmamodem",
+	.probe			=3D cdma_connman_probe,
+	.remove			=3D cdma_connman_remove,
+	.activate		=3D cdma_connman_activate,
+	.deactivate		=3D cdma_connman_deactivate,
+};
+
+void cdma_connman_init(void)
+{
+	ofono_cdma_connman_driver_register(&driver);
+}
+
+void cdma_connman_exit(void)
+{
+	ofono_cdma_connman_driver_unregister(&driver);
+}
-- =

1.7.0.4


--===============3977310101112413465==--

