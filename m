Content-Type: multipart/mixed; boundary="===============1053021195837202397=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 5/7] quectel: EC21 does not understand AT+QIURC
Date: Tue, 26 May 2020 12:16:23 +0200
Message-ID: <20200526101625.31871-6-poeschel@lemonage.de>
In-Reply-To: <20200526101625.31871-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1053021195837202397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

Because the Quectel EC21 does not understand the AT+QIURC command, we
leave that out during initialisation.
---
 plugins/quectel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 9ff75516..574de44e 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -772,8 +772,14 @@ static void setup_aux(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	g_at_chat_set_slave(data->modem, data->aux);
-	g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1; +QIURC=3D0", none_prefix,
-			NULL, NULL, NULL);
+
+	if (data->model =3D=3D QUECTEL_EC21)
+		g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1", none_prefix,
+				NULL, NULL, NULL);
+	else
+		g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1; +QIURC=3D0",
+				none_prefix, NULL, NULL, NULL);
+
 	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix, cfun_query, modem,
 			NULL);
 }
-- =

2.26.2

--===============1053021195837202397==--

