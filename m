Content-Type: multipart/mixed; boundary="===============6184697838512588220=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 1/7] sim-auth: prep simauth/dbus headers
Date: Thu, 21 Sep 2017 11:11:54 -0700
Message-ID: <1506017520-22482-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6184697838512588220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added new dbus interfaces for SimAuth module as well as
function prototype definitions to simauth header
---
 include/dbus.h     |  2 ++
 include/sim-auth.h | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

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
index 0a62adc..68c8602 100644
--- a/include/sim-auth.h
+++ b/include/sim-auth.h
@@ -34,6 +34,14 @@ typedef void (*ofono_sim_list_apps_cb_t)(const struct of=
ono_error *error,
 					const unsigned char *dataobj,
 					int len, void *data);
 =

+typedef void (*ofono_sim_open_channel_cb_t)(int session_id, void *data);
+
+typedef void (*ofono_gsm_authenticate_cb_t)(void *data, const guint8 *sres,
+		const guint8 *kc);
+
+typedef void (*ofono_umts_authenticate_cb_t)(void *data, const guint8 *res,
+		guint8 res_len, const guint8 *ck, const guint8 *ik);
+
 struct ofono_sim_auth_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim_auth *sa, unsigned int vendor,
@@ -41,7 +49,17 @@ struct ofono_sim_auth_driver {
 	void (*remove)(struct ofono_sim_auth *sa);
 =

 	void (*list_apps)(struct ofono_sim_auth *sa,
-				ofono_sim_list_apps_cb_t cb, void *data);
+			ofono_sim_list_apps_cb_t cb, void *data);
+	void (*open_channel)(struct ofono_sim_auth *sa,
+			ofono_sim_open_channel_cb_t cb,
+			const void *channel, void *data);
+	void (*close_channel)(struct ofono_sim_auth *sa, int session_id);
+	void (*gsm_authenticate)(struct ofono_sim_auth *sa,
+			ofono_gsm_authenticate_cb_t cb, int session_id,
+			const void *rand, void *data);
+	void (*umts_authenticate)(struct ofono_sim_auth *sa,
+			ofono_umts_authenticate_cb_t cb, int session_id,
+			const void *rand, const void *autn, void *data);
 };
 =

 int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d);
-- =

2.7.4


--===============6184697838512588220==--

