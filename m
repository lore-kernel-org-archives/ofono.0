Content-Type: multipart/mixed; boundary="===============8648127597038880561=="
MIME-Version: 1.0
From: Torgny Johansson <torgny.johansson@ericsson.com>
Subject: [PATCH] Additional vid/pids to udev rules file
Date: Mon, 06 Dec 2010 14:17:19 +0100
Message-ID: <1291641439-20664-1-git-send-email-torgny.johansson@ericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8648127597038880561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index da8a8ef..b9cd486 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -390,6 +390,9 @@ ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"104=
9", ENV{OFONO_DRIVER}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"190a", ENV{OFONO_DRIVE=
R}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"1909", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

+# Ericsson F3307 R2
+ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"1914", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
 # Ericsson F5521gw
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"190d", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

@@ -407,6 +410,9 @@ ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"818=
4", ENV{OFONO_DRIVER}=3D"mbm"
 ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"818b", ENV{OFONO_DRIVE=
R}=3D"mbm"
 ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"818c", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

+# Dell 5550
+ATTRS{idVendor}=3D=3D"413c", ATTRS{idProduct}=3D=3D"818d", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
 # HP hs2330 Mobile Broadband Module
 ATTRS{idVendor}=3D=3D"03f0", ATTRS{idProduct}=3D=3D"271d", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

@@ -426,6 +432,15 @@ ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"13=
0b", ENV{OFONO_DRIVER}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"130c", ENV{OFONO_DRIVE=
R}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"1311", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

+# Toshiba F3307 R2
+ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"1315", ENV{OFONO_DRIVE=
R}=3D"mbm"
+ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"1316", ENV{OFONO_DRIVE=
R}=3D"mbm"
+ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"1317", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
+# Toshiba F5521gw
+ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"1313", ENV{OFONO_DRIVE=
R}=3D"mbm"
+ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"1314", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
 # Nokia Internet Stick CS-10
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"060e", ENV{OFONO_DRIVE=
R}=3D"nokia"
 =

-- =

1.7.1


--===============8648127597038880561==--

