Content-Type: multipart/mixed; boundary="===============0851208648886760904=="
MIME-Version: 1.0
From: KrzysztofX Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 3/8] include: Add Siri interface definition
Date: Mon, 16 Dec 2013 17:52:39 +0000
Message-ID: <1387216364-7138-4-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1387216364-7138-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0851208648886760904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |  2 +-
 include/siri.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100755 include/siri.h

diff --git a/Makefile.am b/Makefile.am
index b89352e..cd84c14 100755
--- a/Makefile.am
+++ b/Makefile.am
@@ -21,7 +21,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/cdma-connman.h include/gnss.h \
 			include/private-network.h include/cdma-netreg.h \
 			include/cdma-provision.h include/handsfree.h \
-			include/handsfree-audio.h
+			include/handsfree-audio.h include/siri.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/siri.h b/include/siri.h
new file mode 100755
index 0000000..4199da1
--- /dev/null
+++ b/include/siri.h
@@ -0,0 +1,65 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2013  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_SIRI_H
+#define __OFONO_SIRI_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_siri;
+
+typedef void (*ofono_siri_cb_t)(const struct ofono_error *error,
+					struct ofono_siri *siri);
+
+struct ofono_siri_driver {
+	const char *name;
+	int (*probe)(struct ofono_siri *siri, unsigned int vendor,
+				void *data);
+	void (*remove)(struct ofono_siri *siri);
+	void (*set_eyes_free_mode) (struct ofono_siri *siri,
+				ofono_siri_cb_t cb,
+				unsigned int val);
+};
+
+void ofono_siri_set_status(struct ofono_siri *siri, int value);
+
+int ofono_siri_driver_register(const struct ofono_siri_driver *driver);
+void ofono_siri_driver_unregister(const struct ofono_siri_driver *driver);
+
+struct ofono_siri *ofono_siri_create(struct ofono_modem *modem,
+			unsigned int vendor, const char *driver, void *data);
+
+void ofono_siri_register(struct ofono_siri *siri);
+void ofono_siri_remove(struct ofono_siri *siri);
+
+void ofono_siri_set_data(struct ofono_siri *siri, void *data);
+void *ofono_siri_get_data(struct ofono_siri *siri);
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_SIRI_H */
-- =

1.7.11.7


--===============0851208648886760904==--

