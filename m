Content-Type: multipart/mixed; boundary="===============6387092366420135856=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 2/4] quectel: remove leftover reset of wakeup command
Date: Thu, 26 Sep 2019 21:27:23 +0200
Message-ID: <20190926192725.227285-2-martin@geanix.com>
In-Reply-To: <20190926192725.227285-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6387092366420135856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 1d21d6dd..a0e435b5 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -968,7 +968,6 @@ static void ate_cb(int ok, GAtResult *result, void *use=
r_data)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_set_wakeup_command(data->uart, NULL, 0, 0);
 	g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
 			cmux_cb, modem, NULL);
 }
-- =

2.23.0


--===============6387092366420135856==--

