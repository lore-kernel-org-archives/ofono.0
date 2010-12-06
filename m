Content-Type: multipart/mixed; boundary="===============8842777004421416133=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 11/14] call-settings: add CNAP support
Date: Mon, 06 Dec 2010 18:12:39 -0200
Message-ID: <1291666362-19128-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-10-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8842777004421416133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-settings.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++-=
---
 1 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index 2bf54d3..b6c3924 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -55,6 +55,13 @@ enum clip_status {
 	CLIP_STATUS_UNKNOWN
 };
 =

+/* 27.007 Section 7.30 */
+enum cnap_status {
+	CNAP_STATUS_NOT_PROVISIONED =3D 0,
+	CNAP_STATUS_PROVISIONED,
+	CNAP_STATUS_UNKNOWN
+};
+
 /* 27.007 Section 7.8 */
 enum colp_status {
 	COLP_STATUS_NOT_PROVISIONED =3D 0,
@@ -71,6 +78,7 @@ enum colr_status {
 =

 enum call_setting_type {
 	CALL_SETTING_TYPE_CLIP =3D 0,
+	CALL_SETTING_TYPE_CNAP,
 	CALL_SETTING_TYPE_COLP,
 	CALL_SETTING_TYPE_COLR,
 	CALL_SETTING_TYPE_CLIR,
@@ -81,6 +89,7 @@ struct ofono_call_settings {
 	int clir;
 	int colr;
 	int clip;
+	int cnap;
 	int colp;
 	int clir_setting;
 	int cw;
@@ -108,6 +117,18 @@ static const char *clip_status_to_string(int status)
 	return "unknown";
 }
 =

+static const char *cnap_status_to_string(int status)
+{
+	switch (status) {
+	case CNAP_STATUS_NOT_PROVISIONED:
+		return "disabled";
+	case CNAP_STATUS_PROVISIONED:
+		return "enabled";
+	}
+
+	return "unknown";
+}
+
 static const char *colp_status_to_string(int status)
 {
 	switch (status) {
@@ -228,6 +249,28 @@ static void set_clip(struct ofono_call_settings *cs, i=
nt clip)
 						DBUS_TYPE_STRING, &str);
 }
 =

+static void set_cnap(struct ofono_call_settings *cs, int cnap)
+{
+	DBusConnection *conn;
+	const char *path;
+	const char *str;
+
+	if (cs->cnap =3D=3D cnap)
+		return;
+
+	cs->cnap =3D cnap;
+
+	conn =3D ofono_dbus_get_connection();
+	path =3D __ofono_atom_get_path(cs->atom);
+
+	str =3D cnap_status_to_string(cnap);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_CALL_SETTINGS_INTERFACE,
+						"CallingNamePresentation",
+						DBUS_TYPE_STRING, &str);
+}
+
 static void set_colp(struct ofono_call_settings *cs, int colp)
 {
 	DBusConnection *conn;
@@ -520,7 +563,7 @@ static void generate_ss_query_reply(struct ofono_call_s=
ettings *cs,
 	__ofono_dbus_pending_reply(&cs->pending, reply);
 }
 =

-static void clip_colp_colr_ss_query_cb(const struct ofono_error *error,
+static void clip_cnap_colp_colr_ss_query_cb(const struct ofono_error *erro=
r,
 					int status, void *data)
 {
 	struct ofono_call_settings *cs =3D data;
@@ -542,6 +585,13 @@ static void clip_colp_colr_ss_query_cb(const struct of=
ono_error *error,
 		context =3D "CallingLinePresentation";
 		break;
 =

+	case CALL_SETTING_TYPE_CNAP:
+		set_cnap(cs, status);
+		value =3D cnap_status_to_string(status);
+		context =3D "CallingNamePresentation";
+		break;
+
+
 	case CALL_SETTING_TYPE_COLP:
 		set_colp(cs, status);
 		value =3D colp_status_to_string(status);
@@ -557,14 +607,14 @@ static void clip_colp_colr_ss_query_cb(const struct o=
fono_error *error,
 	default:
 		__ofono_dbus_pending_reply(&cs->pending,
 				__ofono_error_failed(cs->pending));
-		ofono_error("Unknown type during COLR/COLP/CLIP ss");
+		ofono_error("Unknown type during COLR/COLP/CLIP/CNAP ss");
 		return;
 	};
 =

 	generate_ss_query_reply(cs, context, value);
 }
 =

-static gboolean clip_colp_colr_ss(int type,
+static gboolean clip_cnap_colp_colr_ss(int type,
 				const char *sc, const char *sia,
 				const char *sib, const char *sic,
 				const char *dn, DBusMessage *msg, void *data)
@@ -587,6 +637,9 @@ static gboolean clip_colp_colr_ss(int type,
 	if (!strcmp(sc, "30")) {
 		cs->ss_setting =3D CALL_SETTING_TYPE_CLIP;
 		query_op =3D cs->driver->clip_query;
+	} else if (!strcmp(sc, "300")) {
+		cs->ss_setting =3D CALL_SETTING_TYPE_CNAP;
+		query_op =3D cs->driver->cnap_query;
 	} else if (!strcmp(sc, "76")) {
 		cs->ss_setting =3D CALL_SETTING_TYPE_COLP;
 		query_op =3D cs->driver->colp_query;
@@ -612,11 +665,11 @@ static gboolean clip_colp_colr_ss(int type,
 		return TRUE;
 	}
 =

-	DBG("Received CLIP/COLR/COLP query ss control");
+	DBG("Received CLIP/CNAP/COLR/COLP query ss control");
 =

 	cs->pending =3D dbus_message_ref(msg);
 =

-	query_op(cs, clip_colp_colr_ss_query_cb, cs);
+	query_op(cs, clip_cnap_colp_colr_ss_query_cb, cs);
 =

 	return TRUE;
 }
@@ -762,15 +815,19 @@ static gboolean clir_ss_control(int type,
 =

 static void cs_register_ss_controls(struct ofono_call_settings *cs)
 {
-	__ofono_ussd_ssc_register(cs->ussd, "30", clip_colp_colr_ss, cs, NULL);
+	__ofono_ussd_ssc_register(cs->ussd, "30", clip_cnap_colp_colr_ss,
+								cs, NULL);
 	__ofono_ussd_ssc_register(cs->ussd, "31", clir_ss_control, cs, NULL);
-	__ofono_ussd_ssc_register(cs->ussd, "76", clip_colp_colr_ss, cs, NULL);
+	__ofono_ussd_ssc_register(cs->ussd, "76", clip_cnap_colp_colr_ss,
+								cs, NULL);
+	__ofono_ussd_ssc_register(cs->ussd, "300", clip_cnap_colp_colr_ss,
+								cs, NULL);
 =

 	__ofono_ussd_ssc_register(cs->ussd, "43", cw_ss_control, cs, NULL);
 =

 	if (cs->driver->colr_query)
 		__ofono_ussd_ssc_register(cs->ussd, "77",
-						clip_colp_colr_ss, cs, NULL);
+					clip_cnap_colp_colr_ss, cs, NULL);
 }
 =

 static void cs_unregister_ss_controls(struct ofono_call_settings *cs)
@@ -778,6 +835,7 @@ static void cs_unregister_ss_controls(struct ofono_call=
_settings *cs)
 	__ofono_ussd_ssc_unregister(cs->ussd, "30");
 	__ofono_ussd_ssc_unregister(cs->ussd, "31");
 	__ofono_ussd_ssc_unregister(cs->ussd, "76");
+	__ofono_ussd_ssc_unregister(cs->ussd, "300");
 =

 	__ofono_ussd_ssc_unregister(cs->ussd, "43");
 =

@@ -812,6 +870,10 @@ static DBusMessage *generate_get_properties_reply(stru=
ct ofono_call_settings *cs
 	ofono_dbus_dict_append(&dict, "CallingLinePresentation",
 				DBUS_TYPE_STRING, &str);
 =

+	str =3D cnap_status_to_string(cs->clip);
+	ofono_dbus_dict_append(&dict, "CallingNamePresentation",
+				DBUS_TYPE_STRING, &str);
+
 	str =3D colp_status_to_string(cs->colp);
 	ofono_dbus_dict_append(&dict, "CalledLinePresentation",
 				DBUS_TYPE_STRING, &str);
@@ -872,6 +934,27 @@ static void query_clir(struct ofono_call_settings *cs)
 	cs->driver->clir_query(cs, cs_clir_callback, cs);
 }
 =

+static void cs_cnap_callback(const struct ofono_error *error,
+				int state, void *data)
+{
+	struct ofono_call_settings *cs =3D data;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		set_cnap(cs, state);
+
+	query_clir(cs);
+}
+
+static void query_cnap(struct ofono_call_settings *cs)
+{
+	if (cs->driver->cnap_query =3D=3D NULL) {
+		query_clir(cs);
+		return;
+	}
+
+	cs->driver->cnap_query(cs, cs_cnap_callback, cs);
+}
+
 static void cs_clip_callback(const struct ofono_error *error,
 				int state, void *data)
 {
@@ -880,7 +963,7 @@ static void cs_clip_callback(const struct ofono_error *=
error,
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 		set_clip(cs, state);
 =

-	query_clir(cs);
+	query_cnap(cs);
 }
 =

 static void query_clip(struct ofono_call_settings *cs)
@@ -1260,6 +1343,7 @@ struct ofono_call_settings *ofono_call_settings_creat=
e(struct ofono_modem *modem
 =

 	/* Set all the settings to unknown state */
 	cs->clip =3D 2;
+	cs->cnap =3D 2;
 	cs->clir =3D 2;
 	cs->colp =3D 2;
 	cs->colr =3D 2;
-- =

1.7.3.2


--===============8842777004421416133==--

