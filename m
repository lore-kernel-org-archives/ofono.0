Content-Type: multipart/mixed; boundary="===============1052015154056997020=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 6/7] voicecall: Quectel modem do not understand AT+CNAP
Date: Tue, 26 May 2020 12:16:24 +0200
Message-ID: <20200526101625.31871-7-poeschel@lemonage.de>
In-Reply-To: <20200526101625.31871-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1052015154056997020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

---
 drivers/atmodem/voicecall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 7ab6567f..e7f24b60 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -1113,7 +1113,9 @@ static int at_voicecall_probe(struct ofono_voicecall =
*vc, unsigned int vendor,
 	g_at_chat_send(vd->chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CDIP=3D1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL, NULL);
+
+	if (vd->vendor !=3D OFONO_VENDOR_QUECTEL)
+		g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL, NULL);
 =

 	switch (vd->vendor) {
 	case OFONO_VENDOR_QUALCOMM_MSM:
-- =

2.26.2

--===============1052015154056997020==--

