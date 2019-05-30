Content-Type: multipart/mixed; boundary="===============3487564117059734293=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/4] netmon: adding get function for neighbouring cell
 information
Date: Thu, 30 May 2019 14:51:28 +0530
Message-ID: <1559208088-3510-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3487564117059734293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added declaration of functions and structures required for getting
neighbouring cell information.
---
 include/netmon.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/netmon.h b/include/netmon.h
index c8fcafa..8847b82 100644
--- a/include/netmon.h
+++ b/include/netmon.h
@@ -43,6 +43,8 @@ struct ofono_netmon_driver {
 					unsigned int enable,
 					unsigned int period,
 					ofono_netmon_cb_t cb, void *data);
+	void (*neighbouring_cell_update)(struct ofono_netmon *netmon,
+					ofono_netmon_cb_t cb, void *data);
 };
 =

 enum ofono_netmon_cell_type {
@@ -73,6 +75,28 @@ enum ofono_netmon_info {
 	OFONO_NETMON_INFO_INVALID,
 };
 =

+struct ofono_netmon_neighbouring_cell
+{
+	enum ofono_netmon_cell_type cell_type;
+	int mcc;
+	int mnc;
+	int cell_id;
+	union {
+		struct lte_cell {
+			int rsrq;
+			int rsrp;
+		} lte;
+		struct umts_cell {
+			int rscp;
+			int ecno;
+		} umts;
+		struct gsm_cell {
+			int rssi;
+			int ber;
+		} gsm;
+	} cell_meas;
+};
+
 /*
  * Examples:
  * ofono_netmon_serving_cell_notify(netmon, OFONO_NETMON_CELL_TYPE_GSM,
@@ -104,6 +128,9 @@ void ofono_netmon_set_data(struct ofono_netmon *netmon,=
 void *data);
 =

 void *ofono_netmon_get_data(struct ofono_netmon *netmon);
 =

+void ofono_netmon_neighbouring_cell_notify(struct ofono_netmon *netmon,
+					void *cell_list);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.9.1


--===============3487564117059734293==--

