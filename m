Content-Type: multipart/mixed; boundary="===============6241591979743438718=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 3/4] quectel: implement dbus signals for modem power
 notifications
Date: Fri, 19 Jul 2019 14:39:56 +0200
Message-ID: <20190719123957.6911-3-martin@geanix.com>
In-Reply-To: <20190719123957.6911-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6241591979743438718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Quectel modems issues unsolicited strings in case of power related
events. The UC15 uses +QIND: for the events, while M95 and MC60 uses
descriptive strings. (UC15 also uses a string for normal power down).

Register listeners for these strings/codes. The handler emits an
appropriate dbus signal, and closes down the modem if needed.
---

Changes since v2:
 * Use Voltage{High,Low} instead of {High,Low}Power

Changes since v1:
 * remove doc/ changes
 * place dbus functions below close_serial()

 plugins/quectel.c | 146 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index efdb7617..79316d45 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -108,6 +108,14 @@ struct dbus_hw {
 	int32_t voltage;
 };
 =

+enum quectel_power_event {
+	LOW_POWER_DOWN    =3D -2,
+	LOW_WARNING       =3D -1,
+	NORMAL_POWER_DOWN =3D  0,
+	HIGH_WARNING      =3D  1,
+	HIGH_POWER_DOWN   =3D  2,
+};
+
 static const char dbus_hw_interface[] =3D OFONO_SERVICE ".quectel.Hardware=
";
 =

 static void quectel_debug(const char *str, void *user_data)
@@ -335,6 +343,110 @@ static DBusMessage *dbus_hw_get_properties(DBusConnec=
tion *conn,
 	return NULL;
 }
 =

+static void voltage_handle(struct ofono_modem *modem,
+				enum quectel_power_event event)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	const char *path =3D ofono_modem_get_path(modem);
+	const char *name;
+	const char *reason;
+	bool close;
+
+	DBG("%p", modem);
+
+	switch (event) {
+	case LOW_POWER_DOWN:
+		close =3D true;
+		name =3D "PowerDown";
+		reason =3D "VoltageLow";
+		break;
+	case LOW_WARNING:
+		close =3D false;
+		name =3D "PowerWarning";
+		reason =3D "VoltageLow";
+		break;
+	case NORMAL_POWER_DOWN:
+		close =3D true;
+		name =3D "PowerDown";
+		reason =3D "Normal";
+		break;
+	case HIGH_WARNING:
+		close =3D false;
+		name =3D "PowerWarning";
+		reason =3D "VoltageHigh";
+		break;
+	case HIGH_POWER_DOWN:
+		close =3D true;
+		name =3D "PowerDown";
+		reason =3D "VoltageHigh";
+		break;
+	default:
+		return;
+	}
+
+	signal =3D dbus_message_new_signal(path, dbus_hw_interface, name);
+	if (signal) {
+		dbus_message_iter_init_append(signal, &iter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+						&reason);
+		g_dbus_send_message(conn, signal);
+	}
+
+	if (close)
+		close_serial(modem);
+}
+
+static void qind_notify(GAtResult *result, void *user_data)
+{
+	struct dbus_hw *hw =3D user_data;
+	GAtResultIter iter;
+	enum quectel_power_event event;
+	const char *type;
+
+	DBG("%p", hw->modem);
+
+	g_at_result_iter_init(&iter, result);
+	g_at_result_iter_next(&iter, "+QIND:");
+
+	if (!g_at_result_iter_next_string(&iter, &type))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &event))
+		return;
+
+	voltage_handle(hw->modem, event);
+}
+
+static void power_notify(GAtResult *result, void *user_data)
+{
+	struct dbus_hw *hw =3D user_data;
+	GAtResultIter iter;
+	const char *event;
+
+	DBG("%p", hw->modem);
+
+	g_at_result_iter_init(&iter, result);
+	g_at_result_iter_next(&iter, NULL);
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
+		return;
+
+	DBG("event: %s", event);
+
+	if (g_strcmp0(event, "UNDER_VOLTAGE POWER DOWN") =3D=3D 0)
+		voltage_handle(hw->modem, LOW_POWER_DOWN);
+	else if (g_strcmp0(event, "UNDER_VOLTAGE WARNING") =3D=3D 0)
+		voltage_handle(hw->modem, LOW_WARNING);
+	else if (g_strcmp0(event, "NORMAL POWER DOWN") =3D=3D 0)
+		voltage_handle(hw->modem, NORMAL_POWER_DOWN);
+	else if (g_strcmp0(event, "OVER_VOLTAGE WARNING") =3D=3D 0)
+		voltage_handle(hw->modem, HIGH_WARNING);
+	else if (g_strcmp0(event, "OVER_VOLTAGE POWER DOWN") =3D=3D 0)
+		voltage_handle(hw->modem, HIGH_POWER_DOWN);
+}
+
 static const GDBusMethodTable dbus_hw_methods[] =3D {
 	{ GDBUS_ASYNC_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
@@ -342,6 +454,14 @@ static const GDBusMethodTable dbus_hw_methods[] =3D {
 	{}
 };
 =

+static const GDBusSignalTable dbus_hw_signals[] =3D {
+	{ GDBUS_SIGNAL("PowerDown",
+			GDBUS_ARGS({ "reason", "s" })) },
+	{ GDBUS_SIGNAL("PowerWarning",
+			GDBUS_ARGS({ "reason", "s" })) },
+	{ }
+};
+
 static void dbus_hw_cleanup(void *data)
 {
 	struct dbus_hw *hw =3D data;
@@ -358,6 +478,7 @@ static void dbus_hw_cleanup(void *data)
 static void dbus_hw_enable(struct ofono_modem *modem)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
 	const char *path =3D ofono_modem_get_path(modem);
 	struct dbus_hw *hw;
 =

@@ -367,7 +488,7 @@ static void dbus_hw_enable(struct ofono_modem *modem)
 	hw->modem =3D modem;
 =

 	if (!g_dbus_register_interface(conn, path, dbus_hw_interface,
-					dbus_hw_methods, NULL, NULL,
+					dbus_hw_methods, dbus_hw_signals, NULL,
 					hw, dbus_hw_cleanup)) {
 		ofono_error("Could not register %s interface under %s",
 				dbus_hw_interface, path);
@@ -375,6 +496,29 @@ static void dbus_hw_enable(struct ofono_modem *modem)
 		return;
 	}
 =

+	g_at_chat_register(data->aux, "NORMAL POWER DOWN", power_notify, FALSE,
+				hw, NULL);
+
+	switch (data->model) {
+	case QUECTEL_UC15:
+		g_at_chat_register(data->aux, "+QIND",  qind_notify, FALSE, hw,
+					NULL);
+		break;
+	case QUECTEL_M95:
+	case QUECTEL_MC60:
+		g_at_chat_register(data->aux, "OVER_VOLTAGE POWER DOWN",
+					power_notify, FALSE, hw, NULL);
+		g_at_chat_register(data->aux, "UNDER_VOLTAGE POWER DOWN",
+					power_notify, FALSE, hw, NULL);
+		g_at_chat_register(data->aux, "OVER_VOLTAGE WARNING",
+					power_notify, FALSE, hw, NULL);
+		g_at_chat_register(data->aux, "UNDER_VOLTAGE WARNING",
+					power_notify, FALSE, hw, NULL);
+		break;
+	case QUECTEL_UNKNOWN:
+		break;
+	}
+
 	ofono_modem_add_interface(modem, dbus_hw_interface);
 }
 =

-- =

2.22.0


--===============6241591979743438718==--

