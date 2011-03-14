Content-Type: multipart/mixed; boundary="===============3749629007134017067=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/5] hsp_ag: add modem watch
Date: Mon, 14 Mar 2011 16:49:18 +0100
Message-ID: <1300117761-6181-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300117761-6181-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3749629007134017067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hsp_ag.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++=
---
 1 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/plugins/hsp_ag.c b/plugins/hsp_ag.c
index 34bf0a1..467b6b2 100644
--- a/plugins/hsp_ag.c
+++ b/plugins/hsp_ag.c
@@ -48,6 +48,8 @@
 #define HSP_RFCOMM_CHAN 17
 =

 static struct server *hsp;
+static unsigned int modemwatch_id;
+static GList *modems;
 =

 static const gchar *hsp_record =3D =

 "<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>\n"
@@ -90,16 +92,95 @@ static const gchar *hsp_record =3D
 " </attribute>\n"
 "</record>\n";
 =

-static void connect_cb(GIOChannel *channel, GError *err, gpointer user_dat=
a)
+static void connect_cb(GIOChannel *channel, GError *err, gpointer data)
 {
+	int fd;
+	struct ofono_emulator *em;
+	struct ofono_modem *modem;
+
+	/* Pick the first powered modem */
+	modem =3D modems->data;
+	DBG("Picked modem %p for emulator", modem);
+
+	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_DUN);
+	if (em =3D=3D NULL)
+		return;
+
+	fd =3D g_io_channel_unix_get_fd(channel);
+
+	ofono_emulator_register(em, fd);
+
+	g_io_channel_set_close_on_unref(channel, FALSE);
+}
+
+static void create_server()
+{
+	if(hsp =3D=3D NULL)
+		hsp =3D bluetooth_register_server(HSP_RFCOMM_CHAN, hsp_record,
+					connect_cb, NULL);
+
+	DBG("Creating server: %p", hsp);
+}
+
+static void destroy_server()
+{
+	DBG("Removing server: %p", hsp);
+
+	if(hsp)
+		bluetooth_unregister_server(hsp);
+	hsp =3D NULL;
+}
+
+static void powered_watch(struct ofono_modem *modem, gboolean powered,
+				void *user)
+{
+	if (powered =3D=3D FALSE) {
+		DBG("Removing modem %p from the list", modem);
+		modems =3D g_list_remove(modems, modem);
+
+		if (modems =3D=3D NULL) {
+			destroy_server();
+		}
+	} else {
+		DBG("Adding modem %p to the list", modem);
+		modems =3D g_list_append(modems, modem);
+
+		if (modems->next =3D=3D NULL)
+			create_server();
+	}
+}
+
+static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
+{
+	DBG("modem: %p, added: %d", modem, added);
+
+	if (added =3D=3D FALSE) {
+		DBG("Removing modem %p from the list", modem);
+		modems =3D g_list_remove(modems, modem);
+		return;
+	}
+
+	if (ofono_modem_get_powered(modem) =3D=3D TRUE) {
+		DBG("Adding modem %p to the list", modem);
+		modems =3D g_list_append(modems, modem);
+
+		if (modems->next =3D=3D NULL)
+			create_server();
+	}
+
+	__ofono_modem_add_powered_watch(modem, powered_watch, NULL, NULL);
+}
+
+static void call_modemwatch(struct ofono_modem *modem, void *user)
+{
+	modem_watch(modem, TRUE, user);
 }
 =

 static int hsp_ag_init(void)
 {
-	hsp =3D bluetooth_register_server(HSP_RFCOMM_CHAN, hsp_record, connect_cb=
, NULL);
+	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 =

-	if(!hsp)
-		return -1;
+	__ofono_modem_foreach(call_modemwatch, NULL);
 =

 	DBG("HSP Gateway profile starting");
 	return 0;
@@ -107,8 +188,11 @@ static int hsp_ag_init(void)
 =

 static void hsp_ag_exit(void)
 {
-	if(hsp)
-		bluetooth_unregister_server(hsp);
+	destroy_server();
+
+	__ofono_modemwatch_remove(modemwatch_id);
+
+	g_list_free(modems);
 }
 =

 OFONO_PLUGIN_DEFINE(hsp_ag, "Headset Gateway Profile", VERSION,
-- =

1.7.1


--===============3749629007134017067==--

