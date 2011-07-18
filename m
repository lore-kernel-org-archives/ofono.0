Content-Type: multipart/mixed; boundary="===============3311406063140778131=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] ofono.rules: Add rules for Reliance ZTE MF 688
Date: Mon, 18 Jul 2011 16:33:17 +0200
Message-ID: <1310999597-10590-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3311406063140778131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 36574ba..1aef4bd 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -16,6 +16,9 @@ ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"6880"=
, ENV{OFONO_IFACE_NUM}=3D=3D"03", E
 ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"6890", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_SIERRA_TYPE}=3D"modem"
 =

 # ZTE
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0016", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_ZTE_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0016", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
+
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
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

--===============3311406063140778131==--

