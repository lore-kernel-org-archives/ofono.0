Content-Type: multipart/mixed; boundary="===============2289838330670421212=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 1/4] gprs-provision: add driver API header
Date: Tue, 25 Jan 2011 14:15:11 +0200
Message-ID: <1295957714-21053-2-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295957714-21053-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2289838330670421212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am              |    3 +-
 include/gprs-provision.h |   69 ++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 71 insertions(+), 1 deletions(-)
 create mode 100644 include/gprs-provision.h

diff --git a/Makefile.am b/Makefile.am
index f941a19..f543135 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,8 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
-			include/cdma-sms.h include/sim-auth.h
+			include/cdma-sms.h include/sim-auth.h \
+			include/gprs-provision.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/gprs-provision.h b/include/gprs-provision.h
new file mode 100644
index 0000000..cc9f5b5
--- /dev/null
+++ b/include/gprs-provision.h
@@ -0,0 +1,69 @@
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
+struct ofono_gprs_provision_driver {
+	const char *name;
+	int priority;
+	void (*get_settings)(const char *mcc, const char *mnc, const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count);
+};
+
+int ofono_gprs_provision_driver_register(
+			const struct ofono_gprs_provision_driver *driver);
+void ofono_gprs_provision_driver_unregister(
+			const struct ofono_gprs_provision_driver *driver);
+
+/* For gprs */
+void __ofono_gprs_provision_get_settings(const char *mcc, const char *mnc,
+			const char *spn,
+			struct ofono_gprs_provision_data **settings,
+			int *count);
+void provision_settings_free(struct ofono_gprs_provision_data *settings,
+				int count);
+
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_GPRS_PROVISION_H */
-- =

1.7.1


--===============2289838330670421212==--

