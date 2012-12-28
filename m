Content-Type: multipart/mixed; boundary="===============1750404702821447564=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 1/8] sierramodem: Add skeleton for Sierra Wireless modem driver
Date: Fri, 28 Dec 2012 14:34:47 -0500
Message-ID: <20121228193447.GG18339@alittletooquiet.net>
In-Reply-To: <20121228193141.GF18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1750404702821447564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

---
 Makefile.am                       |    5 ++++
 drivers/sierramodem/sierramodem.c |   47 +++++++++++++++++++++++++++++++++=
++++
 drivers/sierramodem/sierramodem.h |   23 ++++++++++++++++++
 3 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 drivers/sierramodem/sierramodem.c
 create mode 100644 drivers/sierramodem/sierramodem.h

diff --git a/Makefile.am b/Makefile.am
index 0d2ba9f..ca488a7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -317,6 +317,11 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/speedupmodem/speedupmodem.c \
 			drivers/speedupmodem/ussd.c
 =

+builtin_modules +=3D sierramodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/sierramodem/sierramodem.h \
+			drivers/sierramodem/sierramodem.c
+
 if PHONESIM
 builtin_modules +=3D phonesim
 builtin_sources +=3D plugins/phonesim.c
diff --git a/drivers/sierramodem/sierramodem.c b/drivers/sierramodem/sierra=
modem.c
new file mode 100644
index 0000000..f31dd84
--- /dev/null
+++ b/drivers/sierramodem/sierramodem.c
@@ -0,0 +1,47 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  Outpost Embedded, LLC. All rights reserved.
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
+#include "sierramodem.h"
+
+static int sierramodem_init(void)
+{
+	return 0;
+}
+
+static void sierramodem_exit(void)
+{
+}
+
+OFONO_PLUGIN_DEFINE(sierramodem, "Sierra Wireless modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			sierramodem_init, sierramodem_exit)
diff --git a/drivers/sierramodem/sierramodem.h b/drivers/sierramodem/sierra=
modem.h
new file mode 100644
index 0000000..35e8b49
--- /dev/null
+++ b/drivers/sierramodem/sierramodem.h
@@ -0,0 +1,23 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  Outpost Embedded, LLC. All rights reserved.
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

--===============1750404702821447564==--

