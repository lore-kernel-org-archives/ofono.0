Content-Type: multipart/mixed; boundary="===============0072199920358746741=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: [PATCH 3/4] udevng: support Huawei QMI modems on newer kernels
Date: Sun, 03 Feb 2013 22:39:46 +0100
Message-ID: <1359927587-24353-4-git-send-email-bjorn@mork.no>
In-Reply-To: <1359927587-24353-1-git-send-email-bjorn@mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0072199920358746741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
 plugins/udevng.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 9fee7c2..d27dd67 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -324,7 +324,10 @@ static gboolean setup_huawei(struct modem_info *modem)
 			net =3D info->devnode;
 		} else if (g_strcmp0(info->interface, "255/1/9") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/57") =3D=3D 0) {
-			qmi =3D info->devnode;
+			if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+				net =3D info->devnode;
+			else
+				qmi =3D info->devnode;
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
 			if (g_strcmp0(info->number, "00") =3D=3D 0)
 				mdm =3D info->devnode;
-- =

1.7.10.4


--===============0072199920358746741==--

