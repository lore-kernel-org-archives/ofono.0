Content-Type: multipart/mixed; boundary="===============7564726325597984037=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready-v2 PATCH 1/3] sim: add ofono_sim_ready_notify
Date: Mon, 08 Nov 2010 22:27:43 +0200
Message-ID: <1289248065-3078-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1289248065-3078-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7564726325597984037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The ofono_sim_driver indicates that SIM is not ready with CME error 14
(SIM is busy) in query_passwd_state callback. The sim atom then stops
initializing itself and waits for a call to ofono_sim_ready_notify().

Note that ofono_sim_ready_notify() can be used both before and after
entering the PIN/PUK code.

Based on patches by Kristen Accardi and Denis Kenzior.
---
 include/sim.h |    2 ++
 src/sim.c     |   30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

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
index e5e304c..294c1a8 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -45,6 +45,8 @@
 #include "simfs.h"
 #include "stkutil.h"
 =

+#define SIM_FLAG_WAIT_FOR_READY 0x1
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

@@ -1562,6 +1565,13 @@ static void sim_pin_query_cb(const struct ofono_erro=
r *error,
 	const char *path =3D __ofono_atom_get_path(sim->atom);
 	const char *pin_name;
 =

+	if (error->type =3D=3D OFONO_ERROR_TYPE_CME && error->error =3D=3D 14) {
+		DBG("SIM not ready");
+		/* Wait for ofono_sim_ready_notify() */
+		sim->flags |=3D SIM_FLAG_WAIT_FOR_READY;
+		return;
+	}
+
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Querying PIN authentication state failed");
 =

@@ -1600,6 +1610,24 @@ static void sim_pin_check(struct ofono_sim *sim)
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
+	sim->flags &=3D ~SIM_FLAG_WAIT_FOR_READY;
+
+	sim_pin_check(sim);
+}
+
 static void sim_efli_read_cb(int ok, int length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
@@ -2007,6 +2035,8 @@ static void sim_free_state(struct ofono_sim *sim)
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


--===============7564726325597984037==--

