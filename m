Content-Type: multipart/mixed; boundary="===============7618101240446318344=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 2/3] sim: Don't use sim file system for CDMA sim
Date: Wed, 16 Nov 2011 15:49:00 +0100
Message-ID: <1321454941-32022-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1321454941-32022-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7618101240446318344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----=
---
 1 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d1d55c5..9ba3483 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -102,6 +102,8 @@ struct ofono_sim {
 	unsigned char *iidf_image;
 	unsigned int *iidf_watch_ids;
 =

+	gboolean cdma_sim;
+
 	DBusMessage *pending;
 	const struct ofono_sim_driver *driver;
 	void *driver_data;
@@ -1380,7 +1382,8 @@ static void sim_set_ready(struct ofono_sim *sim)
 =

 	sim->state =3D OFONO_SIM_STATE_READY;
 =

-	sim_fs_check_version(sim->simfs);
+	if (sim->simfs)
+		sim_fs_check_version(sim->simfs);
 =

 	call_state_watches(sim);
 }
@@ -2527,6 +2530,47 @@ struct ofono_sim *ofono_sim_create(struct ofono_mode=
m *modem,
 	return sim;
 }
 =

+struct ofono_sim *ofono_cdma_sim_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver,
+					void *data)
+{
+	struct ofono_sim *sim;
+	GSList *l;
+	int i;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	sim =3D g_try_new0(struct ofono_sim, 1);
+
+	if (sim =3D=3D NULL)
+		return NULL;
+
+	sim->cdma_sim =3D TRUE;
+	sim->phase =3D OFONO_SIM_PHASE_UNKNOWN;
+	sim->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_SIM,
+						sim_remove, sim);
+
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		sim->pin_retries[i] =3D -1;
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_sim_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(sim, vendor, data) < 0)
+			continue;
+
+		sim->driver =3D drv;
+		break;
+	}
+
+	return sim;
+}
+
 static void emulator_cnum_cb(struct ofono_emulator *em,
 			struct ofono_emulator_request *req, void *userdata)
 {
@@ -2591,19 +2635,23 @@ void ofono_sim_register(struct ofono_sim *sim)
 	}
 =

 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
-	sim->state_watches =3D __ofono_watchlist_new(g_free);
-	sim->simfs =3D sim_fs_new(sim, sim->driver);
 =

+	sim->state_watches =3D __ofono_watchlist_new(g_free);
 	__ofono_atom_register(sim->atom, sim_unregister);
 =

-	ofono_sim_add_state_watch(sim, sim_ready, sim, NULL);
+	if (sim->cdma_sim =3D=3D FALSE) {
+		sim->simfs =3D sim_fs_new(sim, sim->driver);
 =

-	if (sim->state > OFONO_SIM_STATE_NOT_PRESENT)
-		sim_initialize(sim);
+		ofono_sim_add_state_watch(sim, sim_ready, sim, NULL);
+
+		if (sim->state > OFONO_SIM_STATE_NOT_PRESENT)
+			sim_initialize(sim);
 =

-	sim->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
-					OFONO_ATOM_TYPE_EMULATOR_HFP,
-					emulator_hfp_watch, sim, NULL);
+		sim->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_hfp_watch, sim, NULL);
+	} else
+		sim_retrieve_imsi(sim);
 }
 =

 void ofono_sim_remove(struct ofono_sim *sim)
-- =

1.7.1


--===============7618101240446318344==--

