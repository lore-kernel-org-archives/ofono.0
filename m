Content-Type: multipart/mixed; boundary="===============4472503450641027567=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [RFC v2 1/3] gemalto: Prepare new interface for hardware monitoring
Date: Tue, 16 May 2017 10:38:40 +0200
Message-ID: <1494923922-8874-1-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <a8e4b2e1-9ffe-d6ba-2a7c-28dc1fd1e445@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4472503450641027567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Gemalto modems have hardware related commands, allowing to monitor voltage
and temperature. These parameters will be accessible on DBus interface:
org.ofono.HardwareMonitor.

 - Create the DBus method table with one entry: GetStatistics. This method
would return temperature and voltage values.
 - Create a dedicated structure to handle the DBus methods.
 - Create enable/disable functions to handle DBus interface registration.
---
 plugins/gemalto.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 75 insertions(+)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 2870ce8..3798e09 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -29,8 +29,12 @@
 #include <glib.h>
 #include <gatchat.h>
 #include <gattty.h>
+#include <gdbus.h>
+
+#include "ofono.h"
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/dbus.h>
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
@@ -46,14 +50,23 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+#define HARDWARE_MONITOR_INTERFACE OFONO_SERVICE ".cinterion.HardwareMonit=
or"
+
 static const char *none_prefix[] =3D { NULL };
 =

+struct gemalto_hardware_monitor {
+	DBusMessage *msg;
+	int32_t temperature;
+	int32_t voltage;
+};
+
 struct gemalto_data {
 	GAtChat *app;
 	GAtChat *mdm;
 	struct ofono_sim *sim;
 	gboolean have_sim;
 	struct at_util_sim_state_query *sim_state_query;
+	struct gemalto_hardware_monitor *hm;
 };
 =

 static int gemalto_probe(struct ofono_modem *modem)
@@ -142,6 +155,59 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 						NULL);
 }
 =

+static DBusMessage *hardware_monitor_get_statistics(DBusConnection *conn,
+							DBusMessage *msg,
+							void *user_data)
+{
+	DBG("");
+
+	return __ofono_error_not_implemented(msg);
+}
+
+static const GDBusMethodTable hardware_monitor_methods[] =3D {
+	{ GDBUS_ASYNC_METHOD("GetStatistics",
+			NULL, GDBUS_ARGS({ "Statistics", "a{sv}" }),
+			hardware_monitor_get_statistics) },
+	{}
+};
+
+static void hardware_monitor_cleanup(void *user_data)
+{
+	struct gemalto_data *data =3D user_data;
+	struct gemalto_hardware_monitor *hm =3D data->hm;
+
+	g_free(hm);
+}
+
+static int gemalto_hardware_monitor_enable(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+
+	DBG("");
+
+	/* Enable temperature output */
+	g_at_chat_send(data->app, "AT^SCTM=3D0,1", none_prefix, NULL, NULL, NULL);
+
+	/* Create Hardware Monitor DBus interface */
+	data->hm =3D g_try_new0(struct gemalto_hardware_monitor, 1);
+	if (data->hm =3D=3D NULL)
+		return -EIO;
+
+	if (!g_dbus_register_interface(conn, path, HARDWARE_MONITOR_INTERFACE,
+					hardware_monitor_methods, NULL, NULL,
+					data, hardware_monitor_cleanup)) {
+		ofono_error("Could not register %s interface under %s",
+					HARDWARE_MONITOR_INTERFACE, path);
+		g_free(data->hm);
+		return -EIO;
+	}
+
+	ofono_modem_add_interface(modem, HARDWARE_MONITOR_INTERFACE);
+	return 0;
+}
+
 static int gemalto_enable(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
@@ -181,6 +247,8 @@ static int gemalto_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->app, "AT+CFUN=3D4", none_prefix,
 			cfun_enable, modem, NULL);
 =

+	gemalto_hardware_monitor_enable(modem);
+
 	return -EINPROGRESS;
 }
 =

@@ -203,12 +271,19 @@ static void gemalto_smso_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 static int gemalto_disable(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
 =

 	DBG("%p", modem);
 =

 	g_at_chat_cancel_all(data->app);
 	g_at_chat_unregister_all(data->app);
 =

+	if (g_dbus_unregister_interface(conn, path,
+				HARDWARE_MONITOR_INTERFACE))
+		ofono_modem_remove_interface(modem,
+				HARDWARE_MONITOR_INTERFACE);
+
 	/* Shutdown the modem */
 	g_at_chat_send(data->app, "AT^SMSO", none_prefix, gemalto_smso_cb,
 			modem, NULL);
-- =

1.9.1


--===============4472503450641027567==--

