Content-Type: multipart/mixed; boundary="===============3072658204601377066=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC sim-ready-v0 PATCH 1/3] sim: add ofono_sim_ready_notify
Date: Tue, 05 Oct 2010 19:04:19 +0300
Message-ID: <1286294661-24300-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286294661-24300-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3072658204601377066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

If SIM is not ready, the ofono_sim_driver indicates that with
query_passwd_state callback returning OFONO_SIM_PASSWORD_INVALID.

After the driver determines that SIM is ready, it calls
ofono_sim_ready_notify().

Based on patches by Kristen Accardi and Denis Kenzior.
---
 include/sim.h |    2 ++
 src/sim.c     |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 42b19bd..786e3c5 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -187,6 +187,8 @@ enum ofono_sim_state ofono_sim_get_state(struct ofono_s=
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
index 6f10d4c..9077224 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -85,6 +85,8 @@ struct ofono_sim {
 	unsigned char *efimg;
 	unsigned short efimg_length;
 =

+	gboolean waiting_ready;
+
 	enum ofono_sim_state state;
 	struct ofono_watchlist *state_watches;
 =

@@ -1227,6 +1229,14 @@ static void sim_pin_query_cb(const struct ofono_erro=
r *error,
 		goto checkdone;
 	}
 =

+	if (pin_type =3D=3D OFONO_SIM_PASSWORD_INVALID) {
+		DBG("Waiting for ready notification");
+
+		sim->waiting_ready =3D TRUE;
+
+		return;
+	}
+
 	if (sim->pin_type !=3D pin_type) {
 		sim->pin_type =3D pin_type;
 		pin_name =3D sim_passwd_name(pin_type);
@@ -1251,6 +1261,8 @@ checkdone:
 =

 static void sim_pin_check(struct ofono_sim *sim)
 {
+	sim->waiting_ready =3D FALSE;
+
 	if (!sim->driver->query_passwd_state) {
 		sim_initialize_after_pin(sim);
 		return;
@@ -1259,6 +1271,20 @@ static void sim_pin_check(struct ofono_sim *sim)
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
+	if (sim->waiting_ready)
+		sim_pin_check(sim);
+}
+
 static void sim_efli_read_cb(int ok, int length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
-- =

1.7.0.4


--===============3072658204601377066==--

