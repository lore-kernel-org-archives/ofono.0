Content-Type: multipart/mixed; boundary="===============0381680439267116750=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v6 06/14] huaweicdmamodem: create a huawei cdma driver.
Date: Fri, 05 Aug 2011 15:21:07 +0200
Message-ID: <1312550475-8537-7-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312550475-8537-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0381680439267116750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                               |    5 +++
 drivers/huaweicdmamodem/huaweicdmamodem.c |   42 +++++++++++++++++++++++++=
++++
 drivers/huaweicdmamodem/huaweicdmamodem.h |   21 ++++++++++++++
 3 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.c
 create mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.h

diff --git a/Makefile.am b/Makefile.am
index 238771c..1c424ca 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -277,6 +277,11 @@ builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
 			drivers/cdmamodem/voicecall.c \
 			drivers/cdmamodem/devinfo.c \
 			drivers/cdmamodem/connman.c
+
+builtin_modules +=3D huaweicdmamodem
+builtin_sources +=3D drivers/huaweicdmamodem/huaweicdmamodem.h \
+			drivers/huaweicdmamodem/huaweicdmamodem.c
+
 endif
 =

 builtin_modules +=3D g1
diff --git a/drivers/huaweicdmamodem/huaweicdmamodem.c b/drivers/huaweicdma=
modem/huaweicdmamodem.c
new file mode 100644
index 0000000..d9e7943
--- /dev/null
+++ b/drivers/huaweicdmamodem/huaweicdmamodem.c
@@ -0,0 +1,42 @@
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
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+
+#include "huaweicdmamodem.h"
+
+static int huaweicdmamodem_init(void)
+{
+	return 0;
+}
+
+static void huaweicdmamodem_exit(void)
+{
+}
+
+OFONO_PLUGIN_DEFINE(huaweicdmamodem, "Huawei CDMA modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			huaweicdmamodem_init, huaweicdmamodem_exit)
diff --git a/drivers/huaweicdmamodem/huaweicdmamodem.h b/drivers/huaweicdma=
modem/huaweicdmamodem.h
new file mode 100644
index 0000000..018747f
--- /dev/null
+++ b/drivers/huaweicdmamodem/huaweicdmamodem.h
@@ -0,0 +1,21 @@
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
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============0381680439267116750==--

