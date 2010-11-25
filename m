Content-Type: multipart/mixed; boundary="===============7245313003525743823=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/5] text-telephony: add public header
Date: Thu, 25 Nov 2010 15:41:56 -0200
Message-ID: <1290706920-24740-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7245313003525743823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am   |    3 +-
 include/ctm.h |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 73 insertions(+), 1 deletions(-)
 create mode 100644 include/ctm.h

diff --git a/Makefile.am b/Makefile.am
index f841b4c..2615be7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,8 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/cbs.h include/call-volume.h \
 			include/gprs.h include/gprs-context.h \
 			include/radio-settings.h include/stk.h \
-			include/audio-settings.h include/nettime.h
+			include/audio-settings.h include/nettime.h \
+			include/ctm.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

diff --git a/include/ctm.h b/include/ctm.h
new file mode 100644
index 0000000..4b07192
--- /dev/null
+++ b/include/ctm.h
@@ -0,0 +1,71 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CTM_H
+#define __OFONO_CTM_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_ctm;
+
+typedef void (*ofono_ctm_set_cb_t)(const struct ofono_error *error,
+					void *data);
+typedef void (*ofono_ctm_query_cb_t)(const struct ofono_error *error,
+					ofono_bool_t enable, void *data);
+
+struct ofono_ctm_driver {
+	const char *name;
+	int (*probe)(struct ofono_ctm *tt, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_ctm *tt);
+	void (*query_tty)(struct ofono_ctm *tt,
+				ofono_ctm_query_cb_t cb,
+				void *data);
+	void (*set_tty)(struct ofono_ctm *tt,
+				int enable,
+				ofono_ctm_set_cb_t cb,
+				void *data);
+};
+
+int ofono_ctm_driver_register(const struct ofono_ctm_driver *d);
+void ofono_ctm_driver_unregister(const struct ofono_ctm_driver *d);
+
+struct ofono_ctm *ofono_ctm_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver,
+					void *data);
+
+void ofono_ctm_register(struct ofono_ctm *tt);
+void ofono_ctm_remove(struct ofono_ctm *tt);
+
+void ofono_ctm_set_data(struct ofono_ctm *tt, void *data);
+void *ofono_ctm_get_data(struct ofono_ctm *tt);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_TEXT_TELEPHONY_H */
-- =

1.7.3.2


--===============7245313003525743823==--

