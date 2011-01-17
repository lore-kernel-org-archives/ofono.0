Content-Type: multipart/mixed; boundary="===============1029445965698052883=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: [PATCH] sim: check if lock is locked after code input attempt
Date: Mon, 17 Jan 2011 13:34:05 +0200
Message-ID: <1295264045.18761.35.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1029445965698052883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again,

This is third attempt to fix the problem where PUK required information
is not shown correctly after user tries to change pin code too many
times with wrong passwords. Basically solution is pretty much as in
original made by Marit Henriksen except it does not do the sim interface
initialization anymore and it goes to PRE_SIM state if PUK is required
except in case of PIN2. Fix is also extended to pin locking and pin
unlocking.  =


Br,
-Jussi

---
 src/sim.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d627647..00f0463 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -622,6 +622,45 @@ static void sim_locked_cb(struct ofono_sim *sim,
gboolean locked)
 	sim_pin_retries_check(sim);
 }
 =

+static void fail_reason_check_cb(const struct ofono_error *error,
+				enum ofono_sim_password_type pin_type,
+				void *data)
+{
+	struct ofono_sim *sim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sim->atom);
+	const char *pin_name;
+
+	if (sim->pin_type !=3D pin_type) {
+		sim->pin_type =3D pin_type;
+		pin_name =3D sim_passwd_name(pin_type);
+
+		if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
+				password_is_pin(pin_type) =3D=3D FALSE)
+			pin_type =3D puk2pin(pin_type);
+
+		if (pin_type !=3D OFONO_SIM_PASSWORD_INVALID)
+			sim->locked_pins[pin_type] =3D TRUE;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"PinRequired", DBUS_TYPE_STRING,
+						&pin_name);
+
+		if ((sim->state !=3D OFONO_SIM_STATE_READY) ||
+		   ((sim->locked_pins[pin_type] =3D=3D TRUE) && (
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHSIM_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHFSIM_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHNET_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHNETSUB_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHSP_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHCORP_PIN)))
+			ofono_modem_reset(modem);
+	}
+}
+
 static void sim_unlock_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_sim *sim =3D data;
@@ -630,6 +669,9 @@ static void sim_unlock_cb(const struct ofono_error
*error, void *data)
 		DBusMessage *reply =3D __ofono_error_failed(sim->pending);
 =

 		__ofono_dbus_pending_reply(&sim->pending, reply);
+
+		sim->driver->query_passwd_state(sim, fail_reason_check_cb, sim);
+
 		sim_pin_retries_check(sim);
 =

 		return;
@@ -646,6 +688,9 @@ static void sim_lock_cb(const struct ofono_error
*error, void *data)
 		DBusMessage *reply =3D __ofono_error_failed(sim->pending);
 =

 		__ofono_dbus_pending_reply(&sim->pending, reply);
+
+		sim->driver->query_passwd_state(sim, fail_reason_check_cb, sim);
+
 		sim_pin_retries_check(sim);
 =

 		return;
@@ -717,6 +762,8 @@ static void sim_change_pin_cb(const struct
ofono_error *error, void *data)
 		__ofono_dbus_pending_reply(&sim->pending,
 				__ofono_error_failed(sim->pending));
 =

+		sim->driver->query_passwd_state(sim, fail_reason_check_cb, sim);
+
 		sim_pin_retries_check(sim);
 =

 		return;
-- =

1.7.1



--===============1029445965698052883==--

