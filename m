Content-Type: multipart/mixed; boundary="===============5005220283255587922=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/4] include: Add method to list RATs to radio-settings
Date: Tue, 09 Dec 2014 13:34:37 +0100
Message-ID: <1418128479-5491-3-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1418128479-5491-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5005220283255587922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/radio-settings.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/radio-settings.h b/include/radio-settings.h
index 1d0ca3e..545a29d 100644
--- a/include/radio-settings.h
+++ b/include/radio-settings.h
@@ -35,6 +35,13 @@ enum ofono_radio_access_mode {
 	OFONO_RADIO_ACCESS_MODE_LTE	=3D 3,
 };
 =

+#define OFONO_FLAG_RADIO_ACCESS_MODE_GSM \
+				(1 << (OFONO_RADIO_ACCESS_MODE_GSM - 1))
+#define OFONO_FLAG_RADIO_ACCESS_MODE_UMTS \
+				(1 << (OFONO_RADIO_ACCESS_MODE_UMTS - 1))
+#define OFONO_FLAG_RADIO_ACCESS_MODE_LTE \
+				(1 << (OFONO_RADIO_ACCESS_MODE_LTE - 1))
+
 enum ofono_radio_band_gsm {
 	OFONO_RADIO_BAND_GSM_ANY,
 	OFONO_RADIO_BAND_GSM_850,
@@ -80,6 +87,11 @@ typedef void (*ofono_radio_settings_fast_dormancy_query_=
cb_t)(
 						ofono_bool_t enable,
 						void *data);
 =

+typedef void (*ofono_radio_settings_available_rats_query_cb_t)(
+						const struct ofono_error *error,
+						unsigned int available_rats,
+						void *data);
+
 struct ofono_radio_settings_driver {
 	const char *name;
 	int (*probe)(struct ofono_radio_settings *rs, unsigned int vendor,
@@ -107,6 +119,9 @@ struct ofono_radio_settings_driver {
 				ofono_bool_t enable,
 				ofono_radio_settings_fast_dormancy_set_cb_t,
 				void *data);
+	void (*query_available_rats)(struct ofono_radio_settings *rs,
+			ofono_radio_settings_available_rats_query_cb_t cb,
+			void *data);
 };
 =

 int ofono_radio_settings_driver_register(
-- =

2.1.0


--===============5005220283255587922==--

