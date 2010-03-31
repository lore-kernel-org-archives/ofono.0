Content-Type: multipart/mixed; boundary="===============4033300220530864586=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5][RfC] Add functions to notify core of SIM
 insertion/removal/proactive command.
Date: Wed, 31 Mar 2010 06:57:42 +0200
Message-ID: <1270011462-6831-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4033300220530864586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make every plugin generate a sim inserted event on start.  For devices
with removable SIM card, the event should be emitted after the
plugin detects it.
---
 include/sim.h      |   12 +++++-
 plugins/atgen.c    |    5 ++-
 plugins/calypso.c  |    5 ++-
 plugins/em770.c    |    5 ++-
 plugins/g1.c       |    5 ++-
 plugins/hso.c      |    5 ++-
 plugins/huawei.c   |    5 ++-
 plugins/mbm.c      |    5 ++-
 plugins/palmpre.c  |    5 ++-
 plugins/phonesim.c |    5 ++-
 plugins/ste.c      |    5 ++-
 src/sim.c          |  113 +++++++++++++++++++++++++++++++++++++++++-------=
----
 12 files changed, 141 insertions(+), 34 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 6ff29f7..2cf6afb 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -179,8 +179,18 @@ unsigned int ofono_sim_add_ready_watch(struct ofono_si=
m *sim,
 =

 void ofono_sim_remove_ready_watch(struct ofono_sim *sim, unsigned int id);
 =

+unsigned int ofono_sim_add_removed_watch(struct ofono_sim *sim,
+				ofono_sim_ready_notify_cb_t cb,
+				void *data, ofono_destroy_func destroy);
+
+void ofono_sim_remove_removed_watch(struct ofono_sim *sim, unsigned int id=
);
+
 int ofono_sim_get_ready(struct ofono_sim *sim);
-void ofono_sim_set_ready(struct ofono_sim *sim);
+
+void ofono_sim_inserted(struct ofono_sim *sim);
+void ofono_sim_removed(struct ofono_sim *sim);
+void ofono_sim_proactive_command_notify(struct ofono_sim *sim,
+		int length, const guint8 *pdu);
 =

 /* This will queue an operation to read all available records with id from=
 the
  * SIM.  Callback cb will be called every time a record has been read, or =
once
diff --git a/plugins/atgen.c b/plugins/atgen.c
index 7e760bc..bbfb99c 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -156,12 +156,15 @@ static int atgen_disable(struct ofono_modem *modem)
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
+	ofono_sim_inserted(sim);
 }
 =

 static void atgen_post_sim(struct ofono_modem *modem)
diff --git a/plugins/calypso.c b/plugins/calypso.c
index 5b28176..db02b94 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -431,12 +431,15 @@ static int calypso_disable(struct ofono_modem *modem)
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
+	ofono_sim_inserted(sim);
 }
 =

 static void calypso_post_sim(struct ofono_modem *modem)
diff --git a/plugins/em770.c b/plugins/em770.c
index a5d87f7..df09a8f 100644
--- a/plugins/em770.c
+++ b/plugins/em770.c
@@ -172,12 +172,15 @@ static int em770_disable(struct ofono_modem *modem)
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
+	ofono_sim_inserted(sim);
 }
 =

 static void em770_post_sim(struct ofono_modem *modem)
diff --git a/plugins/g1.c b/plugins/g1.c
index 81edfab..2a3d257 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -156,12 +156,15 @@ static int g1_disable(struct ofono_modem *modem)
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
+	ofono_sim_inserted(sim);
 }
 =

 static void g1_post_sim(struct ofono_modem *modem)
diff --git a/plugins/hso.c b/plugins/hso.c
index e682064..9bebb0d 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -198,11 +198,14 @@ static int hso_disable(struct ofono_modem *modem)
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
+	ofono_sim_inserted(sim);
 }
 =

 static void hso_post_sim(struct ofono_modem *modem)
diff --git a/plugins/huawei.c b/plugins/huawei.c
index 41ad636..ee48498 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -163,12 +163,15 @@ static int huawei_disable(struct ofono_modem *modem)
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
+	ofono_sim_inserted(sim);
 }
 =

 static void huawei_post_sim(struct ofono_modem *modem)
diff --git a/plugins/mbm.c b/plugins/mbm.c
index a164361..af0915e 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -272,12 +272,15 @@ static int mbm_disable(struct ofono_modem *modem)
 static void mbm_pre_sim(struct ofono_modem *modem)
 {
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	ofono_sim_create(modem, 0, "atmodem", data->chat);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+
+	ofono_sim_inserted(sim);
 }
 =

 static void mbm_post_sim(struct ofono_modem *modem)
diff --git a/plugins/palmpre.c b/plugins/palmpre.c
index 049b9bd..7734d0d 100644
--- a/plugins/palmpre.c
+++ b/plugins/palmpre.c
@@ -170,13 +170,16 @@ static int palmpre_disable(struct ofono_modem *modem)
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
+	ofono_sim_inserted(sim);
 }
 =

 static void palmpre_post_sim(struct ofono_modem *modem)
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 523f5a9..fb85523 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -277,16 +277,19 @@ static int phonesim_disable(struct ofono_modem *modem)
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
+	ofono_sim_inserted(sim);
 }
 =

 static void phonesim_post_sim(struct ofono_modem *modem)
diff --git a/plugins/ste.c b/plugins/ste.c
index 66065c1..24eabba 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -208,12 +208,15 @@ static int ste_disable(struct ofono_modem *modem)
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
+	ofono_sim_inserted(sim);
 }
 =

 static void ste_post_sim(struct ofono_modem *modem)
diff --git a/src/sim.c b/src/sim.c
index 6402761..3d89cb2 100644
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
@@ -90,6 +91,8 @@ struct ofono_sim {
 	enum ofono_sim_cphs_phase cphs_phase;
 	unsigned char cphs_service_table[2];
 	struct ofono_watchlist *ready_watches;
+	struct ofono_watchlist *removed_watches;
+	gboolean inserted;
 	const struct ofono_sim_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -970,7 +973,7 @@ static void sim_cphs_information_read_cb(int ok, int le=
ngth, int record,
 	memcpy(sim->cphs_service_table, data + 1, 2);
 =

 ready:
-	ofono_sim_set_ready(sim);
+	sim_set_ready(sim);
 }
 =

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
@@ -1745,6 +1748,60 @@ const unsigned char *ofono_sim_get_cphs_service_tabl=
e(struct ofono_sim *sim)
 	return sim->cphs_service_table;
 }
 =

+void ofono_sim_inserted(struct ofono_sim *sim)
+{
+	sim->inserted =3D TRUE;
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
+void ofono_sim_removed(struct ofono_sim *sim)
+{
+	GSList *l;
+	ofono_sim_ready_notify_cb_t notify;
+
+	if (sim =3D=3D NULL)
+		return;
+
+	sim->inserted =3D FALSE;
+
+	if (sim->ready =3D=3D FALSE)
+		return;
+
+	sim->ready =3D FALSE;
+
+	for (l =3D sim->removed_watches->items; l; l =3D l->next) {
+		struct ofono_watchlist_item *item =3D l->data;
+		notify =3D item->notify;
+
+		notify(item->notify_data);
+	}
+}
+
+void ofono_sim_proactive_command_notify(struct ofono_sim *sim,
+		int length, const guint8 *pdu)
+{
+}
+
 unsigned int ofono_sim_add_ready_watch(struct ofono_sim *sim,
 				ofono_sim_ready_notify_cb_t notify,
 				void *data, ofono_destroy_func destroy)
@@ -1773,6 +1830,34 @@ void ofono_sim_remove_ready_watch(struct ofono_sim *=
sim, unsigned int id)
 	__ofono_watchlist_remove_item(sim->ready_watches, id);
 }
 =

+unsigned int ofono_sim_add_removed_watch(struct ofono_sim *sim,
+				ofono_sim_ready_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	DBG("%p", sim);
+
+	if (sim =3D=3D NULL)
+		return 0;
+
+	if (notify =3D=3D NULL)
+		return 0;
+
+	item =3D g_new0(struct ofono_watchlist_item, 1);
+
+	item->notify =3D notify;
+	item->destroy =3D destroy;
+	item->notify_data =3D data;
+
+	return __ofono_watchlist_add_item(sim->removed_watches, item);
+}
+
+void ofono_sim_remove_removed_watch(struct ofono_sim *sim, unsigned int id)
+{
+	__ofono_watchlist_remove_item(sim->removed_watches, id);
+}
+
 int ofono_sim_get_ready(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
@@ -1784,7 +1869,7 @@ int ofono_sim_get_ready(struct ofono_sim *sim)
 	return 0;
 }
 =

-void ofono_sim_set_ready(struct ofono_sim *sim)
+static void sim_set_ready(struct ofono_sim *sim)
 {
 	GSList *l;
 	ofono_sim_ready_notify_cb_t notify;
@@ -1869,6 +1954,8 @@ static void sim_unregister(struct ofono_atom *atom)
 =

 	__ofono_watchlist_free(sim->ready_watches);
 	sim->ready_watches =3D NULL;
+	__ofono_watchlist_free(sim->removed_watches);
+	sim->removed_watches =3D NULL;
 =

 	g_dbus_unregister_interface(conn, path, OFONO_SIM_MANAGER_INTERFACE);
 	ofono_modem_remove_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
@@ -1983,31 +2070,11 @@ void ofono_sim_register(struct ofono_sim *sim)
 =

 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
 	sim->ready_watches =3D __ofono_watchlist_new(g_free);
+	sim->removed_watches =3D __ofono_watchlist_new(g_free);
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
 =

 	ofono_sim_add_ready_watch(sim, sim_ready, sim, NULL);
-
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
 }
 =

 void ofono_sim_remove(struct ofono_sim *sim)
-- =

1.6.1


--===============4033300220530864586==--

