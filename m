Content-Type: multipart/mixed; boundary="===============7390039035041623205=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 4/4] udev: Add bootstrapping for n950 plugin
Date: Mon, 14 May 2012 21:03:11 +0300
Message-ID: <1337018591-6553-4-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1337018591-6553-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7390039035041623205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 8cb87a5..fe18450 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -278,6 +278,8 @@ done:
 		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "n900") =3D=3D 0)
 		add_isi(modem, udev_device);
+	else if (g_strcmp0(driver, "n950") =3D=3D 0)
+		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "calypso") =3D=3D 0)
 		add_calypso(modem, udev_device);
 	else if (g_strcmp0(driver, "tc65") =3D=3D 0)
-- =

1.7.5.4


--===============7390039035041623205==--

