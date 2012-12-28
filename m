Content-Type: multipart/mixed; boundary="===============8312076651862092058=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 6/8] sierra: Initialize GSM error reporting separately
Date: Fri, 28 Dec 2012 14:36:00 -0500
Message-ID: <20121228193600.GL18339@alittletooquiet.net>
In-Reply-To: <20121228193141.GF18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8312076651862092058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

---
 plugins/sierra.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/sierra.c b/plugins/sierra.c
index 4e125d7..a458e38 100644
--- a/plugins/sierra.c
+++ b/plugins/sierra.c
@@ -144,8 +144,9 @@ static int sierra_enable(struct ofono_modem *modem)
 	if (data->modem =3D=3D NULL)
 		return -EINVAL;
 =

-	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL,
-						NULL, NULL, NULL);
+	g_at_chat_send(data->modem, "ATE0 &C0", NULL, NULL, NULL, NULL);
+	/* This is separate because it is not supported by all modems. */
+	g_at_chat_send(data->modem, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
 =

 	g_at_chat_send(data->modem, "AT+CFUN=3D4", none_prefix,
 					cfun_enable, modem, NULL);
-- =

1.7.0.4

--===============8312076651862092058==--

