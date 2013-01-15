Content-Type: multipart/mixed; boundary="===============4311255994492896480=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 3/6] bluetooth: Initial files for BlueZ 5
Date: Tue, 15 Jan 2013 15:24:45 -0300
Message-ID: <1358274288-24857-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358274288-24857-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4311255994492896480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the file for Bluetooth(BlueZ 5) oFono plugin.
---
 Makefile.am      |  5 +++++
 plugins/bluez5.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 plugins/bluez5.c

diff --git a/Makefile.am b/Makefile.am
index 85824be..2f50673 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -407,6 +407,11 @@ builtin_sources +=3D plugins/samsung.c
 builtin_modules +=3D sim900
 builtin_sources +=3D plugins/sim900.c
 =

+if BLUEZ5
+builtin_modules +=3D bluez5
+builtin_sources +=3D plugins/bluez5.c
+endif
+
 if BLUEZ4
 builtin_modules +=3D bluez4
 builtin_sources +=3D plugins/bluez4.c plugins/bluez4.h
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


--===============4311255994492896480==--

