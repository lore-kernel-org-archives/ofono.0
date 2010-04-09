Content-Type: multipart/mixed; boundary="===============1726440305513890176=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/8] Remove post-sim atoms after SIM is extracted.
Date: Fri, 09 Apr 2010 08:49:39 +0200
Message-ID: <1270795779-7215-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1726440305513890176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 7cdd9c4..45c2bc4 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -53,6 +53,7 @@ enum ofono_property_type {
 struct ofono_modem {
 	char			*path;
 	GSList			*atoms;
+	GSList			*pre_sim_atoms;
 	struct ofono_watchlist	*atom_watches;
 	GSList         		*interface_list;
 	unsigned int		call_ids;
@@ -301,6 +302,7 @@ void __ofono_atom_free(struct ofono_atom *atom)
 	struct ofono_modem *modem =3D atom->modem;
 =

 	modem->atoms =3D g_slist_remove(modem->atoms, atom);
+	modem->pre_sim_atoms =3D g_slist_remove(modem->pre_sim_atoms, atom);
 =

 	__ofono_atom_unregister(atom);
 =

@@ -330,7 +332,35 @@ static void remove_all_atoms(struct ofono_modem *modem)
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
@@ -1122,9 +1152,19 @@ static void modem_sim_ready(void *user, enum ofono_s=
im_state new_state)
 {
 	struct ofono_modem *modem =3D user;
 =

+	if (new_state =3D=3D OFONO_SIM_STATE_NOT_PRESENT) {
+		if (modem->pre_sim_atoms)
+			remove_post_sim_atoms(modem);
+
+		return;
+	}
+
 	if (new_state !=3D OFONO_SIM_STATE_READY)
 		return;
 =

+	if (modem->pre_sim_atoms =3D=3D NULL)
+		modem->pre_sim_atoms =3D g_slist_copy(modem->atoms);
+
 	if (modem->driver->post_sim)
 		modem->driver->post_sim(modem);
 =

-- =

1.6.1


--===============1726440305513890176==--

