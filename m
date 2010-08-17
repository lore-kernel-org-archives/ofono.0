Content-Type: multipart/mixed; boundary="===============7355624822272921581=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH v5 3/8] plugins/ste: Add AT Channel configurations
Date: Tue, 17 Aug 2010 14:22:29 +0200
Message-ID: <1282047754-15562-4-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1282047754-15562-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7355624822272921581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ste.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index fcf4d15..bcf2704 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -216,7 +216,8 @@ static int ste_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->chat, ste_debug, NULL);
 =

-	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
+			NULL, NULL, NULL, NULL);
 	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
-- =

1.6.3.3


--===============7355624822272921581==--

