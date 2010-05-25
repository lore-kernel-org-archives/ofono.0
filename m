Content-Type: multipart/mixed; boundary="===============3613622321219540875=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 4/4] isimodem: fix confusing log message
Date: Tue, 25 May 2010 23:37:07 +0300
Message-ID: <1274819827-27993-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1274819827-27993-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3613622321219540875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/sms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index b605160..768d38b 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -472,7 +472,7 @@ static bool routing_resp_cb(GIsiClient *client, const v=
oid *restrict data,
 				"already\n  registered as the SMS "
 				"routing endpoint.\n  As a consequence, "
 				"receiving SMSs is NOT going to work.\n  "
-				"Receiving on the other hand might work.\n\n",
+				"On the other hand, sending might work.\n\n",
 				msg[1], sms_isi_cause_name(msg[1]));
 			ofono_sms_register(sms);
 		}
-- =

1.6.3.3


--===============3613622321219540875==--

