Content-Type: multipart/mixed; boundary="===============6794559753566090567=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/2] message-waiting: Update properly EF_MWIS SIM file
Date: Thu, 16 Jul 2015 15:02:17 +0200
Message-ID: <1437051738-11852-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6794559753566090567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/message-waiting.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index fc03d62..6d1b462 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -732,6 +732,7 @@ static void mw_set_indicator(struct ofono_message_waiti=
ng *mw, int profile,
 		efmwis[i + 1] =3D mw->messages[i].message_count;
 =

 	/* Fill in indicator state bits in byte 0 */
+	efmwis[0] =3D 0;
 	for (i =3D 0; i < 5 && i < mw->efmwis_length - 1; i++)
 		if (mw->messages[i].indication)
 			efmwis[0] |=3D 1 << i;
-- =

2.1.4


--===============6794559753566090567==--

