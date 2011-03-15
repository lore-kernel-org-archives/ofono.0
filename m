Content-Type: multipart/mixed; boundary="===============2964312254046011796=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] emulator: fix some indentation issues
Date: Tue, 15 Mar 2011 14:10:46 +0100
Message-ID: <1300194646-30265-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2964312254046011796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |  116 ++++++++++++++++++++++++++++------------------------=
----
 1 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 20a575f..c84f0a9 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -73,108 +73,108 @@ static void emulator_disconnect(gpointer user_data)
 }
 =

 static void ppp_connect(const char *iface, const char *local,
-                       const char *remote,
-                       const char *dns1, const char *dns2,
-                       gpointer user_data)
+			const char *remote,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
 {
-       DBG("Network Device: %s\n", iface);
-       DBG("IP Address: %s\n", local);
-       DBG("Remote IP Address: %s\n", remote);
-       DBG("Primary DNS Server: %s\n", dns1);
-       DBG("Secondary DNS Server: %s\n", dns2);
+	DBG("Network Device: %s\n", iface);
+	DBG("IP Address: %s\n", local);
+	DBG("Remote IP Address: %s\n", remote);
+	DBG("Primary DNS Server: %s\n", dns1);
+	DBG("Secondary DNS Server: %s\n", dns2);
 }
 =

 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
 {
-       struct ofono_emulator *em =3D user_data;
+	struct ofono_emulator *em =3D user_data;
 =

-       DBG("");
+	DBG("");
 =

-       g_at_ppp_unref(em->ppp);
-       em->ppp =3D NULL;
+	g_at_ppp_unref(em->ppp);
+	em->ppp =3D NULL;
 =

-       if (em->server =3D=3D NULL)
-               return;
+	if (em->server =3D=3D NULL)
+		return;
 =

-       g_at_server_resume(em->server);
+	g_at_server_resume(em->server);
 }
 =

 static gboolean setup_ppp(gpointer user_data)
 {
-       struct ofono_emulator *em =3D user_data;
-       GAtIO *io;
+	struct ofono_emulator *em =3D user_data;
+	GAtIO *io;
 =

-       DBG("");
+	DBG("");
 =

-       em->source =3D 0;
+	em->source =3D 0;
 =

-       io =3D g_at_server_get_io(em->server);
+	io =3D g_at_server_get_io(em->server);
 =

-       g_at_server_suspend(em->server);
+	g_at_server_suspend(em->server);
 =

-       em->ppp =3D g_at_ppp_server_new_from_io(io, DUN_SERVER_ADDRESS);
-       if (em->ppp =3D=3D NULL) {
-               g_at_server_resume(em->server);
-               return FALSE;
-       }
+	em->ppp =3D g_at_ppp_server_new_from_io(io, DUN_SERVER_ADDRESS);
+	if (em->ppp =3D=3D NULL) {
+		g_at_server_resume(em->server);
+		return FALSE;
+	}
 =

-       g_at_ppp_set_server_info(em->ppp, DUN_PEER_ADDRESS,
-                                       DUN_DNS_SERVER_1, DUN_DNS_SERVER_2);
+	g_at_ppp_set_server_info(em->ppp, DUN_PEER_ADDRESS,
+					DUN_DNS_SERVER_1, DUN_DNS_SERVER_2);
 =

-       g_at_ppp_set_credentials(em->ppp, "", "");
-       g_at_ppp_set_debug(em->ppp, emulator_debug, "PPP");
+	g_at_ppp_set_credentials(em->ppp, "", "");
+	g_at_ppp_set_debug(em->ppp, emulator_debug, "PPP");
 =

-       g_at_ppp_set_connect_function(em->ppp, ppp_connect, em);
-       g_at_ppp_set_disconnect_function(em->ppp, ppp_disconnect, em);
+	g_at_ppp_set_connect_function(em->ppp, ppp_connect, em);
+	g_at_ppp_set_disconnect_function(em->ppp, ppp_disconnect, em);
 =

-       return FALSE;
+	return FALSE;
 }
 =

 static gboolean dial_call(struct ofono_emulator *em, const char *dial_str)
 {
-       char c =3D *dial_str;
+	char c =3D *dial_str;
 =

-       DBG("dial call %s", dial_str);
+	DBG("dial call %s", dial_str);
 =

-       if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
-               g_at_server_send_intermediate(em->server, "CONNECT");
-               em->source =3D g_idle_add(setup_ppp, em);
-       }
+	if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
+		g_at_server_send_intermediate(em->server, "CONNECT");
+		em->source =3D g_idle_add(setup_ppp, em);
+	}
 =

-       return TRUE;
+	return TRUE;
 }
 =

 static void dial_cb(GAtServer *server, GAtServerRequestType type,
 				GAtResult *result, gpointer user_data)
 {
-       struct ofono_emulator *em =3D user_data;
-       GAtResultIter iter;
-       const char *dial_str;
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	const char *dial_str;
 =

-       DBG("");
+	DBG("");
 =

-       if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
-               goto error;
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
+		goto error;
 =

-       g_at_result_iter_init(&iter, result);
+	g_at_result_iter_init(&iter, result);
 =

-       if (!g_at_result_iter_next(&iter, ""))
-               goto error;
+	if (!g_at_result_iter_next(&iter, ""))
+		goto error;
 =

-       dial_str =3D g_at_result_iter_raw_line(&iter);
-       if (!dial_str)
-               goto error;
+	dial_str =3D g_at_result_iter_raw_line(&iter);
+	if (!dial_str)
+		goto error;
 =

-       if (em->ppp)
-               goto error;
+	if (em->ppp)
+		goto error;
 =

-       if (!dial_call(em, dial_str))
-               goto error;
+	if (!dial_call(em, dial_str))
+		goto error;
 =

-       return;
+	return;
 =

 error:
-       g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
+	g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 }
 =

 static void brsf_cb(GAtServer *server, GAtServerRequestType type,
-- =

1.7.1


--===============2964312254046011796==--

