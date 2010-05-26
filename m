Content-Type: multipart/mixed; boundary="===============7454873391283630812=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] Fix more-messages-to-send indicator
Date: Wed, 26 May 2010 18:43:45 +0300
Message-ID: <1274888625-21255-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7454873391283630812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Set the mms indicator based on remaining segment count and not on the
message transmit queue status alone.
---
 src/sms.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 3a1cff0..7d4a099 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -58,7 +58,6 @@ struct ofono_sms {
 	unsigned int next_msg_id;
 	guint ref;
 	GQueue *txq;
-	time_t last_mms;
 	gint tx_source;
 	struct ofono_message_waiting *mw;
 	unsigned int mw_watch;
@@ -331,7 +330,6 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 static gboolean tx_next(gpointer user_data)
 {
 	struct ofono_sms *sms =3D user_data;
-	time_t ts;
 	int send_mms =3D 0;
 	struct tx_queue_entry *entry =3D g_queue_peek_head(sms->txq);
 	struct pending_pdu *pdu =3D &entry->pdus[entry->cur_pdu];
@@ -346,10 +344,8 @@ static gboolean tx_next(gpointer user_data)
 	if (!entry)
 		return FALSE;
 =

-	ts =3D time(NULL);
-
-	if ((g_queue_get_length(sms->txq) > 1) &&
-			((ts - sms->last_mms) > 60))
+	if (g_queue_get_length(sms->txq) > 1
+		|| entry->cur_pdu < entry->num_pdus - 1)
 		send_mms =3D 1;
 =

 	sms->driver->submit(sms, pdu->pdu, pdu->pdu_len, pdu->tpdu_len, send_mms,
-- =

1.7.0.4


--===============7454873391283630812==--

