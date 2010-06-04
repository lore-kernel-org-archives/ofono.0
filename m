Content-Type: multipart/mixed; boundary="===============6964311796791964570=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 4/6] SetProperty for UseDeliveryReports.
Date: Fri, 04 Jun 2010 14:17:35 +0300
Message-ID: <1275650257-30593-5-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1275650257-30593-4-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6964311796791964570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c       |   34 +++++++++++++++++++++++++++++++++-
 src/smsutil.c   |    5 +++--
 src/smsutil.h   |    3 ++-
 test/send-sms   |    7 ++++++-
 unit/test-sms.c |   10 +++++-----
 5 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 14748c6..16a4d41 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -67,6 +67,7 @@ struct ofono_sms {
 	const struct ofono_sms_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	gboolean use_delivery_reports;
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
+		gboolean value;
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
@@ -1004,6 +1030,9 @@ static void sms_remove(struct ofono_atom *atom)
 					"NextMessageId", sms->next_msg_id);
 		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
 					"NextReference", sms->ref);
+		g_key_file_set_boolean(sms->settings, SETTINGS_GROUP,
+					"UseDeliveryReports",
+					sms->use_delivery_reports);
 =

 		storage_close(sms->imsi, SETTINGS_STORE, sms->settings, TRUE);
 =

@@ -1090,6 +1119,9 @@ static void sms_load_settings(struct ofono_sms *sms, =
const char *imsi)
 							"NextMessageId", NULL);
 	sms->ref =3D g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
 							"NextReference", NULL);
+	sms->use_delivery_reports =3D
+		g_key_file_get_boolean(sms->settings, SETTINGS_GROUP,
+					"UseDeliveryReports", NULL);
 =

 	if (sms->ref >=3D 65536)
 		sms->ref =3D 1;
diff --git a/src/smsutil.c b/src/smsutil.c
index 30c1250..a92089b 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2642,7 +2642,8 @@ static inline GSList *sms_list_append(GSList *l, cons=
t struct sms *in)
  * if no concatenation took place.
  */
 GSList *sms_text_prepare(const char *utf8, guint16 ref,
-				gboolean use_16bit, int *ref_offset)
+				gboolean use_16bit, int *ref_offset,
+				const gboolean use_delivery_reports)
 {
 	struct sms template;
 	int offset =3D 0;
@@ -2658,7 +2659,7 @@ GSList *sms_text_prepare(const char *utf8, guint16 re=
f,
 	template.submit.rd =3D FALSE;
 	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_RELATIVE;
 	template.submit.rp =3D FALSE;
-	template.submit.srr =3D FALSE;
+	template.submit.srr =3D use_delivery_reports;
 	template.submit.mr =3D 0;
 	template.submit.vp.relative =3D 0xA7; /* 24 Hours */
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index a36a9d3..cfb2765 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -482,7 +482,8 @@ GSList *sms_assembly_add_fragment(struct sms_assembly *=
assembly,
 void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
 =

 GSList *sms_text_prepare(const char *utf8, guint16 ref,
-				gboolean use_16bit, int *ref_offset);
+				gboolean use_16bit, int *ref_offset,
+				const gboolean use_delivery_reports);
 =

 gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, enum sms_class *cls,
 			enum sms_charset *charset, gboolean *compressed,
diff --git a/test/send-sms b/test/send-sms
index 8024fda..7c1e56e 100755
--- a/test/send-sms
+++ b/test/send-sms
@@ -15,4 +15,9 @@ path =3D properties["Modems"][0]
 manager =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.SmsManager')
 =

-manager.SendMessage(sys.argv[1], sys.argv[2])
+if sys.argv[3] =3D=3D "1":
+	manager.SetProperty("UseDeliveryReports", dbus.Boolean(1))
+	manager.SendMessage(sys.argv[1], sys.argv[2])
+else:
+	manager.SetProperty("UseDeliveryReports", dbus.Boolean(0))
+	manager.SendMessage(sys.argv[1], sys.argv[2])
diff --git a/unit/test-sms.c b/unit/test-sms.c
index d7d97f3..9a20897 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -685,7 +685,7 @@ static void test_assembly()
 	if (g_test_verbose())
 		g_printf("Text:\n%s\n", utf8);
 =

-	l =3D sms_text_prepare(utf8, ref, TRUE, NULL);
+	l =3D sms_text_prepare(utf8, ref, TRUE, NULL, FALSE);
 	g_assert(l);
 	g_assert(g_slist_length(l) =3D=3D 3);
 =

@@ -715,7 +715,7 @@ static void test_prepare_7bit()
 	int encoded_tpdu_len;
 	char *encoded_pdu;
 =

-	r =3D sms_text_prepare(test_no_fragmentation_7bit, 0, FALSE, NULL);
+	r =3D sms_text_prepare(test_no_fragmentation_7bit, 0, FALSE, NULL, FALSE);
 =

 	g_assert(r !=3D NULL);
 =

@@ -798,7 +798,7 @@ static void test_prepare_concat(gconstpointer data)
 	if (g_test_verbose())
 		g_print("strlen: %zd\n", strlen(test->str));
 =

-	r =3D sms_text_prepare(test->str, 0, TRUE, NULL);
+	r =3D sms_text_prepare(test->str, 0, TRUE, NULL, FALSE);
 =

 	g_assert(r);
 	g_assert(g_slist_length(r) =3D=3D test->segments);
@@ -875,7 +875,7 @@ static void test_limit(gunichar uni, int target_size, g=
boolean use_16bit)
 =

 	utf8[i] =3D '\0';
 =

-	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL);
+	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL, FALSE);
 =

 	g_assert(l);
 	g_assert(g_slist_length(l) =3D=3D 255);
@@ -888,7 +888,7 @@ static void test_limit(gunichar uni, int target_size, g=
boolean use_16bit)
 	memcpy(utf8 + i, utf8_char, stride);
 	utf8[i+stride] =3D '\0';
 =

-	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL);
+	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL, FALSE);
 =

 	g_assert(l =3D=3D NULL);
 	g_free(utf8);
-- =

1.6.0.4



--===============6964311796791964570==--

