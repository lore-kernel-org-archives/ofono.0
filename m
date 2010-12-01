Content-Type: multipart/mixed; boundary="===============7442292134769837437=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC PATCH 1/3] radio-settings: add frequency band selection methods
Date: Wed, 01 Dec 2010 10:10:17 -0200
Message-ID: <1291205419-2659-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1291205419-2659-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7442292134769837437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/radio-settings.h |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/radio-settings.h b/include/radio-settings.h
index 45e88e7..e839231 100644
--- a/include/radio-settings.h
+++ b/include/radio-settings.h
@@ -35,6 +35,24 @@ enum ofono_radio_access_mode {
 	OFONO_RADIO_ACCESS_MODE_LTE	=3D 3,
 };
 =

+enum ofono_radio_band_gsm {
+	OFONO_RADIO_BAND_GSM_ANY	=3D 0,
+	OFONO_RADIO_BAND_GSM_850	=3D 1,
+	OFONO_RADIO_BAND_GSM_900P	=3D 2,
+	OFONO_RADIO_BAND_GSM_900E	=3D 3,
+	OFONO_RADIO_BAND_GSM_1800	=3D 4,
+	OFONO_RADIO_BAND_GSM_1900	=3D 5,
+};
+
+enum ofono_radio_band_umts {
+	OFONO_RADIO_BAND_UMTS_ANY	=3D 0,
+	OFONO_RADIO_BAND_UMTS_850	=3D 1,
+	OFONO_RADIO_BAND_UMTS_900	=3D 2,
+	OFONO_RADIO_BAND_UMTS_1700AWS	=3D 3,
+	OFONO_RADIO_BAND_UMTS_1900	=3D 4,
+	OFONO_RADIO_BAND_UMTS_2100	=3D 5,
+};
+
 struct ofono_radio_settings;
 =

 typedef void (*ofono_radio_settings_rat_mode_set_cb_t)(const struct ofono_=
error *error,
@@ -43,6 +61,13 @@ typedef void (*ofono_radio_settings_rat_mode_query_cb_t)=
(const struct ofono_erro
 						enum ofono_radio_access_mode mode,
 						void *data);
 =

+typedef void (*ofono_radio_settings_band_set_cb_t)(const struct ofono_erro=
r *error,
+							void *data);
+typedef void (*ofono_radio_settings_band_query_cb_t)(const struct ofono_er=
ror *error,
+						enum ofono_radio_band_gsm band_gsm,
+						enum ofono_radio_band_umts band_umts,
+						void *data);
+
 typedef void (*ofono_radio_settings_fast_dormancy_set_cb_t)(const struct o=
fono_error *error,
 							void *data);
 typedef void (*ofono_radio_settings_fast_dormancy_query_cb_t)(const struct=
 ofono_error *error,
@@ -61,6 +86,14 @@ struct ofono_radio_settings_driver {
 				enum ofono_radio_access_mode mode,
 				ofono_radio_settings_rat_mode_set_cb_t cb,
 				void *data);
+	void (*query_band)(struct ofono_radio_settings *rs,
+				ofono_radio_settings_band_query_cb_t cb,
+				void *data);
+	void (*set_band)(struct ofono_radio_settings *rs,
+				enum ofono_radio_band_gsm band_gsm,
+				enum ofono_radio_band_umts band_umts,
+				ofono_radio_settings_band_set_cb_t cb,
+				void *data);
 	void (*query_fast_dormancy)(struct ofono_radio_settings *rs,
 			ofono_radio_settings_fast_dormancy_query_cb_t cb,
 			void *data);
-- =

1.7.3.2


--===============7442292134769837437==--

