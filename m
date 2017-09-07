Content-Type: multipart/mixed; boundary="===============1045510512884209543=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 2/7] include: added enable_periodic_update in netmon driver
Date: Thu, 07 Sep 2017 09:53:15 +0530
Message-ID: <1504758200-18624-2-git-send-email-nishanth.v@intel.com>
In-Reply-To: <1504758200-18624-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1045510512884209543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Defining new method in ofono_netmon_driver,
enable_periodic_update useful to get periodic update
on serving cell information.
---
 include/netmon.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/netmon.h b/include/netmon.h
index 72090c3..c8fcafa 100644
--- a/include/netmon.h
+++ b/include/netmon.h
@@ -39,6 +39,10 @@ struct ofono_netmon_driver {
 	void (*remove)(struct ofono_netmon *netmon);
 	void (*request_update)(struct ofono_netmon *netmon,
 					ofono_netmon_cb_t cb, void *data);
+	void (*enable_periodic_update)(struct ofono_netmon *netmon,
+					unsigned int enable,
+					unsigned int period,
+					ofono_netmon_cb_t cb, void *data);
 };
 =

 enum ofono_netmon_cell_type {
-- =

1.9.1


--===============1045510512884209543==--

