Content-Type: multipart/mixed; boundary="===============2756776610245739961=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH 1/2] sim900: Add support for SIMCOM SMS delivery reports
Date: Mon, 27 Feb 2012 11:19:43 +0400
Message-ID: <1330327184-1497-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2756776610245739961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

---
 plugins/sim900.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/sim900.c b/plugins/sim900.c
index f7b1642..b2d1b46 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -224,7 +224,8 @@ static void sim900_post_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_phonebook_create(modem, 0, "atmodem", data->modem);
-	ofono_sms_create(modem, 0, "atmodem", data->modem);
+	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", =

+				data->modem);
 }
 =

 static void sim900_post_online(struct ofono_modem *modem)
-- =

1.7.7.3


--===============2756776610245739961==--

