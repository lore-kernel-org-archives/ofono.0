Content-Type: multipart/mixed; boundary="===============3989602176274840820=="
MIME-Version: 1.0
From: ext-arun.1.ravindran@nokia.com
Subject: [PATCH] Isimodem: Crash while setting SCA
Date: Fri, 11 Mar 2011 14:49:55 +0200
Message-ID: <1299847795-9935-1-git-send-email-ext-arun.1.ravindran@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3989602176274840820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>

---
 drivers/isimodem/sms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 957b342..c90c06d 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -292,7 +292,7 @@ static void isi_sca_set(struct ofono_sms *sms,
 		{ &sd->params, sizeof(sd->params) },
 	};
 =

-	if (cbd =3D=3D NULL || sd =3D=3D NULL)
+	if (cbd =3D=3D NULL || sd =3D=3D NULL || sd->sim =3D=3D NULL)
 		goto error;
 =

 	bcd =3D sd->params.sca;
-- =

1.7.0.4


--===============3989602176274840820==--

