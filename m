Content-Type: multipart/mixed; boundary="===============1482318960198984819=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/3] udev:  add support for Olive HSDPA modem
Date: Thu, 11 Aug 2011 17:38:23 +0200
Message-ID: <1313077104-13397-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1313077104-13397-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1482318960198984819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 82232d9..a361e70 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -376,9 +376,12 @@ ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"98=
00", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"00", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
 =

-# SpeedUp 8000
-ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
-ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
+# SpeedUp
+ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1005", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1005", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
+
+ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
 =

 # Olive
 ATTRS{idVendor}=3D=3D"201e", ATTRS{idProduct}=3D=3D"2009", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
@@ -434,8 +437,8 @@ ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"980=
0", ENV{OFONO_DRIVER}=3D"speedup"
 =

 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
 =

-# SpeedUp 8000
-ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{OFONO_DRIVE=
R}=3D"speedup"
+# SpeedUp
+ATTRS{idVendor}=3D=3D"2020", ENV{OFONO_DRIVER}=3D"speedup"
 =

 ATTRS{idVendor}=3D=3D"2020", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
 =

-- =

1.7.1


--===============1482318960198984819==--

