Content-Type: multipart/mixed; boundary="===============8598570025751096470=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] sim: allow access to IMSI only when SIM is ready
Date: Mon, 23 Aug 2010 19:57:36 +0300
Message-ID: <1282582656-14507-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8598570025751096470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The IMSI was emitted and got available slightly before sim got
ready (while CPHS-support bits were read).
---
 src/sim.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d2ed780..955452a 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -309,7 +309,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 		ofono_dbus_dict_append(&dict, "CardIdentifier",
 					DBUS_TYPE_STRING, &sim->iccid);
 =

-	if (sim->imsi)
+	if (sim->imsi && sim->state =3D=3D OFONO_SIM_STATE_READY)
 		ofono_dbus_dict_append(&dict, "SubscriberIdentity",
 					DBUS_TYPE_STRING, &sim->imsi);
 =

@@ -1043,8 +1043,6 @@ static void sim_imsi_cb(const struct ofono_error *err=
or, const char *imsi,
 		void *data)
 {
 	struct ofono_sim *sim =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path =3D __ofono_atom_get_path(sim->atom);
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Unable to read IMSI, emergency calls only");
@@ -1053,11 +1051,6 @@ static void sim_imsi_cb(const struct ofono_error *er=
ror, const char *imsi,
 =

 	sim->imsi =3D g_strdup(imsi);
 =

-	ofono_dbus_signal_property_changed(conn, path,
-						OFONO_SIM_MANAGER_INTERFACE,
-						"SubscriberIdentity",
-						DBUS_TYPE_STRING, &sim->imsi);
-
 	/* Read CPHS-support bits, this is still part of the SIM
 	 * initialisation but no order is specified for it.  */
 	ofono_sim_read(sim, SIM_EF_CPHS_INFORMATION_FILEID,
@@ -2004,6 +1997,8 @@ enum ofono_sim_state ofono_sim_get_state(struct ofono=
_sim *sim)
 =

 static void sim_set_ready(struct ofono_sim *sim)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
 	GSList *l;
 	ofono_sim_state_event_notify_cb_t notify;
 =

@@ -2015,6 +2010,12 @@ static void sim_set_ready(struct ofono_sim *sim)
 =

 	sim->state =3D OFONO_SIM_STATE_READY;
 =

+	path =3D __ofono_atom_get_path(sim->atom);
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"SubscriberIdentity",
+						DBUS_TYPE_STRING, &sim->imsi);
+
 	for (l =3D sim->state_watches->items; l; l =3D l->next) {
 		struct ofono_watchlist_item *item =3D l->data;
 		notify =3D item->notify;
-- =

1.7.0.4


--===============8598570025751096470==--

