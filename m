Content-Type: multipart/mixed; boundary="===============6713773480748126769=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 1/7] sim-auth: prep simauth/dbus headers
Date: Tue, 26 Sep 2017 09:26:03 -0700
Message-ID: <1506443169-19755-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6713773480748126769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added new dbus interfaces for SimAuth module as well as
function prototype definitions to simauth header
---
 include/dbus.h     |  2 ++
 include/sim-auth.h | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/dbus.h b/include/dbus.h
index a6519c7..f0e437c 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -58,6 +58,8 @@ extern "C" {
 #define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationReporti=
ng"
 #define OFONO_GNSS_INTERFACE "org.ofono.AssistedSatelliteNavigation"
 #define OFONO_GNSS_POSR_AGENT_INTERFACE "org.ofono.PositioningRequestAgent"
+#define OFONO_USIM_APPLICATION_INTERFACE "org.ofono.USimApplication"
+#define OFONO_ISIM_APPLICATION_INTERFACE "org.ofono.ISimApplication"
 #define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
 #define OFONO_SIRI_INTERFACE OFONO_SERVICE ".Siri"
 #define OFONO_NETMON_INTERFACE OFONO_SERVICE ".NetworkMonitor"
diff --git a/include/sim-auth.h b/include/sim-auth.h
index 0a62adc..b57fe25 100644
--- a/include/sim-auth.h
+++ b/include/sim-auth.h
@@ -26,6 +26,8 @@
 extern "C" {
 #endif
 =

+#include <stdint.h>
+
 #include <ofono/types.h>
 =

 struct ofono_sim_auth;
@@ -34,6 +36,11 @@ typedef void (*ofono_sim_list_apps_cb_t)(const struct of=
ono_error *error,
 					const unsigned char *dataobj,
 					int len, void *data);
 =

+typedef void (*ofono_sim_open_channel_cb_t)(int session_id, void *data);
+
+typedef void (*ofono_logical_access_cb_t)(const uint8_t *resp,
+		uint16_t len, void *data);
+
 struct ofono_sim_auth_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim_auth *sa, unsigned int vendor,
@@ -41,7 +48,14 @@ struct ofono_sim_auth_driver {
 	void (*remove)(struct ofono_sim_auth *sa);
 =

 	void (*list_apps)(struct ofono_sim_auth *sa,
-				ofono_sim_list_apps_cb_t cb, void *data);
+			ofono_sim_list_apps_cb_t cb, void *data);
+	void (*open_channel)(struct ofono_sim_auth *sa,
+			ofono_sim_open_channel_cb_t cb,
+			const void *channel, void *data);
+	void (*close_channel)(struct ofono_sim_auth *sa, int session_id);
+	void (*logical_access)(struct ofono_sim_auth *sa,
+			ofono_logical_access_cb_t cb, int session_id,
+			const uint8_t *pdu, uint16_t len, void *data);
 };
 =

 int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d);
-- =

2.7.4


--===============6713773480748126769==--

