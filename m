Content-Type: multipart/mixed; boundary="===============9216945683842925429=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 4/5] emulator: add request/release private network calls
Date: Fri, 06 May 2011 16:01:52 +0200
Message-ID: <1304690513-3137-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1304690513-3137-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9216945683842925429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   49 +++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 9055909..d6b2b1b 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -25,6 +25,7 @@
 =

 #include <stdio.h>
 #include <string.h>
+#include <unistd.h>
 =

 #include <glib.h>
 =

@@ -32,11 +33,7 @@
 #include "common.h"
 #include "gatserver.h"
 #include "gatppp.h"
-
-#define DUN_SERVER_ADDRESS     "192.168.1.1"
-#define DUN_PEER_ADDRESS       "192.168.1.2"
-#define DUN_DNS_SERVER_1       "10.10.10.10"
-#define DUN_DNS_SERVER_2       "10.10.10.11"
+#include "private-network.h"
 =

 #define RING_TIMEOUT 3
 =

@@ -55,6 +52,8 @@ struct ofono_emulator {
 	guint callsetup_source;
 	gboolean clip;
 	gboolean ccwa;
+	int pns_id;
+	struct ofono_private_network_settings *pns;
 };
 =

 struct indicator {
@@ -99,6 +98,11 @@ static void ppp_disconnect(GAtPPPDisconnectReason reason=
, gpointer user_data)
 	g_at_ppp_unref(em->ppp);
 	em->ppp =3D NULL;
 =

+	if (em->pns_id > 0)
+		__ofono_private_network_release(em->pns_id);
+
+	em->pns_id =3D -1;
+
 	if (em->server =3D=3D NULL)
 		return;
 =

@@ -118,14 +122,19 @@ static gboolean setup_ppp(gpointer user_data)
 =

 	g_at_server_suspend(em->server);
 =

-	em->ppp =3D g_at_ppp_server_new_from_io(io, DUN_SERVER_ADDRESS);
+	em->ppp =3D g_at_ppp_server_new_full(io, em->pns->server_ip, em->pns->fd);
 	if (em->ppp =3D=3D NULL) {
+		close(em->pns->fd);
+		if (em->pns_id > 0)
+			__ofono_private_network_release(em->pns_id);
+		em->pns_id =3D -1;
 		g_at_server_resume(em->server);
 		return FALSE;
 	}
 =

-	g_at_ppp_set_server_info(em->ppp, DUN_PEER_ADDRESS,
-					DUN_DNS_SERVER_1, DUN_DNS_SERVER_2);
+	g_at_ppp_set_server_info(em->ppp, em->pns->peer_ip,
+					em->pns->primary_dns,
+					em->pns->secondary_dns);
 =

 	g_at_ppp_set_credentials(em->ppp, "", "");
 	g_at_ppp_set_debug(em->ppp, emulator_debug, "PPP");
@@ -136,6 +145,24 @@ static gboolean setup_ppp(gpointer user_data)
 	return FALSE;
 }
 =

+static gboolean setup_ppp_cb(void *data,
+				struct ofono_private_network_settings *pns)
+{
+	struct ofono_emulator *em =3D data;
+
+	if (pns =3D=3D NULL) {
+		__ofono_private_network_release(em->pns_id);
+		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
+		return FALSE;
+	}
+
+	em->pns =3D pns;
+	g_at_server_send_intermediate(em->server, "CONNECT");
+	em->source =3D g_idle_add(setup_ppp, em);
+
+	return TRUE;
+}
+
 static gboolean dial_call(struct ofono_emulator *em, const char *dial_str)
 {
 	char c =3D *dial_str;
@@ -143,8 +170,9 @@ static gboolean dial_call(struct ofono_emulator *em, co=
nst char *dial_str)
 	DBG("dial call %s", dial_str);
 =

 	if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
-		g_at_server_send_intermediate(em->server, "CONNECT");
-		em->source =3D g_idle_add(setup_ppp, em);
+		if (__ofono_private_network_request(setup_ppp_cb, em,
+							&em->pns_id) =3D=3D FALSE)
+			return FALSE;
 	}
 =

 	return TRUE;
@@ -707,6 +735,7 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 	/* TODO: Check real local features */
 	em->l_features =3D 32;
 	em->events_mode =3D 3;	/* default mode is forwarding events */
+	em->pns_id =3D -1;
 =

 	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
 							emulator_remove, em);
-- =

1.7.1


--===============9216945683842925429==--

