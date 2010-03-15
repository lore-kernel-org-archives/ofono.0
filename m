Content-Type: multipart/mixed; boundary="===============6286677550713578801=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/8][RFC] Remove post-sim atoms after SIM is extracted.
Date: Mon, 15 Mar 2010 22:21:36 +0100
Message-ID: <1268688096-3946-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6286677550713578801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index b935328..6dfa73a 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -52,6 +52,7 @@ enum ofono_property_type {
 struct ofono_modem {
 	char			*path;
 	GSList			*atoms;
+	GSList			*pre_sim_atoms;
 	struct ofono_watchlist	*atom_watches;
 	GSList         		*interface_list;
 	unsigned int		call_ids;
@@ -64,6 +65,7 @@ struct ofono_modem {
 	struct ofono_sim	*sim;
 	unsigned int		sim_watch;
 	unsigned int		sim_ready_watch;
+	unsigned int		sim_removed_watch;
 	const struct ofono_modem_driver *driver;
 	void			*driver_data;
 	char			*driver_type;
@@ -300,6 +302,7 @@ void __ofono_atom_free(struct ofono_atom *atom)
 	struct ofono_modem *modem =3D atom->modem;
 =

 	modem->atoms =3D g_slist_remove(modem->atoms, atom);
+	modem->pre_sim_atoms =3D g_slist_remove(modem->pre_sim_atoms, atom);
 =

 	__ofono_atom_unregister(atom);
 =

@@ -329,7 +332,35 @@ static void remove_all_atoms(struct ofono_modem *modem)
 	}
 =

 	g_slist_free(modem->atoms);
+	g_slist_free(modem->pre_sim_atoms);
 	modem->atoms =3D NULL;
+	modem->pre_sim_atoms =3D NULL;
+}
+
+static void remove_post_sim_atoms(struct ofono_modem *modem)
+{
+	GSList *l;
+	struct ofono_atom *atom;
+
+	if (modem =3D=3D NULL)
+		return;
+
+	for (l =3D modem->atoms; l; l =3D l->next) {
+		atom =3D l->data;
+
+		if (g_slist_find(modem->pre_sim_atoms, atom))
+			continue;
+
+		__ofono_atom_unregister(atom);
+
+		if (atom->destruct)
+			atom->destruct(atom);
+
+		g_free(atom);
+	}
+
+	g_slist_free(modem->atoms);
+	modem->atoms =3D g_slist_copy(modem->pre_sim_atoms);
 }
 =

 static DBusMessage *modem_get_properties(DBusConnection *conn,
@@ -1121,12 +1152,25 @@ static void modem_sim_ready(void *user)
 {
 	struct ofono_modem *modem =3D user;
 =

+	if (modem->pre_sim_atoms =3D=3D NULL)
+		modem->pre_sim_atoms =3D g_slist_copy(modem->atoms);
+
 	if (modem->driver->post_sim)
 		modem->driver->post_sim(modem);
 =

 	__ofono_history_probe_drivers(modem);
 }
 =

+static void modem_sim_removed(void *user)
+{
+	struct ofono_modem *modem =3D user;
+
+	if (modem->pre_sim_atoms =3D=3D NULL)
+		return;
+
+	remove_post_sim_atoms(modem);
+}
+
 static void sim_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *data)
 {
@@ -1134,6 +1178,7 @@ static void sim_watch(struct ofono_atom *atom,
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
 		modem->sim_ready_watch =3D 0;
+		modem->sim_removed_watch =3D 0;
 		return;
 	}
 =

@@ -1141,6 +1186,9 @@ static void sim_watch(struct ofono_atom *atom,
 	modem->sim_ready_watch =3D ofono_sim_add_ready_watch(modem->sim,
 							modem_sim_ready,
 							modem, NULL);
+	modem->sim_removed_watch =3D ofono_sim_add_removed_watch(modem->sim,
+							modem_sim_removed,
+							modem, NULL);
 =

 	if (ofono_sim_get_ready(modem->sim))
 		modem_sim_ready(modem);
-- =

1.6.1


--===============6286677550713578801==--

