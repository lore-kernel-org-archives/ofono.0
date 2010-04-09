Content-Type: multipart/mixed; boundary="===============6904998222893414306=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/8] Functions to notify core of SIM insertion/removal.
Date: Fri, 09 Apr 2010 08:48:50 +0200
Message-ID: <1270795730-7127-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6904998222893414306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make every plugin generate a sim inserted event on start.  For devices
with removable card, the event should be emitted after the
plugin detects such event.
---
 include/sim.h      |    3 +-
 plugins/atgen.c    |    6 +++-
 plugins/calypso.c  |    6 +++-
 plugins/em770.c    |    6 +++-
 plugins/g1.c       |    6 +++-
 plugins/hso.c      |    6 +++-
 plugins/huawei.c   |    6 +++-
 plugins/mbm.c      |    6 +++-
 plugins/palmpre.c  |    6 +++-
 plugins/phonesim.c |    6 +++-
 plugins/ste.c      |    6 +++-
 src/sim.c          |   78 ++++++++++++++++++++++++++++++++++++------------=
---
 12 files changed, 107 insertions(+), 34 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 23b1905..2218564 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -187,7 +187,8 @@ unsigned int ofono_sim_add_state_watch(struct ofono_sim=
 *sim,
 void ofono_sim_remove_state_watch(struct ofono_sim *sim, unsigned int id);
 =

 enum ofono_sim_state ofono_sim_get_state(struct ofono_sim *sim);
-void ofono_sim_set_ready(struct ofono_sim *sim);
+
+void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d);
 =

 /* This will queue an operation to read all available records with id from=
 the
  * SIM.  Callback cb will be called every time a record has been read, or =
once
diff --git a/plugins/atgen.c b/plugins/atgen.c
index 7e760bc..ed963c2 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -156,12 +156,16 @@ static int atgen_disable(struct ofono_modem *modem)
 static void atgen_pre_sim(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", chat);
-	ofono_sim_create(modem, 0, "atmodem", chat);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", chat);
 	ofono_voicecall_create(modem, 0, "atmodem", chat);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void atgen_post_sim(struct ofono_modem *modem)
diff --git a/plugins/calypso.c b/plugins/calypso.c
index 5b28176..9d6280c 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -431,12 +431,16 @@ static int calypso_disable(struct ofono_modem *modem)
 static void calypso_pre_sim(struct ofono_modem *modem)
 {
 	struct calypso_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("");
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
-	ofono_sim_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_voicecall_create(modem, 0, "calypsomodem", data->dlcs[VOICE_DLC]);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void calypso_post_sim(struct ofono_modem *modem)
diff --git a/plugins/em770.c b/plugins/em770.c
index a5d87f7..138c67a 100644
--- a/plugins/em770.c
+++ b/plugins/em770.c
@@ -172,12 +172,16 @@ static int em770_disable(struct ofono_modem *modem)
 static void em770_pre_sim(struct ofono_modem *modem)
 {
 	struct em770_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	ofono_sim_create(modem, 0, "atmodem", data->chat);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void em770_post_sim(struct ofono_modem *modem)
diff --git a/plugins/g1.c b/plugins/g1.c
index 81edfab..fa96eb1 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -156,12 +156,16 @@ static int g1_disable(struct ofono_modem *modem)
 static void g1_pre_sim(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("");
 =

 	ofono_devinfo_create(modem, 0, "atmodem", chat);
-	ofono_sim_create(modem, 0, "atmodem", chat);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", chat);
 	ofono_voicecall_create(modem, 0, "atmodem", chat);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void g1_post_sim(struct ofono_modem *modem)
diff --git a/plugins/hso.c b/plugins/hso.c
index e682064..27b69dc 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -198,11 +198,15 @@ static int hso_disable(struct ofono_modem *modem)
 static void hso_pre_sim(struct ofono_modem *modem)
 {
 	struct hso_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->control);
-	ofono_sim_create(modem, 0, "atmodem", data->control);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->control);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void hso_post_sim(struct ofono_modem *modem)
diff --git a/plugins/huawei.c b/plugins/huawei.c
index 41ad636..90fdcf0 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -163,12 +163,16 @@ static int huawei_disable(struct ofono_modem *modem)
 static void huawei_pre_sim(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	ofono_sim_create(modem, 0, "atmodem", data->chat);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void huawei_post_sim(struct ofono_modem *modem)
diff --git a/plugins/mbm.c b/plugins/mbm.c
index 439d3b9..79d180b 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -285,12 +285,16 @@ static int mbm_disable(struct ofono_modem *modem)
 static void mbm_pre_sim(struct ofono_modem *modem)
 {
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->modem_port);
-	ofono_sim_create(modem, 0, "atmodem", data->modem_port);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->modem_port);
 	ofono_voicecall_create(modem, 0, "atmodem", data->modem_port);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void mbm_post_sim(struct ofono_modem *modem)
diff --git a/plugins/palmpre.c b/plugins/palmpre.c
index 049b9bd..7d2aeb4 100644
--- a/plugins/palmpre.c
+++ b/plugins/palmpre.c
@@ -170,13 +170,17 @@ static int palmpre_disable(struct ofono_modem *modem)
 static void palmpre_pre_sim(struct ofono_modem *modem)
 {
 	struct palmpre_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem",
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem",
 				data->chat);
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void palmpre_post_sim(struct ofono_modem *modem)
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index ca12cf2..4c3b3ce 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -277,16 +277,20 @@ static int phonesim_disable(struct ofono_modem *modem)
 static void phonesim_pre_sim(struct ofono_modem *modem)
 {
 	struct phonesim_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	ofono_sim_create(modem, 0, "atmodem", data->chat);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
 =

 	if (data->calypso)
 		ofono_voicecall_create(modem, 0, "calypsomodem", data->chat);
 	else
 		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void phonesim_post_sim(struct ofono_modem *modem)
diff --git a/plugins/ste.c b/plugins/ste.c
index 66065c1..7e2df96 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -208,12 +208,16 @@ static int ste_disable(struct ofono_modem *modem)
 static void ste_pre_sim(struct ofono_modem *modem)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	ofono_sim_create(modem, 0, "atmodem", data->chat);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
 	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void ste_post_sim(struct ofono_modem *modem)
diff --git a/src/sim.c b/src/sim.c
index 58de191..5559be4 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -55,6 +55,7 @@ static gboolean sim_op_next(gpointer user_data);
 static gboolean sim_op_retrieve_next(gpointer user);
 static void sim_own_numbers_update(struct ofono_sim *sim);
 static void sim_pin_check(struct ofono_sim *sim);
+static void sim_set_ready(struct ofono_sim *sim);
 =

 struct sim_file_op {
 	int id;
@@ -1003,7 +1004,7 @@ static void sim_cphs_information_read_cb(int ok, int =
length, int record,
 	memcpy(sim->cphs_service_table, data + 1, 2);
 =

 ready:
-	ofono_sim_set_ready(sim);
+	sim_set_ready(sim);
 }
 =

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
@@ -1778,6 +1779,53 @@ const unsigned char *ofono_sim_get_cphs_service_tabl=
e(struct ofono_sim *sim)
 	return sim->cphs_service_table;
 }
 =

+void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
+{
+	ofono_sim_state_event_notify_cb_t notify;
+	GSList *l;
+
+	if (inserted && sim->state =3D=3D OFONO_SIM_STATE_NOT_PRESENT)
+		sim->state =3D OFONO_SIM_STATE_INSERTED;
+	else if (!inserted && sim->state !=3D OFONO_SIM_STATE_NOT_PRESENT)
+		sim->state =3D OFONO_SIM_STATE_NOT_PRESENT;
+	else
+		return;
+
+	if (!__ofono_atom_get_registered(sim->atom))
+		return;
+
+	for (l =3D sim->state_watches->items; l; l =3D l->next) {
+		struct ofono_watchlist_item *item =3D l->data;
+		notify =3D item->notify;
+
+		notify(item->notify_data, sim->state);
+	}
+
+	if (!inserted)
+		return;
+
+	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
+	 * The assumption here is that if sim manager is being initialized,
+	 * then sim commands are implemented, and the sim manager is then
+	 * responsible for checking the PIN, reading the IMSI and signaling
+	 * SIM ready condition.
+	 *
+	 * The procedure according to 31.102 is roughly:
+	 * Read EFecc
+	 * Read EFli and EFpl
+	 * SIM Pin check
+	 * Request SIM phase (only in 51.011)
+	 * Read EFust
+	 * Read EFest
+	 * Read IMSI
+	 *
+	 * At this point we signal the SIM ready condition and allow
+	 * arbitrary files to be written or read, assuming their presence
+	 * in the EFust
+	 */
+	sim_determine_phase(sim);
+}
+
 unsigned int ofono_sim_add_state_watch(struct ofono_sim *sim,
 				ofono_sim_state_event_notify_cb_t notify,
 				void *data, ofono_destroy_func destroy)
@@ -1814,7 +1862,7 @@ enum ofono_sim_state ofono_sim_get_state(struct ofono=
_sim *sim)
 	return sim->state;
 }
 =

-void ofono_sim_set_ready(struct ofono_sim *sim)
+static void sim_set_ready(struct ofono_sim *sim)
 {
 	GSList *l;
 	ofono_sim_state_event_notify_cb_t notify;
@@ -2000,6 +2048,7 @@ void ofono_sim_register(struct ofono_sim *sim)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(sim->atom);
 	const char *path =3D __ofono_atom_get_path(sim->atom);
+	ofono_bool_t inserted;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_SIM_MANAGER_INTERFACE,
@@ -2013,32 +2062,15 @@ void ofono_sim_register(struct ofono_sim *sim)
 =

 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
 	sim->state_watches =3D __ofono_watchlist_new(g_free);
-	sim->state =3D OFONO_SIM_STATE_INSERTED;
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
 =

 	ofono_sim_add_state_watch(sim, sim_ready, sim, NULL);
 =

-	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
-	 * The assumption here is that if sim manager is being initialized,
-	 * then sim commands are implemented, and the sim manager is then
-	 * responsible for checking the PIN, reading the IMSI and signaling
-	 * SIM ready condition.
-	 *
-	 * The procedure according to 31.102 is roughly:
-	 * Read EFecc
-	 * Read EFli and EFpl
-	 * SIM Pin check
-	 * Request SIM phase (only in 51.011)
-	 * Read EFust
-	 * Read EFest
-	 * Read IMSI
-	 *
-	 * At this point we signal the SIM ready condition and allow
-	 * arbitrary files to be written or read, assuming their presence
-	 * in the EFust
-	 */
-	sim_determine_phase(sim);
+	inserted =3D sim->state !=3D OFONO_SIM_STATE_NOT_PRESENT;
+	sim->state =3D OFONO_SIM_STATE_NOT_PRESENT;
+
+	ofono_sim_inserted_notify(sim, inserted);
 }
 =

 void ofono_sim_remove(struct ofono_sim *sim)
-- =

1.6.1


--===============6904998222893414306==--

