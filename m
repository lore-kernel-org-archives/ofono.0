Content-Type: multipart/mixed; boundary="===============6280233005046419139=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 3/5] gprs-provision: add driver API sources
Date: Wed, 26 Jan 2011 14:34:13 +0200
Message-ID: <1296045255-29890-4-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1296045255-29890-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6280233005046419139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    2 +-
 src/gprs-provision.c |  104 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 105 insertions(+), 1 deletions(-)
 create mode 100644 src/gprs-provision.c

diff --git a/Makefile.am b/Makefile.am
index f543135..9c4f383 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -356,7 +356,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
 			src/cdma-voicecall.c src/sim-auth.c \
-			src/message.h src/message.c
+			src/message.h src/message.c src/gprs-provision.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/gprs-provision.c b/src/gprs-provision.c
new file mode 100644
index 0000000..cc1f589
--- /dev/null
+++ b/src/gprs-provision.c
@@ -0,0 +1,104 @@
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
+
+static GSList *g_drivers =3D NULL;
+
+void  __ofono_gprs_provision_free_settings(
+				struct ofono_gprs_provision_data *settings,
+				int count)
+{
+	int i;
+
+	for (i =3D 0; i < count; i++) {
+		g_free(settings[i].name);
+		g_free(settings[i].apn);
+		g_free(settings[i].username);
+		g_free(settings[i].password);
+		g_free(settings[i].message_proxy);
+		g_free(settings[i].message_center);
+	}
+
+	g_free(settings);
+}
+
+void __ofono_gprs_provision_get_settings(const char *mcc, const char *mnc,
+			struct ofono_gprs_provision_data **settings,
+			int *count)
+{
+	GSList *d;
+
+	*settings =3D NULL;
+	*count =3D 0;
+
+	if (mcc =3D=3D NULL || strlen(mcc) =3D=3D 0 || mnc =3D=3D NULL || strlen(=
mnc) =3D=3D 0)
+		return;
+
+	for (d =3D g_drivers; d !=3D NULL; d =3D d->next) {
+		const struct ofono_gprs_provision_driver *driver =3D d->data;
+
+		DBG("Calling provisioning plugin '%s'", driver->name);
+
+		driver->get_settings(mcc, mnc, settings, count);
+
+		if (*count > 0) {
+			DBG("Plugin '%s' returned %d context settings",
+				driver->name, *count);
+			return;
+		}
+
+		ofono_warn("Provisioning plugin '%s' returned no settings",
+			driver->name);
+	}
+}
+
+static gint compare_priority(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_gprs_provision_driver *plugin1 =3D a;
+	const struct ofono_gprs_provision_driver *plugin2 =3D b;
+
+	return plugin2->priority - plugin1->priority;
+}
+
+int ofono_gprs_provision_driver_register(
+			const struct ofono_gprs_provision_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_insert_sorted(g_drivers, (void *) driver,
+						compare_priority);
+	return 0;
+}
+
+void ofono_gprs_provision_driver_unregister(
+			const struct ofono_gprs_provision_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, driver);
+}
-- =

1.7.1


--===============6280233005046419139==--

