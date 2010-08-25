Content-Type: multipart/mixed; boundary="===============5597595566042786985=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/2] sim: add ofono_sim_ready_notify() support
Date: Wed, 25 Aug 2010 04:23:11 -0700
Message-ID: <1282735392-5283-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1282735392-5283-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5597595566042786985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    2 ++
 src/sim.c     |   25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

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
index 04a708b..b76a263 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -56,6 +56,9 @@ static void sim_own_numbers_update(struct ofono_sim *sim);
 static void sim_pin_check(struct ofono_sim *sim);
 static void sim_set_ready(struct ofono_sim *sim);
 =

+#define SIM_STATUS_READY		1
+#define SIM_STATUS_WAITING_FOR_READY	(1 << 1)
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
@@ -686,15 +690,20 @@ static void sim_enter_pin_cb(const struct ofono_error=
 *error, void *data)
 {
 	struct ofono_sim *sim =3D data;
 	DBusMessage *reply;
+	gboolean ok =3D (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR);
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+	if (!ok)
 		reply =3D __ofono_error_failed(sim->pending);
 	else
 		reply =3D dbus_message_new_method_return(sim->pending);
 =

 	__ofono_dbus_pending_reply(&sim->pending, reply);
 =

-	sim_pin_check(sim);
+	if (ok && (sim->status & SIM_STATUS_READY)) {
+		sim->status &=3D ~SIM_STATUS_WAITING_FOR_READY;
+		sim_pin_check(sim);
+	} else
+		sim->status |=3D SIM_STATUS_WAITING_FOR_READY;
 }
 =

 static DBusMessage *sim_enter_pin(DBusConnection *conn, DBusMessage *msg,
@@ -2002,6 +2011,18 @@ static void sim_free_state(struct ofono_sim *sim)
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
+	if (sim->status & SIM_STATUS_WAITING_FOR_READY) {
+		sim->status &=3D ~SIM_STATUS_WAITING_FOR_READY;
+		sim_pin_check(sim);
+	}
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
-- =

1.7.2.1


--===============5597595566042786985==--

