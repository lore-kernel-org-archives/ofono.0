Content-Type: multipart/mixed; boundary="===============3801083677253383707=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 4/5] push notification: track and clean up atom watches
Date: Fri, 22 Apr 2016 13:07:15 +0000
Message-ID: <1461330431-20206-5-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330431-20206-4-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3801083677253383707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

Prevents glib from causing SIGFPE during certain circumstances of modem
removal.
---
 plugins/push-notification.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/plugins/push-notification.c b/plugins/push-notification.c
index ff388d9..ecf100f 100644
--- a/plugins/push-notification.c
+++ b/plugins/push-notification.c
@@ -45,6 +45,7 @@
 #define WAP_PUSH_DST_PORT 2948
 =

 static unsigned int modemwatch_id;
+static GHashTable *sms_watches =3D NULL;
 =

 struct push_notification {
 	struct ofono_modem *modem;
@@ -164,6 +165,16 @@ static void push_notification_cleanup(gpointer user)
 	ofono_modem_remove_interface(pn->modem, PUSH_NOTIFICATION_INTERFACE);
 }
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
 static void sms_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
@@ -197,18 +208,22 @@ static void sms_watch(struct ofono_atom *atom,
 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
 {
 	struct push_notification *pn;
+	int sms;
 	DBG("modem: %p, added: %d", modem, added);
 =

-	if (added =3D=3D FALSE)
+	if (added =3D=3D FALSE) {
+		g_hash_table_remove(sms_watches, modem);
 		return;
+	}
 =

 	pn =3D g_try_new0(struct push_notification, 1);
 	if (pn =3D=3D NULL)
 		return;
 =

 	pn->modem =3D modem;
-	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SMS,
-					sms_watch, pn, g_free);
+	sms =3D __ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SMS,
+						sms_watch, pn, g_free);
+	g_hash_table_insert(sms_watches, modem, GUINT_TO_POINTER(sms));
 }
 =

 static void call_modemwatch(struct ofono_modem *modem, void *user)
@@ -220,6 +235,8 @@ static int push_notification_init(void)
 {
 	DBG("");
 =

+	sms_watches =3D g_hash_table_new(g_direct_hash, g_direct_equal);
+
 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 =

 	__ofono_modem_foreach(call_modemwatch, NULL);
@@ -232,6 +249,9 @@ static void push_notification_exit(void)
 	DBG("");
 =

 	__ofono_modemwatch_remove(modemwatch_id);
+
+	g_hash_table_foreach_remove(sms_watches, atom_watch_remove, NULL);
+	g_hash_table_destroy(sms_watches);
 }
 =

 OFONO_PLUGIN_DEFINE(push_notification, "Push Notification Plugin", VERSION,
-- =

1.9.1

--===============3801083677253383707==--

