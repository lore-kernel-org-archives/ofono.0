Content-Type: multipart/mixed; boundary="===============0721768736142636350=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 4/5] emulator: add request/release private network calls
Date: Thu, 19 May 2011 11:58:31 +0200
Message-ID: <1305799112-14289-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305799112-14289-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0721768736142636350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   75 ++++++++++++++++++++++++++++++++++++++++++++++++----=
---
 1 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c17b901..0a83403 100644
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

@@ -56,6 +53,8 @@ struct ofono_emulator {
 	guint callsetup_source;
 	gboolean clip;
 	gboolean ccwa;
+	int pns_id;
+	struct ofono_private_network_settings *local_pns;
 };
 =

 struct indicator {
@@ -91,6 +90,18 @@ static void ppp_connect(const char *iface, const char *l=
ocal,
 	DBG("Secondary DNS Server: %s\n", dns2);
 }
 =

+static void release_pns(struct ofono_emulator *em)
+{
+	g_free(em->local_pns->server_ip);
+	g_free(em->local_pns->peer_ip);
+	g_free(em->local_pns->primary_dns);
+	g_free(em->local_pns->secondary_dns);
+	g_free(em->local_pns);
+
+	__ofono_private_network_release(em->pns_id);
+	em->pns_id =3D 0;
+}
+
 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
 {
 	struct ofono_emulator *em =3D user_data;
@@ -100,6 +111,9 @@ static void ppp_disconnect(GAtPPPDisconnectReason reaso=
n, gpointer user_data)
 	g_at_ppp_unref(em->ppp);
 	em->ppp =3D NULL;
 =

+	if (em->pns_id > 0)
+		release_pns(em);
+
 	if (em->server =3D=3D NULL)
 		return;
 =

@@ -128,14 +142,21 @@ static gboolean setup_ppp(gpointer user_data)
 =

 	g_at_server_suspend(em->server);
 =

-	em->ppp =3D g_at_ppp_server_new_from_io(io, DUN_SERVER_ADDRESS);
+	em->ppp =3D g_at_ppp_server_new_full(io, em->local_pns->server_ip,
+						em->local_pns->fd);
 	if (em->ppp =3D=3D NULL) {
+		/* PPP stack hasn't closed fd */
+		close(em->local_pns->fd);
+		if (em->pns_id > 0)
+			release_pns(em);
+
 		g_at_server_resume(em->server);
 		return FALSE;
 	}
 =

-	g_at_ppp_set_server_info(em->ppp, DUN_PEER_ADDRESS,
-					DUN_DNS_SERVER_1, DUN_DNS_SERVER_2);
+	g_at_ppp_set_server_info(em->ppp, em->local_pns->peer_ip,
+					em->local_pns->primary_dns,
+					em->local_pns->secondary_dns);
 =

 	g_at_ppp_set_credentials(em->ppp, "", "");
 	g_at_ppp_set_debug(em->ppp, emulator_debug, "PPP");
@@ -147,6 +168,39 @@ static gboolean setup_ppp(gpointer user_data)
 	return FALSE;
 }
 =

+static void request_private_network_cb(void *data,
+			const struct ofono_private_network_settings *pns)
+{
+	struct ofono_emulator *em =3D data;
+
+	if (pns =3D=3D NULL) {
+		__ofono_private_network_release(em->pns_id);
+		em->pns_id =3D 0;
+		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
+		return;
+	}
+
+	em->local_pns =3D g_try_new0(struct ofono_private_network_settings, 1);
+	if (em->local_pns =3D=3D NULL) {
+		close(pns->fd);
+		__ofono_private_network_release(em->pns_id);
+		em->pns_id =3D 0;
+		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
+		return;
+	}
+
+	em->local_pns->fd =3D pns->fd;
+	em->local_pns->server_ip =3D g_strdup(pns->server_ip);
+	em->local_pns->peer_ip =3D g_strdup(pns->peer_ip);
+	em->local_pns->primary_dns =3D g_strdup(pns->primary_dns);
+	em->local_pns->secondary_dns =3D g_strdup(pns->secondary_dns);
+
+	g_at_server_send_intermediate(em->server, "CONNECT");
+	em->source =3D g_idle_add(setup_ppp, em);
+
+	return;
+}
+
 static gboolean dial_call(struct ofono_emulator *em, const char *dial_str)
 {
 	char c =3D *dial_str;
@@ -154,8 +208,9 @@ static gboolean dial_call(struct ofono_emulator *em, co=
nst char *dial_str)
 	DBG("dial call %s", dial_str);
 =

 	if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
-		g_at_server_send_intermediate(em->server, "CONNECT");
-		em->source =3D g_idle_add(setup_ppp, em);
+		if (__ofono_private_network_request(request_private_network_cb,
+						em, &em->pns_id) =3D=3D FALSE)
+			return FALSE;
 	}
 =

 	return TRUE;
-- =

1.7.1


--===============0721768736142636350==--

