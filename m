Content-Type: multipart/mixed; boundary="===============5501345866047067417=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] udev: Add support for SpeedUp 7300 EVDO modem.
Date: Thu, 28 Jul 2011 13:50:01 +0200
Message-ID: <1311853801-16489-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5501345866047067417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index f8e485b..ab21f57 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -422,11 +422,15 @@ ATTRS{idVendor}=3D=3D"19d2", ENV{OFONO_DRIVER}=3D"zte"
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

 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
 =

+# SpeedUp 8000
 ATTRS{idVendor}=3D=3D"2020", ENV{OFONO_DRIVER}=3D"speedup"
 =

 ATTRS{idVendor}=3D=3D"2020", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
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

--===============5501345866047067417==--

