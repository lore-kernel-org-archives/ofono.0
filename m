Content-Type: multipart/mixed; boundary="===============0927996087472393124=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 1/4] sim: check if FD is enabled in the SIM-card
Date: Fri, 01 Oct 2010 19:06:38 +0300
Message-ID: <1285949201-2994-2-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1285949201-2994-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0927996087472393124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |   23 +++++++++++++++++++++
 include/sim.h         |    3 ++
 src/sim.c             |   52 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index d0a7148..854ba08 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -831,6 +831,28 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static void at_barring_query_enabled(struct ofono_sim *sim,
+				ofono_sim_locked_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+
+	if (!cbd)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"FD\",2");
+
+	if (g_at_chat_send(sd->chat, buf, clck_prefix,
+				at_lock_status_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
 static gboolean at_sim_register(gpointer user)
 {
 	struct ofono_sim *sim =3D user;
@@ -898,6 +920,7 @@ static struct ofono_sim_driver driver =3D {
 	.lock			=3D at_pin_enable,
 	.change_passwd		=3D at_change_passwd,
 	.query_locked		=3D at_pin_query_enabled,
+	.query_call_barred	=3D at_barring_query_enabled,
 };
 =

 void at_sim_init()
diff --git a/include/sim.h b/include/sim.h
index 42b19bd..e73a995 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -74,6 +74,7 @@ enum ofono_sim_cphs_phase {
 enum ofono_sim_state {
 	OFONO_SIM_STATE_NOT_PRESENT,
 	OFONO_SIM_STATE_INSERTED,
+	OFONO_SIM_STATE_FAILED,
 	OFONO_SIM_STATE_READY,
 };
 =

@@ -156,6 +157,8 @@ struct ofono_sim_driver {
 	void (*query_locked)(struct ofono_sim *sim,
 			enum ofono_sim_password_type type,
 			ofono_sim_locked_cb_t cb, void *data);
+	void (*query_call_barred)(struct ofono_sim *sim,
+			ofono_sim_locked_cb_t cb, void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
diff --git a/src/sim.c b/src/sim.c
index 6f10d4c..2252ae0 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -49,6 +49,7 @@ static GSList *g_drivers =3D NULL;
 static void sim_own_numbers_update(struct ofono_sim *sim);
 static void sim_pin_check(struct ofono_sim *sim);
 static void sim_set_ready(struct ofono_sim *sim);
+static void sim_set_not_ready(struct ofono_sim *sim);
 =

 struct ofono_sim {
 	/* Contents of the SIM file system, in rough initialization order */
@@ -1468,6 +1469,27 @@ static void sim_iccid_read_cb(int ok, int length, in=
t record,
 						&sim->iccid);
 }
 =

+static void sim_call_barred_query_cb(const struct ofono_error *error,
+				int locked,
+				gpointer data)
+{
+	struct ofono_sim *sim =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || locked) {
+
+		ofono_error("Fixed Dialing is enabled, emergency calls only");
+		sim_set_not_ready(sim);
+	}
+}
+
+static void sim_call_barring_check(struct ofono_sim *sim)
+{
+	if (!sim->driver->query_call_barred)
+		return;
+
+	sim->driver->query_call_barred(sim, sim_call_barred_query_cb, sim);
+}
+
 static void sim_initialize(struct ofono_sim *sim)
 {
 	/*
@@ -1496,6 +1518,15 @@ static void sim_initialize(struct ofono_sim *sim)
 	 * in the EFust
 	 */
 =

+	/*
+	 * In this moment Fixed Dialing is not supported.
+	 * Check if FD is enabled in the SIM-card. If it's
+	 * enabled, signal SIM not ready condition.
+	 * This function checks in this moment only FD-status,
+	 * not any call-barrings.
+	 */
+	sim_call_barring_check(sim);
+
 	/* Grab the EFiccid which is always available */
 	ofono_sim_read(sim, SIM_EF_ICCID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
@@ -1733,6 +1764,27 @@ enum ofono_sim_state ofono_sim_get_state(struct ofon=
o_sim *sim)
 	return sim->state;
 }
 =

+static void sim_set_not_ready(struct ofono_sim *sim)
+{
+	GSList *l;
+	ofono_sim_state_event_cb_t notify;
+
+	if (sim =3D=3D NULL)
+		return;
+
+	if (sim->state !=3D OFONO_SIM_STATE_INSERTED)
+		return;
+
+	sim->state =3D OFONO_SIM_STATE_FAILED;
+
+	for (l =3D sim->state_watches->items; l; l =3D l->next) {
+		struct ofono_watchlist_item *item =3D l->data;
+		notify =3D item->notify;
+
+		notify(sim->state, item->notify_data);
+	}
+}
+
 static void sim_set_ready(struct ofono_sim *sim)
 {
 	GSList *l;
-- =

1.6.3.3



--===============0927996087472393124==--

