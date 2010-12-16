Content-Type: multipart/mixed; boundary="===============3267655532326201134=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready PATCHv3 1/3] sim: add ofono_sim_ready_notify
Date: Thu, 16 Dec 2010 21:57:44 +0200
Message-ID: <1292529466-19284-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1292529466-19284-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3267655532326201134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The sim atom waits for ofono_sim_ready_notify() after the callback
to query_passwd_state.

Upon call to ofono_sim_ready_notify(), SIM atom either continues
initialization or rechecks if the SIM still requires a pin code.

Based on patches by Kristen Accardi and Denis Kenzior.
---
 include/sim.h |    2 ++
 src/sim.c     |   56 ++++++++++++++++++++++++++++++++++++++++-------------=
---
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 7860e24..f4171d1 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -188,6 +188,8 @@ enum ofono_sim_state ofono_sim_get_state(struct ofono_s=
im *sim);
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d);
 =

+void ofono_sim_ready_notify(struct ofono_sim *sim);
+
 /* This will queue an operation to read all available records with id from=
 the
  * SIM.  Callback cb will be called every time a record has been read, or =
once
  * if an error has occurred.  For transparent files, the callback will only
diff --git a/src/sim.c b/src/sim.c
index 6217a25..1878e2c 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -45,6 +45,8 @@
 #include "simfs.h"
 #include "stkutil.h"
 =

+#define SIM_FLAG_WAIT_FOR_READY (1 << 0)
+
 static GSList *g_drivers =3D NULL;
 =

 static void sim_own_numbers_update(struct ofono_sim *sim);
@@ -74,6 +76,7 @@ struct ofono_sim {
 	unsigned char efsst_length;
 	gboolean fixed_dialing;
 	gboolean barred_dialing;
+	guint flags;
 =

 	char *imsi;
 =

@@ -1543,6 +1546,8 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 =

 static void sim_initialize_after_pin(struct ofono_sim *sim)
 {
+	sim->flags &=3D SIM_FLAG_WAIT_FOR_READY;
+
 	ofono_sim_read(sim, SIM_EFPHASE_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efphase_read_cb, sim);
@@ -1569,32 +1574,30 @@ static void sim_pin_query_cb(const struct ofono_err=
or *error,
 	const char *path =3D __ofono_atom_get_path(sim->atom);
 	const char *pin_name;
 =

+	sim->flags |=3D SIM_FLAG_WAIT_FOR_READY;
+
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Querying PIN authentication state failed");
-
-		goto checkdone;
+		return;
 	}
 =

-	if (sim->pin_type !=3D pin_type) {
-		sim->pin_type =3D pin_type;
-		pin_name =3D sim_passwd_name(pin_type);
+	if (sim->pin_type =3D=3D pin_type)
+		return;
 =

-		if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
-				password_is_pin(pin_type) =3D=3D FALSE)
-			pin_type =3D puk2pin(pin_type);
+	sim->pin_type =3D pin_type;
+	pin_name =3D sim_passwd_name(pin_type);
 =

-		if (pin_type !=3D OFONO_SIM_PASSWORD_INVALID)
-			sim->locked_pins[pin_type] =3D TRUE;
+	if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
+			password_is_pin(pin_type) =3D=3D FALSE)
+		pin_type =3D puk2pin(pin_type);
 =

-		ofono_dbus_signal_property_changed(conn, path,
+	if (pin_type !=3D OFONO_SIM_PASSWORD_INVALID)
+		sim->locked_pins[pin_type] =3D TRUE;
+
+	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
 						"PinRequired", DBUS_TYPE_STRING,
 						&pin_name);
-	}
-
-checkdone:
-	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
-		sim_initialize_after_pin(sim);
 }
 =

 static void sim_pin_check(struct ofono_sim *sim)
@@ -1607,6 +1610,25 @@ static void sim_pin_check(struct ofono_sim *sim)
 	sim->driver->query_passwd_state(sim, sim_pin_query_cb, sim);
 }
 =

+void ofono_sim_ready_notify(struct ofono_sim *sim)
+{
+	DBG("");
+
+	if (sim =3D=3D NULL)
+		return;
+
+	if (sim->state !=3D OFONO_SIM_STATE_INSERTED)
+		return;
+
+	if (!(sim->flags & SIM_FLAG_WAIT_FOR_READY))
+		return;
+
+	if (sim->pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
+		sim_initialize_after_pin(sim);
+	else
+		sim_pin_check(sim);
+}
+
 static void sim_efli_read_cb(int ok, int length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
@@ -2029,6 +2051,8 @@ static void sim_free_state(struct ofono_sim *sim)
 =

 	sim->fixed_dialing =3D FALSE;
 	sim->barred_dialing =3D FALSE;
+
+	sim->flags =3D 0;
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
-- =

1.7.1


--===============3267655532326201134==--

