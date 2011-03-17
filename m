Content-Type: multipart/mixed; boundary="===============8729848569290807676=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 5/9] hsp_ag: add modem watch
Date: Thu, 17 Mar 2011 19:55:44 +0100
Message-ID: <1300388148-925-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300388148-925-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8729848569290807676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hsp_ag.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++---=
---
 1 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/plugins/hsp_ag.c b/plugins/hsp_ag.c
index a8e6f40..5a60269 100644
--- a/plugins/hsp_ag.c
+++ b/plugins/hsp_ag.c
@@ -47,7 +47,9 @@
 =

 #define HSP_RFCOMM_CHAN 17
 =

-static struct server *hsp;
+static struct server *server;
+static guint modemwatch_id;
+static GList *modems;
 =

 static const gchar *hsp_record =3D
 "<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>\n"
@@ -90,25 +92,81 @@ static const gchar *hsp_record =3D
 " </attribute>\n"
 "</record>\n";
 =

-static void connect_cb(GIOChannel *channel, GError *err, gpointer user_dat=
a)
+static void connect_cb(GIOChannel *channel, GError *err, gpointer data)
+{	int fd;
+	struct ofono_emulator *em;
+	struct ofono_modem *modem;
+
+	/* Pick the first powered modem */
+	modem =3D modems->data;
+	DBG("Picked modem %p for emulator", modem);
+
+	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_HSP);
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
+static void voicecall_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
 {
+	struct ofono_modem *modem =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		modems =3D g_list_append(modems, modem);
+
+		if (modems->next =3D=3D NULL)
+			server =3D bluetooth_register_server(HSP_RFCOMM_CHAN,
+							hsp_record,
+							connect_cb,
+							NULL);
+	} else {
+		modems =3D g_list_remove(modems, modem);
+		if (modems =3D=3D NULL &&  server !=3D NULL) {
+			bluetooth_unregister_server(server);
+			server =3D NULL;
+		}
+	}
 }
 =

-static int hsp_ag_init(void)
+static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
 {
-	hsp =3D bluetooth_register_server(HSP_RFCOMM_CHAN, hsp_record, connect_cb=
, NULL);
+	DBG("modem: %p, added: %d", modem, added);
 =

-	if(!hsp)
-		return -1;
+	if (added =3D=3D FALSE)
+		return;
+
+	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_VOICECALL,
+					voicecall_watch, modem, NULL);
+}
+
+static void call_modemwatch(struct ofono_modem *modem, void *user)
+{
+	modem_watch(modem, TRUE, user);
+}
+
+static int hsp_ag_init(void)
+{
+	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
+	__ofono_modem_foreach(call_modemwatch, NULL);
 =

-	DBG("HSP Gateway profile starting");
 	return 0;
 }
 =

 static void hsp_ag_exit(void)
 {
-	if(hsp)
-		bluetooth_unregister_server(hsp);
+	__ofono_modemwatch_remove(modemwatch_id);
+
+	if (server) {
+		bluetooth_unregister_server(server);
+		server =3D NULL;
+	}
 }
 =

 OFONO_PLUGIN_DEFINE(hsp_ag, "Headset Gateway Profile", VERSION,
-- =

1.7.1


--===============8729848569290807676==--

