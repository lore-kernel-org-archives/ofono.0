Content-Type: multipart/mixed; boundary="===============5383749332214874040=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] rules: Add ofono rules for ZTE MF190
Date: Mon, 11 Jul 2011 14:16:56 +0200
Message-ID: <1310386616-12834-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5383749332214874040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 1fcdddb..794a02d 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -24,6 +24,9 @@ ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0063"=
, ENV{OFONO_IFACE_NUM}=3D=3D"01", E
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0117", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0117", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{OFONO_IFACE=
_NUM}=3D=3D"04", ENV{OFONO_ZTE_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
+
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

-- =

1.7.1


--===============5383749332214874040==--

