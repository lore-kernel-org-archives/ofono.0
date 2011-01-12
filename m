Content-Type: multipart/mixed; boundary="===============4056167747144446394=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 6/9] call-settings: add support for cdip
Date: Wed, 12 Jan 2011 09:27:44 -0200
Message-ID: <1294831667-7447-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294831667-7447-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4056167747144446394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-settings.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index 4dac2b6..0214abf 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -69,6 +69,13 @@ enum colp_status {
 	COLP_STATUS_UNKNOWN =3D 2
 };
 =

+/* 27.007 Section 7.9 */
+enum cdip_status {
+	CDIP_STATUS_NOT_PROVISIONED =3D		0,
+	CDIP_STATUS_PROVISIONED =3D		1,
+	CDIP_STATUS_UNKNOWN =3D			2
+};
+
 /* This is not defined in 27.007, but presumably the same as CLIP/COLP */
 enum colr_status {
 	COLR_STATUS_NOT_PROVISIONED =3D 0,
@@ -79,6 +86,7 @@ enum colr_status {
 enum call_setting_type {
 	CALL_SETTING_TYPE_CLIP =3D 0,
 	CALL_SETTING_TYPE_CNAP,
+	CALL_SETTING_TYPE_CDIP,
 	CALL_SETTING_TYPE_COLP,
 	CALL_SETTING_TYPE_COLR,
 	CALL_SETTING_TYPE_CLIR,
@@ -90,6 +98,7 @@ struct ofono_call_settings {
 	int colr;
 	int clip;
 	int cnap;
+	int cdip;
 	int colp;
 	int clir_setting;
 	int cw;
@@ -117,6 +126,18 @@ static const char *clip_status_to_string(int status)
 	return "unknown";
 }
 =

+static const char *cdip_status_to_string(int status)
+{
+	switch (status) {
+	case CDIP_STATUS_NOT_PROVISIONED:
+		return "disabled";
+	case CDIP_STATUS_PROVISIONED:
+		return "enabled";
+	}
+
+	return "unknown";
+}
+
 static const char *cnap_status_to_string(int status)
 {
 	switch (status) {
@@ -227,6 +248,28 @@ static void set_clir_override(struct ofono_call_settin=
gs *cs, int override)
 						DBUS_TYPE_STRING, &str);
 }
 =

+static void set_cdip(struct ofono_call_settings *cs, int cdip)
+{
+	DBusConnection *conn;
+	const char *path;
+	const char *str;
+
+	if (cs->cdip =3D=3D cdip)
+		return;
+
+	cs->cdip =3D cdip;
+
+	conn =3D ofono_dbus_get_connection();
+	path =3D __ofono_atom_get_path(cs->atom);
+
+	str =3D cdip_status_to_string(cdip);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_CALL_SETTINGS_INTERFACE,
+						"CalledLinePresentation",
+						DBUS_TYPE_STRING, &str);
+}
+
 static void set_clip(struct ofono_call_settings *cs, int clip)
 {
 	DBusConnection *conn;
@@ -882,6 +925,10 @@ static DBusMessage *generate_get_properties_reply(stru=
ct ofono_call_settings *cs
 	ofono_dbus_dict_append(&dict, "ConnectedLineRestriction",
 				DBUS_TYPE_STRING, &str);
 =

+	str =3D cdip_status_to_string(cs->cdip);
+	ofono_dbus_dict_append(&dict, "CalledLinePresentation",
+				DBUS_TYPE_STRING, &str);
+
 	str =3D clir_status_to_string(cs->clir);
 	ofono_dbus_dict_append(&dict, "CallingLineRestriction",
 				DBUS_TYPE_STRING, &str);
@@ -934,6 +981,28 @@ static void query_clir(struct ofono_call_settings *cs)
 	cs->driver->clir_query(cs, cs_clir_callback, cs);
 }
 =

+static void cs_cdip_callback(const struct ofono_error *error,
+				int state, void *data)
+{
+	struct ofono_call_settings *cs =3D data;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		set_cdip(cs, state);
+
+	query_clir(cs);
+}
+
+static void query_cdip(struct ofono_call_settings *cs)
+{
+	if (cs->driver->cdip_query =3D=3D NULL) {
+		query_clir(cs);
+		return;
+	}
+
+	cs->driver->cdip_query(cs, cs_cdip_callback, cs);
+}
+
+
 static void cs_cnap_callback(const struct ofono_error *error,
 				int state, void *data)
 {
@@ -942,13 +1011,13 @@ static void cs_cnap_callback(const struct ofono_erro=
r *error,
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 		set_cnap(cs, state);
 =

-	query_clir(cs);
+	query_cdip(cs);
 }
 =

 static void query_cnap(struct ofono_call_settings *cs)
 {
 	if (cs->driver->cnap_query =3D=3D NULL) {
-		query_clir(cs);
+		query_cdip(cs);
 		return;
 	}
 =

-- =

1.7.3.5


--===============4056167747144446394==--

