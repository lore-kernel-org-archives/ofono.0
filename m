Content-Type: multipart/mixed; boundary="===============2017591915906618628=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] ofono.rules: Add rules for SpeedUp 8000 modem
Date: Tue, 12 Jul 2011 16:33:29 +0200
Message-ID: <1310481209-5805-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2017591915906618628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 27615cc..0f4f85d 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -369,6 +369,10 @@ ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"98=
00", ENV{OFONO_IFACE_NUM}=3D=3D"02", E
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
 =

+# SpeedUp 8000
+ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
+
 LABEL=3D"ofono_tty_end"
 =

 # ISI/Phonet drivers
@@ -414,6 +418,10 @@ ATTRS{idVendor}=3D=3D"1c9e", ENV{OFONO_DRIVER}=3D"spee=
dup"
 =

 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
 =

+ATTRS{idVendor}=3D=3D"2020", ENV{OFONO_DRIVER}=3D"speedup"
+
+ATTRS{idVendor}=3D=3D"2020", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
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

--===============2017591915906618628==--

