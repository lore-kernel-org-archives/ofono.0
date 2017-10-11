Content-Type: multipart/mixed; boundary="===============1734298995313177990=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv3 1/7] sim-auth: prep simauth/dbus headers
Date: Wed, 11 Oct 2017 11:57:42 -0700
Message-ID: <1507748268-4799-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1734298995313177990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added new dbus interfaces for SimAuth module as well as
function prototype definitions to simauth header.

org.ofono.SimAuthentication:
   Interface to hold the auth object to type mapping property

org.ofono.USimApplication:
   Application with USim functionality (GSM/UMTS auth)

org.ofono.ISimApplication:
   Application with ISim functionality (IMS auth)
---
 include/dbus.h     |  3 +++
 include/sim-auth.h | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/dbus.h b/include/dbus.h
index 0a8f2e5..9cc47f7 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -58,6 +58,9 @@ extern "C" {
 #define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationReporti=
ng"
 #define OFONO_GNSS_INTERFACE "org.ofono.AssistedSatelliteNavigation"
 #define OFONO_GNSS_POSR_AGENT_INTERFACE "org.ofono.PositioningRequestAgent"
+#define OFONO_USIM_APPLICATION_INTERFACE "org.ofono.USimApplication"
+#define OFONO_ISIM_APPLICATION_INTERFACE "org.ofono.ISimApplication"
+#define OFONO_SIM_AUTHENTICATION_INTERFACE "org.ofono.SimAuthentication"
 #define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
 #define OFONO_SIRI_INTERFACE OFONO_SERVICE ".Siri"
 #define OFONO_NETMON_INTERFACE OFONO_SERVICE ".NetworkMonitor"
diff --git a/include/sim-auth.h b/include/sim-auth.h
index 0a62adc..ccaa7f2 100644
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
@@ -34,6 +36,15 @@ typedef void (*ofono_sim_list_apps_cb_t)(const struct of=
ono_error *error,
 					const unsigned char *dataobj,
 					int len, void *data);
 =

+typedef void (*ofono_sim_open_channel_cb_t)(const struct ofono_error *erro=
r,
+		int session_id, void *data);
+
+typedef void (*ofono_sim_close_channel_cb_t)(const struct ofono_error *err=
or,
+		void *data);
+
+typedef void (*ofono_logical_access_cb_t)(const struct ofono_error *error,
+		const uint8_t *resp, uint16_t len, void *data);
+
 struct ofono_sim_auth_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim_auth *sa, unsigned int vendor,
@@ -41,7 +52,14 @@ struct ofono_sim_auth_driver {
 	void (*remove)(struct ofono_sim_auth *sa);
 =

 	void (*list_apps)(struct ofono_sim_auth *sa,
-				ofono_sim_list_apps_cb_t cb, void *data);
+			ofono_sim_list_apps_cb_t cb, void *data);
+	void (*open_channel)(struct ofono_sim_auth *sa, const uint8_t *aid,
+			ofono_sim_open_channel_cb_t cb, void *data);
+	void (*close_channel)(struct ofono_sim_auth *sa, int session_id,
+			ofono_sim_close_channel_cb_t cb, void *data);
+	void (*logical_access)(struct ofono_sim_auth *sa,
+			int session_id, const uint8_t *pdu, uint16_t len,
+			ofono_logical_access_cb_t cb, void *data);
 };
 =

 int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d);
-- =

2.7.4


--===============1734298995313177990==--

