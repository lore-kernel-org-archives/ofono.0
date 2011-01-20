Content-Type: multipart/mixed; boundary="===============5853753523997326175=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 1/6] gprs-provision: add driver API header
Date: Thu, 20 Jan 2011 15:11:34 +0200
Message-ID: <1295529099-21082-2-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295529099-21082-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5853753523997326175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am              |    2 +-
 include/gprs-provision.h |   74 ++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 75 insertions(+), 1 deletions(-)
 create mode 100644 include/gprs-provision.h

diff --git a/Makefile.am b/Makefile.am
index c1c34ca..7a03f08 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
-			include/cdma-sms.h
+			include/cdma-sms.h include/gprs-provision.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/gprs-provision.h b/include/gprs-provision.h
new file mode 100644
index 0000000..cc751d2
--- /dev/null
+++ b/include/gprs-provision.h
@@ -0,0 +1,74 @@
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
+ */
+typedef void (*ofono_gprs_provision_cb_t)(
+			const struct ofono_gprs_provision_data settings[],
+			int count, void *user_data);
+
+struct ofono_gprs_provision_driver {
+	const char *name;
+	int priority;
+	int (*probe)(struct ofono_gprs_provision_context *context);
+	void (*remove)(struct ofono_gprs_provision_context *context);
+	void (*get_settings)(struct ofono_gprs_provision_context *context,
+				ofono_gprs_provision_cb_t cb,
+				void *user_data);
+};
+
+int ofono_gprs_provision_driver_register(
+			const struct ofono_gprs_provision_driver *driver);
+void ofono_gprs_provision_driver_unregister(
+			const struct ofono_gprs_provision_driver *driver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_GPRS_PROVISION_H */
-- =

1.7.1


--===============5853753523997326175==--

