Content-Type: multipart/mixed; boundary="===============7301569773746554784=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: [PATCH 4/4] udev: Add support for ehs6 name
Date: Tue, 12 May 2015 18:23:02 +0100
Message-ID: <1431451382-7788-4-git-send-email-ajlennon@dynamicdevices.co.uk>
In-Reply-To: <1431451382-7788-1-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7301569773746554784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As with tc65, ehs6 makes use of cinterion plugin
---
 plugins/udev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udev.c b/plugins/udev.c
index 6330228..3c90e40 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -245,6 +245,8 @@ static void add_modem(struct udev_device *udev_device)
 =

 		if(g_strcmp0(driver, "tc65") =3D=3D 0)
 			driver =3D "cinterion";
+		if(g_strcmp0(driver, "ehs6") =3D=3D 0)
+			driver =3D "cinterion";
 =

 		modem =3D ofono_modem_create(NULL, driver);
 		if (modem =3D=3D NULL)
-- =

1.9.1


--===============7301569773746554784==--

