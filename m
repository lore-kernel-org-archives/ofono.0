Content-Type: multipart/mixed; boundary="===============8165130059454664221=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: [PATCH] linktop: power up the modem in 'offline' state
Date: Wed, 16 Feb 2011 02:34:32 +0530
Message-ID: <1297803872-30760-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8165130059454664221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/linktop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/linktop.c b/plugins/linktop.c
index 61db9a7..2fb3896 100644
--- a/plugins/linktop.c
+++ b/plugins/linktop.c
@@ -200,7 +200,7 @@ static int linktop_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->modem, "AT &F", none_prefix,
 						NULL, NULL, NULL);
 =

-	g_at_chat_send(data->control, "AT+CFUN=3D1", none_prefix,
+	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
 					cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
-- =

1.7.1


--===============8165130059454664221==--

