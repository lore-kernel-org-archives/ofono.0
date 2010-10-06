Content-Type: multipart/mixed; boundary="===============3147891461146259085=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 1/3] sim: check if Fixed Dialing is enabled in the SIM-card
Date: Wed, 06 Oct 2010 17:17:55 +0300
Message-ID: <1286374677-2932-2-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1286374677-2932-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3147891461146259085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If FD is enabled, halt SIM initialization procedure.
---
 src/sim.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 6f10d4c..930d6bf 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -71,6 +71,7 @@ struct ofono_sim {
 	unsigned char efest_length;
 	unsigned char *efsst;
 	unsigned char efsst_length;
+	gboolean fixed_dialing;
 =

 	char *imsi;
 =

@@ -307,6 +308,9 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 		ofono_dbus_dict_append(&dict, "SubscriberIdentity",
 					DBUS_TYPE_STRING, &sim->imsi);
 =

+	ofono_dbus_dict_append(&dict, "FixedDialing", DBUS_TYPE_BOOLEAN,
+				&sim->fixed_dialing);
+
 	if (sim->mnc_length) {
 		char mcc[OFONO_MAX_MCC_LENGTH + 1];
 		char mnc[OFONO_MAX_MNC_LENGTH + 1];
@@ -1066,6 +1070,10 @@ static void sim_efsst_read_cb(int ok, int length, in=
t record,
 				int record_length, void *userdata)
 {
 	struct ofono_sim *sim =3D userdata;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+
+	sim->fixed_dialing =3D FALSE;
 =

 	if (!ok)
 		goto out;
@@ -1078,6 +1086,19 @@ static void sim_efsst_read_cb(int ok, int length, in=
t record,
 	sim->efsst =3D g_memdup(data, length);
 	sim->efsst_length =3D length;
 =

+	if (sim_sst_is_active(sim->efsst, sim->efsst_length,
+				SIM_SST_SERVICE_FDN)) {
+
+		sim->fixed_dialing =3D TRUE;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"FixedDialing",
+						DBUS_TYPE_BOOLEAN,
+						&sim->fixed_dialing);
+		return;
+	}
+
 out:
 	sim_retrieve_imsi(sim);
 }
@@ -1087,6 +1108,8 @@ static void sim_efest_read_cb(int ok, int length, int=
 record,
 				int record_length, void *userdata)
 {
 	struct ofono_sim *sim =3D userdata;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
 =

 	if (!ok)
 		goto out;
@@ -1099,6 +1122,19 @@ static void sim_efest_read_cb(int ok, int length, in=
t record,
 	sim->efest =3D g_memdup(data, length);
 	sim->efest_length =3D length;
 =

+	if (sim_est_is_active(sim->efest, sim->efest_length,
+				SIM_EST_SERVICE_FDN)) {
+
+		sim->fixed_dialing =3D TRUE;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"FixedDialing",
+						DBUS_TYPE_BOOLEAN,
+						&sim->fixed_dialing);
+		return;
+	}
+
 out:
 	sim_retrieve_imsi(sim);
 }
@@ -1109,6 +1145,8 @@ static void sim_efust_read_cb(int ok, int length, int=
 record,
 {
 	struct ofono_sim *sim =3D userdata;
 =

+	sim->fixed_dialing =3D FALSE;
+
 	if (!ok)
 		goto out;
 =

@@ -1665,6 +1703,8 @@ static void sim_free_state(struct ofono_sim *sim)
 		sim->efimg =3D NULL;
 		sim->efimg_length =3D 0;
 	}
+
+	sim->fixed_dialing =3D FALSE;
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
-- =

1.6.3.3



--===============3147891461146259085==--

