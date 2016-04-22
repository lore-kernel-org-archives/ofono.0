Content-Type: multipart/mixed; boundary="===============6281807831669230203=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 08/24] sm: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-9-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-8-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6281807831669230203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 plugins/smart-messaging.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index b368917..bbbdaa9 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -216,8 +216,7 @@ static DBusMessage *smart_messaging_send_vcard(DBusConn=
ection *conn,
 	err =3D __ofono_sms_txq_submit(sm->sms, msg_list, flags, &uuid,
 					message_queued, msg);
 =

-	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
-	g_slist_free(msg_list);
+	g_slist_free_full(msg_list, g_free);
 =

 	if (err < 0)
 		return __ofono_error_failed(msg);
@@ -259,8 +258,7 @@ static DBusMessage *smart_messaging_send_vcal(DBusConne=
ction *conn,
 	err =3D __ofono_sms_txq_submit(sm->sms, msg_list, flags, &uuid,
 					message_queued, msg);
 =

-	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
-	g_slist_free(msg_list);
+	g_slist_free_full(msg_list, g_free);
 =

 	if (err < 0)
 		return __ofono_error_failed(msg);
-- =

1.9.1

--===============6281807831669230203==--

