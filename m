Content-Type: multipart/mixed; boundary="===============8061845843237488313=="
MIME-Version: 1.0
From: Florent Beillonnet <florent.beillonnet@gmail.com>
Subject: [PATCH 2/2] Rework at_pin_send_puk It seems that the function
 at_pin_send_puk should have been changed along with at_pin_send,
 because it's also refering to the at_pin_send_cb callback See this commit :
 ba9f126716db3ae0bf6a3139088d9657cfb8b851
Date: Tue, 22 May 2018 13:08:31 +0000
Message-ID: <1526994511-302-3-git-send-email-florent.beillonnet@ext.actia.fr>
In-Reply-To: <1526994511-302-1-git-send-email-florent.beillonnet@ext.actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8061845843237488313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index ab75b32..10dc800 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1359,12 +1359,12 @@ static void at_pin_send_puk(struct ofono_sim *sim, =
const char *puk,
 	char buf[64];
 	int ret;
 =

-	cbd->user =3D sd;
+	cbd->user =3D sim;
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_pin_send_cb, cbd, NULL);
+				at_pin_send_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

-- =

1.9.1


--===============8061845843237488313==--

