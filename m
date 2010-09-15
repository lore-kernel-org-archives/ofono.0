Content-Type: multipart/mixed; boundary="===============8877759349746527018=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [n900 PATCH 5/5] n900maemo: modem driver plugin for N900 with Maemo
Date: Wed, 15 Sep 2010 19:59:34 +0300
Message-ID: <1284569974-22505-6-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284569974-22505-5-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8877759349746527018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <ppessi@hamsa.research.nokia.com>

This modem plugin is used on N900 running Maemo userspace already
controlling the phonet link and the N900 modem (csd and sscd).

The plugin uses the isigen driver for the N900 internal modem.

The n900maemo is compiled (while the normal n900 modem driver is
disabled) if ofono is configured with with --enable-n900modem option.
---
 Makefile.am         |    9 +++++
 configure.ac        |    5 +++
 plugins/n900maemo.c |   99 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 113 insertions(+), 0 deletions(-)
 create mode 100644 plugins/n900maemo.c

diff --git a/Makefile.am b/Makefile.am
index d643ca8..23f0edb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -132,6 +132,8 @@ isigen_sources =3D plugins/isigen.c
 =

 n900_sources =3D plugins/n900.c plugins/n900gpio.h plugins/n900gpio.c
 =

+n900maemo_sources =3D plugins/n900maemo.c
+
 if ISIMODEM
 builtin_modules +=3D isimodem
 builtin_sources +=3D $(isimodem_sources)
@@ -139,8 +141,14 @@ builtin_sources +=3D $(isimodem_sources)
 builtin_modules +=3D isigen
 builtin_sources +=3D $(isigen_sources)
 =

+if !N900MAEMO
 builtin_modules +=3D n900
 builtin_sources +=3D $(n900_sources)
+else
+builtin_modules +=3D n900maemo
+builtin_sources +=3D $(n900maemo_sources)
+endif
+
 endif
 =

 if ATMODEM
@@ -389,6 +397,7 @@ EXTRA_DIST =3D src/genbuiltin plugins/example_history.c=
 $(doc_files) \
 				$(isimodem_sources) \
 				$(isigen_sources) \
 				$(n900_sources) \
+				$(n900maemo_sources) \
 				$(test_scripts) $(conf_files) $(udev_files)
 =

 dist_man_MANS =3D doc/ofonod.8
diff --git a/configure.ac b/configure.ac
index bd1dacb..c79a88b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -140,6 +140,11 @@ AC_ARG_ENABLE(isimodem, AC_HELP_STRING([--disable-isim=
odem],
 					[enable_isimodem=3D${enableval}])
 AM_CONDITIONAL(ISIMODEM, test "${enable_isimodem}" !=3D "no")
 =

+AC_ARG_ENABLE(n900maemo, AC_HELP_STRING([--enable-n900maemo],
+				[Enable support for N900 running Maemo]),
+					[enable_n900maemo=3D${enableval}])
+AM_CONDITIONAL(N900MAEMO, test "${enable_n900maemo}" =3D "yes")
+
 AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atmodem],
 				[disable ETSI AT modem support]),
 					[enable_atmodem=3D${enableval}])
diff --git a/plugins/n900maemo.c b/plugins/n900maemo.c
new file mode 100644
index 0000000..4728edb
--- /dev/null
+++ b/plugins/n900maemo.c
@@ -0,0 +1,99 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <glib.h>
+
+#include <gisi/client.h>
+#include <gisi/netlink.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+
+#include "drivers/isimodem/isimodem.h"
+#include "drivers/isimodem/debug.h"
+
+static GPhonetNetlink *link;
+
+/*
+ * Add or remove phonet0 interface is added/removed
+ */
+static void phonet0_status_cb(GIsiModem *idx,
+				GPhonetLinkState st,
+				char const ifname[],
+				void *data)
+{
+	struct ofono_modem *modem;
+	int error;
+
+	if (strcmp("phonet0", ifname))
+		return;
+
+	DBG("Phonet link %s (%u) is %s",
+		ifname, g_isi_modem_index(idx),
+		st =3D=3D PN_LINK_REMOVED ? "removed" :
+		st =3D=3D PN_LINK_DOWN ? "down" : "up");
+
+	if (st =3D=3D PN_LINK_REMOVED)
+		return;
+
+	if (g_pn_netlink_by_modem(idx)) {
+		DBG("Modem for interface %s already exists", ifname);
+		return;
+	}
+
+	modem =3D ofono_modem_create("n900", "isigen");
+	if (!modem)
+		return;
+
+	ofono_modem_set_string(modem, "Interface", ifname);
+
+	if (ofono_modem_register(modem) =3D=3D 0)
+		DBG("Done regging modem %s", ofono_modem_get_path(modem));
+	else
+		ofono_modem_remove(modem);
+}
+
+static int n900maemo_init(void)
+{
+	link =3D g_pn_netlink_start(NULL, phonet0_status_cb, NULL);
+
+	return 0;
+}
+
+static void n900maemo_exit(void)
+{
+	g_pn_netlink_stop(link);
+	link =3D NULL;
+}
+
+OFONO_PLUGIN_DEFINE(n900maemo, "Hotplug driver for N900 modem with Maemo",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			n900maemo_init, n900maemo_exit)
-- =

1.7.0.4


--===============8877759349746527018==--

