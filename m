Content-Type: multipart/mixed; boundary="===============8138195634285038063=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/2] sim: add sim_ready_notify
Date: Tue, 24 Aug 2010 07:24:13 -0700
Message-ID: <1282659854-28097-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8138195634285038063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    2 ++
 src/sim.c     |   22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 36a99b9..9b7d52e 100644
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
index a450b30..55499fc 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -56,6 +56,9 @@ static void sim_own_numbers_update(struct ofono_sim *sim);
 static void sim_pin_check(struct ofono_sim *sim);
 static void sim_set_ready(struct ofono_sim *sim);
 =

+#define SIM_STATUS_READY		1
+#define SIM_STATUS_WAITING_FOR_PIN	(1 << 1)
+
 struct sim_file_op {
 	int id;
 	gboolean cache;
@@ -78,6 +81,7 @@ struct ofono_sim {
 	GSList *new_numbers;
 	GSList *service_numbers;
 	gboolean sdn_ready;
+	unsigned int status;
 	enum ofono_sim_state state;
 	enum ofono_sim_password_type pin_type;
 	gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PINs */
@@ -1191,6 +1195,14 @@ checkdone:
 =

 static void sim_pin_check(struct ofono_sim *sim)
 {
+	if (!(sim->status & SIM_STATUS_READY)) {
+		sim->status |=3D SIM_STATUS_WAITING_FOR_PIN;
+		return;
+	}
+
+	if (sim->status & SIM_STATUS_WAITING_FOR_PIN)
+		sim->status &=3D ~(SIM_STATUS_WAITING_FOR_PIN);
+
 	if (!sim->driver->query_passwd_state) {
 		sim_initialize_after_pin(sim);
 		return;
@@ -2004,6 +2016,16 @@ static void sim_free_state(struct ofono_sim *sim)
 	}
 =

 	sim->mnc_length =3D 0;
+
+	sim->status =3D 0;
+}
+
+void ofono_sim_ready_notify(struct ofono_sim *sim)
+{
+	sim->status |=3D SIM_STATUS_READY;
+
+	if (sim->status & SIM_STATUS_WAITING_FOR_PIN)
+		sim_pin_check(sim);
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
-- =

1.7.2.1


--===============8138195634285038063==--

