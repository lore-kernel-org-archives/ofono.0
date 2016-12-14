Content-Type: multipart/mixed; boundary="===============1314009280535525993=="
MIME-Version: 1.0
From: marko.sulejic@hale.at
Subject: [PATCH] sms.c: fix typo
Date: Wed, 14 Dec 2016 10:39:51 +0100
Message-ID: <1481708391-7560-1-git-send-email-marko.sulejic@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1314009280535525993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marko =C5=A0uleji=C4=87 <marko.sulejic@hale.at>

---
 drivers/atmodem/sms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index f93dd23..b6876b0 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -742,7 +742,7 @@ static void at_sms_initialized(struct ofono_sms *sms)
 =

 static void at_sms_not_supported(struct ofono_sms *sms)
 {
-	ofono_error("SMS not supported by this modem.  If this is in error"
+	ofono_error("SMS not supported by this modem.  If this is an error"
 			" please submit patches to support this hardware");
 =

 	ofono_sms_remove(sms);
-- =

2.7.4


--===============1314009280535525993==--

