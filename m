Content-Type: multipart/mixed; boundary="===============0983871848913637433=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 18/24] sms: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-19-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-18-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0983871848913637433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/sms.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 72972b2..17c5a9c 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -988,8 +988,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	err =3D __ofono_sms_txq_submit(sms, msg_list, flags, &uuid,
 					message_queued, msg);
 =

-	g_slist_foreach(msg_list, (GFunc) g_free, NULL);
-	g_slist_free(msg_list);
+	g_slist_free_full(msg_list, g_free);
 =

 	if (err < 0)
 		return __ofono_error_failed(msg);
@@ -1425,8 +1424,7 @@ static void handle_deliver(struct ofono_sms *sms, con=
st struct sms *incoming)
 			return;
 =

 		sms_dispatch(sms, sms_list);
-		g_slist_foreach(sms_list, (GFunc) g_free, NULL);
-		g_slist_free(sms_list);
+		g_slist_free_full(sms_list, g_free);
 =

 		return;
 	}
@@ -1946,8 +1944,7 @@ static void sms_restore_tx_queue(struct ofono_sms *sm=
s)
 		g_queue_push_tail(sms->txq, txq_entry);
 =

 loop_out:
-		g_slist_foreach(backup_entry->msg_list, (GFunc)g_free, NULL);
-		g_slist_free(backup_entry->msg_list);
+		g_slist_free_full(backup_entry->msg_list, g_free);
 		g_free(backup_entry);
 	}
 =

-- =

1.9.1

--===============0983871848913637433==--

