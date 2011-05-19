Content-Type: multipart/mixed; boundary="===============0651761817168802618=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 3/5] private-network: add request/release functions and new
 feature to Makefile.am
Date: Thu, 19 May 2011 11:55:32 +0200
Message-ID: <1305798934-14242-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305798934-14242-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0651761817168802618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    3 +-
 src/ofono.h           |    6 +++
 src/private-network.c |   91 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 99 insertions(+), 1 deletions(-)
 create mode 100644 src/private-network.c

diff --git a/Makefile.am b/Makefile.am
index d7e5626..e1eaf15 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -387,7 +387,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/message.h src/message.c src/gprs-provision.c \
 			src/emulator.c src/location-reporting.c \
 			src/cdma-connman.c src/gnss.c \
-			src/gnssagent.c src/gnssagent.h
+			src/gnssagent.c src/gnssagent.h \
+			src/private-network.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/ofono.h b/src/ofono.h
index 82d7e34..7353022 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -468,3 +468,9 @@ void __ofono_gprs_provision_free_settings(
 =

 #include <ofono/emulator.h>
 #include <ofono/gnss.h>
+#include <ofono/private-network.h>
+
+void __ofono_private_network_release(int id);
+ofono_bool_t __ofono_private_network_request(ofono_private_network_cb_t cb,
+						void *data, int *id);
+
diff --git a/src/private-network.c b/src/private-network.c
new file mode 100644
index 0000000..e955656
--- /dev/null
+++ b/src/private-network.c
@@ -0,0 +1,91 @@
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
+
+static GSList *g_drivers =3D NULL;
+
+void __ofono_private_network_release(int id)
+{
+	GSList *d;
+
+	DBG("");
+
+	for (d =3D g_drivers; d; d =3D d->next) {
+		const struct ofono_private_network_driver *driver =3D d->data;
+
+		if (!driver->release)
+			continue;
+
+		driver->release(id);
+
+		break;
+	}
+}
+
+ofono_bool_t __ofono_private_network_request(ofono_private_network_cb_t cb,
+						void *data, int *id)
+{
+	GSList *d;
+	int uid;
+
+	DBG("");
+
+	for (d =3D g_drivers; d; d =3D d->next) {
+		const struct ofono_private_network_driver *driver =3D d->data;
+
+		if (!driver->request)
+			continue;
+
+		uid =3D driver->request(cb, data);
+		if (uid <=3D 0)
+			continue;
+
+		*id =3D uid;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+int ofono_private_network_driver_register(
+			const struct ofono_private_network_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
+
+	return 0;
+}
+
+void ofono_private_network_driver_unregister(
+			const struct ofono_private_network_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
-- =

1.7.1


--===============0651761817168802618==--

