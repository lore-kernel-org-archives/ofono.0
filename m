Content-Type: multipart/mixed; boundary="===============4817107053710394645=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 3/6] bluetooth: Initial files for BlueZ 5
Date: Wed, 16 Jan 2013 10:31:28 -0300
Message-ID: <1358343091-23350-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358343091-23350-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4817107053710394645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the file for Bluetooth(BlueZ 5) oFono plugin.
---
 Makefile.am      |  3 +++
 plugins/bluez5.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 plugins/bluez5.c

diff --git a/Makefile.am b/Makefile.am
index 63e6fdb..3c4b588 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -433,6 +433,9 @@ builtin_sources +=3D plugins/connman.c
 builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
+else
+builtin_modules +=3D bluez5
+builtin_sources +=3D plugins/bluez5.c
 endif
 endif
 endif
diff --git a/plugins/bluez5.c b/plugins/bluez5.c
new file mode 100644
index 0000000..335331c
--- /dev/null
+++ b/plugins/bluez5.c
@@ -0,0 +1,33 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+
+OFONO_PLUGIN_DEFINE(bluez5, "BlueZ 5 Utils Plugin", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
-- =

1.7.11.7


--===============4817107053710394645==--

