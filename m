Content-Type: multipart/mixed; boundary="===============1816666770033681694=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/4] include: Add method to list RATs to radio-settings
Date: Fri, 05 Dec 2014 17:46:29 +0100
Message-ID: <1417797991-19700-3-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1417797991-19700-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1816666770033681694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/radio-settings.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/radio-settings.h b/include/radio-settings.h
index 1d0ca3e..d7481b3 100644
--- a/include/radio-settings.h
+++ b/include/radio-settings.h
@@ -35,6 +35,9 @@ enum ofono_radio_access_mode {
 	OFONO_RADIO_ACCESS_MODE_LTE	=3D 3,
 };
 =

+/* Set this to latest in ofono_radio_access_mode + 1 */
+#define OFONO_RADIO_ACCESS_MODE_LAST (OFONO_RADIO_ACCESS_MODE_LTE + 1)
+
 enum ofono_radio_band_gsm {
 	OFONO_RADIO_BAND_GSM_ANY,
 	OFONO_RADIO_BAND_GSM_850,
@@ -80,6 +83,11 @@ typedef void (*ofono_radio_settings_fast_dormancy_query_=
cb_t)(
 						ofono_bool_t enable,
 						void *data);
 =

+typedef void (*ofono_radio_settings_modem_rats_query_cb_t)(
+						const struct ofono_error *error,
+						const ofono_bool_t rats[],
+						void *data);
+
 struct ofono_radio_settings_driver {
 	const char *name;
 	int (*probe)(struct ofono_radio_settings *rs, unsigned int vendor,
@@ -107,6 +115,9 @@ struct ofono_radio_settings_driver {
 				ofono_bool_t enable,
 				ofono_radio_settings_fast_dormancy_set_cb_t,
 				void *data);
+	void (*query_modem_rats)(struct ofono_radio_settings *rs,
+				ofono_radio_settings_modem_rats_query_cb_t cb,
+				void *data);
 };
 =

 int ofono_radio_settings_driver_register(
-- =

2.1.0


--===============1816666770033681694==--

