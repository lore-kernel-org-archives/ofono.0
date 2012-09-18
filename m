Content-Type: multipart/mixed; boundary="===============6983887972898022629=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: [PATCH 01/11] build: Add skeleton for Samsung IPC modem driver
Date: Tue, 18 Sep 2012 20:18:45 +0200
Message-ID: <1347992335-9016-2-git-send-email-morphis@gravedo.de>
In-Reply-To: <1347992335-9016-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6983887972898022629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                               |    7 +++++
 configure.ac                              |    5 ++++
 drivers/samsungipcmodem/samsungipcmodem.c |   41 +++++++++++++++++++++++++=
++++
 drivers/samsungipcmodem/samsungipcmodem.h |   20 ++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 drivers/samsungipcmodem/samsungipcmodem.c
 create mode 100644 drivers/samsungipcmodem/samsungipcmodem.h

diff --git a/Makefile.am b/Makefile.am
index 40a83dc..4cfec6b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -181,6 +181,13 @@ builtin_modules +=3D gobi
 builtin_sources +=3D plugins/gobi.c
 endif
 =

+if SAMSUNGIPCMODEM
+builtin_modules +=3D samsungipcmodem
+builtin_sources +=3D \
+	drivers/samsungipcmodem/samsungipcmodem.c \
+	drivers/samsungipcmodem/samsungipcmodem.h
+endif
+
 if ATMODEM
 builtin_modules +=3D atmodem
 builtin_sources +=3D $(gatchat_sources) \
diff --git a/configure.ac b/configure.ac
index 2d6247d..3835d35 100644
--- a/configure.ac
+++ b/configure.ac
@@ -172,6 +172,11 @@ AC_ARG_ENABLE(qmimodem, AC_HELP_STRING([--disable-qmim=
odem],
 					[enable_qmimodem=3D${enableval}])
 AM_CONDITIONAL(QMIMODEM, test "${enable_qmimodem}" !=3D "no")
 =

+AC_ARG_ENABLE(samsungipc, AC_HELP_STRING([--disable-samsungipcmodem],
+				[disable Samsung IPC modem support]),
+					[enable_samsungipc=3D${enableval}])
+AM_CONDITIONAL(SAMSUNGIPCMODEM, test "${enable_samsungipc}" !=3D "no")
+
 AC_ARG_ENABLE(bluetooth, AC_HELP_STRING([--disable-bluetooth],
 				[disable Bluetooth modem support]),
 					[enable_bluetooth=3D${enableval}])
diff --git a/drivers/samsungipcmodem/samsungipcmodem.c b/drivers/samsungipc=
modem/samsungipcmodem.c
new file mode 100644
index 0000000..c302dfd
--- /dev/null
+++ b/drivers/samsungipcmodem/samsungipcmodem.c
@@ -0,0 +1,41 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2012 Simon Busch <morphis@gravedo.de>. All rights rese=
rved.
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
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+
+#include "samsungipcmodem.h"
+
+static int samsungipcmodem_init(void)
+{
+	return 0;
+}
+
+static void samsungipcmodem_exit(void)
+{
+}
+
+OFONO_PLUGIN_DEFINE(samsungipcmodem, "Samsung IPC modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, samsungipcmodem_init, samsungipcmodem_exi=
t)
diff --git a/drivers/samsungipcmodem/samsungipcmodem.h b/drivers/samsungipc=
modem/samsungipcmodem.h
new file mode 100644
index 0000000..3f9b386
--- /dev/null
+++ b/drivers/samsungipcmodem/samsungipcmodem.h
@@ -0,0 +1,20 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2012 Simon Busch <morphis@gravedo.de>. All rights rese=
rved.
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
-- =

1.7.9.5


--===============6983887972898022629==--

