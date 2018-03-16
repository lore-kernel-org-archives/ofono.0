Content-Type: multipart/mixed; boundary="===============2077871129224913847=="
MIME-Version: 1.0
From: Bassem Boubaker <bassem.boubaker@actia.fr>
Subject: [PATCH] gemalto: Add more details in setup_gemalto comment
Date: Fri, 16 Mar 2018 18:21:43 +0100
Message-ID: <1521220903-20723-1-git-send-email-bassem.boubaker@actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2077871129224913847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

	ALS3, PLS8-E and PLS8-X have same vid/pid with same enumeration process
---
 plugins/udevng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 6b5b015..ff5d41a 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1146,7 +1146,7 @@ static gboolean setup_gemalto(struct modem_info* mode=
m)
 				qmi =3D info->devnode;
 		}
 =

-		/* ALS3 */
+		/* Cinterion ALS3, PLS8-E, PLS8-X */
 		if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
 			if (g_strcmp0(info->number, "00") =3D=3D 0)
 				mdm =3D info->devnode;
-- =

2.7.4


--===============2077871129224913847==--

