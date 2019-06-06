Content-Type: multipart/mixed; boundary="===============4555016286167589950=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/3] netmon: adding get function for neighbouring cell
 information
Date: Thu, 06 Jun 2019 14:32:08 +0530
Message-ID: <1559811728-31583-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4555016286167589950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added declaration of functions and structures required for getting
neighbouring cell information.
---
 include/netmon.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/netmon.h b/include/netmon.h
index c8fcafa..a99d6ca 100644
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
@@ -104,6 +106,10 @@ void ofono_netmon_set_data(struct ofono_netmon *netmon=
, void *data);
 =

 void *ofono_netmon_get_data(struct ofono_netmon *netmon);
 =

+void ofono_netmon_neighbouring_cell_notify(struct ofono_netmon *netmon,
+					enum ofono_netmon_cell_type type,
+					int info_type, ...);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.9.1


--===============4555016286167589950==--

