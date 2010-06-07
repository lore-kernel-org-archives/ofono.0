Content-Type: multipart/mixed; boundary="===============5361946148178083413=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 3/4] SetProperty for UseDeliveryReports. sms.c.
Date: Mon, 07 Jun 2010 12:53:28 +0300
Message-ID: <1275904409-19829-4-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1275904409-19829-3-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5361946148178083413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index c0e9fc4..0bd35c2 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -67,6 +67,7 @@ struct ofono_sms {
 	const struct ofono_sms_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	ofono_bool_t use_delivery_reports;
 };
 =

 struct pending_pdu {
@@ -131,6 +132,9 @@ static DBusMessage *generate_get_properties_reply(struc=
t ofono_sms *sms,
 	ofono_dbus_dict_append(&dict, "ServiceCenterAddress", DBUS_TYPE_STRING,
 				&sca);
 =

+	ofono_dbus_dict_append(&dict, "UseDeliveryReports", DBUS_TYPE_BOOLEAN,
+				&sms->use_delivery_reports);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -260,6 +264,27 @@ static DBusMessage *sms_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 		return NULL;
 	}
 =

+	if (!strcmp(property, "UseDeliveryReports")) {
+		const char *path =3D __ofono_atom_get_path(sms->atom);
+		dbus_bool_t value;
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		sms->use_delivery_reports =3D value;
+
+		g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SMS_MANAGER_INTERFACE,
+						"UseDeliveryReports",
+						DBUS_TYPE_BOOLEAN, &value);
+
+		return NULL;
+	}
+
 	return __ofono_error_invalid_args(msg);
 }
 =

@@ -426,7 +451,8 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	if (valid_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset);
+	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset,
+					sms->use_delivery_reports);
 =

 	if (!msg_list)
 		return __ofono_error_invalid_format(msg);
@@ -895,6 +921,9 @@ static void sms_remove(struct ofono_atom *atom)
 					"NextMessageId", sms->next_msg_id);
 		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
 					"NextReference", sms->ref);
+		g_key_file_set_boolean(sms->settings, SETTINGS_GROUP,
+					"UseDeliveryReports",
+					sms->use_delivery_reports);
 =

 		storage_close(sms->imsi, SETTINGS_STORE, sms->settings, TRUE);
 =

@@ -981,6 +1010,9 @@ static void sms_load_settings(struct ofono_sms *sms, c=
onst char *imsi)
 							"NextMessageId", NULL);
 	sms->ref =3D g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
 							"NextReference", NULL);
+	sms->use_delivery_reports =3D
+		g_key_file_get_boolean(sms->settings, SETTINGS_GROUP,
+					"UseDeliveryReports", NULL);
 =

 	if (sms->ref >=3D 65536)
 		sms->ref =3D 1;
-- =

1.6.0.4



--===============5361946148178083413==--

