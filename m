Content-Type: multipart/mixed; boundary="===============4256351253421620260=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v7 05/16] dundee: Add D-Bus error messages
Date: Tue, 22 May 2012 18:33:13 +0200
Message-ID: <1337704404-5260-6-git-send-email-wagi@monom.org>
In-Reply-To: <1337704404-5260-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4256351253421620260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am     |    2 +-
 dundee/dbus.c   |   45 +++++++++++++++++++++++++++++++++++++++++++++
 dundee/dundee.h |    3 +++
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 dundee/dbus.c

diff --git a/Makefile.am b/Makefile.am
index 9925435..068e4e8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -689,7 +689,7 @@ sbin_PROGRAMS +=3D dundee/dundee
 =

 dundee_dundee_SOURCES =3D $(gdbus_sources) \
 			src/log.c src/dbus.c \
-			dundee/dundee.h dundee/main.c
+			dundee/dundee.h dundee/main.c dundee/dbus.c
 =

 dundee_dundee_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_L=
IBS@ -ldl
 =

diff --git a/dundee/dbus.c b/dundee/dbus.c
new file mode 100644
index 0000000..c245eab
--- /dev/null
+++ b/dundee/dbus.c
@@ -0,0 +1,45 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2012  BMW Car IT GmbH. All rights reserved.
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
+#include <glib.h>
+#include <gdbus.h>
+
+#include "dundee.h"
+
+#define DUNDEE_ERROR_INTERFACE "org.ofono.dundee.Error"
+
+DBusMessage *__dundee_error_invalid_args(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, DUNDEE_ERROR_INTERFACE
+					".InvalidArguments",
+					"Invalid arguments in method call");
+}
+
+DBusMessage *__dundee_error_failed(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, DUNDEE_ERROR_INTERFACE
+					".Failed",
+					"Operation failed");
+}
diff --git a/dundee/dundee.h b/dundee/dundee.h
index c4c9800..c972af0 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -44,3 +44,6 @@ int __ofono_dbus_init(DBusConnection *conn);
 void __ofono_dbus_cleanup(void);
 =

 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
+
+DBusMessage *__dundee_error_invalid_args(DBusMessage *msg);
+DBusMessage *__dundee_error_failed(DBusMessage *msg);
-- =

1.7.10.130.g36e6c


--===============4256351253421620260==--

