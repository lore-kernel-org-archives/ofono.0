Content-Type: multipart/mixed; boundary="===============6080875589858749357=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 1/6] include: add macros for declaring drivers
Date: Fri, 26 Oct 2018 11:54:14 +0200
Message-ID: <20181026095419.26260-2-jonas@norrbonn.se>
In-Reply-To: <20181026095419.26260-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6080875589858749357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h       | 11 +++++++++++
 include/location-reporting.h | 10 ++++++++++
 include/modem.h              | 11 +++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 965cefc2..d7576bf5 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -115,6 +115,17 @@ void ofono_gprs_context_set_ipv6_gateway(struct ofono_=
gprs_context *gc,
 						const char *gateway);
 void ofono_gprs_context_set_ipv6_dns_servers(struct ofono_gprs_context *gc,
 						const char **dns);
+
+#define OFONO_GPRS_CONTEXT_DRIVER(driver) \
+static void __attribute((constructor(102))) init() \
+{ \
+	ofono_gprs_context_driver_register(driver); \
+} \
+static void __attribute((destructor(102))) fini() \
+{ \
+	ofono_gprs_context_driver_unregister(driver); \
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/location-reporting.h b/include/location-reporting.h
index 0717f710..a639a2b4 100644
--- a/include/location-reporting.h
+++ b/include/location-reporting.h
@@ -74,6 +74,16 @@ void *ofono_location_reporting_get_data(struct ofono_loc=
ation_reporting *lr);
 struct ofono_modem *ofono_location_reporting_get_modem(
 					struct ofono_location_reporting *lr);
 =

+#define OFONO_LOCATION_REPORTING_DRIVER(driver) \
+static void __attribute((constructor(102))) init() \
+{ \
+	ofono_location_reporting_driver_register(driver); \
+} \
+static void __attribute((destructor(102))) fini() \
+{ \
+	ofono_location_reporting_driver_unregister(driver); \
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/modem.h b/include/modem.h
index 9b12cfad..decd1297 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -130,6 +130,17 @@ struct ofono_modem *ofono_modem_find(ofono_modem_compa=
re_cb_t func,
 void ofono_modem_set_powered_timeout_hint(struct ofono_modem *modem,
 							unsigned int seconds);
 =

+#define OFONO_MODEM_DRIVER(driver) \
+static void __attribute((constructor(102))) init() \
+{ \
+	ofono_modem_driver_register(driver); \
+} \
+static void __attribute((destructor(102))) fini() \
+{ \
+	ofono_modem_driver_unregister(driver); \
+}
+
+
 #ifdef __cplusplus
 }
 #endif
-- =

2.17.1


--===============6080875589858749357==--

