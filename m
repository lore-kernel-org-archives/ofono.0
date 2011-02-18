Content-Type: multipart/mixed; boundary="===============1008557681231043220=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 4/4] emulator: add network signal support for HFP
Date: Fri, 18 Feb 2011 17:34:08 +0100
Message-ID: <1298046848-24622-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298046848-24622-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1008557681231043220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index d8cd32f..6835f96 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -38,8 +38,10 @@ struct ofono_emulator {
 	struct ofono_netreg *netreg;
 	unsigned int netreg_watch;
 	unsigned int status_watch;
+	unsigned int strength_watch;
 	gboolean net_registered;
 	gboolean roaming;
+	int strength;
 };
 =

 static void emulator_debug(const char *str, void *data)
@@ -84,12 +86,29 @@ static void net_status_changed(int status, int lac, int=
 ci, int tech,
 	}
 }
 =

+static void net_strength_changed(int signal_strength, void *data)
+{
+	struct ofono_emulator *em =3D data;
+	int old_strength =3D em->strength;
+	char buf[20];
+
+	DBG("%d", signal_strength);
+
+	em->strength =3D (signal_strength + 20) / 21;
+
+	if (em->strength !=3D old_strength) {
+		sprintf(buf, "+CIEV: 5,%d", em->strength);
+		g_at_server_send_info(em->server, buf, TRUE);
+	}
+}
+
 static void netreg_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
 {
 	struct ofono_emulator *em =3D data;
 	int status;
+	int strength;
 =

 	DBG("%p %sregistered", atom, cond ? "un" : "");
 =

@@ -98,6 +117,9 @@ static void netreg_watch(struct ofono_atom *atom,
 		net_status_changed(NETWORK_REGISTRATION_STATUS_NOT_REGISTERED,
 					0, 0, 0, NULL, NULL, em);
 =

+		em->strength_watch =3D 0;
+		net_strength_changed(0, em);
+
 		em->netreg =3D NULL;
 =

 		return;
@@ -110,6 +132,13 @@ static void netreg_watch(struct ofono_atom *atom,
 =

 	em->status_watch =3D __ofono_netreg_add_status_watch(em->netreg,
 					net_status_changed, em, NULL);
+
+	strength =3D ofono_netreg_get_strength(em->netreg);
+	net_strength_changed(strength, em);
+
+	em->strength_watch =3D __ofono_netreg_add_strength_watch(em->netreg,
+					net_strength_changed, em, NULL);
+
 }
 =

 static void cind_cb(GAtServer *server, GAtServerRequestType type,
@@ -120,8 +149,8 @@ static void cind_cb(GAtServer *server, GAtServerRequest=
Type type,
 =

 	switch (type) {
 	case G_AT_SERVER_REQUEST_TYPE_QUERY:
-		sprintf(buf, "+CIND: %d,0,0,0,0,%d,0", em->net_registered,
-					em->roaming);
+		sprintf(buf, "+CIND: %d,0,0,0,%d,%d,0", em->net_registered,
+					em->strength, em->roaming);
 		g_at_server_send_info(em->server, buf, FALSE);
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
 		break;
@@ -161,6 +190,10 @@ static void emulator_unregister(struct ofono_atom *ato=
m)
 			__ofono_netreg_remove_status_watch(em->netreg,
 							em->status_watch);
 =

+		if (em->strength_watch)
+			__ofono_netreg_remove_strength_watch(em->netreg,
+							em->strength_watch);
+
 		modem =3D __ofono_atom_get_modem(em->atom);
 		__ofono_modem_remove_atom_watch(modem, em->netreg_watch);
 	}
-- =

1.7.1


--===============1008557681231043220==--

