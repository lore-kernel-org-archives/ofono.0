Content-Type: multipart/mixed; boundary="===============0984069224229171814=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 1/8] gprs-provision: add driver API header
Date: Tue, 18 Jan 2011 10:09:25 +0200
Message-ID: <1295338172-12773-2-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295338172-12773-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0984069224229171814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am              |    2 +-
 include/gprs-provision.h |   80 ++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 81 insertions(+), 1 deletions(-)
 create mode 100644 include/gprs-provision.h

diff --git a/Makefile.am b/Makefile.am
index da59be7..22ec95d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -15,7 +15,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
-			include/cdma-sms.h
+			include/cdma-sms.h include/gprs-provision.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

diff --git a/include/gprs-provision.h b/include/gprs-provision.h
new file mode 100644
index 0000000..70152b4
--- /dev/null
+++ b/include/gprs-provision.h
@@ -0,0 +1,80 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).
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
+#ifndef __OFONO_GPRS_PROVISION_H
+#define __OFONO_GPRS_PROVISION_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "gprs-context.h"
+
+struct ofono_gprs_provision_context {
+	struct ofono_gprs_provision_driver *driver;
+	struct ofono_modem *modem;
+	void *data;
+};
+
+struct ofono_gprs_provision_data {
+	enum ofono_gprs_context_type type;
+	enum ofono_gprs_proto proto;
+	char *name;
+	char *apn;
+	char *username;
+	char *password;
+	char *message_proxy;
+	char *message_center;
+};
+
+/*
+ * Callback from provisioning plugin.
+ * settings: list of struct ofono_gprs_provision_data
+ *
+ * It is responsibility of callback function to free settings-list
+ * settings-list elements must be freed with ofono_gprs_provision_data_fre=
e()
+ */
+typedef void (*ofono_gprs_provision_cb_t)(GSList *settings, void *userdata=
);
+
+struct ofono_gprs_provision_driver {
+	const char *name;
+	int priority;
+	int (*probe)(struct ofono_gprs_provision_context *context);
+	void (*remove)(struct ofono_gprs_provision_context *context);
+	void (*get_settings) (struct ofono_gprs_provision_context *context,
+				ofono_gprs_provision_cb_t cb,
+				void *user_data);
+};
+
+/* For provisioning drivers/plugins */
+int ofono_gprs_provision_driver_register(
+			const struct ofono_gprs_provision_driver *driver);
+void ofono_gprs_provision_driver_unregister(
+			const struct ofono_gprs_provision_driver *driver);
+
+/* For gprs */
+void ofono_gprs_provision_data_free(struct ofono_gprs_provision_data *data=
);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_GPRS_PROVISION_H */
-- =

1.7.1


--===============0984069224229171814==--

