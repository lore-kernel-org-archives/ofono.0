Content-Type: multipart/mixed; boundary="===============1848771483916693020=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-fdn PATCH 1/4] sim: add EnableFDN and DisableFDN methods
Date: Thu, 26 Aug 2010 15:52:38 +0300
Message-ID: <1282827161-8351-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282827161-8351-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1848771483916693020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Enable or disable Fixed Dialing Numbers feature on SIM card.

If enabled, calls can be dialled or SMSs sent only to numbers listed on
special FDN phonebook on the SIM card.
---
 include/sim.h |    3 ++
 src/sim.c     |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index d3e564c..4639671 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -157,6 +157,9 @@ struct ofono_sim_driver {
 	void (*query_locked)(struct ofono_sim *sim,
 			enum ofono_sim_password_type type,
 			ofono_sim_locked_cb_t cb, void *data);
+	void (*enable_fdn)(struct ofono_sim *sim,
+			int enable, const char *passwd,
+			ofono_sim_lock_unlock_cb_t cb, void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
diff --git a/src/sim.c b/src/sim.c
index bac77e0..7af4565 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -626,6 +626,61 @@ static DBusMessage *sim_unlock_pin(DBusConnection *con=
n, DBusMessage *msg,
 	return sim_lock_or_unlock(sim, 0, conn, msg);
 }
 =

+static void sim_fdn_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	DBusMessage *reply;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D dbus_message_new_method_return(sim->pending);
+	else
+		reply =3D __ofono_error_failed(sim->pending);
+
+	__ofono_dbus_pending_reply(&sim->pending, reply);
+}
+
+static DBusMessage *sim_fdn(struct ofono_sim *sim, int enable,
+				DBusConnection *conn, DBusMessage *msg)
+{
+	const char *pin;
+
+	if (!sim->driver->enable_fdn)
+		return __ofono_error_not_implemented(msg);
+
+	if (sim->pending)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_STRING, &pin,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!is_valid_pin(pin, PIN_TYPE_PIN))
+		return __ofono_error_invalid_format(msg);
+
+	sim->pending =3D dbus_message_ref(msg);
+
+	sim->driver->enable_fdn(sim, enable, pin, sim_fdn_cb, sim);
+
+	return NULL;
+}
+
+static DBusMessage *sim_enable_fdn(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_sim *sim =3D data;
+
+	return sim_fdn(sim, 1, conn, msg);
+}
+
+static DBusMessage *sim_disable_fdn(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_sim *sim =3D data;
+
+	return sim_fdn(sim, 0, conn, msg);
+}
+
 static void sim_change_pin_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_sim *sim =3D data;
@@ -787,6 +842,10 @@ static GDBusMethodTable sim_methods[] =3D {
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "UnlockPin",		"ss",	"",		sim_unlock_pin,
 							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "EnableFDN",		"s",	"",		sim_enable_fdn,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "DisableFDN",		"s",	"",		sim_disable_fdn,
+							G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

-- =

1.7.0.4


--===============1848771483916693020==--

