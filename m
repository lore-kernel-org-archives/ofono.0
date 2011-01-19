Content-Type: multipart/mixed; boundary="===============3346579190349710959=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] Add the sim-auth atom.
Date: Wed, 19 Jan 2011 09:07:57 +0100
Message-ID: <1295424478-12049-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1295424478-12049-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3346579190349710959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add dummy SIM authentication atom.
---
 Makefile.am    |    2 +-
 src/ofono.h    |    2 +
 src/sim-auth.c |  134 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 137 insertions(+), 1 deletions(-)
 create mode 100644 src/sim-auth.c

diff --git a/Makefile.am b/Makefile.am
index 7ea1b2d..10892a6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -353,7 +353,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
-			src/cdma-voicecall.c
+			src/cdma-voicecall.c src/sim-auth.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/ofono.h b/src/ofono.h
index badc2ee..e48dbf6 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -127,6 +127,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_NETTIME,
 	OFONO_ATOM_TYPE_CTM,
 	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER,
+	OFONO_ATOM_TYPE_SIM_AUTH,
 };
 =

 enum ofono_atom_watch_condition {
@@ -418,3 +419,4 @@ void __ofono_nettime_info_received(struct ofono_modem *=
modem,
 					struct ofono_network_time *info);
 =

 #include <ofono/cdma-voicecall.h>
+#include <ofono/sim-auth.h>
diff --git a/src/sim-auth.c b/src/sim-auth.c
new file mode 100644
index 0000000..5d2f075
--- /dev/null
+++ b/src/sim-auth.c
@@ -0,0 +1,134 @@
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
+#define _GNU_SOURCE
+
+#include <glib.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include "ofono.h"
+
+#include "simutil.h"
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_sim_auth {
+	const struct ofono_sim_auth_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
+
+	return 0;
+}
+
+void ofono_sim_auth_driver_unregister(const struct ofono_sim_auth_driver *=
d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
+static void sim_auth_unregister(struct ofono_atom *atom)
+{
+}
+
+static void sim_auth_remove(struct ofono_atom *atom)
+{
+	struct ofono_sim_auth *sa =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (sa =3D=3D NULL)
+		return;
+
+	if (sa->driver && sa->driver->remove)
+		sa->driver->remove(sa);
+
+	g_free(sa);
+}
+
+struct ofono_sim_auth *ofono_sim_auth_create(struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver, void *data)
+{
+	struct ofono_sim_auth *sa;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	sa =3D g_try_new0(struct ofono_sim_auth, 1);
+
+	if (sa =3D=3D NULL)
+		return NULL;
+
+	sa->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_SIM_AUTH,
+						sim_auth_remove, sa);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_sim_auth_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(sa, vendor, data) < 0)
+			continue;
+
+		sa->driver =3D drv;
+		break;
+	}
+
+	return sa;
+}
+
+void ofono_sim_auth_register(struct ofono_sim_auth *sa)
+{
+	__ofono_atom_register(sa->atom, sim_auth_unregister);
+}
+
+void ofono_sim_auth_remove(struct ofono_sim_auth *sa)
+{
+	__ofono_atom_free(sa->atom);
+}
+
+void ofono_sim_auth_set_data(struct ofono_sim_auth *sa, void *data)
+{
+	sa->driver_data =3D data;
+}
+
+void *ofono_sim_auth_get_data(struct ofono_sim_auth *sa)
+{
+	return sa->driver_data;
+}
-- =

1.7.1.86.g0e460.dirty


--===============3346579190349710959==--

