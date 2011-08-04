Content-Type: multipart/mixed; boundary="===============2324342936426609538=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] udev: add support for Olive HSDPA modem,
 which seems to be a SpeedUP.
Date: Thu, 04 Aug 2011 15:06:04 +0200
Message-ID: <1312463164-5817-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2324342936426609538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 27a6316..4e697af 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -385,7 +385,10 @@ ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"98=
00", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"00", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
 =

-# SpeedUp 8000
+# SpeedUp
+ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1005", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1005", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
+
 ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
 =

@@ -446,8 +449,8 @@ ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"980=
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

--===============2324342936426609538==--

