Content-Type: multipart/mixed; boundary="===============7135473508223908533=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/4] emulator: add network info support for HFP
Date: Fri, 18 Feb 2011 17:34:05 +0100
Message-ID: <1298046848-24622-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298046848-24622-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7135473508223908533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add CIND and CIEV support related to network info
---
 src/emulator.c |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 129 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 101b33d..d8cd32f 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -28,12 +28,18 @@
 #include <glib.h>
 =

 #include "ofono.h"
+#include "common.h"
 #include "gatserver.h"
 =

 struct ofono_emulator {
 	struct ofono_atom *atom;
 	enum ofono_emulator_type type;
 	GAtServer *server;
+	struct ofono_netreg *netreg;
+	unsigned int netreg_watch;
+	unsigned int status_watch;
+	gboolean net_registered;
+	gboolean roaming;
 };
 =

 static void emulator_debug(const char *str, void *data)
@@ -41,6 +47,99 @@ static void emulator_debug(const char *str, void *data)
 	ofono_info("%s: %s\n", (char *)data, str);
 }
 =

+static void net_status_changed(int status, int lac, int ci, int tech,
+					const char *mcc, const char *mnc,
+					void *data)
+{
+	struct ofono_emulator *em =3D data;
+	gboolean old_registered =3D em->net_registered;
+	gboolean old_roaming =3D em->roaming;
+	char buf[20];
+
+	DBG("%d", status);
+
+	switch (status) {
+	case NETWORK_REGISTRATION_STATUS_REGISTERED:
+		em->net_registered =3D 1;
+		em->roaming =3D 0;
+		break;
+	case NETWORK_REGISTRATION_STATUS_ROAMING:
+		em->net_registered =3D 1;
+		em->roaming =3D 1;
+		break;
+	default:
+		em->net_registered =3D 0;
+		em->roaming =3D 0;
+		break;
+	}
+
+	if (em->net_registered !=3D old_registered) {
+		sprintf(buf, "+CIEV: 1,%d", em->net_registered);
+		g_at_server_send_info(em->server, buf, TRUE);
+	}
+
+	if (em->roaming !=3D old_roaming) {
+		sprintf(buf, "+CIEV: 6,%d", em->roaming);
+		g_at_server_send_info(em->server, buf, TRUE);
+	}
+}
+
+static void netreg_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_emulator *em =3D data;
+	int status;
+
+	DBG("%p %sregistered", atom, cond ? "un" : "");
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		em->status_watch =3D 0;
+		net_status_changed(NETWORK_REGISTRATION_STATUS_NOT_REGISTERED,
+					0, 0, 0, NULL, NULL, em);
+
+		em->netreg =3D NULL;
+
+		return;
+	}
+
+	em->netreg =3D __ofono_atom_get_data(atom);
+
+	status =3D ofono_netreg_get_status(em->netreg);
+	net_status_changed(status, 0, 0, 0, NULL, NULL, em);
+
+	em->status_watch =3D __ofono_netreg_add_status_watch(em->netreg,
+					net_status_changed, em, NULL);
+}
+
+static void cind_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	char buf[30];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		sprintf(buf, "+CIND: %d,0,0,0,0,%d,0", em->net_registered,
+					em->roaming);
+		g_at_server_send_info(em->server, buf, FALSE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		g_at_server_send_info(server, "+CIND: (\"service\",(0,1)),"
+				"(\"call\",(0,1)),(\"callsetup\",(0-3)),"
+				"(\"callheld\",(0-2)),(\"signal\",(0-5)),"
+				"(\"roam\",(0,1)),(\"battchg\",(0-5))", FALSE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void emulator_disconnect(gpointer user_data)
 {
 	struct ofono_emulator *em =3D user_data;
@@ -53,9 +152,19 @@ static void emulator_disconnect(gpointer user_data)
 static void emulator_unregister(struct ofono_atom *atom)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem;
 =

 	DBG("%p", em);
 =

+	if (em->netreg) {
+		if (em->status_watch)
+			__ofono_netreg_remove_status_watch(em->netreg,
+							em->status_watch);
+
+		modem =3D __ofono_atom_get_modem(em->atom);
+		__ofono_modem_remove_atom_watch(modem, em->netreg_watch);
+	}
+
 	g_at_server_unref(em->server);
 	em->server =3D NULL;
 }
@@ -63,6 +172,8 @@ static void emulator_unregister(struct ofono_atom *atom)
 void ofono_emulator_register(struct ofono_emulator *em, int fd)
 {
 	GIOChannel *io;
+	struct ofono_modem *modem;
+	struct ofono_atom *netreg_atom;
 =

 	DBG("%p, %d", em, fd);
 =

@@ -81,6 +192,24 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 	g_at_server_set_disconnect_function(em->server,
 						emulator_disconnect, em);
 =

+	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP) {
+		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
+
+		modem =3D __ofono_atom_get_modem(em->atom);
+
+		em->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
+						OFONO_ATOM_TYPE_NETREG,
+						netreg_watch, em, NULL);
+
+		netreg_atom =3D __ofono_modem_find_atom(modem,
+							OFONO_ATOM_TYPE_NETREG);
+
+		if (netreg_atom && __ofono_atom_get_registered(netreg_atom))
+			netreg_watch(netreg_atom,
+					OFONO_ATOM_WATCH_CONDITION_REGISTERED,
+					em);
+	}
+
 	__ofono_atom_register(em->atom, emulator_unregister);
 }
 =

-- =

1.7.1


--===============7135473508223908533==--

