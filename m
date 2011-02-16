Content-Type: multipart/mixed; boundary="===============6648780286813595981=="
MIME-Version: 1.0
From: Jan Luebbe <jluebbe@debian.org>
Subject: [PATCH] plugins/ofono.rules: add ID for Sierra Wireless MC8790
Date: Wed, 16 Feb 2011 16:34:49 +0100
Message-ID: <1297870489-2092-1-git-send-email-jluebbe@debian.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6648780286813595981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 111f071..f381881 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -11,6 +11,7 @@ SUBSYSTEMS=3D=3D"usb", ATTRS{bInterfaceNumber}=3D=3D"?*",=
 ATTRS{bInterfaceClass}=3D=3D"ff",
 ATTRS{idVendor}=3D=3D"05c6", ATTRS{idProduct}=3D=3D"9205", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_GOBI_TYPE}=3D"modem"
 =

 # Sierra Wireless HSPA Modem
+ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"683c", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_SIERRA_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"6880", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_SIERRA_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"6890", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_SIERRA_TYPE}=3D"modem"
 =

-- =

1.7.2.3


--===============6648780286813595981==--

