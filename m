Content-Type: multipart/mixed; boundary="===============2484170999458197408=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/1] sms: limit the sms sending retry
Date: Thu, 17 Mar 2011 09:36:37 -0700
Message-ID: <1300379798-3390-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1300379798-3390-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2484170999458197408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 01f54dd..c4f8b54 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -47,6 +47,7 @@
 #define SETTINGS_GROUP "Settings"
 =

 #define TXQ_MAX_RETRIES 4
+#define NETWORK_TIMEOUT 332
 =

 static gboolean tx_next(gpointer user_data);
 =

@@ -630,6 +631,10 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 		if (sms->registered =3D=3D FALSE)
 			return;
 =

+		/* Retry done only for Network Timeout failure */
+		if (error->error !=3D NETWORK_TIMEOUT)
+			goto next_q;
+
 		if (!(entry->flags & OFONO_SMS_SUBMIT_FLAG_RETRY))
 			goto next_q;
 =

-- =

1.7.0.4


--===============2484170999458197408==--

