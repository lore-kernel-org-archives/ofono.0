Content-Type: multipart/mixed; boundary="===============1993859398628790543=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 6/7] quectel: add dbus hardware interface
Date: Tue, 16 Jul 2019 21:10:52 +0200
Message-ID: <20190716191053.71990-6-martin@geanix.com>
In-Reply-To: <20190716191053.71990-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1993859398628790543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For now the interface only exposes the modem supply voltage, but is
added as a preparation for signaling power events.
---
 doc/quectel-hardware-api.txt |  15 ++++
 plugins/quectel.c            | 154 +++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 doc/quectel-hardware-api.txt

diff --git a/doc/quectel-hardware-api.txt b/doc/quectel-hardware-api.txt
new file mode 100644
index 00000000..f54ea8c7
--- /dev/null
+++ b/doc/quectel-hardware-api.txt
@@ -0,0 +1,15 @@
+Hardware hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.quectel.Hardware
+Object path	/{device0,device1,...}
+
+Methods		array{string,variant} GetProperties
+
+			Returns hardware properties for the modem object. See
+			the properties section for available properties.
+
+Properties	uint32 Voltage [readonly]
+
+			Integer with the modem supply voltage in mV.
diff --git a/plugins/quectel.c b/plugins/quectel.c
index 9cac92fa..3c1d49cd 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -37,6 +37,7 @@
 #include <gattty.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono.h>
 #include <ofono/plugin.h>
 #include <ofono/modem.h>
 #include <ofono/devinfo.h>
@@ -49,12 +50,16 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/log.h>
+#include <ofono/dbus.h>
+
+#include <gdbus/gdbus.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+static const char *cbc_prefix[] =3D { "+CBC:", NULL };
 static const char *qinistat_prefix[] =3D { "+QINISTAT:", NULL };
 static const char *cgmm_prefix[] =3D { "UC15", "Quectel_M95", "Quectel_MC6=
0",
 					NULL };
@@ -95,6 +100,148 @@ struct quectel_data {
 	struct l_gpio_writer *gpio;
 };
 =

+struct dbus_hw {
+	DBusMessage *msg;
+	struct ofono_modem *modem;
+	gint charge_status;
+	gint charge_level;
+	gint voltage;
+};
+
+static const char dbus_hw_interface[] =3D OFONO_SERVICE ".quectel.Hardware=
";
+
+static void dbus_hw_reply_properties(struct dbus_hw *hw)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(hw->modem);
+	DBusMessage *reply;
+	DBusMessageIter dbus_iter;
+	DBusMessageIter dbus_dict;
+
+	DBG("%p", hw->modem);
+
+	reply =3D dbus_message_new_method_return(hw->msg);
+	dbus_message_iter_init_append(reply, &dbus_iter);
+	dbus_message_iter_open_container(&dbus_iter, DBUS_TYPE_ARRAY,
+			OFONO_PROPERTIES_ARRAY_SIGNATURE,
+			&dbus_dict);
+
+	if (data->model =3D=3D QUECTEL_UC15) {
+		ofono_dbus_dict_append(&dbus_dict, "ChargeStatus",
+					DBUS_TYPE_INT32, &hw->charge_status);
+
+		ofono_dbus_dict_append(&dbus_dict, "ChargeLevel",
+					DBUS_TYPE_INT32, &hw->charge_level);
+	}
+
+	ofono_dbus_dict_append(&dbus_dict, "Voltage", DBUS_TYPE_UINT32,
+				&hw->voltage);
+
+	dbus_message_iter_close_container(&dbus_iter, &dbus_dict);
+
+	__ofono_dbus_pending_reply(&hw->msg, reply);
+}
+
+static void cbc_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct dbus_hw *hw =3D user_data;
+	GAtResultIter iter;
+
+	DBG("%p", hw->modem);
+
+	if (!hw->msg)
+		return;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CBC:"))
+		goto error;
+
+	/* only uc15 returns valid charge status */
+	if (!g_at_result_iter_next_number(&iter, &hw->charge_status))
+		goto error;
+
+	/* only uc15 returns valid charge level */
+	if (!g_at_result_iter_next_number(&iter, &hw->charge_level))
+		goto error;
+
+	/* now comes the millivolts */
+	if (!g_at_result_iter_next_number(&iter, &hw->voltage))
+		goto error;
+
+	dbus_hw_reply_properties(hw);
+
+	return;
+
+error:
+	__ofono_dbus_pending_reply(&hw->msg, __ofono_error_failed(hw->msg));
+}
+
+static DBusMessage *dbus_hw_get_properties(DBusConnection *conn,
+						DBusMessage *msg,
+						void *user_data)
+{
+	struct dbus_hw *hw =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(hw->modem);
+
+	DBG("%p", hw->modem);
+
+	if (hw->msg !=3D NULL)
+		return __ofono_error_busy(msg);
+
+	if (!g_at_chat_send(data->aux, "AT+CBC", cbc_prefix, cbc_cb, hw, NULL))
+		return __ofono_error_failed(msg);
+
+	hw->msg =3D dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static const GDBusMethodTable dbus_hw_methods[] =3D {
+	{ GDBUS_ASYNC_METHOD("GetProperties",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				dbus_hw_get_properties) },
+	{}
+};
+
+static void dbus_hw_cleanup(void *data)
+{
+	struct dbus_hw *hw =3D data;
+
+	DBG("%p", hw->modem);
+
+	if (hw->msg)
+		__ofono_dbus_pending_reply(&hw->msg,
+					__ofono_error_canceled(hw->msg));
+
+	l_free(hw);
+}
+
+static void dbus_hw_enable(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+	struct dbus_hw *hw;
+
+	DBG("%p", modem);
+
+	hw =3D l_new(struct dbus_hw, 1);
+	hw->modem =3D modem;
+
+	if (!g_dbus_register_interface(conn, path, dbus_hw_interface,
+					dbus_hw_methods, NULL, NULL,
+					hw, dbus_hw_cleanup)) {
+		ofono_error("Could not register %s interface under %s",
+				dbus_hw_interface, path);
+		l_free(hw);
+		return;
+	}
+
+	ofono_modem_add_interface(modem, dbus_hw_interface);
+}
+
 static void quectel_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -253,6 +400,8 @@ static void cpin_notify(GAtResult *result, gpointer use=
r_data)
 =

 	g_at_chat_unregister(data->aux, data->cpin_ready);
 	data->cpin_ready =3D 0;
+
+	dbus_hw_enable(modem);
 }
 =

 static void cpin_query(gboolean ok, GAtResult *result, gpointer user_data)
@@ -650,9 +799,14 @@ static void cfun_disable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 static int quectel_disable(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
 =

 	DBG("%p", modem);
 =

+	if (g_dbus_unregister_interface(conn, path, dbus_hw_interface))
+		ofono_modem_remove_interface(modem, dbus_hw_interface);
+
 	g_at_chat_cancel_all(data->modem);
 	g_at_chat_unregister_all(data->modem);
 =

-- =

2.22.0


--===============1993859398628790543==--

