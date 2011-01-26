Content-Type: multipart/mixed; boundary="===============0344176625730312160=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v3 1/7] gps: add public header
Date: Wed, 26 Jan 2011 12:32:48 -0300
Message-ID: <1296055974-9640-2-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1296055974-9640-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0344176625730312160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am   |    2 +-
 include/gps.h |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 77 insertions(+), 1 deletions(-)
 create mode 100644 include/gps.h

diff --git a/Makefile.am b/Makefile.am
index 9933e32..7374f70 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
-			include/cdma-sms.h include/sim-auth.h
+			include/cdma-sms.h include/sim-auth.h include/gps.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/gps.h b/include/gps.h
new file mode 100644
index 0000000..c70e90f
--- /dev/null
+++ b/include/gps.h
@@ -0,0 +1,76 @@
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
+enum ofono_gps_device_type {
+	OFONO_GPS_DEVICE_TYPE_NMEA =3D 0,
+};
+
+typedef void (*ofono_gps_enable_cb_t)(const struct ofono_error *error,
+					int fd,
+					void *data);
+typedef void (*ofono_gps_disable_cb_t)(const struct ofono_error *error,
+								void *data);
+
+struct ofono_gps_driver {
+	const char *name;
+	enum ofono_gps_device_type type;
+	int (*probe)(struct ofono_gps *gps, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_gps *gps);
+	void (*enable)(struct ofono_gps *gps,
+					ofono_gps_enable_cb_t cb, void *data);
+	void (*disable)(struct ofono_gps *gps,
+					ofono_gps_disable_cb_t cb, void *data);
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
+int ofono_gps_get_fd(struct ofono_gps *gps);
+
+struct ofono_modem *ofono_gps_get_modem(struct ofono_gps *gps);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_GPS_H */
-- =

1.7.2.3


--===============0344176625730312160==--

