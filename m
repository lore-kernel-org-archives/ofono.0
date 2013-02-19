Content-Type: multipart/mixed; boundary="===============7094441791705522074=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 01/11] hfp_audio: Adds initial plugin files
Date: Tue, 19 Feb 2013 17:44:42 -0300
Message-ID: <1361306692-959-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7094441791705522074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a plugin related to a new experimental Handsfree Audio
interface. HF and AG will expose Handsfree Audio Cards to a Handfree
Audio Agent.
---
 Makefile.am         |  3 +++
 plugins/hfp_audio.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 plugins/hfp_audio.c

diff --git a/Makefile.am b/Makefile.am
index ef4d314..8fc6dca 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -434,6 +434,9 @@ builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
 else
+builtin_modules +=3D hfp_audio
+builtin_sources +=3D plugins/hfp_audio.c
+
 builtin_modules +=3D bluez5
 builtin_sources +=3D plugins/bluez5.c plugins/bluez5.h
 =

diff --git a/plugins/hfp_audio.c b/plugins/hfp_audio.c
new file mode 100644
index 0000000..e90d35b
--- /dev/null
+++ b/plugins/hfp_audio.c
@@ -0,0 +1,32 @@
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
+#include <stdio.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+
+OFONO_PLUGIN_DEFINE(hfp_audio, "Handsfree Audio Plugin", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
-- =

1.7.11.7


--===============7094441791705522074==--

