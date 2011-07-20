Content-Type: multipart/mixed; boundary="===============2034516501432200220=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2] plugins: update ofono rule and udev for using speedupcdma
Date: Wed, 20 Jul 2011 12:51:21 +0200
Message-ID: <1311159081-13961-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2034516501432200220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    9 ++++++---
 plugins/udev.c      |    2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 1aef4bd..54df1bc 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -420,10 +420,13 @@ ATTRS{idVendor}=3D=3D"19d2", ENV{OFONO_DRIVER}=3D"zte"
 =

 ATTRS{idVendor}=3D=3D"19d2", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
 =

-# SpeedUp
-ATTRS{idVendor}=3D=3D"1c9e", ENV{OFONO_DRIVER}=3D"speedup"
+# SpeedUp 7300
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{OFONO_DRIVE=
R}=3D"speedupcdma"
+
+# SpeedUp 9800
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{OFONO_DRIVE=
R}=3D"speedup"
 =

-ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ATTRS{serial}=
=3D=3D"1234567890ABCDEF", ENV{ID_SERIAL_SHORT}=3D""
 =

 ATTRS{idVendor}=3D=3D"2020", ENV{OFONO_DRIVER}=3D"speedup"
 =

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

1.7.1


--===============2034516501432200220==--

