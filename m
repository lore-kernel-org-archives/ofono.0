Content-Type: multipart/mixed; boundary="===============3614799981023614253=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 7/7] handsfree-audio: Add USR1 signal to connect audio
Date: Tue, 27 Aug 2013 18:59:43 +0200
Message-ID: <1377622783-22845-8-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1377622783-22845-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3614799981023614253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Frederic Danis <frederic.danis@linux.intel.com>

---
 tools/handsfree-audio.c |   90 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 90 insertions(+)

diff --git a/tools/handsfree-audio.c b/tools/handsfree-audio.c
index 1201a62..26415fa 100644
--- a/tools/handsfree-audio.c
+++ b/tools/handsfree-audio.c
@@ -48,6 +48,7 @@
 #define HFP_AUDIO_MANAGER_INTERFACE	OFONO_SERVICE ".HandsfreeAudioManager"
 #define HFP_AUDIO_AGENT_PATH		"/hfpaudioagent"
 #define HFP_AUDIO_AGENT_INTERFACE	OFONO_SERVICE ".HandsfreeAudioAgent"
+#define HFP_AUDIO_CARD_INTERFACE	OFONO_SERVICE ".HandsfreeAudioCard"
 =

 #define HFP_AUDIO_CVSD			1
 #define HFP_AUDIO_MSBC			2
@@ -67,6 +68,8 @@ static gboolean option_nomsbc =3D FALSE;
 static const char sntable[4] =3D { 0x08, 0x38, 0xC8, 0xF8 };
 static const int audio_rates[3] =3D { 0, 8000, 16000 };
 =

+static char *card_path =3D NULL;
+
 struct msbc_parser {
 	uint8_t buffer[60];
 	int parsed;
@@ -732,6 +735,71 @@ static void sig_term(int sig)
 	g_main_loop_quit(main_loop);
 }
 =

+static void sig_user(int sig)
+{
+	DBusMessage *msg;
+
+	if (sig =3D=3D SIGUSR1) {
+		if (card_path =3D=3D NULL) {
+			DBG("No audio card");
+			return;
+		}
+
+		DBG("Request audio connection");
+
+		msg =3D dbus_message_new_method_call(OFONO_SERVICE, card_path,
+					HFP_AUDIO_CARD_INTERFACE, "Connect");
+		if (msg =3D=3D NULL) {
+			DBG("Not enough memory");
+			return;
+		}
+
+		g_dbus_send_message(conn, msg);
+	}
+}
+
+static gboolean card_added(DBusConnection *connection, DBusMessage *messag=
e,
+			void *user_data)
+{
+	DBusMessageIter iter;
+	const char *path;
+
+	dbus_message_iter_init(message, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_OBJECT_PATH)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &path);
+	DBG("%s", path);
+
+	if (card_path =3D=3D NULL)
+		card_path =3D g_strdup(path);
+
+	return TRUE;
+}
+
+static gboolean card_removed(DBusConnection *connection, DBusMessage *mess=
age,
+			void *user_data)
+{
+	DBusMessageIter iter;
+	const char *path;
+
+	dbus_message_iter_init(message, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_OBJECT_PATH)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &path);
+	DBG("%s", path);
+
+	if (g_str_equal(card_path, path)) {
+		g_free(card_path);
+		card_path =3D NULL;
+	}
+
+	return TRUE;
+}
+
 static GOptionEntry options[] =3D {
 	{ "nocvsd", 'c', 0, G_OPTION_ARG_NONE, &option_nocvsd,
 				"Disable CVSD support" },
@@ -746,7 +814,10 @@ int main(int argc, char **argv)
 	GError *error =3D NULL;
 	DBusError err;
 	guint watch;
+	guint add_card_watch =3D 0;
+	guint remove_card_watch =3D 0;
 	struct sigaction sa;
+	struct sigaction sa_user;
 =

 	context =3D g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
@@ -776,6 +847,10 @@ int main(int argc, char **argv)
 	sigaction(SIGINT, &sa, NULL);
 	sigaction(SIGTERM, &sa, NULL);
 =

+	memset(&sa_user, 0, sizeof(sa_user));
+	sa_user.sa_handler =3D sig_user;
+	sigaction(SIGUSR1, &sa_user, NULL);
+
 	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &err);
 	if (conn =3D=3D NULL) {
 		if (dbus_error_is_set(&err) =3D=3D TRUE) {
@@ -793,17 +868,32 @@ int main(int argc, char **argv)
 	watch =3D g_dbus_add_service_watch(conn, OFONO_SERVICE,
 				ofono_connect, ofono_disconnect, NULL, NULL);
 =

+	add_card_watch =3D g_dbus_add_signal_watch(conn, OFONO_SERVICE,
+						HFP_AUDIO_MANAGER_PATH,
+						HFP_AUDIO_MANAGER_INTERFACE,
+						"CardAdded", card_added,
+						NULL, NULL);
+	remove_card_watch =3D g_dbus_add_signal_watch(conn, OFONO_SERVICE,
+						HFP_AUDIO_MANAGER_PATH,
+						HFP_AUDIO_MANAGER_INTERFACE,
+						"CardRemoved", card_removed,
+						NULL, NULL);
+
 	g_main_loop_run(main_loop);
 =

 	while (threads !=3D NULL)
 		hfp_audio_thread_free(threads->data);
 =

 	g_dbus_remove_watch(conn, watch);
+	g_dbus_remove_watch(conn, add_card_watch);
+	g_dbus_remove_watch(conn, remove_card_watch);
 	hfp_audio_agent_destroy(conn);
 =

 	dbus_connection_unref(conn);
 =

 	g_main_loop_unref(main_loop);
 =

+	g_free(card_path);
+
 	return 0;
 }
-- =

1.7.9.5


--===============3614799981023614253==--

