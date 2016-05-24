Content-Type: multipart/mixed; boundary="===============0376740474570734160=="
MIME-Version: 1.0
From: Rajagopal Aravindan <rajagopalx.aravindan@intel.com>
Subject: [PATCH 1/3] ril_sofia3gr: Modem throttling changes
Date: Tue, 24 May 2016 14:14:17 +0530
Message-ID: <1464079459-6525-1-git-send-email-rajagopalx.aravindan@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0376740474570734160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added 'sofia3gr.ThermalManagement' interface to sofia3gr plugin and
floated 'TransmitPowerThrottling' as an ofono property under that,
to support modem throttling.

'sofia3gr.ThermalManagement'
    1.Will be available ONLY if modem throttling is supported in RIL.
      This is determined by sending a RIL request during ofono start,
      to get current throttling state. If it succeeds, interface is
      published otherwise not.

'TransmitPowerThrottling'
    1.GetProperties will be allowed both when modem is ON & OFF.
    2.GetProperties will be serviced by looking it up from state
      information maintained inside ofono. No RIL call will be made.
    3.SetProperty will be allowed ONLY when modem is ON.
    4.SetProperty request will be forwarded to RIL ONLY if
      new state !=3D current state. If RIL request succeeds, state
      information will be updated and also, a property change signal
      will be emitted.
---
 plugins/ril_sofia3gr.c | 292 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 292 insertions(+)

diff --git a/plugins/ril_sofia3gr.c b/plugins/ril_sofia3gr.c
index ce29d13..f8bf2bb 100644
--- a/plugins/ril_sofia3gr.c
+++ b/plugins/ril_sofia3gr.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <stdbool.h>
 =

 #include <unistd.h>
 #include <glib.h>
@@ -52,11 +53,22 @@
 =

 #include "drivers/rilmodem/rilmodem.h"
 #include "drivers/rilmodem/vendor.h"
+#include "gdbus.h"
+
+#include "ofono.h"
+
+#define THERMAL_MANAGEMENT_INTERFACE OFONO_SERVICE ".sofia3gr.ThermalManag=
ement"
 =

 struct ril_data {
 	GRil *ril;
 };
 =

+struct ril_thermal_management {
+	DBusMessage *pending;
+	struct ofono_modem *modem;
+	dbus_bool_t throttling;
+};
+
 static int ril_send_power(GRil *ril, ofono_bool_t online,
 				GRilResponseFunc func,
 				gpointer user_data,
@@ -129,7 +141,14 @@ static int ril_probe(struct ofono_modem *modem)
 =

 static void ril_remove(struct ofono_modem *modem)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	const char *path =3D ofono_modem_get_path(modem);
+
+	if (g_dbus_unregister_interface(conn, path,
+					THERMAL_MANAGEMENT_INTERFACE))
+		ofono_modem_remove_interface(modem,
+						THERMAL_MANAGEMENT_INTERFACE);
 =

 	ofono_modem_set_data(modem, NULL);
 =

@@ -137,6 +156,270 @@ static void ril_remove(struct ofono_modem *modem)
 	g_free(rd);
 }
 =

+static void set_rf_power_status_cb(struct ril_msg *message, gpointer user_=
data)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ril_thermal_management *tm =3D user_data;
+	struct ril_data *rd =3D ofono_modem_get_data(tm->modem);
+	const char *path =3D ofono_modem_get_path(tm->modem);
+
+	DBG("");
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s RILD reply failure: %s",
+			g_ril_request_id_to_string(rd->ril, message->req),
+			ril_error_to_string(message->error));
+
+		__ofono_dbus_pending_reply(&tm->pending,
+					__ofono_error_failed(tm->pending));
+		return;
+	}
+
+	/* Change the throttling state */
+	tm->throttling =3D tm->throttling ? false : true;
+
+	__ofono_dbus_pending_reply(&tm->pending,
+				dbus_message_new_method_return(tm->pending));
+
+	ofono_dbus_signal_property_changed(conn, path,
+					THERMAL_MANAGEMENT_INTERFACE,
+					"TransmitPowerThrottling",
+					DBUS_TYPE_BOOLEAN,
+					&tm->throttling);
+}
+
+static DBusMessage *set_rf_power_status(DBusMessage *msg,
+					dbus_bool_t enable,
+					void *data)
+{
+	struct ril_thermal_management *tm =3D data;
+	struct ril_data *rd =3D ofono_modem_get_data(tm->modem);
+	struct parcel rilp;
+
+	int cmd_id;
+	char buf[4];
+
+	DBG("");
+
+	if (tm->pending)
+		return __ofono_error_busy(msg);
+
+	parcel_init(&rilp);
+	parcel_w_int32(&rilp, 2);
+	/* RIL_OEM_HOOK_STRING_SET_RF_POWER_STATUS =3D 0x000000AC */
+	cmd_id =3D 0x000000AC;
+	sprintf(buf, "%d", cmd_id);
+	parcel_w_string(&rilp, buf);
+
+	memset(buf, 0, sizeof(buf));
+	sprintf(buf, "%d", enable ? 1 : 0);
+	parcel_w_string(&rilp, buf);
+
+	g_ril_append_print_buf(rd->ril, "{cmd_id=3D0x%02X,arg=3D%s}", cmd_id, buf=
);
+
+	if (g_ril_send(rd->ril, RIL_REQUEST_OEM_HOOK_STRINGS, &rilp,
+			set_rf_power_status_cb, tm, NULL) =3D=3D 0)
+		return __ofono_error_failed(msg);
+
+	tm->pending =3D dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static DBusMessage *thermal_management_set_property(DBusConnection *conn,
+							DBusMessage *msg,
+							void *data)
+{
+	struct ril_thermal_management *tm =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *name;
+	dbus_bool_t throttling;
+
+	DBG("");
+
+	if (!ofono_modem_get_online(tm->modem))
+		return __ofono_error_not_available(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &name);
+
+	if (!strcmp(name, "TransmitPowerThrottling")) {
+		dbus_message_iter_next(&iter);
+
+		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_recurse(&iter, &var);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &throttling);
+
+		if (tm->throttling =3D=3D throttling)
+			/* Ignore set request if new state =3D=3D current state */
+			return dbus_message_new_method_return(msg);
+
+		return set_rf_power_status(msg, throttling, tm);
+	}
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static DBusMessage *thermal_management_get_properties(DBusConnection *conn,
+							DBusMessage *msg,
+							void *data)
+{
+	struct ril_thermal_management *tm =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	DBG("");
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	ofono_dbus_dict_append(&dict, "TransmitPowerThrottling",
+				DBUS_TYPE_BOOLEAN,
+				&tm->throttling);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static const GDBusMethodTable thermal_management_methods[] =3D {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			thermal_management_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, thermal_management_set_property) },
+	{}
+};
+
+static const GDBusSignalTable thermal_management_signals[] =3D {
+	{ GDBUS_SIGNAL("PropertyChanged",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
+};
+
+static void thermal_management_cleanup(void *data)
+{
+	struct ril_thermal_management *tm =3D data;
+
+	if (tm->pending)
+		__ofono_dbus_pending_reply(&tm->pending,
+					__ofono_error_canceled(tm->pending));
+
+	g_free(tm);
+}
+
+static void get_rf_power_status_cb(struct ril_msg *message, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	struct ril_thermal_management *tm;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct parcel rilp;
+	gint numstr;
+	gchar *power_status;
+	char *endptr;
+	int enabled;
+	const char *path =3D ofono_modem_get_path(modem);
+
+	DBG("");
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s RILD reply failure: %s",
+			g_ril_request_id_to_string(rd->ril, message->req),
+			ril_error_to_string(message->error));
+		return;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	numstr =3D parcel_r_int32(&rilp);
+	if (numstr < 1) {
+		ofono_error("RILD reply empty !");
+		return;
+	}
+
+	power_status =3D parcel_r_string(&rilp);
+	if (power_status =3D=3D NULL || power_status =3D=3D '\0')
+		return;
+
+	enabled =3D strtol(power_status, &endptr, 10);
+	/*
+	 * power_status =3D=3D endptr =3D> conversion error
+	 * *endptr !=3D '\0' =3D> partial conversion
+	 */
+	if (power_status =3D=3D endptr || *endptr !=3D '\0')
+		return;
+
+	tm =3D g_try_new0(struct ril_thermal_management, 1);
+	if (tm =3D=3D NULL)
+		return;
+
+	tm->modem =3D modem;
+	tm->throttling =3D (enabled > 0) ? true : false;
+
+
+	if (!g_dbus_register_interface(conn, path, THERMAL_MANAGEMENT_INTERFACE,
+					thermal_management_methods,
+					thermal_management_signals,
+					NULL, tm, thermal_management_cleanup)) {
+		ofono_error("Could not register %s interface under %s",
+					THERMAL_MANAGEMENT_INTERFACE, path);
+		g_free(tm);
+		return;
+	}
+
+	ofono_modem_add_interface(modem, THERMAL_MANAGEMENT_INTERFACE);
+}
+
+static int ril_thermal_management_enable(struct ofono_modem *modem)
+{
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	struct parcel rilp;
+
+	int cmd_id;
+	char buf[4];
+
+	DBG("");
+
+	parcel_init(&rilp);
+	parcel_w_int32(&rilp, 1);
+	/* RIL_OEM_HOOK_STRING_GET_RF_POWER_STATUS =3D 0x000000AB */
+	cmd_id =3D 0x000000AB;
+	sprintf(buf, "%d", cmd_id);
+	parcel_w_string(&rilp, buf);
+
+	g_ril_append_print_buf(rd->ril, "{cmd_id=3D0x%02X}", cmd_id);
+
+	if (g_ril_send(rd->ril, RIL_REQUEST_OEM_HOOK_STRINGS, &rilp,
+			get_rf_power_status_cb, modem, NULL) > 0)
+		return 0;
+
+	/* Error path */
+
+	return -EIO;
+}
+
 static void ril_pre_sim(struct ofono_modem *modem)
 {
 	struct ril_data *rd =3D ofono_modem_get_data(modem);
@@ -145,6 +428,7 @@ static void ril_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "rilmodem", rd->ril);
 	ofono_sim_create(modem, 0, "rilmodem", rd->ril);
+	ril_thermal_management_enable(modem);
 }
 =

 static void ril_post_sim(struct ofono_modem *modem)
@@ -267,9 +551,17 @@ static void ril_send_power_off_cb(struct ril_msg *mess=
age, gpointer user_data)
 =

 static int ril_disable(struct ofono_modem *modem)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	const char *path =3D ofono_modem_get_path(modem);
 =

 	DBG("%p", modem);
+
+	if (g_dbus_unregister_interface(conn, path,
+					THERMAL_MANAGEMENT_INTERFACE))
+		ofono_modem_remove_interface(modem,
+						THERMAL_MANAGEMENT_INTERFACE);
+
 	ril_send_power(rd->ril, FALSE, ril_send_power_off_cb, modem, NULL);
 =

 	return -EINPROGRESS;
-- =

1.9.1


--===============0376740474570734160==--

