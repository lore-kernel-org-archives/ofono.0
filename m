Content-Type: multipart/mixed; boundary="===============5206148227836450316=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/6] coex: Adding coex includes for coex atom
Date: Mon, 01 Oct 2018 16:03:42 +0530
Message-ID: <1538390022-6183-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5206148227836450316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

Added coex.h which describes the includes of coex atom
---
 include/coex.h | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 119 insertions(+)
 create mode 100644 include/coex.h

diff --git a/include/coex.h b/include/coex.h
new file mode 100644
index 0000000..9e1ed63
--- /dev/null
+++ b/include/coex.h
@@ -0,0 +1,119 @@
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
+#ifndef __OFONO_COEX_H
+#define __OFONO_COEX_H
+#include <ofono/types.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define MAX_BT_SAFE_VECTOR 15
+#define MAX_WL_SAFE_VECTOR 13
+
+enum ofono_wlan_bw {
+	OFONO_WLAN_BW_UNSUPPORTED =3D -1,
+	OFONO_WLAN_BW_20MHZ =3D 0,
+	OFONO_WLAN_BW_40MHZ =3D 1,
+	OFONO_WLAN_BW_80MHZ =3D 2,
+};
+
+struct Plmnhist {
+	unsigned short mnc;
+	unsigned short mcc;
+	unsigned long tdd;
+	unsigned long fdd;
+	unsigned char bw;
+};
+
+struct ofono_coex;
+
+typedef void (*ofono_coex_bt_active_set_cb_t)(
+					const struct ofono_error *error,
+					void *data);
+
+typedef void (*ofono_coex_wlan_active_set_cb_t)(
+					const struct ofono_error *error,
+					void *data);
+
+typedef void (*ofono_coex_enable_cb_t)(
+				const struct ofono_error *error,
+				void *data);
+
+typedef void (*ofono_coex_remove_cb_t)( const struct ofono_error *error,
+				void *data);
+
+typedef void (*ofono_coex_get_plmn_history_cb_t)(
+					const struct ofono_error *error,
+					int list_size,
+					struct Plmnhist *list,
+					void *data);
+
+struct ofono_coex_driver {
+	const char *name;
+	int (*probe)(struct ofono_coex *coex, unsigned int vendor, void *data);
+	void (*enable)(struct ofono_coex *coex,	ofono_coex_enable_cb_t cb,
+		void *data);
+	void (*remove)(struct ofono_coex *coex,	ofono_coex_remove_cb_t cb,
+		void *data);
+	void (*set_bt_active)(struct ofono_coex *coex, ofono_bool_t bt_active,
+			ofono_coex_bt_active_set_cb_t cb, void *data);
+	void (*set_wlan_active)(struct ofono_coex *coex,
+			ofono_bool_t wlan_active, enum ofono_wlan_bw wlan_bw,
+			ofono_coex_bt_active_set_cb_t cb, void *data);
+	void (*get_plmn_history)(struct ofono_coex *coex,
+			ofono_coex_get_plmn_history_cb_t cb, void *data);
+};
+
+struct ofono_coex *ofono_coex_create(struct ofono_modem *modem,
+				unsigned int vendor,
+				const char *driver,
+				void *data);
+
+void ofono_coex_ril_lte_band_notify(struct ofono_coex *coex,
+				 const char *band);
+void ofono_coex_driver_unregister(const struct ofono_coex_driver *d);
+int ofono_coex_driver_register(const struct ofono_coex_driver *d);
+
+void* ofono_coex_get_data(struct ofono_coex *coex);
+void ofono_coex_set_data(struct ofono_coex *coex, void *data);
+struct ofono_modem *ofono_coex_get_modem(struct ofono_coex *coex);
+
+void ofono_coex_register(struct ofono_coex *coex);
+void ofono_coex_remove(struct ofono_coex *coex);
+
+void ofono_lte_coex_status_notify(struct ofono_coex *coex,
+				ofono_bool_t lte_active);
+
+void ofono_wlan_coex_status_notify(struct ofono_coex* coex,
+				int rx_min, int rx_max, int tx_min,
+				int tx_max, int num_vector, int *vector);
+
+void ofono_bt_coex_status_notify(struct ofono_coex* coex,
+				int rx_min, int rx_max, int tx_min,
+				int tx_max, int num_vector, int *vector);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- =

1.9.1


--===============5206148227836450316==--

