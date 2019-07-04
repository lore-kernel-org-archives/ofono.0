Content-Type: multipart/mixed; boundary="===============0744885179779927267=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv2 08/10] quectel: fix initial channel/device configuration
Date: Thu, 04 Jul 2019 13:03:50 +0200
Message-ID: <20190704110351.47831-1-martin@geanix.com>
In-Reply-To: <20190703180955.18246-9-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0744885179779927267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The three-commands-in-one-go results in error on some quectel devices
(e.g. m95). Add semicolons between the commands to fix it.
---
 plugins/quectel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 3c6b9d9f..7e3c4e4a 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -207,9 +207,9 @@ static int quectel_enable(struct ofono_modem *modem)
 =

 	g_at_chat_set_slave(data->modem, data->aux);
 =

-	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", none_prefix, NULL, NULL,
-			NULL);
-	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", none_prefix, NULL, NULL,
+	g_at_chat_send(data->modem, "ATE0; &C0; +CMEE=3D1", none_prefix, NULL,
+			NULL, NULL);
+	g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1", none_prefix, NULL, NULL,
 			NULL);
 	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix, cfun_query, modem,
 			NULL);
-- =

2.22.0


--===============0744885179779927267==--

