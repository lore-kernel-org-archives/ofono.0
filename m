Content-Type: multipart/mixed; boundary="===============8059033818243010332=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: [PATCH] Added udev rules for Option GI0201 and Option GTM382 modems.
Date: Wed, 25 Nov 2009 09:38:25 +0200
Message-ID: <4B0CDEF1.3030907@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8059033818243010332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index ca00673..3db0cf4 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -11,8 +11,10 @@ ATTRS{idVendor}=3D=3D"12d1", ENV{OFONO_DRIVER}=3D"huawei"
 ATTRS{idVendor}=3D=3D"1410", ENV{OFONO_DRIVER}=3D"novatel"

 # Option Globetrotter
+ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"6911", ENV{OFONO_DRIVE=
R}=3D"hso"
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"6971", ENV{OFONO_DRIVE=
R}=3D"hso"
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"7401", ENV{OFONO_DRIVE=
R}=3D"hso"
+ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"7601", ENV{OFONO_DRIVE=
R}=3D"hso"

 # Ericsson F3507g
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"1900", ENV{OFONO_DRIVE=
R}=3D"mbm"
--
1.6.3.3

--===============8059033818243010332==--

