Content-Type: multipart/mixed; boundary="===============5570083555976412178=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH] rildev: Do not create modems if no env var set
Date: Thu, 15 Oct 2015 16:12:26 +0200
Message-ID: <1444918346-17212-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5570083555976412178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do not create rilmodem instances if the environment variable
OFONO_RIL_DEVICE is not set.
---
 plugins/rildev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/rildev.c b/plugins/rildev.c
index 461324d..f4cea6f 100644
--- a/plugins/rildev.c
+++ b/plugins/rildev.c
@@ -93,7 +93,7 @@ static int detect_init(void)
 =

 	ril_type =3D getenv("OFONO_RIL_DEVICE");
 	if (ril_type =3D=3D NULL)
-		ril_type =3D "ril";
+		return 0;
 =

 	/* Check for multi-SIM support */
 	multi_sim =3D getenv("OFONO_RIL_NUM_SIM_SLOTS");
-- =

2.1.4


--===============5570083555976412178==--

