Content-Type: multipart/mixed; boundary="===============6543148613639174627=="
MIME-Version: 1.0
From: Torgny Johansson <torgny.johansson@ericsson.com>
Subject: [PATCH] add vid/pid for Dell 5541 and 5542
Date: Fri, 30 Apr 2010 15:14:05 +0200
Message-ID: <201004301514.06053.torgny.johansson@ericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6543148613639174627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

The following patch adds two new devices in the ofono.rules file:

Regards
Torgny Johansson

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index e6da49d..0575362 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -42,6 +42,10 @@ ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"8147=
", =

ENV{OFONO_DRIVER}=3D"mbm"
 ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"8183", ENV{OFONO_DRIVE=
R}=3D"mbm"
 ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"8184", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

+# Dell F3307
+ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"818b", ENV{OFONO_DRIVE=
R}=3D"mbm"
+ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"818c", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
 # Toshiba
 ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"130b", ENV{OFONO_DRIVE=
R}=3D"mbm"
=20

--===============6543148613639174627==--

