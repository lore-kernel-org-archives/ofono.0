Content-Type: multipart/mixed; boundary="===============0749742507998662015=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v2 5/9] cdmamodem: Add CDMA MO Call Support
Date: Fri, 17 Dec 2010 15:11:17 -0800
Message-ID: <1292627481-9109-6-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0749742507998662015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                   |    7 ++
 configure.ac                  |    5 +
 drivers/cdmamodem/cdmamodem.c |   48 ++++++++++
 drivers/cdmamodem/cdmamodem.h |   25 ++++++
 drivers/cdmamodem/voicecall.c |  190 +++++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 275 insertions(+), 0 deletions(-)
 create mode 100644 drivers/cdmamodem/cdmamodem.c
 create mode 100644 drivers/cdmamodem/cdmamodem.h
 create mode 100644 drivers/cdmamodem/voicecall.c

diff --git a/Makefile.am b/Makefile.am
index 40ff52d..50e893f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -242,6 +242,13 @@ conf_DATA +=3D plugins/phonesim.conf
 endif
 endif
 =

+if CDMA_ATMODEM
+builtin_modules +=3D cdma_atmodem
+builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
+			drivers/cdmamodem/cdmamodem.c \
+			drivers/cdmamodem/voicecall.c
+endif
+
 builtin_modules +=3D g1
 builtin_sources +=3D plugins/g1.c
 =

diff --git a/configure.ac b/configure.ac
index 5c18f68..9cc0689 100644
--- a/configure.ac
+++ b/configure.ac
@@ -160,6 +160,11 @@ AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atmod=
em],
 					[enable_atmodem=3D${enableval}])
 AM_CONDITIONAL(ATMODEM, test "${enable_atmodem}" !=3D "no")
 =

+AC_ARG_ENABLE(cdmaatmodem, AC_HELP_STRING([--disable-cdmamodem],
+				[disable CDMA AT modem support]),
+					[enable_cdma_atmodem=3D${enableval}])
+AM_CONDITIONAL(CDMA_ATMODEM, test "${enable_cdma_atmodem}" !=3D "no")
+
 AC_ARG_ENABLE(phonesim, AC_HELP_STRING([--disable-phonesim],
 				[disable Phone simulator support]),
 					[enable_phonesim=3D${enableval}])
diff --git a/drivers/cdmamodem/cdmamodem.c b/drivers/cdmamodem/cdmamodem.c
new file mode 100644
index 0000000..20e6d96
--- /dev/null
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -0,0 +1,48 @@
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
+#include <glib.h>
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+
+#include "cdmamodem.h"
+
+static int cdma_atmodem_init(void)
+{
+	cdma_at_voicecall_init();
+
+	return 0;
+}
+
+static void cdma_atmodem_exit(void)
+{
+	cdma_at_voicecall_exit();
+}
+
+OFONO_PLUGIN_DEFINE(cdma_atmodem, "CDMA AT modem driver", VERSION,
+	OFONO_PLUGIN_PRIORITY_DEFAULT, cdma_atmodem_init, cdma_atmodem_exit)
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
new file mode 100644
index 0000000..a5991cf
--- /dev/null
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -0,0 +1,25 @@
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
+#include <drivers/atmodem/atutil.h>
+
+extern void cdma_at_voicecall_init();
+extern void cdma_at_voicecall_exit();
diff --git a/drivers/cdmamodem/voicecall.c b/drivers/cdmamodem/voicecall.c
new file mode 100644
index 0000000..f9955d6
--- /dev/null
+++ b/drivers/cdmamodem/voicecall.c
@@ -0,0 +1,190 @@
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
+	struct ofono_cdma_voicecall_manager *vc;
+	unsigned int local_release;
+	GAtChat *chat;
+	unsigned int vendor;
+};
+
+struct change_state_req {
+	struct ofono_cdma_voicecall_manager *vc;
+	ofono_cdma_voicecall_cb_t cb;
+	void *data;
+};
+
+static void at_dial_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_cdma_voicecall_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto out;
+
+out:
+	cb(&error, cbd->data);
+}
+
+static void at_dial(struct ofono_cdma_voicecall_manager *vc,
+				const struct ofono_cdma_phone_number *ph,
+				ofono_cdma_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_driver *vd =3D ofono_cdma_voicecall_manager_get_data(vc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[256];
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	cbd->user =3D vc;
+
+	snprintf(buf, sizeof(buf), "AT+CDV=3D%s", ph->number);
+
+	if (g_at_chat_send(vd->chat, buf, none_prefix,
+				at_dial_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void at_template(const char *cmd,
+				struct ofono_cdma_voicecall_manager *vc,
+				GAtResultFunc result_cb,
+				ofono_cdma_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_driver *vd =3D ofono_cdma_voicecall_manager_get_data(vc);
+	struct change_state_req *req =3D g_try_new0(struct change_state_req, 1);
+
+	if (req =3D=3D NULL)
+		goto error;
+
+	req->vc =3D vc;
+	req->cb =3D cb;
+	req->data =3D data;
+
+	if (g_at_chat_send(vd->chat, cmd, none_prefix,
+				result_cb, req, g_free) > 0)
+		return;
+
+error:
+	g_free(req);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void at_hangup_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct change_state_req *req =3D user_data;
+
+	if (!ok) {
+		ofono_error("hangup failed.");
+		return;
+	}
+
+	ofono_cdma_voicecall_manager_disconnected(req->vc,
+				OFONO_DISCONNECT_REASON_LOCAL_HANGUP, NULL);
+		CALLBACK_WITH_SUCCESS(req->cb, req->data);
+}
+
+static void at_hangup(struct ofono_cdma_voicecall_manager *vc,
+			ofono_cdma_voicecall_cb_t cb, void *data)
+{
+	/* Hangup active call */
+	at_template("AT+CHV", vc, at_hangup_cb, cb, data);
+}
+
+static int at_voicecall_probe(struct ofono_cdma_voicecall_manager *vc,
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
+	ofono_cdma_voicecall_manager_set_data(vc, vd);
+
+	ofono_cdma_voicecall_manager_register(vc);
+
+	return 0;
+}
+
+static void at_voicecall_remove(struct ofono_cdma_voicecall_manager *vc)
+{
+	struct voicecall_driver *vd =3D ofono_cdma_voicecall_manager_get_data(vc);
+
+	ofono_cdma_voicecall_manager_set_data(vc, NULL);
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


--===============0749742507998662015==--

