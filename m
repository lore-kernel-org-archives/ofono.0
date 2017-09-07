Content-Type: multipart/mixed; boundary="===============6599375310689564725=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 3/7] include: added NetworkMonitorAgent interface
Date: Thu, 07 Sep 2017 09:53:16 +0530
Message-ID: <1504758200-18624-3-git-send-email-nishanth.v@intel.com>
In-Reply-To: <1504758200-18624-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6599375310689564725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dbus.h b/include/dbus.h
index cf68ae5..a6519c7 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -61,6 +61,7 @@ extern "C" {
 #define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
 #define OFONO_SIRI_INTERFACE OFONO_SERVICE ".Siri"
 #define OFONO_NETMON_INTERFACE OFONO_SERVICE ".NetworkMonitor"
+#define OFONO_NETMON_AGENT_INTERFACE OFONO_SERVICE ".NetworkMonitorAgent"
 #define OFONO_LTE_INTERFACE OFONO_SERVICE ".LongTermEvolution"
 =

 /* CDMA Interfaces */
-- =

1.9.1


--===============6599375310689564725==--

