Content-Type: multipart/mixed; boundary="===============6169964253531468407=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC PATCH 2/3] radio-settings: add frequency band selection
 properties
Date: Wed, 01 Dec 2010 10:10:18 -0200
Message-ID: <1291205419-2659-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1291205419-2659-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6169964253531468407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/radio-settings.c |  250 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 248 insertions(+), 2 deletions(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index ff6934b..8c82e29 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -41,8 +41,12 @@ struct ofono_radio_settings {
 	DBusMessage *pending;
 	int flags;
 	enum ofono_radio_access_mode mode;
-	enum ofono_radio_access_mode pending_mode;
+	enum ofono_radio_band_gsm band_gsm;
+	enum ofono_radio_band_umts band_umts;
 	ofono_bool_t fast_dormancy;
+	enum ofono_radio_access_mode pending_mode;
+	enum ofono_radio_band_gsm pending_band_gsm;
+	enum ofono_radio_band_umts pending_band_umts;
 	ofono_bool_t fast_dormancy_pending;
 	const struct ofono_radio_settings_driver *driver;
 	void *driver_data;
@@ -86,6 +90,100 @@ static gboolean radio_access_mode_from_string(const cha=
r *str,
 	return FALSE;
 }
 =

+static const char *radio_band_gsm_to_string(enum ofono_radio_band_gsm band)
+{
+	switch (band) {
+	case OFONO_RADIO_BAND_GSM_ANY:
+		return "any";
+	case OFONO_RADIO_BAND_GSM_850:
+		return "850";
+	case OFONO_RADIO_BAND_GSM_900P:
+		return "900P";
+	case OFONO_RADIO_BAND_GSM_900E:
+		return "900E";
+	case OFONO_RADIO_BAND_GSM_1800:
+		return "1800";
+	case OFONO_RADIO_BAND_GSM_1900:
+		return "1900";
+	}
+
+	return "";
+}
+
+static gboolean radio_band_gsm_from_string(const char *str,
+						enum ofono_radio_band_gsm *band)
+
+{
+	if (g_str_equal(str, "any")) {
+		*band =3D OFONO_RADIO_BAND_GSM_ANY;
+		return TRUE;
+	} else if (g_str_equal(str, "850")) {
+		*band =3D OFONO_RADIO_BAND_GSM_850;
+		return TRUE;
+	} else if (g_str_equal(str, "900P")) {
+		*band =3D OFONO_RADIO_BAND_GSM_900P;
+		return TRUE;
+	} else if (g_str_equal(str, "900E")) {
+		*band =3D OFONO_RADIO_BAND_GSM_900E;
+		return TRUE;
+	} else if (g_str_equal(str, "1800")) {
+		*band =3D OFONO_RADIO_BAND_GSM_1800;
+		return TRUE;
+	} else if (g_str_equal(str, "1900")) {
+		*band =3D OFONO_RADIO_BAND_GSM_1900;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static const char *radio_band_umts_to_string(enum ofono_radio_band_umts ba=
nd)
+{
+	switch (band) {
+	case OFONO_RADIO_BAND_UMTS_ANY:
+		return "any";
+	case OFONO_RADIO_BAND_UMTS_850:
+		return "850";
+	case OFONO_RADIO_BAND_UMTS_900:
+		return "900P";
+	case OFONO_RADIO_BAND_UMTS_1700AWS:
+		return "900E";
+	case OFONO_RADIO_BAND_UMTS_1900:
+		return "1800";
+	case OFONO_RADIO_BAND_UMTS_2100:
+		return "1900";
+	}
+
+	return "";
+}
+
+static gboolean radio_band_umts_from_string(const char *str,
+						enum ofono_radio_band_umts *band)
+
+{
+	if (g_str_equal(str, "any")) {
+		*band =3D OFONO_RADIO_BAND_GSM_ANY;
+		return TRUE;
+	} else if (g_str_equal(str, "850")) {
+		*band =3D OFONO_RADIO_BAND_UMTS_850;
+		return TRUE;
+	} else if (g_str_equal(str, "900")) {
+		*band =3D OFONO_RADIO_BAND_UMTS_900;
+		return TRUE;
+	} else if (g_str_equal(str, "1700AWS")) {
+		*band =3D OFONO_RADIO_BAND_UMTS_1700AWS;
+		return TRUE;
+	} else if (g_str_equal(str, "1900")) {
+		*band =3D OFONO_RADIO_BAND_UMTS_1900;
+		return TRUE;
+	} else if (g_str_equal(str, "2100")) {
+		*band =3D OFONO_RADIO_BAND_UMTS_2100;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static DBusMessage *radio_get_properties_reply(DBusMessage *msg,
 						struct ofono_radio_settings *rs)
 {
@@ -108,6 +206,18 @@ static DBusMessage *radio_get_properties_reply(DBusMes=
sage *msg,
 	ofono_dbus_dict_append(&dict, "TechnologyPreference",
 					DBUS_TYPE_STRING, &mode);
 =

+	if (rs->driver->query_band) {
+		const char *band =3D radio_band_gsm_to_string(rs->band_gsm);
+
+		ofono_dbus_dict_append(&dict, "GsmBand",
+					DBUS_TYPE_STRING, &band);
+
+		band =3D radio_band_umts_to_string(rs->band_umts);
+
+		ofono_dbus_dict_append(&dict, "UmtsBand",
+					DBUS_TYPE_STRING, &band);
+	}
+
 	if (rs->driver->query_fast_dormancy) {
 		dbus_bool_t value =3D rs->fast_dormancy;
 		ofono_dbus_dict_append(&dict, "FastDormancy",
@@ -159,6 +269,60 @@ static void radio_fast_dormancy_set_callback(const str=
uct ofono_error *error,
 	radio_set_fast_dormancy(rs, rs->fast_dormancy_pending);
 }
 =

+static void radio_set_band(struct ofono_radio_settings *rs)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *str_band;
+
+	path =3D __ofono_atom_get_path(rs->atom);
+
+	if (rs->band_gsm !=3D rs->pending_band_gsm) {
+		rs->band_gsm =3D rs->pending_band_gsm;
+		str_band =3D radio_band_gsm_to_string(rs->band_gsm);
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_RADIO_SETTINGS_INTERFACE,
+						"GsmBand", DBUS_TYPE_STRING,
+						&str_band);
+	}
+
+	if (rs->band_umts !=3D rs->pending_band_umts) {
+		rs->band_umts =3D rs->pending_band_umts;
+		str_band =3D radio_band_umts_to_string(rs->band_umts);
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_RADIO_SETTINGS_INTERFACE,
+						"UmtsBand", DBUS_TYPE_STRING,
+						&str_band);
+	}
+
+}
+
+static void radio_band_set_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error setting radio frequency band");
+
+		rs->pending_band_gsm =3D rs->band_gsm;
+		rs->pending_band_umts =3D rs->band_umts;
+
+		reply =3D __ofono_error_failed(rs->pending);
+		__ofono_dbus_pending_reply(&rs->pending, reply);
+
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(rs->pending);
+	__ofono_dbus_pending_reply(&rs->pending, reply);
+
+	radio_set_band(rs);
+}
+
 static void radio_set_rat_mode(struct ofono_radio_settings *rs,
 				enum ofono_radio_access_mode mode)
 {
@@ -242,6 +406,40 @@ static void radio_query_fast_dormancy(struct ofono_rad=
io_settings *rs)
 					rs);
 }
 =

+static void radio_band_query_callback(const struct ofono_error *error,
+					enum ofono_radio_band_gsm band_gsm,
+					enum ofono_radio_band_umts band_umts,
+					void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error during radio frequency band query");
+
+		reply =3D __ofono_error_failed(rs->pending);
+		__ofono_dbus_pending_reply(&rs->pending, reply);
+
+		return;
+	}
+
+	rs->pending_band_gsm =3D band_gsm;
+	rs->pending_band_umts =3D band_umts;
+
+	radio_set_band(rs);
+	radio_query_fast_dormancy(rs);
+}
+
+static void radio_query_band(struct ofono_radio_settings *rs)
+{
+	if (!rs->driver->query_band) {
+		radio_query_fast_dormancy(rs);
+		return;
+	}
+
+	rs->driver->query_band(rs, radio_band_query_callback, rs);
+}
+
 static void radio_rat_mode_query_callback(const struct ofono_error *error,
 					enum ofono_radio_access_mode mode,
 					void *data)
@@ -259,7 +457,7 @@ static void radio_rat_mode_query_callback(const struct =
ofono_error *error,
 	}
 =

 	radio_set_rat_mode(rs, mode);
-	radio_query_fast_dormancy(rs);
+	radio_query_band(rs);
 }
 =

 static DBusMessage *radio_get_properties(DBusConnection *conn,
@@ -330,6 +528,54 @@ static DBusMessage *radio_set_property(DBusConnection =
*conn, DBusMessage *msg,
 		rs->driver->set_rat_mode(rs, mode, radio_mode_set_callback, rs);
 =

 		return NULL;
+	} else if (g_strcmp0(property, "GsmBand") =3D=3D 0) {
+		const char *value;
+		enum ofono_radio_band_gsm band;
+
+		if (!rs->driver->set_band)
+			return __ofono_error_not_implemented(msg);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+		if (radio_band_gsm_from_string(value, &band) =3D=3D FALSE)
+			return __ofono_error_invalid_args(msg);
+
+		if (rs->band_gsm =3D=3D band)
+			return dbus_message_new_method_return(msg);
+
+		rs->pending =3D dbus_message_ref(msg);
+		rs->pending_band_gsm =3D band;
+
+		rs->driver->set_band(rs, band, rs->band_umts,
+					radio_band_set_callback, rs);
+
+		return NULL;
+	} else if (g_strcmp0(property, "UmtsBand") =3D=3D 0) {
+		const char *value;
+		enum ofono_radio_band_umts band;
+
+		if (!rs->driver->set_band)
+			return __ofono_error_not_implemented(msg);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+		if (radio_band_umts_from_string(value, &band) =3D=3D FALSE)
+			return __ofono_error_invalid_args(msg);
+
+		if (rs->band_umts =3D=3D band)
+			return dbus_message_new_method_return(msg);
+
+		rs->pending =3D dbus_message_ref(msg);
+		rs->pending_band_umts =3D band;
+
+		rs->driver->set_band(rs, rs->band_gsm, band,
+					radio_band_set_callback, rs);
+
+		return NULL;
 	} else if (g_strcmp0(property, "FastDormancy") =3D=3D 0) {
 		dbus_bool_t value;
 		int target;
-- =

1.7.3.2


--===============6169964253531468407==--

