Content-Type: multipart/mixed; boundary="===============0972234409073253854=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v3, Part1, 3/5] cdmamodem: Add cdmamodem stubs
Date: Mon, 20 Dec 2010 17:36:35 -0800
Message-ID: <1292895397-11573-4-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0972234409073253854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                   |    6 +++++
 configure.ac                  |    5 ++++
 drivers/cdmamodem/cdmamodem.c |   45 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/cdmamodem/cdmamodem.h |   22 ++++++++++++++++++++
 4 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 drivers/cdmamodem/cdmamodem.c
 create mode 100644 drivers/cdmamodem/cdmamodem.h

diff --git a/Makefile.am b/Makefile.am
index 40ff52d..861237c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -242,6 +242,12 @@ conf_DATA +=3D plugins/phonesim.conf
 endif
 endif
 =

+if CDMA_ATMODEM
+builtin_modules +=3D cdma_atmodem
+builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
+			drivers/cdmamodem/cdmamodem.c
+endif
+
 builtin_modules +=3D g1
 builtin_sources +=3D plugins/g1.c
 =

diff --git a/configure.ac b/configure.ac
index 5c18f68..9cc0689 100644
--- a/configure.ac
+++ b/configure.ac
@@ -160,6 +160,11 @@ AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atmod=
em],
 					[enable_atmodem=3D${enableval}])
 AM_CONDITIONAL(ATMODEM, test "${enable_atmodem}" !=3D "no")
 =

+AC_ARG_ENABLE(cdmaatmodem, AC_HELP_STRING([--disable-cdmamodem],
+				[disable CDMA AT modem support]),
+					[enable_cdma_atmodem=3D${enableval}])
+AM_CONDITIONAL(CDMA_ATMODEM, test "${enable_cdma_atmodem}" !=3D "no")
+
 AC_ARG_ENABLE(phonesim, AC_HELP_STRING([--disable-phonesim],
 				[disable Phone simulator support]),
 					[enable_phonesim=3D${enableval}])
diff --git a/drivers/cdmamodem/cdmamodem.c b/drivers/cdmamodem/cdmamodem.c
new file mode 100644
index 0000000..25bd0f3
--- /dev/null
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -0,0 +1,45 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+
+#include "cdmamodem.h"
+
+static int cdma_atmodem_init(void)
+{
+	return 0;
+}
+
+static void cdma_atmodem_exit(void)
+{
+}
+
+OFONO_PLUGIN_DEFINE(cdma_atmodem, "CDMA AT modem driver", VERSION,
+	OFONO_PLUGIN_PRIORITY_DEFAULT, cdma_atmodem_init, cdma_atmodem_exit)
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
new file mode 100644
index 0000000..114d1fd
--- /dev/null
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -0,0 +1,22 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
+#include <drivers/atmodem/atutil.h>
-- =

1.7.0.4


--===============0972234409073253854==--

