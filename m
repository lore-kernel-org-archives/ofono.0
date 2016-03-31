Content-Type: multipart/mixed; boundary="===============4342215426975362529=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 1/6] include: Add netmon changes
Date: Thu, 31 Mar 2016 09:51:42 +0530
Message-ID: <1459398102-5757-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4342215426975362529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h   |  1 +
 include/netmon.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/dbus.h b/include/dbus.h
index 3d39eff..99d45d6 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -60,6 +60,7 @@ extern "C" {
 #define OFONO_GNSS_POSR_AGENT_INTERFACE "org.ofono.PositioningRequestAgent"
 #define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
 #define OFONO_SIRI_INTERFACE OFONO_SERVICE ".Siri"
+#define OFONO_NETMON_INTERFACE OFONO_SERVICE ".NetworkMonitor"
 =

 /* CDMA Interfaces */
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
diff --git a/include/netmon.h b/include/netmon.h
index 324d2f7..a8390c4 100644
--- a/include/netmon.h
+++ b/include/netmon.h
@@ -77,6 +77,20 @@ void ofono_netmon_serving_cell_notify(struct ofono_netmo=
n *netmon,
 					enum ofono_netmon_cell_type type,
 					int info_type, ...);
 =

+int ofono_netmon_driver_register(const struct ofono_netmon_driver *d);
+
+void ofono_netmon_driver_unregister(const struct ofono_netmon_driver *d);
+
+struct ofono_netmon *ofono_netmon_create(struct ofono_modem *modem,
+    unsigned int vendor, const char *driver, void *data);
+
+void ofono_netmon_register(struct ofono_netmon *netmon);
+
+void ofono_netmon_remove(struct ofono_netmon *netmon);
+
+void ofono_netmon_set_data(struct ofono_netmon *netmon, void *data);
+
+void *ofono_netmon_get_data(struct ofono_netmon *netmon);
 =

 #ifdef __cplusplus
 }
-- =

1.9.1


--===============4342215426975362529==--

