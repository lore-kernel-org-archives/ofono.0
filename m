Content-Type: multipart/mixed; boundary="===============6553221278569269279=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isimodem: fix crash in sms driver
Date: Tue, 01 Feb 2011 22:37:09 +0200
Message-ID: <1296592629-31227-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6553221278569269279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/sms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index ded7d9c..c2172f7 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -248,7 +248,7 @@ static void isi_sca_query(struct ofono_sms *sms,
 		1,	/* Location, default is 1 */
 	};
 =

-	if (cbd =3D=3D NULL || sd =3D=3D NULL)
+	if (cbd =3D=3D NULL || sd =3D=3D NULL || sd->sim =3D=3D NULL)
 		goto error;
 =

 	if (g_isi_client_send(sd->sim, msg, sizeof(msg),
-- =

1.7.1


--===============6553221278569269279==--

