Content-Type: multipart/mixed; boundary="===============8477803383366303378=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 5/5] smart messaging: track and clean up atom watches
Date: Fri, 22 Apr 2016 13:07:15 +0000
Message-ID: <1461330431-20206-6-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330431-20206-5-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8477803383366303378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

Prevents glib from causing SIGFPE during certain circumstances of modem
removal.
---
 plugins/smart-messaging.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index b368917..38a03f3 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -48,6 +48,7 @@
 #define VCAL_SRC_PORT -1
 #define VCAL_DST_PORT 9205
 =

+static GHashTable *sms_watches =3D NULL;
 static unsigned int modemwatch_id;
 =

 struct smart_messaging {
@@ -284,6 +285,16 @@ static const GDBusMethodTable smart_messaging_methods[=
] =3D {
 	{ }
 };
 =

+static gboolean atom_watch_remove(gpointer key, gpointer value,
+					gpointer user_data)
+{
+	struct ofono_modem *modem =3D key;
+
+	__ofono_modem_remove_atom_watch(modem, GPOINTER_TO_UINT(value));
+
+	return TRUE;
+}
+
 static void smart_messaging_cleanup(gpointer user)
 {
 	struct smart_messaging *sm =3D user;
@@ -333,18 +344,22 @@ static void sms_watch(struct ofono_atom *atom,
 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
 {
 	struct smart_messaging *sm;
+	int sms;
 	DBG("modem: %p, added: %d", modem, added);
 =

-	if (added =3D=3D FALSE)
+	if (added =3D=3D FALSE) {
+		g_hash_table_remove(sms_watches, modem);
 		return;
+	}
 =

 	sm =3D g_try_new0(struct smart_messaging, 1);
 	if (sm =3D=3D NULL)
 		return;
 =

 	sm->modem =3D modem;
-	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SMS,
-					sms_watch, sm, g_free);
+	sms =3D __ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SMS,
+						sms_watch, sm, g_free);
+	g_hash_table_insert(sms_watches, modem, GUINT_TO_POINTER(sms));
 }
 =

 static void call_modemwatch(struct ofono_modem *modem, void *user)
@@ -356,6 +371,8 @@ static int smart_messaging_init(void)
 {
 	DBG("");
 =

+	sms_watches =3D g_hash_table_new(g_direct_hash, g_direct_equal);
+
 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 =

 	__ofono_modem_foreach(call_modemwatch, NULL);
@@ -368,6 +385,9 @@ static void smart_messaging_exit(void)
 	DBG("");
 =

 	__ofono_modemwatch_remove(modemwatch_id);
+
+	g_hash_table_foreach_remove(sms_watches, atom_watch_remove, NULL);
+	g_hash_table_destroy(sms_watches);
 }
 =

 OFONO_PLUGIN_DEFINE(smart_messaging, "Smart Messaging Plugin", VERSION,
-- =

1.9.1

--===============8477803383366303378==--

