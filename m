Content-Type: multipart/mixed; boundary="===============6355596412001750344=="
MIME-Version: 1.0
From: Torgny Johansson <torgny.johansson@ericsson.com>
Subject: [PATCH] Add Ericsson c3607w and HP f3607gw/f3307 devices to udev
 rules file
Date: Tue, 12 Oct 2010 14:41:03 +0200
Message-ID: <1286887263-24639-1-git-send-email-torgny.johansson@ericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6355596412001750344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 0f0f1fc..f46d198 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -380,6 +380,10 @@ ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"19=
04", ENV{OFONO_DRIVER}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"1905", ENV{OFONO_DRIVE=
R}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"1906", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

+# Ericsson c3607w
+ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"190b", ENV{OFONO_DRIVE=
R}=3D"mbm"
+ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"1049", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
 # Ericsson F3307
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"190a", ENV{OFONO_DRIVE=
R}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"1909", ENV{OFONO_DRIVE=
R}=3D"mbm"
@@ -398,6 +402,18 @@ ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"81=
84", ENV{OFONO_DRIVER}=3D"mbm"
 ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"818b", ENV{OFONO_DRIVE=
R}=3D"mbm"
 ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"818c", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

+# HP hs2330 Mobile Broadband Module
+ATTRS{idVendor}=3D=3D"03f0", ATTRS{idProduct}=3D=3D"271d", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
+# HP hs2320 Mobile Broadband Module
+ATTRS{idVendor}=3D=3D"03f0", ATTRS{idProduct}=3D=3D"261d", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
+# HP lc2000 Mobile Broadband Module
+ATTRS{idVendor}=3D=3D"03f0", ATTRS{idProduct}=3D=3D"301d", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
+# HP lc2010 Mobile Broadband Module
+ATTRS{idVendor}=3D=3D"03f0", ATTRS{idProduct}=3D=3D"2f1d", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
 # Toshiba
 ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"130b", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

-- =

1.7.0.4


--===============6355596412001750344==--

