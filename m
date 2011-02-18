Content-Type: multipart/mixed; boundary="===============5030620233664182283=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] emulator: add dialing support
Date: Fri, 18 Feb 2011 14:27:34 -0300
Message-ID: <1298050054-30702-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5030620233664182283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It handles client ATD*99# request and then initiate the PPP negotiation.
IP forward through the new ppp interface is not done yet.

Initially based on patches from Zhenhua Zhang <zhenhua.zhang@intel.com>
---
 src/emulator.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 101b33d..cb9e88f 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -29,11 +29,19 @@
 =

 #include "ofono.h"
 #include "gatserver.h"
+#include "gatppp.h"
+
+#define DUN_SERVER_ADDRESS     "192.168.1.1"
+#define DUN_PEER_ADDRESS       "192.168.1.2"
+#define DUN_DNS_SERVER_1       "10.10.10.10"
+#define DUN_DNS_SERVER_2       "10.10.10.11"
 =

 struct ofono_emulator {
 	struct ofono_atom *atom;
 	enum ofono_emulator_type type;
 	GAtServer *server;
+	GAtPPP *ppp;
+	guint source;
 };
 =

 static void emulator_debug(const char *str, void *data)
@@ -50,12 +58,122 @@ static void emulator_disconnect(gpointer user_data)
 	ofono_emulator_remove(em);
 }
 =

+static void ppp_connect(const char *iface, const char *local,
+                       const char *remote,
+                       const char *dns1, const char *dns2,
+                       gpointer user_data)
+{
+       DBG("Network Device: %s\n", iface);
+       DBG("IP Address: %s\n", local);
+       DBG("Remote IP Address: %s\n", remote);
+       DBG("Primary DNS Server: %s\n", dns1);
+       DBG("Secondary DNS Server: %s\n", dns2);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+       struct ofono_emulator *em =3D user_data;
+
+       DBG("");
+
+       g_at_ppp_unref(em->ppp);
+       em->ppp =3D NULL;
+
+       if (em->server =3D=3D NULL)
+               return;
+
+       g_at_server_resume(em->server);
+}
+
+static gboolean setup_ppp(gpointer user_data)
+{
+       struct ofono_emulator *em =3D user_data;
+       GAtIO *io;
+
+       DBG("");
+
+       em->source =3D 0;
+
+       io =3D g_at_server_get_io(em->server);
+
+       g_at_server_suspend(em->server);
+
+       em->ppp =3D g_at_ppp_server_new_from_io(io, DUN_SERVER_ADDRESS);
+       if (em->ppp =3D=3D NULL) {
+               g_at_server_resume(em->server);
+               return FALSE;
+       }
+
+       g_at_ppp_set_server_info(em->ppp, DUN_PEER_ADDRESS,
+                                       DUN_DNS_SERVER_1, DUN_DNS_SERVER_2);
+
+       g_at_ppp_set_credentials(em->ppp, "", "");
+       g_at_ppp_set_debug(em->ppp, emulator_debug, "PPP");
+
+       g_at_ppp_set_connect_function(em->ppp, ppp_connect, em);
+       g_at_ppp_set_disconnect_function(em->ppp, ppp_disconnect, em);
+
+       return FALSE;
+}
+
+static gboolean dial_call(struct ofono_emulator *em, const char *dial_str)
+{
+       char c =3D *dial_str;
+
+       DBG("dial call %s", dial_str);
+
+       if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
+               g_at_server_send_intermediate(em->server, "CONNECT");
+               em->source =3D g_idle_add(setup_ppp, em);
+       }
+
+       return TRUE;
+}
+
+static void dial_cb(GAtServer *server, GAtServerRequestType type,
+				 GAtResult *result, gpointer user_data)
+{
+       struct ofono_emulator *em =3D user_data;
+       GAtResultIter iter;
+       const char *dial_str;
+
+       DBG("");
+
+       if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
+               goto error;
+
+       g_at_result_iter_init(&iter, result);
+
+       if (!g_at_result_iter_next(&iter, ""))
+               goto error;
+
+       dial_str =3D g_at_result_iter_raw_line(&iter);
+       if (!dial_str)
+               goto error;
+
+       if (em->ppp)
+               goto error;
+
+       if (!dial_call(em, dial_str))
+               goto error;
+
+       return;
+
+error:
+       g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
+}
+
 static void emulator_unregister(struct ofono_atom *atom)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 =

 	DBG("%p", em);
 =

+	if (em->source) {
+		g_source_remove(em->source);
+		em->source =3D 0;
+	}
+
 	g_at_server_unref(em->server);
 	em->server =3D NULL;
 }
@@ -82,6 +200,9 @@ void ofono_emulator_register(struct ofono_emulator *em, =
int fd)
 						emulator_disconnect, em);
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
+
+	if (em->type =3D=3D OFONO_EMULATOR_TYPE_DUN)
+		g_at_server_register(em->server, "D", dial_cb, em, NULL);
 }
 =

 static void emulator_remove(struct ofono_atom *atom)
-- =

1.7.4


--===============5030620233664182283==--

