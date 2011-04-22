Content-Type: multipart/mixed; boundary="===============3679639455268455277=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/4] emulator: add routine to request/release private network
 from ConnMan
Date: Fri, 22 Apr 2011 12:02:41 +0200
Message-ID: <1303466563-3111-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1303466563-3111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3679639455268455277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |   10 +++++++
 src/emulator.c     |   75 +++++++++++++++++++++++++++++++++++++++++++++++-=
----
 2 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 5cd894b..29abf55 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -105,6 +105,16 @@ enum ofono_emulator_request_type ofono_emulator_reques=
t_get_type(
 void ofono_emulator_set_indicator(struct ofono_emulator *em,
 					const char *name, int value);
 =

+typedef void (*network_request)(struct ofono_error *, int *,
+				const char **, const char **,
+				const char **, const char **);
+typedef void (*network_release)(void);
+
+void ofono_emulator_add_network_request_cb(struct ofono_emulator *em,
+							network_request cb);
+void ofono_emulator_add_network_release_cb(struct ofono_emulator *em,
+							network_release cb);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/emulator.c b/src/emulator.c
index 9b4647b..b5055ff 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -33,10 +33,13 @@
 #include "gatserver.h"
 #include "gatppp.h"
 =

-#define DUN_SERVER_ADDRESS     "192.168.1.1"
-#define DUN_PEER_ADDRESS       "192.168.1.2"
-#define DUN_DNS_SERVER_1       "10.10.10.10"
-#define DUN_DNS_SERVER_2       "10.10.10.11"
+struct emulator_network {
+	int fd;
+	const char *server_ip;
+	const char *peer_ip;
+	const char *primary_dns;
+	const char *secondary_dns;
+};
 =

 #define RING_TIMEOUT 3
 =

@@ -55,6 +58,9 @@ struct ofono_emulator {
 	guint callsetup_source;
 	gboolean clip;
 	gboolean ccwa;
+	struct emulator_network *en;
+	network_request req_en_cb;
+	network_release rel_en_cb;
 };
 =

 struct indicator {
@@ -78,6 +84,40 @@ static void emulator_disconnect(gpointer user_data)
 	ofono_emulator_remove(em);
 }
 =

+static struct emulator_network *get_emulator_network(struct ofono_emulator=
 *e)
+{
+	struct ofono_error error;
+	struct emulator_network *en;
+
+	en =3D g_try_new0(struct emulator_network, 1);
+
+	if (en =3D=3D NULL)
+		return en;
+
+	if (e->req_en_cb)
+		e->req_en_cb(&error, &en->fd, &en->server_ip, &en->peer_ip,
+				&en->primary_dns, &en->secondary_dns);
+	else
+		goto error;
+
+	if (error.type =3D=3D OFONO_ERROR_TYPE_FAILURE)
+		goto error;
+
+	return en;
+
+error:
+	g_free(en);
+	return NULL;
+}
+
+static void release_emulator_network(struct ofono_emulator *e)
+{
+	if (e->rel_en_cb)
+		e->rel_en_cb();
+	if (e->en)
+		g_free(e->en);
+}
+
 static void ppp_connect(const char *iface, const char *local,
 			const char *remote,
 			const char *dns1, const char *dns2,
@@ -98,6 +138,7 @@ static void ppp_disconnect(GAtPPPDisconnectReason reason=
, gpointer user_data)
 =

 	g_at_ppp_unref(em->ppp);
 	em->ppp =3D NULL;
+	release_emulator_network(em);
 =

 	if (em->server =3D=3D NULL)
 		return;
@@ -118,14 +159,16 @@ static gboolean setup_ppp(gpointer user_data)
 =

 	g_at_server_suspend(em->server);
 =

-	em->ppp =3D g_at_ppp_server_new_from_io(io, DUN_SERVER_ADDRESS);
+	em->ppp =3D g_at_ppp_server_new_from_io_with_fd(io,
+							em->en->server_ip,
+							em->en->fd);
 	if (em->ppp =3D=3D NULL) {
 		g_at_server_resume(em->server);
 		return FALSE;
 	}
 =

-	g_at_ppp_set_server_info(em->ppp, DUN_PEER_ADDRESS,
-					DUN_DNS_SERVER_1, DUN_DNS_SERVER_2);
+	g_at_ppp_set_server_info(em->ppp, em->en->peer_ip,
+					em->en->primary_dns, em->en->secondary_dns);;
 =

 	g_at_ppp_set_credentials(em->ppp, "", "");
 	g_at_ppp_set_debug(em->ppp, emulator_debug, "PPP");
@@ -143,6 +186,9 @@ static gboolean dial_call(struct ofono_emulator *em, co=
nst char *dial_str)
 	DBG("dial call %s", dial_str);
 =

 	if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
+		em->en =3D get_emulator_network(em);
+		if (!em->en)
+			return FALSE;
 		g_at_server_send_intermediate(em->server, "CONNECT");
 		em->source =3D g_idle_add(setup_ppp, em);
 	}
@@ -927,3 +973,18 @@ void ofono_emulator_set_indicator(struct ofono_emulato=
r *em,
 		break;
 	}
 }
+
+void ofono_emulator_add_network_request_cb(struct ofono_emulator *em,
+							network_request cb)
+{
+	if (em !=3DNULL)
+		em->req_en_cb =3D cb;
+}
+
+void ofono_emulator_add_network_release_cb(struct ofono_emulator *em,
+							network_release cb)
+{
+	if (em !=3DNULL)
+		em->rel_en_cb =3D cb;
+}
+
-- =

1.7.1


--===============3679639455268455277==--

