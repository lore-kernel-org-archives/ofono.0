Content-Type: multipart/mixed; boundary="===============3633608578359492616=="
MIME-Version: 1.0
From: christian.lam@nokia.com
Subject: [PATCH 2/7] cdma-connman: add CDMA Connection Manager support
Date: Fri, 21 Jan 2011 15:06:45 -0800
Message-ID: <1295651210-22922-3-git-send-email-christian.lam@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3633608578359492616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christian Lam <christian.lam@nokia.com>

---
 Makefile.am            |    3 +-
 include/cdma-connman.h |   79 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 81 insertions(+), 1 deletions(-)
 create mode 100644 include/cdma-connman.h

diff --git a/Makefile.am b/Makefile.am
index 9933e32..c4f5983 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,8 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
-			include/cdma-sms.h include/sim-auth.h
+			include/cdma-sms.h include/sim-auth.h \
+			include/cdma-connman.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/cdma-connman.h b/include/cdma-connman.h
new file mode 100644
index 0000000..22252e0
--- /dev/null
+++ b/include/cdma-connman.h
@@ -0,0 +1,79 @@
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
+#ifndef __OFONO_CDMA_CONNMAN_H
+#define __OFONO_CDMA_CONNMAN_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cdma_connman;
+
+typedef void (*ofono_cdma_connman_cb_t)(const struct ofono_error *error,
+						void *data);
+typedef void (*ofono_cdma_connman_up_cb_t)(const struct ofono_error *error,
+						const char *interface,
+						ofono_bool_t static_ip,
+						const char *address,
+						const char *netmask,
+						const char *gw,
+						const char **dns,
+						void *data);
+
+struct ofono_cdma_connman_driver {
+	const char *name;
+	int (*probe)(struct ofono_cdma_connman *cm, unsigned int vendor,
+						void *data);
+	void (*remove)(struct ofono_cdma_connman *cm);
+	void (*activate)(struct ofono_cdma_connman *cm,
+						ofono_cdma_connman_up_cb_t cb,
+						void *data);
+	void (*deactivate)(struct ofono_cdma_connman *cm,
+						ofono_cdma_connman_cb_t cb,
+						void *data);
+};
+
+int ofono_cdma_connman_driver_register(
+				const struct ofono_cdma_connman_driver *d);
+void ofono_cdma_connman_driver_unregister(
+				const struct ofono_cdma_connman_driver *d);
+
+struct ofono_cdma_connman *ofono_cdma_connman_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver,
+						void *data);
+
+void ofono_cdma_connman_register(struct ofono_cdma_connman *cm);
+void ofono_cdma_connman_remove(struct ofono_cdma_connman *cm);
+
+void ofono_cdma_connman_set_data(struct ofono_cdma_connman *cm,
+						void *data);
+void *ofono_cdma_connman_get_data(struct ofono_cdma_connman *cm);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_CONNMAN_H */
-- =

1.7.0.4


--===============3633608578359492616==--

