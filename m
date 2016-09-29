Content-Type: multipart/mixed; boundary="===============8353517969664779358=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@collabora.co.uk>
Subject: [PATCH 1/2] udevng: Detect huawei E3372 pcui
Date: Thu, 29 Sep 2016 09:52:57 +0200
Message-ID: <1475135578-26864-2-git-send-email-frederic.dalleau@collabora.co.uk>
In-Reply-To: <1475135578-26864-1-git-send-email-frederic.dalleau@collabora.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8353517969664779358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The huawei E3372 exposes two USB tty at /dev/ttyUSB0 and /dev/ttyUSB1
/dev/ttyUSB1 is properly detected as modem.
/dev/ttyUSB0 is the pcui.

lsusb shows 12d1:1506 Huawei Technologies Co., Ltd. Modem/Networkcard

Signed-off-by: Fr=C3=A9d=C3=A9ric Dalleau <frederic.dalleau@collabora.co.=
uk>
---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 607e381..1a85246 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -330,6 +330,7 @@ static gboolean setup_huawei(struct modem_info *modem)
 		} else if (g_strcmp0(info->label, "pcui") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/2") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/2/2") =3D=3D 0 ||
+				g_strcmp0(info->interface, "255/2/18") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/50") =3D=3D 0) {
 			pcui =3D info->devnode;
 		} else if (g_strcmp0(info->label, "diag") =3D=3D 0 ||
-- =

2.7.4


--===============8353517969664779358==--

