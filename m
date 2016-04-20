Content-Type: multipart/mixed; boundary="===============5893718393635639002=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] Fix crash when PUK is required
Date: Wed, 20 Apr 2016 16:09:45 +0800
Message-ID: <1461139785-28790-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5893718393635639002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

After input PIN wrong 3 times, sim main state (include spn_watches)
is freed. but the watch id still be kept by other atoms (network and
gprs), when remove the atom, it will try to remove the watch from
spn_watches, ofono daemon will crash.
---
 src/sim.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index e1c1809..bcf5afd 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1840,7 +1840,6 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 static void sim_initialize_after_pin(struct ofono_sim *sim)
 {
 	sim->context =3D ofono_sim_context_create(sim);
-	sim->spn_watches =3D __ofono_watchlist_new(g_free);
 =

 	ofono_sim_read(sim->context, SIM_EFPHASE_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
@@ -2348,11 +2347,6 @@ static void sim_free_early_state(struct ofono_sim *s=
im)
 =

 static void sim_spn_close(struct ofono_sim *sim)
 {
-	if (sim->spn_watches) {
-		__ofono_watchlist_free(sim->spn_watches);
-		sim->spn_watches =3D NULL;
-	}
-
 	/*
 	 * We have not initialized SPN logic at all yet, either because
 	 * no netreg / gprs atom has been needed or we have not reached the
@@ -2881,6 +2875,8 @@ static void sim_unregister(struct ofono_atom *atom)
 =

 	__ofono_watchlist_free(sim->state_watches);
 	sim->state_watches =3D NULL;
+	__ofono_watchlist_free(sim->spn_watches);
+	sim->spn_watches =3D NULL;
 =

 	g_dbus_unregister_interface(conn, path, OFONO_SIM_MANAGER_INTERFACE);
 	ofono_modem_remove_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
@@ -3011,6 +3007,7 @@ void ofono_sim_register(struct ofono_sim *sim)
 =

 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
 	sim->state_watches =3D __ofono_watchlist_new(g_free);
+	sim->spn_watches =3D __ofono_watchlist_new(g_free);
 	sim->simfs =3D sim_fs_new(sim, sim->driver);
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
-- =

1.9.1


--===============5893718393635639002==--

