Content-Type: multipart/mixed; boundary="===============3804968100004543879=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 7/7] quectel: implement dbus signals for modem power
 notifications
Date: Tue, 16 Jul 2019 21:10:53 +0200
Message-ID: <20190716191053.71990-7-martin@geanix.com>
In-Reply-To: <20190716191053.71990-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3804968100004543879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Quectel modems issues unsolicited strings in case of power related
events. The UC15 uses +QIND: for the events, while M95 and MC60 uses
descriptive strings. (UC15 also uses a string for normal power down).

Register listeners for these strings/codes. The handler emits an
appropriate dbus signal, and closes down the modem if needed.
---
 doc/quectel-hardware-api.txt |  19 +++++
 plugins/quectel.c            | 148 ++++++++++++++++++++++++++++++++++-
 2 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/doc/quectel-hardware-api.txt b/doc/quectel-hardware-api.txt
index f54ea8c7..c9e93926 100644
--- a/doc/quectel-hardware-api.txt
+++ b/doc/quectel-hardware-api.txt
@@ -10,6 +10,25 @@ Methods		array{string,variant} GetProperties
 			Returns hardware properties for the modem object. See
 			the properties section for available properties.
 =

+Signals		PowerDown(string reason)
+
+			This signal is emitted on gracefull shutdowns initiated
+			by the modem.
+
+			Possible reasons:
+				"LowPower"	The supply voltage is too low
+				"Normal"	The PWRKEY pin was asserted
+				"HighPower"	The supply voltage is too high
+
+		PowerWarning(string reason)
+
+			This signal is emitted when the modem detects its supply
+			voltage is close to its supported limits.
+
+			Possible reasons:
+				"LowPower"	The supply voltage is low
+				"HighPower"	The supply voltage is high
+
 Properties	uint32 Voltage [readonly]
 =

 			Integer with the modem supply voltage in mV.
diff --git a/plugins/quectel.c b/plugins/quectel.c
index 3c1d49cd..3c74fc41 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -108,8 +108,122 @@ struct dbus_hw {
 	gint voltage;
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

+static void close_serial(struct ofono_modem *modem);
+
+static void power_handle(struct ofono_modem *modem,
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
+		reason =3D "LowPower";
+		break;
+	case LOW_WARNING:
+		close =3D false;
+		name =3D "PowerWarning";
+		reason =3D "LowPower";
+		break;
+	case NORMAL_POWER_DOWN:
+		close =3D true;
+		name =3D "PowerDown";
+		reason =3D "Normal";
+		break;
+	case HIGH_WARNING:
+		close =3D false;
+		name =3D "PowerWarning";
+		reason =3D "HighPower";
+		break;
+	case HIGH_POWER_DOWN:
+		close =3D true;
+		name =3D "PowerDown";
+		reason =3D "HighPower";
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
+	power_handle(hw->modem, event);
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
+		power_handle(hw->modem, LOW_POWER_DOWN);
+	else if (g_strcmp0(event, "UNDER_VOLTAGE WARNING") =3D=3D 0)
+		power_handle(hw->modem, LOW_WARNING);
+	else if (g_strcmp0(event, "NORMAL POWER DOWN") =3D=3D 0)
+		power_handle(hw->modem, NORMAL_POWER_DOWN);
+	else if (g_strcmp0(event, "OVER_VOLTAGE WARNING") =3D=3D 0)
+		power_handle(hw->modem, HIGH_WARNING);
+	else if (g_strcmp0(event, "OVER_VOLTAGE POWER DOWN") =3D=3D 0)
+		power_handle(hw->modem, HIGH_POWER_DOWN);
+}
+
 static void dbus_hw_reply_properties(struct dbus_hw *hw)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(hw->modem);
@@ -206,6 +320,14 @@ static const GDBusMethodTable dbus_hw_methods[] =3D {
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
@@ -222,6 +344,7 @@ static void dbus_hw_cleanup(void *data)
 static void dbus_hw_enable(struct ofono_modem *modem)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
 	const char *path =3D ofono_modem_get_path(modem);
 	struct dbus_hw *hw;
 =

@@ -231,7 +354,7 @@ static void dbus_hw_enable(struct ofono_modem *modem)
 	hw->modem =3D modem;
 =

 	if (!g_dbus_register_interface(conn, path, dbus_hw_interface,
-					dbus_hw_methods, NULL, NULL,
+					dbus_hw_methods, dbus_hw_signals, NULL,
 					hw, dbus_hw_cleanup)) {
 		ofono_error("Could not register %s interface under %s",
 				dbus_hw_interface, path);
@@ -239,6 +362,29 @@ static void dbus_hw_enable(struct ofono_modem *modem)
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


--===============3804968100004543879==--

