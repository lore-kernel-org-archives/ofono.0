Content-Type: multipart/mixed; boundary="===============4989256903320382029=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [RFC PATCH 2/4] cell-info: Header file for cell-info atom
Date: Tue, 21 Dec 2010 10:32:23 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9015A322A5B@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1292940024-24363-3-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4989256903320382029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Shouldn't ofono_cell_info_results be defined here and included as an argume=
nt for
ofono_cell_info_query_cb_t ? =


Cheers,
Waldo =


-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Antti Paila
Sent: Tuesday, December 21, 2010 6:00 AM
To: ofono(a)ofono.org
Subject: [RFC PATCH 2/4] cell-info: Header file for cell-info atom

---
 include/cell-info.h |   66 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 include/cell-info.h

diff --git a/include/cell-info.h b/include/cell-info.h
new file mode 100644
index 0000000..d9c7810
--- /dev/null
+++ b/include/cell-info.h
@@ -0,0 +1,66 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CELL_INFO_H
+#define __OFONO_CELL_INFO_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cell_info;
+
+typedef void (*ofono_cell_info_query_cb_t)(const struct ofono_error *error,
+				void *data);
+
+struct ofono_cell_info_driver {
+	const char *name;
+	int (*probe)(struct ofono_cell_info *ci,
+			unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_cell_info *ci);
+	void (*query)(struct ofono_cell_info *ci,
+			ofono_cell_info_query_cb_t,
+			void *data);
+};
+
+struct ofono_cell_info *ofono_cell_info_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver,
+					void *data);
+
+void ofono_cell_info_register(struct ofono_cell_info *ci);
+void ofono_cell_info_remove(struct ofono_cell_info *ci);
+int ofono_cell_info_driver_register(struct ofono_cell_info_driver *driver);
+void ofono_cell_info_driver_unregister(struct ofono_cell_info_driver *driv=
er);
+void *ofono_cell_info_get_data(struct ofono_cell_info *ci);
+void ofono_cell_info_set_data(struct ofono_cell_info *ci, void *cid);
+void ofono_cell_info_query_cb(const struct ofono_error *error,
+				void *data);
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CELL_INFO_H */
-- =

1.7.1

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============4989256903320382029==--

