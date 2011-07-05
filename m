Content-Type: multipart/mixed; boundary="===============1445770159676510395=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/2] rules: Add ofono rule for ZTE modem MF180
Date: Tue, 05 Jul 2011 10:47:12 +0200
Message-ID: <1309855633-14468-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1309855633-14468-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1445770159676510395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 7124143..864cf63 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -21,6 +21,9 @@ ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0031"=
, ENV{OFONO_IFACE_NUM}=3D=3D"01", E
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0063", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0063", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0117", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_ZTE_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0117", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
+
 # Generic 0x1001
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1001", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1001", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
-- =

1.7.1


--===============1445770159676510395==--

