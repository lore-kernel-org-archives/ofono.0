Content-Type: multipart/mixed; boundary="===============1854061243283130248=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] rules: Add oFono rule for SpeedUp 7300 modem
Date: Mon, 11 Jul 2011 18:37:24 +0200
Message-ID: <1310402244-5998-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1854061243283130248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 794a02d..27615cc 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -365,6 +365,10 @@ ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"10=
04", ENV{OFONO_IFACE_NUM}=3D=3D"03", E
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
 =

+# SpeedUp 7300
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
+
 LABEL=3D"ofono_tty_end"
 =

 # ISI/Phonet drivers
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

--===============1854061243283130248==--

