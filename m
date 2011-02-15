Content-Type: multipart/mixed; boundary="===============8510064455692659596=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 3/3] emulator: add +CIND support
Date: Tue, 15 Feb 2011 16:06:33 +0100
Message-ID: <1297782393-9898-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1297782393-9898-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8510064455692659596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

currently, only network registration is supported (service, roaming)
---
 src/emulator.c |  118 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 232b314..96c55d4 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -23,15 +23,21 @@
 #include <config.h>
 #endif
 =

+#include <stdio.h>
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
+	int netreg_status;
 };
 =

 static void emulator_debug(const char *str, void *data)
@@ -39,6 +45,98 @@ static void emulator_debug(const char *str, void *data)
 	ofono_info("%s: %s\n", (char *)data, str);
 }
 =

+static void cind_update(struct ofono_emulator *em, gboolean final)
+{
+	int status;
+	int roam;
+	char buf[30];
+
+	switch (em->netreg_status) {
+	case NETWORK_REGISTRATION_STATUS_REGISTERED:
+		status =3D 1;
+		roam =3D 0;
+		break;
+	case NETWORK_REGISTRATION_STATUS_ROAMING:
+		status =3D 1;
+		roam =3D 1;
+		break;
+	default:
+		status =3D 0;
+		roam =3D 0;
+		break;
+	}
+
+	call =3D 0;
+	callsetup =3D 0;
+	callheld =3D 0;
+	signal =3D (em->netreg_signal + 20) / 21;
+	battchg =3D 0;
+
+	sprintf(buf, "+CIND: %d,0,0,0,0,%d,0", status, roam);
+	g_at_server_send_info(em->server, buf, final);
+}
+
+static void netreg_status_changed(int status, int lac, int ci, int tech,
+					const char *mcc, const char *mnc,
+					void *data)
+{
+	struct ofono_emulator *em =3D data;
+
+	DBG("%d", status);
+
+	if (em->netreg_status =3D=3D status)
+		return;
+
+	em->netreg_status =3D status;
+
+	cind_update(em, TRUE);
+}
+
+static void netreg_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_emulator *em =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		em->status_watch =3D 0;
+		em->netreg_status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+		return;
+	}
+
+	em->netreg =3D __ofono_atom_get_data(atom);
+	em->netreg_status =3D ofono_netreg_get_status(em->netreg);
+	em->status_watch =3D __ofono_netreg_add_status_watch(em->netreg,
+					netreg_status_changed, em, NULL);
+
+	cind_update(em, TRUE);
+}
+
+static void at_cind_cb(GAtServerRequestType type, GAtResult *result,
+			gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		cind_update(em, FALSE);
+		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		g_at_server_send_info(em->server, "+CIND: (\"service\",(0,1))"
+				",(\"call\",(0,1)),(\"callsetup\",(0-3))"
+				",(\"callheld\",(0-2)),(\"signal\",(0-5))"
+				",(\"roam\",(0,1)),(\"battchg\",(0-5))", FALSE);
+		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void emulator_disconnect(gpointer user_data)
 {
 	struct ofono_emulator *em =3D user_data;
@@ -61,6 +159,8 @@ static void emulator_unregister(struct ofono_atom *atom)
 void ofono_emulator_register(struct ofono_emulator *em, int fd)
 {
 	GIOChannel *io;
+	struct ofono_modem *modem;
+	struct ofono_atom *netreg_atom;
 =

 	DBG("%p, %d", em, fd);
 =

@@ -77,6 +177,24 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 	g_at_server_set_disconnect_function(em->server,
 						emulator_disconnect, em);
 =

+	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP) {
+		g_at_server_register(em->server, "+CIND", at_cind_cb, em, NULL);
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


--===============8510064455692659596==--

