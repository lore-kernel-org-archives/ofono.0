Content-Type: multipart/mixed; boundary="===============6834864043515982009=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: [PATCH] sim: showing lock state with call meter
Date: Fri, 25 Feb 2011 15:20:16 +0200
Message-ID: <1298640016-25471-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6834864043515982009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Hi,

Here is the fixed patch for enabling the showing of pin2 blocked =

situation in SIM API when lock state changes after using call meter
API.

Br,
Jussi =


 include/sim.h    |    2 ++
 src/call-meter.c |   19 +++++++++++++++++++
 src/sim.c        |   46 +++++++++++++++++++++++++++++++---------------
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 412ae44..ab3a57f 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -227,6 +227,8 @@ unsigned int ofono_sim_add_file_watch(struct ofono_sim_=
context *context,
 void ofono_sim_remove_file_watch(struct ofono_sim_context *context,
 					unsigned int id);
 =

+void __ofono_sim_recheck_pin(struct ofono_sim *sim);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/call-meter.c b/src/call-meter.c
index 0789935..c6a85aa 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -332,6 +332,22 @@ static void set_acm_max_query_callback(const struct of=
ono_error *error,
 	set_acm_max(cm, value);
 }
 =

+static void check_pin2_state(struct ofono_call_meter *cm)
+{
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
+
+	sim_atom =3D __ofono_modem_find_atom(
+		__ofono_atom_get_modem(cm->atom),
+			OFONO_ATOM_TYPE_SIM);
+
+	if (sim_atom =3D=3D NULL)
+		return;
+
+	sim =3D __ofono_atom_get_data(sim_atom);
+	__ofono_sim_recheck_pin(sim);
+}
+
 static void set_acm_max_callback(const struct ofono_error *error, void *da=
ta)
 {
 	struct ofono_call_meter *cm =3D data;
@@ -340,6 +356,7 @@ static void set_acm_max_callback(const struct ofono_err=
or *error, void *data)
 		DBG("Setting acm_max failed");
 		__ofono_dbus_pending_reply(&cm->pending,
 					__ofono_error_failed(cm->pending));
+		check_pin2_state(cm);
 		return;
 	}
 =

@@ -401,6 +418,7 @@ static void set_puct_callback(const struct ofono_error =
*error, void *data)
 		DBG("setting puct failed");
 		__ofono_dbus_pending_reply(&cm->pending,
 					__ofono_error_failed(cm->pending));
+		check_pin2_state(cm);
 		return;
 	}
 =

@@ -598,6 +616,7 @@ static void acm_reset_callback(const struct ofono_error=
 *error, void *data)
 		DBG("reseting acm failed");
 		__ofono_dbus_pending_reply(&cm->pending,
 					__ofono_error_failed(cm->pending));
+		check_pin2_state(cm);
 		return;
 	}
 =

diff --git a/src/sim.c b/src/sim.c
index c39269d..8eafa1f 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -49,7 +49,6 @@
 static GSList *g_drivers =3D NULL;
 =

 static void sim_own_numbers_update(struct ofono_sim *sim);
-static void sim_pin_check(struct ofono_sim *sim);
 =

 struct ofono_sim {
 	/* Contents of the SIM file system, in rough initialization order */
@@ -624,7 +623,7 @@ static void sim_unlock_cb(const struct ofono_error *err=
or, void *data)
 		DBusMessage *reply =3D __ofono_error_failed(sim->pending);
 =

 		__ofono_dbus_pending_reply(&sim->pending, reply);
-		sim_pin_check(sim);
+		__ofono_sim_recheck_pin(sim);
 =

 		return;
 	}
@@ -640,7 +639,7 @@ static void sim_lock_cb(const struct ofono_error *error=
, void *data)
 		DBusMessage *reply =3D __ofono_error_failed(sim->pending);
 =

 		__ofono_dbus_pending_reply(&sim->pending, reply);
-		sim_pin_check(sim);
+		__ofono_sim_recheck_pin(sim);
 =

 		return;
 	}
@@ -711,7 +710,7 @@ static void sim_change_pin_cb(const struct ofono_error =
*error, void *data)
 		__ofono_dbus_pending_reply(&sim->pending,
 				__ofono_error_failed(sim->pending));
 =

-		sim_pin_check(sim);
+		__ofono_sim_recheck_pin(sim);
 =

 		return;
 	}
@@ -776,7 +775,7 @@ static void sim_enter_pin_cb(const struct ofono_error *=
error, void *data)
 =

 	__ofono_dbus_pending_reply(&sim->pending, reply);
 =

-	sim_pin_check(sim);
+	__ofono_sim_recheck_pin(sim);
 }
 =

 static DBusMessage *sim_enter_pin(DBusConnection *conn, DBusMessage *msg,
@@ -1846,7 +1845,7 @@ skip_efpl:
 						DBUS_TYPE_STRING,
 						&sim->language_prefs);
 =

-	sim_pin_check(sim);
+	__ofono_sim_recheck_pin(sim);
 }
 =

 static void sim_iccid_read_cb(int ok, int length, int record,
@@ -2231,23 +2230,40 @@ static void sim_pin_query_cb(const struct ofono_err=
or *error,
 						&pin_name);
 	}
 =

-	if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
-			sim->state =3D=3D OFONO_SIM_STATE_READY) {
-		/* Force the sim state out of READY */
-		sim_free_main_state(sim);
+	switch (pin_type) {
+	case OFONO_SIM_PASSWORD_NONE:
+	case OFONO_SIM_PASSWORD_SIM_PIN2:
+	case OFONO_SIM_PASSWORD_SIM_PUK2:
+		break;
+	default:
+		if (sim->state =3D=3D OFONO_SIM_STATE_READY) {
+			/* Force the sim state out of READY */
+			sim_free_main_state(sim);
 =

-		sim->state =3D OFONO_SIM_STATE_INSERTED;
-		__ofono_modem_sim_reset(__ofono_atom_get_modem(sim->atom));
+			sim->state =3D OFONO_SIM_STATE_INSERTED;
+			__ofono_modem_sim_reset(
+				__ofono_atom_get_modem(sim->atom));
+		}
+		break;
 	}
 =

 	sim_pin_retries_check(sim);
 =

 checkdone:
-	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
+	switch (pin_type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN2:
+	case OFONO_SIM_PASSWORD_SIM_PUK2:
+		if (sim->state =3D=3D OFONO_SIM_STATE_READY)
+			break;
+	case OFONO_SIM_PASSWORD_NONE:
 		sim_initialize_after_pin(sim);
+		break;
+	default:
+		break;
+	}
 }
 =

-static void sim_pin_check(struct ofono_sim *sim)
+void __ofono_sim_recheck_pin(struct ofono_sim *sim)
 {
 	if (sim->driver->query_passwd_state =3D=3D NULL) {
 		sim_initialize_after_pin(sim);
@@ -2579,6 +2595,6 @@ void __ofono_sim_refresh(struct ofono_sim *sim, GSLis=
t *file_list,
 		 * Start initialization procedure from after EFiccid,
 		 * EFli and EFpl are retrieved.
 		 */
-		sim_pin_check(sim);
+		__ofono_sim_recheck_pin(sim);
 	}
 }
-- =

1.7.1


--===============6834864043515982009==--

