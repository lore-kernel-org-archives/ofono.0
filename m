Content-Type: multipart/mixed; boundary="===============5006139604241746661=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 1/2] include: Add storage.h
Date: Mon, 27 Nov 2017 12:31:38 +0200
Message-ID: <1511778699-32054-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5006139604241746661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To expose ofono directories to dynamically loadable plugins.
---
 Makefile.am       |  3 ++-
 include/storage.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 include/storage.h

diff --git a/Makefile.am b/Makefile.am
index 903630b..f58cc92 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,7 +22,8 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/private-network.h include/cdma-netreg.h \
 			include/cdma-provision.h include/handsfree.h \
 			include/handsfree-audio.h include/siri.h \
-			include/netmon.h include/lte.h include/ims.h
+			include/netmon.h include/lte.h include/ims.h \
+			include/storage.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/storage.h b/include/storage.h
new file mode 100644
index 0000000..243eb88
--- /dev/null
+++ b/include/storage.h
@@ -0,0 +1,32 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2017  Jolla Ltd. All rights reserved.
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
+ */
+
+#ifndef __OFONO_STORAGE_H
+#define __OFONO_STORAGE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+const char *ofono_config_dir(void);
+const char *ofono_storage_dir(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_STORAGE_H */
-- =

1.9.1


--===============5006139604241746661==--

