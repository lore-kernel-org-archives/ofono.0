Content-Type: multipart/mixed; boundary="===============0062996716045340205=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/3] push-notification: Accept push from any origin
Date: Mon, 07 Sep 2015 11:58:15 +0200
Message-ID: <1441619897-22899-2-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1441619897-22899-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0062996716045340205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Accept push notifications regardless of the origin port, as some
operators do not insert there the WAP connectionless session service
port, and use random values instead.
---
 plugins/push-notification.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/plugins/push-notification.c b/plugins/push-notification.c
index f6ca365..ff388d9 100644
--- a/plugins/push-notification.c
+++ b/plugins/push-notification.c
@@ -41,7 +41,7 @@
 #define PUSH_NOTIFICATION_INTERFACE "org.ofono.PushNotification"
 #define AGENT_INTERFACE "org.ofono.PushNotificationAgent"
 =

-#define WAP_PUSH_SRC_PORT 9200
+#define WAP_PUSH_SRC_PORT -1
 #define WAP_PUSH_DST_PORT 2948
 =

 static unsigned int modemwatch_id;
@@ -50,21 +50,16 @@ struct push_notification {
 	struct ofono_modem *modem;
 	struct ofono_sms *sms;
 	struct sms_agent *agent;
-	unsigned int push_watch[2];
+	unsigned int push_watch;
 };
 =

 static void agent_exited(void *userdata)
 {
 	struct push_notification *pn =3D userdata;
 =

-	if (pn->push_watch[0] > 0) {
-		__ofono_sms_datagram_watch_remove(pn->sms, pn->push_watch[0]);
-		pn->push_watch[0] =3D 0;
-	}
-
-	if (pn->push_watch[1] > 0) {
-		__ofono_sms_datagram_watch_remove(pn->sms, pn->push_watch[1]);
-		pn->push_watch[1] =3D 0;
+	if (pn->push_watch > 0) {
+		__ofono_sms_datagram_watch_remove(pn->sms, pn->push_watch);
+		pn->push_watch =3D 0;
 	}
 =

 	pn->agent =3D NULL;
@@ -113,17 +108,12 @@ static DBusMessage *push_notification_register_agent(=
DBusConnection *conn,
 =

 	sms_agent_set_removed_notify(pn->agent, agent_exited, pn);
 =

-	pn->push_watch[0] =3D __ofono_sms_datagram_watch_add(pn->sms,
+	pn->push_watch =3D __ofono_sms_datagram_watch_add(pn->sms,
 							push_received,
 							WAP_PUSH_DST_PORT,
 							WAP_PUSH_SRC_PORT,
 							pn, NULL);
 =

-	pn->push_watch[1] =3D __ofono_sms_datagram_watch_add(pn->sms,
-							push_received,
-							WAP_PUSH_DST_PORT,
-							0, pn, NULL);
-
 	return dbus_message_new_method_return(msg);
 }
 =

@@ -166,8 +156,7 @@ static void push_notification_cleanup(gpointer user)
 	DBG("%p", pn);
 =

 	/* The push watch was already cleaned up */
-	pn->push_watch[0] =3D 0;
-	pn->push_watch[1] =3D 0;
+	pn->push_watch =3D 0;
 	pn->sms =3D NULL;
 =

 	sms_agent_free(pn->agent);
-- =

2.1.4


--===============0062996716045340205==--

