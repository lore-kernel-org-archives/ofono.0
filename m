Content-Type: multipart/mixed; boundary="===============0933798647264294227=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] Radio-setting: Add GSM and UMTS band
Date: Tue, 26 Apr 2016 19:08:27 +0530
Message-ID: <1461677907-15086-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0933798647264294227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara Borwankar <antara.borwankar@gmail.com>

To add GSM band and UMTS band to persitent data
---
 src/radio-settings.c | 100 ++++++++++++++++++++++++++++++++++-------------=
----
 1 file changed, 68 insertions(+), 32 deletions(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index 7bbd811..15d2f8e 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -72,7 +72,7 @@ static const char *radio_access_mode_to_string(enum ofono=
_radio_access_mode m)
 	case OFONO_RADIO_ACCESS_MODE_LTE:
 		return "lte";
 	default:
-		return "";
+		return NULL;
 	}
 }
 =

@@ -114,7 +114,7 @@ static const char *radio_band_gsm_to_string(enum ofono_=
radio_band_gsm band)
 		return "1900";
 	}
 =

-	return "";
+	return NULL;
 }
 =

 static gboolean radio_band_gsm_from_string(const char *str,
@@ -160,7 +160,7 @@ static const char *radio_band_umts_to_string(enum ofono=
_radio_band_umts band)
 		return "2100";
 	}
 =

-	return "";
+	return NULL;
 }
 =

 static gboolean radio_band_umts_from_string(const char *str,
@@ -311,6 +311,12 @@ static void radio_set_band(struct ofono_radio_settings=
 *rs)
 						OFONO_RADIO_SETTINGS_INTERFACE,
 						"GsmBand", DBUS_TYPE_STRING,
 						&str_band);
+
+		if (rs->settings) {
+			g_key_file_set_integer(rs->settings, SETTINGS_GROUP,
+					"GsmBand", rs->band_gsm);
+			storage_sync(rs->imsi, SETTINGS_STORE, rs->settings);
+		}
 	}
 =

 	if (rs->band_umts !=3D rs->pending_band_umts) {
@@ -321,8 +327,13 @@ static void radio_set_band(struct ofono_radio_settings=
 *rs)
 						OFONO_RADIO_SETTINGS_INTERFACE,
 						"UmtsBand", DBUS_TYPE_STRING,
 						&str_band);
-	}
 =

+		if (rs->settings) {
+			g_key_file_set_integer(rs->settings, SETTINGS_GROUP,
+					"UmtsBand", rs->band_umts);
+			storage_sync(rs->imsi, SETTINGS_STORE, rs->settings);
+		}
+	}
 }
 =

 static void radio_band_set_callback(const struct ofono_error *error,
@@ -368,6 +379,12 @@ static void radio_set_rat_mode(struct ofono_radio_sett=
ings *rs,
 						OFONO_RADIO_SETTINGS_INTERFACE,
 						"TechnologyPreference",
 						DBUS_TYPE_STRING, &str_mode);
+
+	if (rs->settings) {
+		g_key_file_set_integer(rs->settings, SETTINGS_GROUP,
+				"TechnologyPreference", rs->mode);
+		storage_sync(rs->imsi, SETTINGS_STORE, rs->settings);
+	}
 }
 =

 static void radio_mode_set_callback(const struct ofono_error *error, void =
*data)
@@ -578,15 +595,7 @@ static DBusMessage *radio_set_property(DBusConnection =
*conn, DBusMessage *msg,
 		rs->pending_mode =3D mode;
 =

 		rs->driver->set_rat_mode(rs, mode, radio_mode_set_callback, rs);
-
-		if (rs->settings) {
-			const char *mode_str;
-			mode_str =3D radio_access_mode_to_string(mode);
-			g_key_file_set_string(rs->settings, SETTINGS_GROUP,
-					"TechnologyPreference", mode_str);
-			storage_sync(rs->imsi, SETTINGS_STORE, rs->settings);
-		}
-
+		/* will be saved in radiosettng on success response*/
 		return NULL;
 	} else if (g_strcmp0(property, "GsmBand") =3D=3D 0) {
 		const char *value;
@@ -610,7 +619,7 @@ static DBusMessage *radio_set_property(DBusConnection *=
conn, DBusMessage *msg,
 =

 		rs->driver->set_band(rs, band, rs->band_umts,
 					radio_band_set_callback, rs);
-
+		/* will be saved in radiosettng on success response*/
 		return NULL;
 	} else if (g_strcmp0(property, "UmtsBand") =3D=3D 0) {
 		const char *value;
@@ -634,7 +643,7 @@ static DBusMessage *radio_set_property(DBusConnection *=
conn, DBusMessage *msg,
 =

 		rs->driver->set_band(rs, rs->band_gsm, band,
 					radio_band_set_callback, rs);
-
+		/* will be saved in radiosettng on success response*/
 		return NULL;
 	} else if (g_strcmp0(property, "FastDormancy") =3D=3D 0) {
 		dbus_bool_t value;
@@ -804,12 +813,21 @@ static void radio_mode_set_callback_at_reg(const stru=
ct ofono_error *error,
 	 */
 	ofono_radio_finish_register(rs);
 }
+static void radio_band_set_callback_at_reg(const struct ofono_error *error,
+						void *data)
+{
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		DBG("Error setting radio access mode register time");
+	/*
+	 * Continue with atom register even if request fail at modem
+	 * ofono_radio_finish_register called by radio_mode_set_callback_at_reg
+	 */
+}
 =

 static void radio_load_settings(struct ofono_radio_settings *rs,
 					const char *imsi)
 {
 	GError *error;
-	char *strmode;
 =

 	rs->settings =3D storage_open(imsi, SETTINGS_STORE);
 =

@@ -820,34 +838,46 @@ static void radio_load_settings(struct ofono_radio_se=
ttings *rs,
 	if (rs->settings =3D=3D NULL) {
 		DBG("radiosetting storage open failed");
 		rs->mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+		rs->band_gsm =3D OFONO_RADIO_BAND_GSM_ANY;
+		rs->band_umts =3D OFONO_RADIO_BAND_UMTS_ANY;
 		return;
 	}
 =

 	rs->imsi =3D g_strdup(imsi);
 =

 	error =3D NULL;
-	strmode =3D g_key_file_get_string(rs->settings, SETTINGS_GROUP,
-					"TechnologyPreference", &error);
+	rs->band_gsm =3D g_key_file_get_integer(rs->settings, SETTINGS_GROUP,
+					"GsmBand", &error);
 =

-	if (error) {
-		g_error_free(error);
-		goto setdefault;
+	if (error || radio_band_gsm_to_string(rs->band_gsm) =3D=3D NULL) {
+		rs->band_gsm =3D OFONO_RADIO_BAND_GSM_ANY;
+		g_key_file_set_integer(rs->settings, SETTINGS_GROUP,
+						"GsmBand", rs->band_gsm);
 	}
 =

-	if (radio_access_mode_from_string(strmode, &rs->mode) =3D=3D FALSE) {
-		DBG("Invalid rat mode in storage; Setting default");
-		goto setdefault;
+	error =3D NULL;
+	rs->band_umts =3D g_key_file_get_integer(rs->settings, SETTINGS_GROUP,
+					"UmtsBand", &error);
+
+	if (error || radio_band_umts_to_string(rs->band_umts) =3D=3D NULL) {
+		rs->band_umts =3D OFONO_RADIO_BAND_UMTS_ANY;
+		g_key_file_set_integer(rs->settings, SETTINGS_GROUP,
+						"UmtsBand", rs->band_umts);
 	}
 =

-	g_free(strmode);
-	return;
+	error =3D NULL;
+	rs->mode =3D g_key_file_get_integer(rs->settings, SETTINGS_GROUP,
+					"TechnologyPreference", &error);
+
+	if (error || radio_access_mode_to_string(rs->mode) =3D=3D NULL) {
+		rs->mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+		g_key_file_set_integer(rs->settings, SETTINGS_GROUP,
+						"TechnologyPreference", rs->mode);
+	}
 =

-setdefault:
-	rs->mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
-	g_key_file_set_string(rs->settings, SETTINGS_GROUP,
-					"TechnologyPreference", "any");
-	storage_sync(rs->imsi, SETTINGS_STORE, rs->settings);
-	g_free(strmode);
+	DBG("TechnologyPreference: %d", rs->mode);
+	DBG("GsmBand: %d", rs->band_gsm);
+	DBG("UmtsBand: %d", rs->band_umts);
 }
 =

 void ofono_radio_settings_register(struct ofono_radio_settings *rs)
@@ -860,6 +890,12 @@ void ofono_radio_settings_register(struct ofono_radio_=
settings *rs)
 =

 	radio_load_settings(rs, ofono_sim_get_imsi(sim));
 =

+	if (rs->driver->set_band =3D=3D NULL)
+		goto finish;
+
+	rs->driver->set_band(rs, rs->band_gsm, rs->band_umts,
+					radio_band_set_callback_at_reg, rs);
+
 	if (rs->driver->set_rat_mode =3D=3D NULL)
 		goto finish;
 =

-- =

1.9.1


--===============0933798647264294227==--

