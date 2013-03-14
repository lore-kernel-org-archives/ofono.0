Content-Type: multipart/mixed; boundary="===============3711295044320263704=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 02/13] dundee: Start BlueZ 5 support
Date: Thu, 14 Mar 2013 10:32:43 -0300
Message-ID: <1363267974-13518-3-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363267974-13518-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3711295044320263704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the BlueZ 5 support file for dundee.
---
 Makefile.am     |   15 ++++++++++-----
 dundee/bluez5.c |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 5 deletions(-)
 create mode 100644 dundee/bluez5.c

diff --git a/Makefile.am b/Makefile.am
index 3a7a8dc..44cf7d7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -756,14 +756,12 @@ endif
 endif
 =

 if BLUETOOTH
-if BLUEZ4
 if DUNDEE
 sbin_PROGRAMS +=3D dundee/dundee
 =

-dundee_dundee_SOURCES =3D $(gdbus_sources) $(gatchat_sources) $(btio_sourc=
es) \
-			src/log.c src/dbus.c plugins/bluez4.c \
-			dundee/dundee.h dundee/main.c dundee/dbus.c \
-			dundee/manager.c dundee/device.c dundee/bluez4.c
+dundee_common_sources =3D $(gdbus_sources) $(gatchat_sources) \
+			src/log.c src/dbus.c dundee/dundee.h dundee/main.c \
+			dundee/dbus.c dundee/manager.c dundee/device.c
 =

 dundee_dundee_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -ldl
 =

@@ -774,6 +772,13 @@ if SYSTEMD
 systemdunit_DATA +=3D dundee/dundee.service
 endif
 endif
+
+if BLUEZ4
+dundee_dundee_SOURCES =3D $(dundee_common_sources) $(btio_sources) \
+			plugins/bluez4.c dundee/bluez4.c
+else
+dundee_dundee_SOURCES =3D $(dundee_common_sources) plugins/bluez5.c \
+			dundee/bluez5.c
 endif
 endif
 endif
diff --git a/dundee/bluez5.c b/dundee/bluez5.c
new file mode 100644
index 0000000..6685b4c
--- /dev/null
+++ b/dundee/bluez5.c
@@ -0,0 +1,37 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2013  Instituto Nokia de Tecnologia - INdT
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
+#include "dundee.h"
+
+int __dundee_bluetooth_init(void)
+{
+	DBG("");
+
+	return 0;
+}
+
+void __dundee_bluetooth_cleanup(void)
+{
+	DBG("");
+}
-- =

1.7.9.5


--===============3711295044320263704==--

