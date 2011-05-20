Content-Type: multipart/mixed; boundary="===============0964100572115438130=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/7] sms: remove set but not used var
Date: Fri, 20 May 2011 16:03:39 -0300
Message-ID: <1305918225-8438-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0964100572115438130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 2940762..323c5ad 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -754,9 +754,6 @@ static gboolean tx_next(gpointer user_data)
 	int send_mms =3D 0;
 	struct tx_queue_entry *entry =3D g_queue_peek_head(sms->txq);
 	struct pending_pdu *pdu =3D &entry->pdus[entry->cur_pdu];
-	struct ofono_error error;
-
-	error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
 =

 	DBG("tx_next: %p", entry);
 =

-- =

1.7.5.1


--===============0964100572115438130==--

