Content-Type: multipart/mixed; boundary="===============4487076561497304584=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 02/16] elect: Add D-Bus error messages
Date: Tue, 13 Dec 2011 15:59:56 +0100
Message-ID: <1323788410-9988-3-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4487076561497304584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am   |    2 +-
 elect/dbus.c  |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 elect/elect.h |    4 ++++
 3 files changed, 57 insertions(+), 1 deletions(-)
 create mode 100644 elect/dbus.c

diff --git a/Makefile.am b/Makefile.am
index 5b7f5ed..38e5d90 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -653,7 +653,7 @@ sbin_PROGRAMS +=3D elect/electd
 =

 elect_electd_SOURCES =3D $(gdbus_sources) \
 			src/log.c src/dbus.c \
-			elect/main.c
+			elect/main.c elect/dbus.c
 =

 elect_electd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LI=
BS@ -ldl
 =

diff --git a/elect/dbus.c b/elect/dbus.c
new file mode 100644
index 0000000..72da441
--- /dev/null
+++ b/elect/dbus.c
@@ -0,0 +1,52 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
+#include "elect.h"
+
+#define ELECT_ERROR_INTERFACE "org.ofono.elect.Error"
+
+DBusMessage *__elect_error_invalid_args(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ELECT_ERROR_INTERFACE
+					".InvalidArguments",
+					"Invalid arguments in method call");
+}
+
+DBusMessage *__elect_error_failed(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ELECT_ERROR_INTERFACE
+					".Failed",
+					"Operation failed");
+}
+
+DBusMessage *__elect_error_connection_refused(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ELECT_ERROR_INTERFACE
+					".ConnectionRefused",
+					"Connection Refused");
+}
diff --git a/elect/elect.h b/elect/elect.h
index 8786240..7338c18 100644
--- a/elect/elect.h
+++ b/elect/elect.h
@@ -44,3 +44,7 @@ int __ofono_dbus_init(DBusConnection *conn);
 void __ofono_dbus_cleanup(void);
 =

 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
+
+DBusMessage *__elect_error_invalid_args(DBusMessage *msg);
+DBusMessage *__elect_error_failed(DBusMessage *msg);
+DBusMessage *__elect_error_connection_refused(DBusMessage *msg);
-- =

1.7.8.110.g4cb5d1


--===============4487076561497304584==--

