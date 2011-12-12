Content-Type: multipart/mixed; boundary="===============2525114490055418934=="
MIME-Version: 1.0
From: marko.saukko@gmail.com
Subject: [PATCH 2/3] Add N950 to use isi driver.
Date: Mon, 12 Dec 2011 13:39:43 +0200
Message-ID: <1323689984-24866-3-git-send-email-marko.saukko@gmail.com>
In-Reply-To: <1323689984-24866-1-git-send-email-marko.saukko@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2525114490055418934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marko Saukko <marko.saukko@cybercom.com>

---
 plugins/udev.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index d0673f7..7de4530 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -265,6 +265,8 @@ done:
 		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "n900") =3D=3D 0)
 		add_isi(modem, udev_device);
+	else if (g_strcmp0(driver, "n950") =3D=3D 0)
+		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "calypso") =3D=3D 0)
 		add_calypso(modem, udev_device);
 	else if (g_strcmp0(driver, "tc65") =3D=3D 0)
-- =

1.7.6.4


--===============2525114490055418934==--

