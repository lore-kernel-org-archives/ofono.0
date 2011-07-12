Content-Type: multipart/mixed; boundary="===============3811057359001628630=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] rules: Add oFono rule for ZTE MF 637 modem
Date: Tue, 12 Jul 2011 17:09:00 +0200
Message-ID: <1310483340-7830-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3811057359001628630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 0f4f85d..876a2f8 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -15,6 +15,10 @@ ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"683c=
", ENV{OFONO_IFACE_NUM}=3D=3D"03", E
 ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"6880", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_SIERRA_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"6890", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_SIERRA_TYPE}=3D"modem"
 =

+# ZTE =

+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_ZTE_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
+
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0031", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0031", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

@@ -24,12 +28,12 @@ ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"006=
3", ENV{OFONO_IFACE_NUM}=3D=3D"01", E
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0117", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0117", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0121", ENV{OFONO_IFACE=
_NUM}=3D=3D"04", ENV{OFONO_ZTE_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0121", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
+
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{OFONO_IFACE=
_NUM}=3D=3D"04", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

-ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_ZTE_TYPE}=3D"modem"
-ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
-
 # Generic 0x1001
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1001", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1001", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
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

--===============3811057359001628630==--

