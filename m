Content-Type: multipart/mixed; boundary="===============7117834547446518273=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/7] call-forwarding: Read/Write cfis/cphs-cff
Date: Thu, 16 Dec 2010 23:04:31 -0800
Message-ID: <1292569471-20952-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1292007409-15069-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7117834547446518273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |  243 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 241 insertions(+), 2 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index bb8aa37..ed67b21 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -34,6 +34,7 @@
 #include "ofono.h"
 =

 #include "common.h"
+#include "simutil.h"
 =

 #define CALL_FORWARDING_FLAG_CACHED 0x1
 =

@@ -58,6 +59,11 @@ struct ofono_call_forwarding {
 	int query_next;
 	int query_end;
 	struct cf_ss_request *ss_req;
+	struct ofono_sim *sim;
+	unsigned char cfis_record_id;
+	unsigned char cfis_indicator;
+	ofono_bool_t cphs_cff_present;
+	ofono_bool_t status_on_sim;
 	struct ofono_ussd *ussd;
 	unsigned int ussd_watch;
 	const struct ofono_call_forwarding_driver *driver;
@@ -202,6 +208,83 @@ static const char *cf_type_lut[] =3D {
 	"AllConditional"
 };
 =

+static void sim_cfis_update_cb(int ok, void *data)
+{
+	if (!ok)
+		ofono_info("Failed to update EFcfis");
+}
+
+static void sim_cphs_cff_update_cb(int ok, void *data)
+{
+	if (!ok)
+		ofono_info("Failed to update EFcphs-cff");
+}
+
+static void sim_set_cf_indicator(struct ofono_call_forwarding *cf)
+{
+	gboolean cfu_voice =3D FALSE;
+	struct ofono_call_forwarding_condition *cond =3D NULL;
+	GSList *l;
+	const char *number =3D NULL;
+
+	/*
+	 * For now we only support Voice, although Fax & all Data
+	 * basic services are applicable as well.
+	 */
+	for (l =3D cf->cf_conditions[0]; l; l =3D l->next) {
+		cond =3D l->data;
+
+		if ((cond->cls & BEARER_CLASS_VOICE) &&
+				(strlen(cond->phone_number.number) > 0)) {
+			number =3D phone_number_to_string(&cond->phone_number);
+			cfu_voice =3D TRUE;
+			break;
+		}
+	}
+
+	cf->status_on_sim =3D cfu_voice;
+
+	if (cf->cfis_record_id) {
+		unsigned char data[16];
+		int number_len;
+
+		memset(data, 0xff, sizeof(data));
+
+		/* Profile Identifier */
+		data[0] =3D 0x01;
+
+		if (cfu_voice) {
+			number_len =3D strlen(cond->phone_number.number);
+
+			/* CFU indicator Status - Voice */
+			data[1] =3D (cf->cfis_indicator |=3D 0x01);
+			number_len =3D (number_len + 1) / 2;
+			data[2] =3D number_len + 1;
+			data[3] =3D cond->phone_number.type;
+
+			sim_encode_bcd_number(cond->phone_number.number,
+						data + 4);
+		} else
+			data[1] =3D (cf->cfis_indicator &=3D 0xFE);
+
+		ofono_sim_write(cf->sim, SIM_EFCFIS_FILEID,
+					sim_cfis_update_cb,
+					OFONO_SIM_FILE_STRUCTURE_FIXED,
+					cf->cfis_record_id, data,
+					sizeof(data), cf);
+		return;
+	}
+
+	if (cf->cphs_cff_present) {
+		unsigned char cff_voice =3D cfu_voice ? 0x0A : 0x05;
+
+		ofono_sim_write(cf->sim, SIM_EF_CPHS_CFF_FILEID,
+					sim_cphs_cff_update_cb,
+					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					0, &cff_voice, sizeof(cff_voice), cf);
+	}
+}
+
 static void set_new_cond_list(struct ofono_call_forwarding *cf,
 				int type, GSList *list)
 {
@@ -216,6 +299,7 @@ static void set_new_cond_list(struct ofono_call_forward=
ing *cf,
 	dbus_uint16_t timeout;
 	char attr[64];
 	char tattr[64];
+	gboolean update_sim =3D FALSE;
 =

 	for (l =3D list; l; l =3D l->next) {
 		lc =3D l->data;
@@ -246,12 +330,16 @@ static void set_new_cond_list(struct ofono_call_forwa=
rding *cf,
 =

 			if (oc->phone_number.type !=3D lc->phone_number.type ||
 				strcmp(oc->phone_number.number,
-					lc->phone_number.number))
+					lc->phone_number.number)) {
 				ofono_dbus_signal_property_changed(conn, path,
 						OFONO_CALL_FORWARDING_INTERFACE,
 						attr, DBUS_TYPE_STRING,
 						&number);
 =

+				if (type =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL)
+					update_sim =3D TRUE;
+			}
+
 			if (type =3D=3D CALL_FORWARDING_TYPE_NO_REPLY &&
 				oc->time !=3D lc->time)
 				ofono_dbus_signal_property_changed(conn, path,
@@ -270,6 +358,9 @@ static void set_new_cond_list(struct ofono_call_forward=
ing *cf,
 						attr, DBUS_TYPE_STRING,
 						&number);
 =

+			if (type =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL)
+				update_sim =3D TRUE;
+
 			if (type =3D=3D CALL_FORWARDING_TYPE_NO_REPLY &&
 				lc->time !=3D DEFAULT_NO_REPLY_TIMEOUT)
 				ofono_dbus_signal_property_changed(conn, path,
@@ -302,6 +393,9 @@ static void set_new_cond_list(struct ofono_call_forward=
ing *cf,
 					OFONO_CALL_FORWARDING_INTERFACE, attr,
 					DBUS_TYPE_STRING, &number);
 =

+		if (type =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL)
+			update_sim =3D TRUE;
+
 		if (type =3D=3D CALL_FORWARDING_TYPE_NO_REPLY &&
 			oc->time !=3D DEFAULT_NO_REPLY_TIMEOUT)
 			ofono_dbus_signal_property_changed(conn, path,
@@ -312,6 +406,9 @@ static void set_new_cond_list(struct ofono_call_forward=
ing *cf,
 =

 	cf_list_clear(old);
 	cf->cf_conditions[type] =3D list;
+
+	if (update_sim =3D=3D TRUE)
+		sim_set_cf_indicator(cf);
 }
 =

 static inline void property_append_cf_condition(DBusMessageIter *dict, int=
 cls,
@@ -372,6 +469,7 @@ static DBusMessage *cf_get_properties_reply(DBusMessage=
 *msg,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	int i;
+	dbus_bool_t status;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -388,6 +486,10 @@ static DBusMessage *cf_get_properties_reply(DBusMessag=
e *msg,
 						BEARER_CLASS_VOICE,
 						cf_type_lut[i]);
 =

+	status =3D cf->status_on_sim;
+	ofono_dbus_dict_append(&dict, "ForwardingFlagOnSim", DBUS_TYPE_BOOLEAN,
+					&status);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -431,8 +533,10 @@ static DBusMessage *cf_get_properties(DBusConnection *=
conn, DBusMessage *msg,
 					void *data)
 {
 	struct ofono_call_forwarding *cf =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
 =

-	if (cf->flags & CALL_FORWARDING_FLAG_CACHED)
+	if ((cf->flags & CALL_FORWARDING_FLAG_CACHED) ||
+			ofono_modem_get_online(modem) =3D=3D FALSE)
 		return cf_get_properties_reply(msg, cf);
 =

 	if (cf->driver->query =3D=3D NULL)
@@ -590,12 +694,16 @@ static DBusMessage *cf_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 					void *data)
 {
 	struct ofono_call_forwarding *cf =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
 	DBusMessageIter iter;
 	DBusMessageIter var;
 	const char *property;
 	int cls;
 	int type;
 =

+	if (ofono_modem_get_online(modem) =3D=3D FALSE)
+		return __ofono_error_not_available(msg);
+
 	if (__ofono_call_forwarding_is_busy(cf) ||
 			__ofono_ussd_is_busy(cf->ussd))
 		return __ofono_error_busy(msg);
@@ -1111,6 +1219,128 @@ gboolean __ofono_call_forwarding_is_busy(struct ofo=
no_call_forwarding *cf)
 	return cf->pending ? TRUE : FALSE;
 }
 =

+static void sim_cfis_read_cb(int ok, int total_length, int record,
+			const unsigned char *data,
+			int record_length, void *userdata)
+{
+	struct ofono_call_forwarding *cf =3D userdata;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(cf->atom);
+
+	if (!ok || record_length < 16 || total_length < record_length) {
+		cf->cfis_indicator =3D 0;
+		cf->cfis_record_id =3D 0;
+		return;
+	}
+
+	/*
+	 * Multiple Subscriber Profile number which can have values 1-4.
+	 * Profile id 1 is assumed as the current profile.
+	 */
+	if (data[0] !=3D 1)
+		return;
+
+	cf->cfis_record_id =3D record;
+
+	/* CFU indicator status */
+	cf->cfis_indicator =3D data[1];
+
+	/*
+	 * For now we only support Voice, although Fax & all Data
+	 * basic services are applicable as well.
+	 */
+	if (cf->cfis_indicator & 0x01) {
+		int ton_npi;
+		int number_len;
+		const char *number;
+		char attr[64];
+		struct ofono_call_forwarding_condition *cond;
+		GSList *l =3D NULL;
+		dbus_bool_t status;
+
+		number_len =3D data[2];
+		ton_npi =3D data[3];
+
+		if (number_len > 11 || ton_npi =3D=3D 0xff)
+			return;
+
+		cond =3D g_try_new0(struct ofono_call_forwarding_condition, 1);
+		if (cond =3D=3D NULL)
+			return;
+
+		status =3D cf->status_on_sim =3D TRUE;
+		cond->status =3D status;
+		cond->cls =3D BEARER_CLASS_VOICE;
+		cond->time =3D 0;
+		cond->phone_number.type =3D ton_npi;
+
+		sim_extract_bcd_number(data + 4, number_len - 1,
+					cond->phone_number.number);
+		number =3D phone_number_to_string(&cond->phone_number);
+
+		snprintf(attr, sizeof(attr), "%s%s",
+			bearer_class_to_string(BEARER_CLASS_VOICE),
+			cf_type_lut[CALL_FORWARDING_TYPE_UNCONDITIONAL]);
+
+		cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] =3D
+							g_slist_append(l, cond);
+
+		ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CALL_FORWARDING_INTERFACE,
+				attr, DBUS_TYPE_STRING,
+				&number);
+
+		ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CALL_FORWARDING_INTERFACE,
+				"ForwardingFlagOnSim",
+				DBUS_TYPE_BOOLEAN,
+				&status);
+	}
+}
+
+static void sim_cphs_cff_read_cb(int ok, int total_length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_call_forwarding *cf =3D userdata;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(cf->atom);
+	dbus_bool_t cfu_voice;
+
+	if (!ok || total_length < 1) {
+		cf->cphs_cff_present =3D FALSE;
+		return;
+	}
+
+	cf->cphs_cff_present =3D TRUE;
+
+	/*
+	 * For now we only support Voice, although Fax & all Data
+	 * basic services are applicable as well.
+	 */
+	cfu_voice =3D cf->status_on_sim =3D ((data[0] & 0xf) =3D=3D 0xa);
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CALL_FORWARDING_INTERFACE,
+					"ForwardingFlagOnSim",
+					DBUS_TYPE_BOOLEAN,
+					&cfu_voice);
+}
+
+static void sim_read_cf_indicator(struct ofono_call_forwarding *cf)
+{
+	if (__ofono_sim_service_available(cf->sim,
+			SIM_UST_SERVICE_CFIS,
+			SIM_SST_SERVICE_CFIS) =3D=3D TRUE)
+		ofono_sim_read(cf->sim, SIM_EFCFIS_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_FIXED,
+				sim_cfis_read_cb, cf);
+	else
+		ofono_sim_read(cf->sim, SIM_EF_CPHS_CFF_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				sim_cphs_cff_read_cb, cf);
+}
+
 int ofono_call_forwarding_driver_register(const struct ofono_call_forwardi=
ng_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -1219,6 +1449,7 @@ void ofono_call_forwarding_register(struct ofono_call=
_forwarding *cf)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(cf->atom);
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
+	struct ofono_atom *sim_atom;
 	struct ofono_atom *ussd_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
@@ -1233,6 +1464,14 @@ void ofono_call_forwarding_register(struct ofono_cal=
l_forwarding *cf)
 =

 	ofono_modem_add_interface(modem, OFONO_CALL_FORWARDING_INTERFACE);
 =

+	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+
+	if (sim_atom) {
+		cf->sim =3D __ofono_atom_get_data(sim_atom);
+
+		sim_read_cf_indicator(cf);
+	}
+
 	cf->ussd_watch =3D __ofono_modem_add_atom_watch(modem,
 					OFONO_ATOM_TYPE_USSD,
 					ussd_watch, cf, NULL);
-- =

1.7.0.4


--===============7117834547446518273==--

