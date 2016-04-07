Content-Type: multipart/mixed; boundary="===============7563022299978477253=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] radio-settings: Add RAT mode to ofono storage
Date: Thu, 07 Apr 2016 10:59:26 +0530
Message-ID: <1460006966-7104-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7563022299978477253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Anirudh Gargi <anirudh.gargi@intel.com>

---
 src/radio-settings.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index bc1c691..33d498a 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -33,7 +33,10 @@
 =

 #include "ofono.h"
 #include "common.h"
+#include "storage.h"
 =

+#define SETTINGS_STORE "radiosetting"
+#define SETTINGS_GROUP "Settings"
 #define RADIO_SETTINGS_FLAG_CACHED 0x1
 =

 static GSList *g_drivers =3D NULL;
@@ -50,6 +53,8 @@ struct ofono_radio_settings {
 	enum ofono_radio_band_umts pending_band_umts;
 	ofono_bool_t fast_dormancy_pending;
 	uint32_t available_rats;
+	GKeyFile *settings;
+	char *imsi;
 	const struct ofono_radio_settings_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -574,6 +579,14 @@ static DBusMessage *radio_set_property(DBusConnection =
*conn, DBusMessage *msg,
 =

 		rs->driver->set_rat_mode(rs, mode, radio_mode_set_callback, rs);
 =

+		if (rs->settings) {
+			const char *mode_str;
+			mode_str =3D radio_access_mode_to_string(mode);
+			g_key_file_set_string(rs->settings, SETTINGS_GROUP,
+					"TechnologyPreference", mode_str);
+			storage_sync(rs->imsi, SETTINGS_STORE, rs->settings);
+		}
+
 		return NULL;
 	} else if (g_strcmp0(property, "GsmBand") =3D=3D 0) {
 		const char *value;
@@ -697,6 +710,14 @@ static void radio_settings_unregister(struct ofono_ato=
m *atom)
 =

 	ofono_modem_remove_interface(modem, OFONO_RADIO_SETTINGS_INTERFACE);
 	g_dbus_unregister_interface(conn, path, OFONO_RADIO_SETTINGS_INTERFACE);
+
+	if (rs->settings) {
+		storage_close(rs->imsi, SETTINGS_STORE, rs->settings, TRUE);
+
+		g_free(rs->imsi);
+		rs->imsi =3D NULL;
+		rs->settings =3D NULL;
+	}
 }
 =

 static void radio_settings_remove(struct ofono_atom *atom)
@@ -750,7 +771,7 @@ struct ofono_radio_settings *ofono_radio_settings_creat=
e(struct ofono_modem *mod
 	return rs;
 }
 =

-void ofono_radio_settings_register(struct ofono_radio_settings *rs)
+static void ofono_radio_finish_register(struct ofono_radio_settings *rs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(rs->atom);
@@ -762,14 +783,97 @@ void ofono_radio_settings_register(struct ofono_radio=
_settings *rs)
 					NULL, rs, NULL)) {
 		ofono_error("Could not create %s interface",
 				OFONO_RADIO_SETTINGS_INTERFACE);
-
 		return;
 	}
 =

 	ofono_modem_add_interface(modem, OFONO_RADIO_SETTINGS_INTERFACE);
+
 	__ofono_atom_register(rs->atom, radio_settings_unregister);
 }
 =

+static void radio_mode_set_callback_at_reg(const struct ofono_error *error=
, void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		DBG("Error setting radio access mode register time");
+
+	/*
+	 * Continue with atom register even if request fail at modem
+	 */
+	ofono_radio_finish_register(rs);
+}
+
+static void radio_load_settings(struct ofono_radio_settings *rs,
+					const char *imsi)
+{
+	GError *error;
+	char *strmode;
+
+	rs->imsi =3D g_strdup(imsi);
+	rs->settings =3D storage_open(rs->imsi, SETTINGS_STORE);
+
+	/*
+	 * If no settings present or error; Set default.
+	 * Default RAT mode: ANY (LTE > UMTS > GSM)
+	 */
+
+	if (rs->settings =3D=3D NULL) {
+		DBG("radiosetting storage open failed");
+		rs->mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+		return;
+	}
+
+	error =3D NULL;
+	strmode =3D g_key_file_get_string(rs->settings, SETTINGS_GROUP,
+					"TechnologyPreference", &error);
+
+	if (error) {
+		g_error_free(error);
+		goto setdefault;
+	}
+
+	if (radio_access_mode_from_string(strmode, &rs->mode) =3D=3D FALSE) {
+		DBG("Invalid rat mode in storage; Setting default");
+		goto setdefault;
+	}
+
+	g_free(strmode);
+	return;
+
+setdefault:
+	rs->mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+	g_key_file_set_string(rs->settings, SETTINGS_GROUP,
+					"TechnologyPreference", "any");
+	storage_sync(rs->imsi, SETTINGS_STORE, rs->settings);
+	g_free(strmode);
+}
+
+void ofono_radio_settings_register(struct ofono_radio_settings *rs)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(rs->atom);
+	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+
+	if (sim =3D=3D NULL)
+		goto finish;
+
+	radio_load_settings(rs, ofono_sim_get_imsi(sim));
+
+	if (rs->driver->set_rat_mode =3D=3D NULL)
+		goto finish;
+
+	/*
+	 * Diff callback used. No need of using DBUS pending concept.
+	 * As its atom registration time - no DBUS clients.
+	 */
+	rs->driver->set_rat_mode(rs, rs->mode,
+					radio_mode_set_callback_at_reg, rs);
+	return;
+
+finish:
+	ofono_radio_finish_register(rs);
+}
+
 void ofono_radio_settings_remove(struct ofono_radio_settings *rs)
 {
 	__ofono_atom_free(rs->atom);
-- =

1.9.1


--===============7563022299978477253==--

