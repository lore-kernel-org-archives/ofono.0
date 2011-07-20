Content-Type: multipart/mixed; boundary="===============5580808327706212608=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] ofono.rules: Add rules for Tata ZTE MF 631
Date: Wed, 20 Jul 2011 07:41:20 +0200
Message-ID: <1311140480-3116-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5580808327706212608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 1aef4bd..9791203 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -37,6 +37,9 @@ ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0121"=
, ENV{OFONO_IFACE_NUM}=3D=3D"01", E
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{OFONO_IFACE=
_NUM}=3D=3D"04", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"2003", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_ZTE_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"2003", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
+
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

--===============5580808327706212608==--

