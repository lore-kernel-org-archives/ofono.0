Content-Type: multipart/mixed; boundary="===============6088486942896336092=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready-nofify-v5 PATCH 1/3] sim: add ofono_sim_ready_notify
Date: Tue, 08 Feb 2011 14:32:57 +0200
Message-ID: <1297168379-16400-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1297168379-16400-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6088486942896336092==
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
 include/sim.h |    1 +
 src/sim.c     |   35 +++++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 412ae44..b33cf8c 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -196,6 +196,7 @@ void ofono_sim_remove_state_watch(struct ofono_sim *sim=
, unsigned int id);
 enum ofono_sim_state ofono_sim_get_state(struct ofono_sim *sim);
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d);
+void ofono_sim_ready_notify(struct ofono_sim *sim);
 =

 struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim);
 void ofono_sim_context_free(struct ofono_sim_context *context);
diff --git a/src/sim.c b/src/sim.c
index 3350166..818d813 100644
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
@@ -76,6 +78,7 @@ struct ofono_sim {
 	unsigned char efsst_length;
 	gboolean fixed_dialing;
 	gboolean barred_dialing;
+	guint flags;
 =

 	char *imsi;
 	char mcc[OFONO_MAX_MCC_LENGTH + 1];
@@ -1621,6 +1624,8 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 =

 static void sim_initialize_after_pin(struct ofono_sim *sim)
 {
+	sim->flags &=3D ~SIM_FLAG_WAIT_FOR_READY;
+
 	ofono_sim_read(sim->context, SIM_EFPHASE_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efphase_read_cb, sim);
@@ -1647,10 +1652,11 @@ static void sim_pin_query_cb(const struct ofono_err=
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

 	if (sim->pin_type !=3D pin_type) {
@@ -1671,10 +1677,6 @@ static void sim_pin_query_cb(const struct ofono_erro=
r *error,
 	}
 =

 	sim_pin_retries_check(sim);
-
-checkdone:
-	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
-		sim_initialize_after_pin(sim);
 }
 =

 static void sim_pin_check(struct ofono_sim *sim)
@@ -1687,6 +1689,25 @@ static void sim_pin_check(struct ofono_sim *sim)
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
@@ -2146,6 +2167,8 @@ static void sim_free_state(struct ofono_sim *sim)
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


--===============6088486942896336092==--

