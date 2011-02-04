Content-Type: multipart/mixed; boundary="===============1385108021120107548=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 6/7] emulator: Implement dialing up for DUN
Date: Fri, 04 Feb 2011 18:11:47 -0200
Message-ID: <1296850308-22194-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296850308-22194-5-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1385108021120107548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It handles client ATD*99# request and then initiate the PPP negotiation.
IP forward through the new ppp interface is not done yet.

Initially based on patches from Zhenhua Zhang <zhenhua.zhang@intel.com>
---
 src/emulator.c |  123 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 123 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 49b129b..f1a079d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -32,11 +32,18 @@
 #include "ofono.h"
 #include "common.h"
 #include "gatserver.h"
+#include "gatppp.h"
+
+#define DUN_SERVER_ADDRESS	"192.168.1.1"
+#define DUN_PEER_ADDRESS	"192.168.1.2"
+#define DUN_DNS_SERVER_1	"10.10.10.10"
+#define DUN_DNS_SERVER_2	"10.10.10.11"
 =

 struct ofono_emulator {
 	struct ofono_modem *modem;
 	struct ofono_atom *atom;
 	GAtServer *server;
+	GAtPPP *ppp;
 	struct ofono_emulator_driver *driver;
 };
 =

@@ -55,10 +62,124 @@ void ofono_emulator_remove(struct ofono_emulator *emul=
ator)
 	__ofono_atom_free(emulator->atom);
 }
 =

+static void ppp_connect(const char *iface, const char *local,
+			const char *remote,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	DBG("Network Device: %s\n", iface);
+	DBG("IP Address: %s\n", local);
+	DBG("Remote IP Address: %s\n", remote);
+	DBG("Primary DNS Server: %s\n", dns1);
+	DBG("Secondary DNS Server: %s\n", dns2);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct ofono_emulator *e =3D user_data;
+
+	DBG("");
+
+	g_at_ppp_unref(e->ppp);
+	e->ppp =3D NULL;
+
+	if (e->server =3D=3D NULL)
+		return;
+
+	g_at_server_resume(e->server);
+
+	g_at_server_send_final(e->server, G_AT_SERVER_RESULT_NO_CARRIER);
+}
+
+static gboolean setup_ppp(gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	GAtServer *server =3D e->server;
+	GAtIO *io;
+
+	DBG("");
+
+	io =3D g_at_server_get_io(server);
+
+	g_at_server_suspend(server);
+
+	e->ppp =3D g_at_ppp_server_new_from_io(io, DUN_SERVER_ADDRESS);
+	if (e->ppp =3D=3D NULL) {
+		g_at_server_resume(server);
+		return FALSE;
+	}
+
+	g_at_ppp_set_server_info(e->ppp, DUN_PEER_ADDRESS,
+					DUN_DNS_SERVER_1, DUN_DNS_SERVER_2);
+
+	g_at_ppp_set_credentials(e->ppp, "", "");
+	g_at_ppp_set_debug(e->ppp, ofono_emulator_debug, "PPP");
+
+	g_at_ppp_set_connect_function(e->ppp, ppp_connect, e);
+	g_at_ppp_set_disconnect_function(e->ppp, ppp_disconnect, e);
+
+	return FALSE;
+}
+
+static gboolean dial_call(struct ofono_emulator *e, const char *dial_str)
+{
+	char c =3D *dial_str;
+
+	DBG("dial call %s", dial_str);
+
+	if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
+
+		g_at_server_send_intermediate(e->server, "CONNECT");
+		g_idle_add(setup_ppp, e);
+	}
+
+	return TRUE;
+}
+
+static void dial_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	GAtServer *server =3D e->server;
+	GAtResultIter iter;
+	const char *dial_str;
+
+	DBG("");
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "D"))
+		goto error;
+
+	dial_str =3D g_at_result_iter_raw_line(&iter);
+	if (!dial_str)
+		goto error;
+
+	if (e->ppp)
+		goto error;
+
+	if (!dial_call(e, dial_str))
+		goto error;
+
+	return;
+
+error:
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+}
+
 static void emulator_disable(struct ofono_emulator *e)
 {
 	DBG("");
 =

+	if (e->ppp) {
+		g_at_ppp_shutdown(e->ppp);
+		g_at_ppp_unref(e->ppp);
+		e->ppp =3D NULL;
+	}
+
 	g_at_server_shutdown(e->server);
 	g_at_server_unref(e->server);
 	e->server =3D NULL;
@@ -93,6 +214,8 @@ int ofono_emulator_enable(struct ofono_emulator *e, int =
fd)
 	g_at_server_set_disconnect_function(e->server,
 						emulator_disconnect_cb, e);
 =

+	g_at_server_register(e->server, "D", dial_cb, e, NULL);
+
 	return 0;
 }
 =

-- =

1.7.4.rc3


--===============1385108021120107548==--

