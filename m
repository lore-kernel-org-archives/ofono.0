Content-Type: multipart/mixed; boundary="===============3283397188169714963=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 4/6] hfp_hf: Add initial file for external HFP
Date: Wed, 16 Jan 2013 10:31:29 -0300
Message-ID: <1358343091-23350-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358343091-23350-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3283397188169714963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the initial file to support external HFP profile and
BlueZ 5. "hfp_bluez5" plugin will implement an external Bluetooth
profile compatible with BlueZ 5, and "hfp" plugin will keep the
compatibility with BlueZ 4.
---
 Makefile.am             |  3 +++
 plugins/hfp_hf_bluez5.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 plugins/hfp_hf_bluez5.c

diff --git a/Makefile.am b/Makefile.am
index 3c4b588..072b386 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -436,6 +436,9 @@ builtin_libadd +=3D @BLUEZ_LIBS@
 else
 builtin_modules +=3D bluez5
 builtin_sources +=3D plugins/bluez5.c
+
+builtin_modules +=3D hfp_bluez5
+builtin_sources +=3D plugins/hfp_hf_bluez5.c
 endif
 endif
 endif
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
new file mode 100644
index 0000000..779f05d
--- /dev/null
+++ b/plugins/hfp_hf_bluez5.c
@@ -0,0 +1,42 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2013 Intel Corporation. All rights reserved.
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
+static int hfp_init(void)
+{
+	return 0;
+}
+
+static void hfp_exit(void)
+{
+}
+
+OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", VERS=
ION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, hfp_init, hfp_exit)
-- =

1.7.11.7


--===============3283397188169714963==--

