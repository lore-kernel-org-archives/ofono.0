Content-Type: multipart/mixed; boundary="===============0800362905640671617=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] Query locked pins after reset pin
Date: Thu, 12 Sep 2013 03:13:57 +0800
Message-ID: <1378926837-16531-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0800362905640671617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

---
 src/sim.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/src/sim.c b/src/sim.c
index edae5eb..ef55b1c 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -123,6 +123,11 @@ struct msisdn_set_request {
 	DBusMessage *msg;
 };
 =

+struct sim_locked_query_request {
+	struct ofono_sim *sim;
+	enum ofono_sim_password_type type;
+};
+
 struct service_number {
 	char *id;
 	struct ofono_phone_number ph;
@@ -610,6 +615,57 @@ error:
 	return __ofono_error_invalid_args(msg);
 }
 =

+void sim_query_locked_cb(const struct ofono_error *error,
+			int locked, void *data)
+{
+	struct sim_locked_query_request *req =3D data;
+	struct ofono_sim *sim =3D req->sim;
+	char **locked_pins;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+
+	DBG("");
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		g_free(req);
+		return;
+	}
+
+	if (req->type >=3D OFONO_SIM_PASSWORD_SIM_PUK) {
+		g_free(req);
+		return;
+	}
+
+	sim->locked_pins[req->type] =3D locked;
+	DBG("sim_query_locked_cb pin_type: %d %d", req->type, locked);
+
+	locked_pins =3D get_locked_pins(sim);
+	ofono_dbus_signal_array_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"LockedPins", DBUS_TYPE_STRING,
+						&locked_pins);
+	g_strfreev(locked_pins);
+	g_free(req);
+}
+
+static void __sim_query_locked(struct ofono_sim *sim,
+			enum ofono_sim_password_type type)
+{
+	struct sim_locked_query_request *req;
+
+	if (type =3D=3D OFONO_SIM_PASSWORD_NONE =

+		|| type > OFONO_SIM_PASSWORD_PHCORP_PIN)
+		return;
+
+	req =3D g_new0(struct sim_locked_query_request, 1);
+	req->sim =3D sim;
+	req->type =3D type;
+		=

+	if (sim->driver->query_locked)
+		sim->driver->query_locked(sim, type, sim_query_locked_cb, req);
+}
+
+
 static void sim_locked_cb(struct ofono_sim *sim, gboolean locked)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -1039,6 +1095,25 @@ static DBusMessage *sim_get_icon(DBusConnection *con=
n,
 	return NULL;
 }
 =

+static void sim_reset_pin_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	DBusMessage *reply;
+	enum ofono_sim_password_type type;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D __ofono_error_failed(sim->pending);
+	else
+		reply =3D dbus_message_new_method_return(sim->pending);
+
+	__ofono_dbus_pending_reply(&sim->pending, reply);
+
+	__ofono_sim_recheck_pin(sim);
+
+	for (type =3D OFONO_SIM_PASSWORD_SIM_PIN; type < OFONO_SIM_PASSWORD_SIM_P=
UK; type++)
+		__sim_query_locked(sim, type);
+}
+
 static DBusMessage *sim_reset_pin(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -1074,7 +1149,7 @@ static DBusMessage *sim_reset_pin(DBusConnection *con=
n, DBusMessage *msg,
 		return __ofono_error_invalid_format(msg);
 =

 	sim->pending =3D dbus_message_ref(msg);
-	sim->driver->reset_passwd(sim, puk, pin, sim_enter_pin_cb, sim);
+	sim->driver->reset_passwd(sim, puk, pin, sim_reset_pin_cb, sim);
 =

 	return NULL;
 }
-- =

1.7.9.5


--===============0800362905640671617==--

