Content-Type: multipart/mixed; boundary="===============5484991689380823665=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: [PATCH] sim: showing lock state with call meter
Date: Tue, 22 Feb 2011 14:05:52 +0200
Message-ID: <1298376352-24521-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5484991689380823665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
Hi,

On Mon, 2011-02-21 at 17:21 +0200, Denis Kenzior wrote:

> It seems to be showing the states correctly except in case when you make
> > PIN2 blocked using call meter API. If PIN2 goes blocked when using
> > callmeter nothing is shown in API. (My patch did not do that either.
> > Plan was to fix it in separate patch)
> > =

> =

> Please do.  Most modems do not support PIN2 entry via CPIN, and
> implement this using a vendor extension.  PIN2 / PUK2 support seems to
> be a rather recent addition to the specs.
> =

Here it is. Also after this patch having PUK2 blocked does not prevent
going online anymore in start up and it does not hide the interfaces if
PIN2 goes blocked during usage.

> There seems to be also some problem when API shows PUK2 required and PIN
> > and PIN2 locked. Reset-pin opens the PUK2 but API does not get the
> > response it's looking for and oFono needs to be booted before states are
> > showed correctly again. I suspect that's a separate issue however and
> > not caused by this patch. =

> > =

> =

> I'm having trouble visualizing this one.  Can you provide an AT debug
> log to illustrate?
> =

I found the problem already. Looks like modem problem which has nothing to
do with having multiple locks on/blocked or with your change. Reseting
the PIN2 does not seem to trigger expected event in startup.

Br,
Jussi

 include/sim.h    |    2 ++
 src/call-meter.c |   27 +++++++++++++++++++++++++++
 src/sim.c        |    8 ++++----
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 412ae44..a56056e 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -227,6 +227,8 @@ unsigned int ofono_sim_add_file_watch(struct ofono_sim_=
context *context,
 void ofono_sim_remove_file_watch(struct ofono_sim_context *context,
 					unsigned int id);
 =

+void sim_pin_check(struct ofono_sim *sim);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/call-meter.c b/src/call-meter.c
index 0789935..61678d8 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -335,11 +335,20 @@ static void set_acm_max_query_callback(const struct o=
fono_error *error,
 static void set_acm_max_callback(const struct ofono_error *error, void *da=
ta)
 {
 	struct ofono_call_meter *cm =3D data;
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Setting acm_max failed");
 		__ofono_dbus_pending_reply(&cm->pending,
 					__ofono_error_failed(cm->pending));
+		sim_atom =3D __ofono_modem_find_atom(
+			__ofono_atom_get_modem(cm->atom),
+				OFONO_ATOM_TYPE_SIM);
+		if (!sim_atom)
+			return;
+		sim =3D __ofono_atom_get_data(sim_atom);
+		sim_pin_check(sim);
 		return;
 	}
 =

@@ -396,11 +405,20 @@ static void set_puct_query_callback(const struct ofon=
o_error *error,
 static void set_puct_callback(const struct ofono_error *error, void *data)
 {
 	struct ofono_call_meter *cm =3D data;
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("setting puct failed");
 		__ofono_dbus_pending_reply(&cm->pending,
 					__ofono_error_failed(cm->pending));
+		sim_atom =3D __ofono_modem_find_atom(
+			__ofono_atom_get_modem(cm->atom),
+				OFONO_ATOM_TYPE_SIM);
+		if (!sim_atom)
+			return;
+		sim =3D __ofono_atom_get_data(sim_atom);
+		sim_pin_check(sim);
 		return;
 	}
 =

@@ -593,11 +611,20 @@ static void reset_acm_query_callback(const struct ofo=
no_error *error, int value,
 static void acm_reset_callback(const struct ofono_error *error, void *data)
 {
 	struct ofono_call_meter *cm =3D data;
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("reseting acm failed");
 		__ofono_dbus_pending_reply(&cm->pending,
 					__ofono_error_failed(cm->pending));
+		sim_atom =3D __ofono_modem_find_atom(
+			__ofono_atom_get_modem(cm->atom),
+				OFONO_ATOM_TYPE_SIM);
+		if (!sim_atom)
+			return;
+		sim =3D __ofono_atom_get_data(sim_atom);
+		sim_pin_check(sim);
 		return;
 	}
 =

diff --git a/src/sim.c b/src/sim.c
index c39269d..08236f2 100644
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
@@ -2231,8 +2230,9 @@ static void sim_pin_query_cb(const struct ofono_error=
 *error,
 						&pin_name);
 	}
 =

-	if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
-			sim->state =3D=3D OFONO_SIM_STATE_READY) {
+	if ((pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
+			sim->state =3D=3D OFONO_SIM_STATE_READY) &&
+				(pin_type !=3D OFONO_SIM_PASSWORD_SIM_PIN2)) {
 		/* Force the sim state out of READY */
 		sim_free_main_state(sim);
 =

@@ -2247,7 +2247,7 @@ checkdone:
 		sim_initialize_after_pin(sim);
 }
 =

-static void sim_pin_check(struct ofono_sim *sim)
+void sim_pin_check(struct ofono_sim *sim)
 {
 	if (sim->driver->query_passwd_state =3D=3D NULL) {
 		sim_initialize_after_pin(sim);
-- =

1.7.1


--===============5484991689380823665==--

