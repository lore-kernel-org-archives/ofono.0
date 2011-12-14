Content-Type: multipart/mixed; boundary="===============7728327521856864693=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 03/10] cdma-provision: Add driver APIs implementation
Date: Wed, 14 Dec 2011 18:56:05 +0100
Message-ID: <1323885372-3574-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1323885372-3574-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7728327521856864693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    4 +-
 src/cdma-provision.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 src/cdma-provision.c

diff --git a/Makefile.am b/Makefile.am
index 337aeb7..f276a41 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -18,7 +18,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/location-reporting.h \
 			include/cdma-connman.h include/gnss.h \
 			include/private-network.h include/cdma-netreg.h \
-			include/handsfree.h
+			include/cdma-provision.h include/handsfree.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

@@ -430,7 +430,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/gnssagent.c src/gnssagent.h \
 			src/cdma-smsutil.h src/cdma-smsutil.c \
 			src/cdma-sms.c src/private-network.c src/cdma-netreg.c \
-			src/handsfree.c
+			src/cdma-provision.c src/handsfree.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/cdma-provision.c b/src/cdma-provision.c
new file mode 100644
index 0000000..33b31b0
--- /dev/null
+++ b/src/cdma-provision.c
@@ -0,0 +1,80 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 U=
SA
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
+
+static GSList *g_drivers =3D NULL;
+
+ofono_bool_t __ofono_cdma_provision_get_name(const char *sid, char **name)
+{
+	GSList *d;
+
+	if (sid =3D=3D NULL || strlen(sid) =3D=3D 0)
+		return FALSE;
+
+	for (d =3D g_drivers; d !=3D NULL; d =3D d->next) {
+		const struct ofono_cdma_provision_driver *driver =3D d->data;
+
+		if (driver->get_provider_name =3D=3D NULL)
+			continue;
+
+		DBG("Calling cdma provision plugin '%s'", driver->name);
+
+		if (driver->get_provider_name(sid, name) < 0)
+			continue;
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static gint compare_priority(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_cdma_provision_driver *plugin1 =3D a;
+	const struct ofono_cdma_provision_driver *plugin2 =3D b;
+
+	return plugin2->priority - plugin1->priority;
+}
+
+int ofono_cdma_provision_driver_register(
+		const struct ofono_cdma_provision_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_insert_sorted(g_drivers, (void *) driver,
+						compare_priority);
+	return 0;
+}
+
+void ofono_cdma_provision_driver_unregister(
+		const struct ofono_cdma_provision_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, driver);
+}
-- =

1.7.1


--===============7728327521856864693==--

