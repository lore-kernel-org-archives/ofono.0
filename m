Content-Type: multipart/mixed; boundary="===============3496195467758761766=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 3/7] cdma-netreg: Add Signal Strength Support
Date: Tue, 08 Feb 2011 13:04:56 -0800
Message-ID: <1297199100-2712-4-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3496195467758761766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    2 +-
 include/cdma-netreg.h |   77 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 78 insertions(+), 1 deletions(-)
 create mode 100644 include/cdma-netreg.h

diff --git a/Makefile.am b/Makefile.am
index 758fb10..93550d0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,7 +14,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
 			include/cdma-sms.h include/sim-auth.h \
-			include/gprs-provision.h
+			include/gprs-provision.h include/cdma-netreg.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/cdma-netreg.h b/include/cdma-netreg.h
new file mode 100644
index 0000000..4472a89
--- /dev/null
+++ b/include/cdma-netreg.h
@@ -0,0 +1,77 @@
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
+#ifndef __OFONO_CDMA_NETREG_H
+#define __OFONO_CDMA_NETREG_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cdma_netreg;
+
+typedef void (*ofono_cdma_netreg_strength_cb_t)(
+					const struct ofono_error *error,
+					int strength, void *data);
+
+/*
+ * Network related functions, including registration status, operator sele=
ction
+ * and signal strength indicators.
+ */
+struct ofono_cdma_netreg_driver {
+	const char *name;
+	int (*probe)(struct ofono_cdma_netreg *netreg, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_cdma_netreg *netreg);
+	void (*strength)(struct ofono_cdma_netreg *netreg,
+			ofono_cdma_netreg_strength_cb_t, void *data);
+};
+
+/*
+ * It is the plugin's responsibility to implement CSQ polling if the modem
+ * does not support vendor extensions for signal strength notification.
+ */
+void ofono_cdma_netreg_strength_notify(struct ofono_cdma_netreg *netreg,
+					int strength);
+
+int ofono_cdma_netreg_driver_register(
+				const struct ofono_cdma_netreg_driver *d);
+void ofono_cdma_netreg_driver_unregister(
+				const struct ofono_cdma_netreg_driver *d);
+
+struct ofono_cdma_netreg *ofono_cdma_netreg_create(struct ofono_modem *mod=
em,
+							unsigned int vendor,
+							const char *driver,
+							void *data);
+
+void ofono_cdma_netreg_register(struct ofono_cdma_netreg *netreg);
+void ofono_cdma_netreg_remove(struct ofono_cdma_netreg *netreg);
+
+void ofono_cdma_netreg_set_data(struct ofono_cdma_netreg *netreg, void *da=
ta);
+void *ofono_cdma_netreg_get_data(struct ofono_cdma_netreg *netreg);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_NETREG_H */
-- =

1.7.0.4


--===============3496195467758761766==--

