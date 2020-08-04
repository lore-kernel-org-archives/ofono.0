Content-Type: multipart/mixed; boundary="===============2557156423017213697=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 2/5] quectel: Set URC port to uart1 on EC21
Date: Tue, 04 Aug 2020 14:38:46 +0200
Message-ID: <20200804123849.909105-2-poeschel@lemonage.de>
In-Reply-To: <20200804123849.909105-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2557156423017213697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

Set the URC port of the Quectel EC21 to uart1 when it is used through
it's serial port. This setting is saved to non-volatile storage by the
modem automatically.
---
 plugins/quectel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index feddb378..50d1b5d3 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -795,10 +795,12 @@ static void setup_aux(struct ofono_modem *modem)
 =

 	g_at_chat_set_slave(data->modem, data->aux);
 =

-	if (data->model =3D=3D QUECTEL_EC21)
+	if (data->model =3D=3D QUECTEL_EC21) {
 		g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1", none_prefix,
 				NULL, NULL, NULL);
-	else
+		g_at_chat_send(data->aux, "AT+QURCCFG=3D\"urcport\",\"uart1\"", none_pre=
fix,
+				NULL, NULL, NULL);
+	} else
 		g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1; +QIURC=3D0",
 				none_prefix, NULL, NULL, NULL);
 =

-- =

2.27.0

--===============2557156423017213697==--

