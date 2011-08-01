Content-Type: multipart/mixed; boundary="===============2808117178391264956=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] udev: switch ttys for SpeedUp 8000.
Date: Mon, 01 Aug 2011 14:25:55 +0200
Message-ID: <1312201555-1396-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2808117178391264956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On SpeedUp 8000, notifications are received only on ttyUSB1.
So we must use this tty for aux, and use ttyUSB3 for modem.
---
 plugins/ofono.rules |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 3434bef..467f342 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -382,8 +382,8 @@ ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e0=
0", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
 =

 # SpeedUp 8000
-ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
-ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
+ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
 =

 # Olive
 ATTRS{idVendor}=3D=3D"201e", ATTRS{idProduct}=3D=3D"2009", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
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

--===============2808117178391264956==--

