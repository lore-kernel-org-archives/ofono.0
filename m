Content-Type: multipart/mixed; boundary="===============8585744667204079743=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 1/3] Add ZTE modem driver
Date: Fri, 23 Mar 2012 12:01:08 +0100
Message-ID: <1332500470-8297-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1332500470-8297-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8585744667204079743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                 |    5 ++++
 drivers/ztemodem/ztemodem.c |   46 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/ztemodem/ztemodem.h |   22 ++++++++++++++++++++
 3 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ztemodem/ztemodem.c
 create mode 100644 drivers/ztemodem/ztemodem.h

diff --git a/Makefile.am b/Makefile.am
index 760b62b..5c48222 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -191,6 +191,11 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/swmodem/swmodem.c \
 			drivers/swmodem/gprs-context.c
 =

+builtin_modules +=3D ztemodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/ztemodem/ztemodem.h \
+			drivers/ztemodem/ztemodem.c
+
 builtin_modules +=3D huaweimodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/huaweimodem/huaweimodem.h \
diff --git a/drivers/ztemodem/ztemodem.c b/drivers/ztemodem/ztemodem.c
new file mode 100644
index 0000000..729e911
--- /dev/null
+++ b/drivers/ztemodem/ztemodem.c
@@ -0,0 +1,46 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
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
+#include "ztemodem.h"
+
+static int ztemodem_init(void)
+{
+	return 0;
+}
+
+static void ztemodem_exit(void)
+{
+}
+
+OFONO_PLUGIN_DEFINE(ztemodem, "ZTE modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			ztemodem_init, ztemodem_exit)
diff --git a/drivers/ztemodem/ztemodem.h b/drivers/ztemodem/ztemodem.h
new file mode 100644
index 0000000..d88fb94
--- /dev/null
+++ b/drivers/ztemodem/ztemodem.h
@@ -0,0 +1,22 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
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

1.7.5.4

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

--===============8585744667204079743==--

