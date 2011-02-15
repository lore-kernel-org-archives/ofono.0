Content-Type: multipart/mixed; boundary="===============7289425467388393003=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 2/2] emulator: Add +CGMI and +CGDCONT commands
Date: Tue, 15 Feb 2011 14:19:23 +0100
Message-ID: <1297775963-3426-3-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1297775963-3426-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7289425467388393003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    7 ++++++-
 src/emulator.c     |   28 ++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 2334e02..94053f1 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -27,8 +27,13 @@ extern "C" {
 #endif
 =

 #include <ofono/types.h>
+#include <gatserver.h>
 =

-struct ofono_emulator;
+struct ofono_emulator {
+	struct ofono_atom *atom;
+	GAtServer *server;
+	struct ofono_atom *gprs_atom;
+};
 =

 enum ofono_emulator_type {
 	OFONO_EMULATOR_TYPE_DUN,
diff --git a/src/emulator.c b/src/emulator.c
index c49283d..0ed2ae5 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -28,10 +28,23 @@
 #include "ofono.h"
 #include "gatserver.h"
 =

-struct ofono_emulator {
-	struct ofono_atom *atom;
-	GAtServer *server;
-};
+static void cgmi_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
+{
+	struct ofono_emulator *em =3D user;
+	GAtServer *server =3D em->server;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		g_at_server_send_info(server, "oFono", TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+	};
+}
 =

 static void emulator_debug(const char *str, void *data)
 {
@@ -76,6 +89,12 @@ void ofono_emulator_register(struct ofono_emulator *em, =
int fd)
 	g_at_server_set_disconnect_function(em->server,
 						emulator_disconnect, em);
 =

+	/* Register local callbacks */
+	g_at_server_register(em->server, "+CGMI", cgmi_cb, em, NULL);
+
+	/* Register external (atoms) callbacks */
+	ofono_gprs_add_emulator_handler(em);
+
 	__ofono_atom_register(em->atom, emulator_unregister);
 }
 =

@@ -102,6 +121,7 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 =

 	em->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_EMULATOR_DUN,
 						emulator_remove, em);
+	em->gprs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
 =

 	return em;
 }
-- =

1.7.1


--===============7289425467388393003==--

