Content-Type: multipart/mixed; boundary="===============9150981104552740114=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] sms: fix type error
Date: Tue, 05 Oct 2010 13:37:55 +0300
Message-ID: <1286275075-31292-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9150981104552740114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/sms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index b7051b9..aee9a61 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -69,7 +69,7 @@ struct ofono_sms {
 	struct sms_assembly *assembly;
 	guint ref;
 	GQueue *txq;
-	gint tx_source;
+	guint tx_source;
 	struct ofono_message_waiting *mw;
 	unsigned int mw_watch;
 	struct ofono_sim *sim;
-- =

1.7.0.4


--===============9150981104552740114==--

