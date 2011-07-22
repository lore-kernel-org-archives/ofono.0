Content-Type: multipart/mixed; boundary="===============5935313932925435190=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] udev: add support for SpeedUp CDMA dongles.
Date: Fri, 22 Jul 2011 05:57:20 +0200
Message-ID: <1311307040-10346-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5935313932925435190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index a28bea7..b50ca2f 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -793,6 +793,8 @@ done:
 		add_linktop(modem, udev_device);
         else if (g_strcmp0(driver, "speedup") =3D=3D 0)
 		add_speedup(modem, udev_device);
+	else if (g_strcmp0(driver, "speedupcdma") =3D=3D 0)
+		add_speedup(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
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

--===============5935313932925435190==--

