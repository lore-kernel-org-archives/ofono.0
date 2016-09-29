Content-Type: multipart/mixed; boundary="===============6941971913621275970=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@collabora.co.uk>
Subject: [PATCH 2/2] udevng: Detect huawei E3372 modem and pcui
Date: Thu, 29 Sep 2016 09:52:58 +0200
Message-ID: <1475135578-26864-3-git-send-email-frederic.dalleau@collabora.co.uk>
In-Reply-To: <1475135578-26864-1-git-send-email-frederic.dalleau@collabora.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6941971913621275970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the modes are modified with AT^SETPORT=3D"FF;12,1,16", this modem
and pcui will appear using different ids. Update the interfaces
identifier accordingly.

Signed-off-by: Fr=C3=A9d=C3=A9ric Dalleau <frederic.dalleau@collabora.co.=
uk>
---
 plugins/udevng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 1a85246..933bf4f 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -325,12 +325,14 @@ static gboolean setup_huawei(struct modem_info *modem)
 		if (g_strcmp0(info->label, "modem") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/1") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/2/1") =3D=3D 0 ||
+				g_strcmp0(info->interface, "255/3/1") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/49") =3D=3D 0) {
 			mdm =3D info->devnode;
 		} else if (g_strcmp0(info->label, "pcui") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/2") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/2/2") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/2/18") =3D=3D 0 ||
+				g_strcmp0(info->interface, "255/3/18") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/50") =3D=3D 0) {
 			pcui =3D info->devnode;
 		} else if (g_strcmp0(info->label, "diag") =3D=3D 0 ||
-- =

2.7.4


--===============6941971913621275970==--

