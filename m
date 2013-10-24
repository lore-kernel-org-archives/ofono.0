Content-Type: multipart/mixed; boundary="===============3887177659483084582=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 3/4] sim: Glue for making mnclength plugin reachable
Date: Thu, 24 Oct 2013 13:03:15 +0200
Message-ID: <1382612595-29628-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3887177659483084582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |  7 ++++--
 src/sim-mnclength.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100644 src/sim-mnclength.c

diff --git a/Makefile.am b/Makefile.am
index 21e8b68..167a350 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -21,7 +21,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/cdma-connman.h include/gnss.h \
 			include/private-network.h include/cdma-netreg.h \
 			include/cdma-provision.h include/handsfree.h \
-			include/handsfree-audio.h
+			include/handsfree-audio.h include/sim-mnclength.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

@@ -463,6 +463,9 @@ builtin_sources +=3D plugins/provision.c
 =

 builtin_modules +=3D cdma_provision
 builtin_sources +=3D plugins/cdma-provision.c
+
+builtin_modules +=3D mnclength
+builtin_sources +=3D plugins/mnclength.c
 endif
 =

 if MAINTAINER_MODE
@@ -518,7 +521,7 @@ src_ofonod_SOURCES =3D $(builtin_sources) src/ofono.ver=
 \
 			src/cdma-sms.c src/private-network.c src/cdma-netreg.c \
 			src/cdma-provision.c src/handsfree.c \
 			src/handsfree-audio.c src/bluetooth.h \
-			src/hfp.h
+			src/hfp.h src/sim-mnclength.c
 =

 src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
diff --git a/src/sim-mnclength.c b/src/sim-mnclength.c
new file mode 100644
index 0000000..9ff6409
--- /dev/null
+++ b/src/sim-mnclength.c
@@ -0,0 +1,70 @@
+/*
+ *
+ *  oFono - Open Source Telephony
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include <glib.h>
+#include "ofono.h"
+#include "sim-mnclength.h"
+
+static GSList *g_drivers =3D NULL;
+
+int __ofono_sim_mnclength_get_mnclength(const char *imsi)
+{
+	GSList *d;
+	int mnclen;
+
+	for (d =3D g_drivers; d !=3D NULL; d =3D d->next) {
+		const struct ofono_sim_mnclength_driver *driver =3D d->data;
+
+		if (driver->get_mnclength =3D=3D NULL)
+			continue;
+
+		DBG("Calling mnclength plugin '%s'", driver->name);
+
+		if ((mnclen =3D driver->get_mnclength(imsi)) <=3D 0)
+			continue;
+
+		return mnclen;
+	}
+
+	return 0;
+}
+
+int ofono_sim_mnclength_driver_register(
+			struct ofono_sim_mnclength_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_prepend(g_drivers, driver);
+	return 0;
+}
+
+void ofono_sim_mnclength_driver_unregister(
+			const struct ofono_sim_mnclength_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, driver);
+}
-- =

1.8.3.2


--===============3887177659483084582==--

