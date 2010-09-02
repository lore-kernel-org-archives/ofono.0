Content-Type: multipart/mixed; boundary="===============1478238062140798193=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 3/4] Add alphabet support to SMS atom
Date: Thu, 02 Sep 2010 10:52:39 +0300
Message-ID: <1283413960-31490-3-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1283413960-31490-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1478238062140798193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 2012fe5..8262d0c 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -65,6 +65,7 @@ struct ofono_sms {
 	GKeyFile *settings;
 	char *imsi;
 	int bearer;
+	int alphabet;
 	const struct ofono_sms_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -121,6 +122,39 @@ static int sms_bearer_from_string(const char *str)
 	return -1;
 }
 =

+static const char *sms_alphabet_to_string(int alphabet)
+{
+	switch (alphabet) {
+	case SMS_ALPHABET_TURKISH:
+		return "turkish";
+	case SMS_ALPHABET_SPANISH:
+		return "spanish";
+	case SMS_ALPHABET_PORTUGUESE:
+		return "portuguese";
+	case SMS_ALPHABET_REDUCED:
+		return "reduced";
+	case SMS_ALPHABET_DEFAULT:
+	default:
+		return "default";
+	}
+}
+
+static int sms_alphabet_from_string(const char *str)
+{
+	if (g_str_equal(str, "default"))
+		return SMS_ALPHABET_DEFAULT;
+	else if (g_str_equal(str, "turkish"))
+		return SMS_ALPHABET_TURKISH;
+	else if (g_str_equal(str, "spanish"))
+		return SMS_ALPHABET_SPANISH;
+	else if (g_str_equal(str, "portuguese"))
+		return SMS_ALPHABET_PORTUGUESE;
+	else if (g_str_equal(str, "reduced"))
+		return SMS_ALPHABET_REDUCED;
+
+	return -1;
+}
+
 static void set_bearer(struct ofono_sms *sms, int bearer)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -140,6 +174,25 @@ static void set_bearer(struct ofono_sms *sms, int bear=
er)
 						DBUS_TYPE_STRING, &value);
 }
 =

+static void set_alphabet(struct ofono_sms *sms, int alphabet)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sms->atom);
+	const char *value;
+
+	if (sms->alphabet =3D=3D alphabet)
+		return;
+
+	sms->alphabet =3D alphabet;
+
+	value =3D sms_alphabet_to_string(sms->alphabet);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_MESSAGE_MANAGER_INTERFACE,
+						"Alphabet",
+						DBUS_TYPE_STRING, &value);
+}
+
 static void set_sca(struct ofono_sms *sms,
 			const struct ofono_phone_number *sca)
 {
@@ -171,6 +224,7 @@ static DBusMessage *generate_get_properties_reply(struc=
t ofono_sms *sms,
 	DBusMessageIter dict;
 	const char *sca;
 	const char *bearer;
+	const char *alphabet;
 =

 	reply =3D dbus_message_new_method_return(msg);
 =

@@ -194,6 +248,9 @@ static DBusMessage *generate_get_properties_reply(struc=
t ofono_sms *sms,
 	bearer =3D sms_bearer_to_string(sms->bearer);
 	ofono_dbus_dict_append(&dict, "Bearer", DBUS_TYPE_STRING, &bearer);
 =

+	alphabet =3D sms_alphabet_to_string(sms->alphabet);
+	ofono_dbus_dict_append(&dict, "Alphabet", DBUS_TYPE_STRING, &alphabet);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -403,6 +460,25 @@ static DBusMessage *sms_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 		return NULL;
 	}
 =

+	if (!strcmp(property, "Alphabet")) {
+		const char *value;
+		int alphabet;
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		alphabet =3D sms_alphabet_from_string(value);
+		if (alphabet < 0)
+			return __ofono_error_invalid_format(msg);
+
+		set_alphabet(sms, alphabet);
+
+		g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+		return NULL;
+	}
+
 	return __ofono_error_invalid_args(msg);
 }
 =

@@ -620,8 +696,10 @@ static DBusMessage *sms_send_message(DBusConnection *c=
onn, DBusMessage *msg,
 	if (valid_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset,
-					sms->use_delivery_reports);
+	msg_list =3D sms_text_prepare_with_alphabet(text, 0, TRUE,
+						&ref_offset,
+						sms->use_delivery_reports,
+						sms->alphabet);
 =

 	if (!msg_list)
 		return __ofono_error_invalid_format(msg);
@@ -1146,6 +1224,8 @@ static void sms_remove(struct ofono_atom *atom)
 					sms->use_delivery_reports);
 		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
 					"Bearer", sms->bearer);
+		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
+					"Alphabet", sms->alphabet);
 =

 		storage_close(sms->imsi, SETTINGS_STORE, sms->settings, TRUE);
 =

@@ -1251,6 +1331,9 @@ static void sms_load_settings(struct ofono_sms *sms, =
const char *imsi)
 							"Bearer", &error);
 	if (error)
 		sms->bearer =3D 3; /* Default to CS then PS */
+
+	sms->alphabet =3D g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
+						"Alphabet", &error);
 }
 =

 static void bearer_init_callback(const struct ofono_error *error, void *da=
ta)
-- =

1.7.0.4


--===============1478238062140798193==--

