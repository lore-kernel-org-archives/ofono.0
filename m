Content-Type: multipart/mixed; boundary="===============8029525971262945791=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 1/9] include: add header file for lte atom
Date: Wed, 09 Nov 2016 18:43:14 +0100
Message-ID: <1478713402-30780-2-git-send-email-dragos@endocode.com>
In-Reply-To: <1478713402-30780-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8029525971262945791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/lte.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 69 insertions(+)
 create mode 100644 include/lte.h

diff --git a/include/lte.h b/include/lte.h
new file mode 100644
index 0000000..8d73079
--- /dev/null
+++ b/include/lte.h
@@ -0,0 +1,69 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2016  Endocode AG. All rights reserved.
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
+#ifndef __OFONO_LTE_H
+#define __OFONO_LTE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_lte;
+
+struct ofono_lte_context_config {
+	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
+	enum ofono_gprs_proto proto;
+};
+
+typedef void (*ofono_lte_cb_t)(const struct ofono_error *error, void *data=
);
+
+struct ofono_lte_driver {
+	const char *name;
+	int (*probe)(struct ofono_lte *lte, void *data);
+	void (*remove)(struct ofono_lte *lte);
+	int (*config)(struct ofono_lte *lte,
+			struct ofono_lte_context_config *config,
+			ofono_lte_cb_t cb, void *data);
+
+};
+
+int ofono_lte_driver_register(const struct ofono_lte_driver *d);
+
+void ofono_lte_driver_unregister(const struct ofono_lte_driver *d);
+
+struct ofono_lte *ofono_lte_create(struct ofono_modem *modem,
+					const char *driver, void *data);
+
+void ofono_lte_register(struct ofono_lte *lte);
+
+void ofono_lte_remove(struct ofono_lte *lte);
+
+void ofono_lte_set_data(struct ofono_lte *lte, void *data);
+
+void *ofono_lte_get_data(struct ofono_lte *lte);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- =

2.7.4


--===============8029525971262945791==--

