Content-Type: multipart/mixed; boundary="===============1140709840702470341=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/3] emulator: add support of indicators
Date: Tue, 22 Feb 2011 16:40:35 +0100
Message-ID: <1298389236-14953-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298389236-14953-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1140709840702470341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/network.c  |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 141 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index b4a4c57..7a46d2a 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -24,6 +24,7 @@
 #endif
 =

 #include <stdio.h>
+#include <string.h>
 =

 #include <glib.h>
 =

@@ -42,8 +43,17 @@ struct ofono_emulator {
 	GAtServer *server;
 	GAtPPP *ppp;
 	guint source;
+	GSList *indicators;
 };
 =

+struct indicator {
+	const char *name;
+	int value;
+	int min;
+	int max;
+};
+
+
 static void emulator_debug(const char *str, void *data)
 {
 	ofono_info("%s: %s\n", (char *)data, str);
@@ -163,6 +173,25 @@ error:
        g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 }
 =

+static void emulator_add_indicator(struct ofono_emulator *em, const char* =
name,
+					int min, int max, int dflt)
+{
+	struct indicator *ind;
+
+	ind =3D g_try_new0(struct indicator, 1);
+	if (ind =3D=3D NULL) {
+		ofono_error("Unable to allocate indicator structure");
+		return;
+	}
+
+	ind->name =3D name;
+	ind->min =3D min;
+	ind->max =3D max;
+	ind->value =3D dflt;
+
+	em->indicators =3D g_slist_append(em->indicators, ind);
+}
+
 static void emulator_unregister(struct ofono_atom *atom)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
@@ -174,6 +203,10 @@ static void emulator_unregister(struct ofono_atom *ato=
m)
 		em->source =3D 0;
 	}
 =

+	g_slist_foreach(em->indicators, (GFunc) g_free, NULL);
+	g_slist_free(em->indicators);
+	em->indicators =3D NULL;
+
 	g_at_server_unref(em->server);
 	em->server =3D NULL;
 }
@@ -199,6 +232,13 @@ void ofono_emulator_register(struct ofono_emulator *em=
, int fd)
 	g_at_server_set_disconnect_function(em->server,
 						emulator_disconnect, em);
 =

+	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP) {
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_SERVICE, 0, 1, 0);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_SIGNAL, 0, 5, 0);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0, 1, 0);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_BATTERY, 0, 5, 5);
+	}
+
 	__ofono_atom_register(em->atom, emulator_unregister);
 =

 	if (em->type =3D=3D OFONO_EMULATOR_TYPE_DUN)
@@ -397,3 +437,31 @@ enum ofono_emulator_request_type ofono_emulator_reques=
t_get_type(
 {
 	return req->type;
 }
+
+void ofono_emulator_set_indicator(struct ofono_emulator *em,
+					const char *name, int value)
+{
+	GSList *l;
+	int i;
+	char buf[20];
+
+	i =3D 1;
+	for (l =3D em->indicators; l; l =3D l->next) {
+		struct indicator *ind =3D l->data;
+
+		if (!strcmp(ind->name, name)) {
+			if ((ind->value =3D=3D value) || (value < ind->min)
+					|| (value > ind->max))
+				return;
+
+			ind->value =3D value;
+
+			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
+			g_at_server_send_info(em->server, buf, TRUE);
+
+			break;
+		}
+
+		i++;
+	}
+}
diff --git a/src/network.c b/src/network.c
index c059906..8124319 100644
--- a/src/network.c
+++ b/src/network.c
@@ -36,6 +36,7 @@
 #include "simutil.h"
 #include "util.h"
 #include "storage.h"
+#include "emulator.h"
 =

 #define NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN 0x1
 #define NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN 0x2
@@ -82,6 +83,7 @@ struct ofono_netreg {
 	const struct ofono_netreg_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	unsigned int hfp_watch;
 };
 =

 struct network_operator_data {
@@ -1287,15 +1289,42 @@ static void signal_strength_callback(const struct o=
fono_error *error,
 	ofono_netreg_strength_notify(netreg, strength);
 }
 =

+static void notify_emulator_status(struct ofono_atom *atom, void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	switch (GPOINTER_TO_INT(data)) {
+	case NETWORK_REGISTRATION_STATUS_REGISTERED:
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_SERVICE, 1);
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0);
+		break;
+	case NETWORK_REGISTRATION_STATUS_ROAMING:
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_SERVICE, 1);
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_ROAMING, 1);
+		break;
+	default:
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_SERVICE, 0);
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0);
+	}
+}
+
 void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
 			int lac, int ci, int tech)
 {
 	if (netreg =3D=3D NULL)
 		return;
 =

-	if (netreg->status !=3D status)
+	if (netreg->status !=3D status) {
+		struct ofono_modem *modem;
+
 		set_registration_status(netreg, status);
 =

+		modem =3D __ofono_atom_get_modem(netreg->atom);
+		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					notify_emulator_status,
+					GINT_TO_POINTER(netreg->status));
+	}
+
 	if (netreg->location !=3D lac)
 		set_registration_location(netreg, lac);
 =

@@ -1375,9 +1404,18 @@ static void init_registration_status(const struct of=
ono_error *error,
 	}
 }
 =

+static void notify_emulator_strength(struct ofono_atom *atom, void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_SIGNAL,
+					(GPOINTER_TO_INT(data) + 20) / 21);
+}
+
 void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int strengt=
h)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem;
 =

 	if (netreg->signal_strength =3D=3D strength)
 		return;
@@ -1401,6 +1439,11 @@ void ofono_netreg_strength_notify(struct ofono_netre=
g *netreg, int strength)
 					"Strength", DBUS_TYPE_BYTE,
 					&strength);
 	}
+
+	modem =3D __ofono_atom_get_modem(netreg->atom);
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+				notify_emulator_strength,
+				GINT_TO_POINTER(netreg->signal_strength));
 }
 =

 static void sim_opl_read_cb(int ok, int length, int record,
@@ -1656,6 +1699,14 @@ static void netreg_unregister(struct ofono_atom *ato=
m)
 	const char *path =3D __ofono_atom_get_path(atom);
 	GSList *l;
 =

+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+				notify_emulator_status,
+				GINT_TO_POINTER(0));
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+				notify_emulator_strength, GINT_TO_POINTER(0));
+
+	__ofono_modem_remove_atom_watch(modem, netreg->hfp_watch);
+
 	__ofono_watchlist_free(netreg->status_watches);
 	netreg->status_watches =3D NULL;
 =

@@ -1837,6 +1888,23 @@ static void sim_spn_spdi_changed(int id, void *userd=
ata)
 			sim_spn_read_cb, netreg);
 }
 =

+static void emulator_hfp_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_netreg *netreg =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(netreg->atom);
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+				notify_emulator_status,
+				GINT_TO_POINTER(netreg->status));
+		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+				notify_emulator_strength,
+				GINT_TO_POINTER(netreg->signal_strength));
+	}
+}
+
 void ofono_netreg_register(struct ofono_netreg *netreg)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -1894,6 +1962,10 @@ void ofono_netreg_register(struct ofono_netreg *netr=
eg)
 	}
 =

 	__ofono_atom_register(netreg->atom, netreg_unregister);
+
+	netreg->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_hfp_watch, netreg, NULL);
 }
 =

 void ofono_netreg_remove(struct ofono_netreg *netreg)
-- =

1.7.1


--===============1140709840702470341==--

