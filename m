Content-Type: multipart/mixed; boundary="===============6854348584227805645=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 2/3] emulator: add drivers to request/release private
 network from ConnMan
Date: Tue, 03 May 2011 16:44:42 +0200
Message-ID: <1304433883-3806-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1304433883-3806-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6854348584227805645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |   18 +++++++++++
 src/emulator.c     |   83 +++++++++++++++++++++++++++++++++++++++---------=
---
 2 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 5cd894b..a7fc23b 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -105,6 +105,24 @@ enum ofono_emulator_request_type ofono_emulator_reques=
t_get_type(
 void ofono_emulator_set_indicator(struct ofono_emulator *em,
 					const char *name, int value);
 =

+ofono_bool_t ofono_emulator_setup_ppp(struct ofono_emulator *em, int fd,
+				const char *server_ip, const char *peer_ip,
+				const char *primary_dns,
+				const char *secondary_dns);
+
+int ofono_emulator_get_uid(struct ofono_emulator *em);
+
+struct emulator_network_provision_driver {
+	char *name;
+	int (*get_settings)(struct ofono_emulator *em);
+	void (*release)(int uid);
+};
+
+int ofono_emulator_network_driver_register(
+			const struct emulator_network_provision_driver *d);
+void ofono_emulator_network_driver_unregister(
+			const struct emulator_network_provision_driver *d);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/emulator.c b/src/emulator.c
index 9055909..8850286 100644
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

@@ -33,10 +34,7 @@
 #include "gatserver.h"
 #include "gatppp.h"
 =

-#define DUN_SERVER_ADDRESS     "192.168.1.1"
-#define DUN_PEER_ADDRESS       "192.168.1.2"
-#define DUN_DNS_SERVER_1       "10.10.10.10"
-#define DUN_DNS_SERVER_2       "10.10.10.11"
+static GSList *g_drivers =3D NULL;
 =

 #define RING_TIMEOUT 3
 =

@@ -45,7 +43,6 @@ struct ofono_emulator {
 	enum ofono_emulator_type type;
 	GAtServer *server;
 	GAtPPP *ppp;
-	guint source;
 	gboolean slc;
 	int l_features;
 	int r_features;
@@ -55,6 +52,8 @@ struct ofono_emulator {
 	guint callsetup_source;
 	gboolean clip;
 	gboolean ccwa;
+	int pns_uid;
+	const struct emulator_network_provision_driver *driver;
 };
 =

 struct indicator {
@@ -98,6 +97,10 @@ static void ppp_disconnect(GAtPPPDisconnectReason reason=
, gpointer user_data)
 =

 	g_at_ppp_unref(em->ppp);
 	em->ppp =3D NULL;
+	if (em->driver->release)
+		em->driver->release(em->pns_uid);
+
+	em->pns_uid =3D 0;
 =

 	if (em->server =3D=3D NULL)
 		return;
@@ -105,27 +108,32 @@ static void ppp_disconnect(GAtPPPDisconnectReason rea=
son, gpointer user_data)
 	g_at_server_resume(em->server);
 }
 =

-static gboolean setup_ppp(gpointer user_data)
+ofono_bool_t ofono_emulator_setup_ppp(struct ofono_emulator *em, int fd,
+				const char *server_ip, const char *peer_ip,
+				const char *primary_dns,
+				const char *secondary_dns)
 {
-	struct ofono_emulator *em =3D user_data;
 	GAtIO *io;
 =

 	DBG("");
 =

-	em->source =3D 0;
-
 	io =3D g_at_server_get_io(em->server);
 =

 	g_at_server_suspend(em->server);
 =

-	em->ppp =3D g_at_ppp_server_new_from_io(io, DUN_SERVER_ADDRESS);
+	em->ppp =3D g_at_ppp_server_new_full(io, server_ip, fd);
 	if (em->ppp =3D=3D NULL) {
+		close(fd);
+		if (em->driver->release)
+			em->driver->release(em->pns_uid);
+		em->pns_uid =3D 0;
 		g_at_server_resume(em->server);
 		return FALSE;
 	}
 =

-	g_at_ppp_set_server_info(em->ppp, DUN_PEER_ADDRESS,
-					DUN_DNS_SERVER_1, DUN_DNS_SERVER_2);
+	g_at_ppp_set_server_info(em->ppp, peer_ip,
+					primary_dns,
+					secondary_dns);
 =

 	g_at_ppp_set_credentials(em->ppp, "", "");
 	g_at_ppp_set_debug(em->ppp, emulator_debug, "PPP");
@@ -133,7 +141,12 @@ static gboolean setup_ppp(gpointer user_data)
 	g_at_ppp_set_connect_function(em->ppp, ppp_connect, em);
 	g_at_ppp_set_disconnect_function(em->ppp, ppp_disconnect, em);
 =

-	return FALSE;
+	return TRUE;
+}
+
+int ofono_emulator_get_uid(struct ofono_emulator *em)
+{
+	return em->pns_uid;
 }
 =

 static gboolean dial_call(struct ofono_emulator *em, const char *dial_str)
@@ -143,10 +156,16 @@ static gboolean dial_call(struct ofono_emulator *em, =
const char *dial_str)
 	DBG("dial call %s", dial_str);
 =

 	if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
-		g_at_server_send_intermediate(em->server, "CONNECT");
-		em->source =3D g_idle_add(setup_ppp, em);
+		if (em->driver->get_settings)
+			em->pns_uid =3D em->driver->get_settings(em);
+		else =

+			return FALSE;
+		if (em->pns_uid < 0)
+			return FALSE;
 	}
 =

+	g_at_server_send_intermediate(em->server, "CONNECT");
+
 	return TRUE;
 }
 =

@@ -603,11 +622,6 @@ static void emulator_unregister(struct ofono_atom *ato=
m)
 =

 	DBG("%p", em);
 =

-	if (em->source) {
-		g_source_remove(em->source);
-		em->source =3D 0;
-	}
-
 	if (em->callsetup_source) {
 		g_source_remove(em->callsetup_source);
 		em->callsetup_source =3D 0;
@@ -688,6 +702,7 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 {
 	struct ofono_emulator *em;
 	enum ofono_atom_type atom_t;
+	GSList *l;
 =

 	DBG("modem: %p, type: %d", modem, type);
 =

@@ -711,6 +726,16 @@ struct ofono_emulator *ofono_emulator_create(struct of=
ono_modem *modem,
 	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
 							emulator_remove, em);
 =

+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct emulator_network_provision_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, "ConnMan Private Network"))
+			continue;
+
+		em->driver =3D drv;
+		break;
+	}
+
 	return em;
 }
 =

@@ -935,3 +960,21 @@ void ofono_emulator_set_indicator(struct ofono_emulato=
r *em,
 		break;
 	}
 }
+
+int ofono_emulator_network_driver_register(
+			const struct emulator_network_provision_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
+
+	return 0;
+}
+
+void ofono_emulator_network_driver_unregister(
+			const struct emulator_network_provision_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
-- =

1.7.1


--===============6854348584227805645==--

