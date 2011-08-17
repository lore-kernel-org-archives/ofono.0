Content-Type: multipart/mixed; boundary="===============2600265315037132441=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] udev: Fix typo for Huawei diagnostic interfaces
Date: Tue, 16 Aug 2011 18:50:05 -0700
Message-ID: <1313545805-20202-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2600265315037132441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/udevng.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 78682ff..1365bd1 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -259,7 +259,7 @@ static gboolean setup_huawei(struct modem_info *modem)
 				break;
 		} else if (g_strcmp0(info->label, "diag") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/3") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/2/2") =3D=3D 0) {
+				g_strcmp0(info->interface, "255/2/3") =3D=3D 0) {
 			diag =3D info->devnode;
 			if (mdm !=3D NULL && pcui !=3D NULL)
 				break;
-- =

1.7.4.4


--===============2600265315037132441==--

