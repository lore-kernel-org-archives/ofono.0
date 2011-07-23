Content-Type: multipart/mixed; boundary="===============8626820053482146337=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] udev: add support for Huawei CDMA dongles.
Date: Sat, 23 Jul 2011 06:45:50 +0200
Message-ID: <1311396350-15928-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8626820053482146337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index f2d89a7..1d9aaf2 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -767,6 +767,8 @@ done:
 		add_zte(modem, udev_device);
 	else if (g_strcmp0(driver, "huawei") =3D=3D 0)
 		add_huawei(modem, udev_device);
+	else if (g_strcmp0(driver, "huaweicdma") =3D=3D 0)
+		add_huawei(modem, udev_device);
 	else if (g_strcmp0(driver, "sierra") =3D=3D 0)
 		add_sierra(modem, udev_device);
 	else if (g_strcmp0(driver, "novatel") =3D=3D 0)
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============8626820053482146337==--

