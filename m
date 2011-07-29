Content-Type: multipart/mixed; boundary="===============1229215834312002714=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] udev: add support for Olive V-ME101 HSIA modem
Date: Fri, 29 Jul 2011 15:14:46 +0200
Message-ID: <1311945286-5920-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1229215834312002714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index bcfd56d..3434bef 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -385,6 +385,10 @@ ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e=
00", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
 =

+# Olive
+ATTRS{idVendor}=3D=3D"201e", ATTRS{idProduct}=3D=3D"2009", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
+ATTRS{idVendor}=3D=3D"201e", ATTRS{idProduct}=3D=3D"2009", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
+
 LABEL=3D"ofono_tty_end"
 =

 # ISI/Phonet drivers
@@ -440,6 +444,9 @@ ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"100=
8", ENV{OFONO_DRIVER}=3D"speedup"
 =

 ATTRS{idVendor}=3D=3D"2020", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
 =

+# Olive
+ATTRS{idVendor}=3D=3D"201e", ENV{OFONO_DRIVER}=3D"huaweicdma"
+
 # Option Globetrotter
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"6911", ENV{OFONO_DRIVE=
R}=3D"hso"
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"6971", ENV{OFONO_DRIVE=
R}=3D"hso"
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

--===============1229215834312002714==--

