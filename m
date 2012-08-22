Content-Type: multipart/mixed; boundary="===============5997744672330929200=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] sms: Add delay before submitting multiple SMS to modem
Date: Wed, 22 Aug 2012 11:29:15 +0200
Message-ID: <1345627755-14091-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5997744672330929200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For 3GPP GSM test case 34.2.9.1 and 34.2.9.1 and WCDMA test
case 16.1.9.1 and 16.1.9.2, we need to transmitmultiple SMS
using same RRC channel.
oFono needs to wait its tx queue to be filled in with the
next SMS before submitting the first one to use +CMMS=3D1 modem
option.
---
 src/sms.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index acfc39b..443e502 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -50,6 +50,8 @@
 #define TXQ_MAX_RETRIES 4
 #define NETWORK_TIMEOUT 332
 =

+#define SMS_TX_NEXT 500
+
 static gboolean tx_next(gpointer user_data);
 =

 static GSList *g_drivers =3D NULL;
@@ -2072,7 +2074,7 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GSL=
ist *list,
 	g_queue_push_tail(sms->txq, entry);
 =

 	if (sms->registered && g_queue_get_length(sms->txq) =3D=3D 1)
-		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
+		sms->tx_source =3D g_timeout_add(SMS_TX_NEXT, tx_next, sms);
 =

 	if (uuid)
 		memcpy(uuid, &entry->uuid, sizeof(*uuid));
-- =

1.7.5.4


--===============5997744672330929200==--

