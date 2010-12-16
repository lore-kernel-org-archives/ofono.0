Content-Type: multipart/mixed; boundary="===============0929617303663376280=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 3/8] gps: add public header
Date: Thu, 16 Dec 2010 17:30:18 -0300
Message-ID: <1292531423-22316-4-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1292531423-22316-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0929617303663376280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am   |    2 +-
 include/gps.h |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 66 insertions(+), 1 deletions(-)
 create mode 100644 include/gps.h

diff --git a/Makefile.am b/Makefile.am
index 12b3c33..370f63e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,7 +14,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/gprs.h include/gprs-context.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
-			include/ctm.h
+			include/ctm.h include/gps.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

diff --git a/include/gps.h b/include/gps.h
new file mode 100644
index 0000000..31210a4
--- /dev/null
+++ b/include/gps.h
@@ -0,0 +1,65 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) 2010 ProFUSION embedded systems.
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
+#ifndef __OFONO_GPS_H
+#define __OFONO_GPS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_gps;
+
+typedef void (*ofono_gps_set_cb_t)(const struct ofono_error *error, void *=
data);
+typedef void (*ofono_gps_query_cb_t)(const struct ofono_error *error,
+					ofono_bool_t enable, void *data);
+
+struct ofono_gps_driver {
+	const char *name;
+	int (*probe)(struct ofono_gps *gps, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_gps *gps);
+	void (*set_gps)(struct ofono_gps *gps, ofono_bool_t enable,
+				ofono_gps_set_cb_t, void *data);
+	void (*query_gps)(struct ofono_gps *gps, ofono_gps_query_cb_t cb,
+				void *data);
+};
+
+int ofono_gps_driver_register(const struct ofono_gps_driver *d);
+void ofono_gps_driver_unregister(const struct ofono_gps_driver *d);
+
+struct ofono_gps *ofono_gps_create(struct ofono_modem *modem,
+					unsigned int vendor, const char *driver,
+					void *data);
+
+void ofono_gps_register(struct ofono_gps *gps);
+void ofono_gps_remove(struct ofono_gps *gps);
+
+void ofono_gps_set_data(struct ofono_gps *gps, void *data);
+void *ofono_gps_get_data(struct ofono_gps *gps);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_GPS_H */
-- =

1.7.2.3


--===============0929617303663376280==--

