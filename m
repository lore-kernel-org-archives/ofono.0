Content-Type: multipart/mixed; boundary="===============7061209164804188362=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 6/6] plugins/udevng: use else if instead of if
Date: Thu, 07 Sep 2017 22:23:00 +0200
Message-ID: <20170907202300.23952-6-lynxis@fe80.eu>
In-Reply-To: <20170907202300.23952-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7061209164804188362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The same variable is checked in two `if's.
---
 plugins/udevng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index aa28bcb8911e..0f6ab2b21d77 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -261,7 +261,7 @@ static gboolean setup_sierra(struct modem_info *modem)
 		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
 			if (g_strcmp0(info->number, "01") =3D=3D 0)
 				diag =3D info->devnode;
-			if (g_strcmp0(info->number, "03") =3D=3D 0)
+			else if (g_strcmp0(info->number, "03") =3D=3D 0)
 				mdm =3D info->devnode;
 			else if (g_strcmp0(info->number, "04") =3D=3D 0)
 				app =3D info->devnode;
-- =

2.14.1


--===============7061209164804188362==--

