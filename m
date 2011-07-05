Content-Type: multipart/mixed; boundary="===============0766537690928498316=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] rules: Add ofono rule for Huwaei modem E173
Date: Tue, 05 Jul 2011 17:16:56 +0200
Message-ID: <1309879016-9760-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0766537690928498316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 7124143..e585bae 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -344,6 +344,9 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"148=
5", ENV{OFONO_IFACE_NUM}=3D=3D"02", E
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 =

+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1c05", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1c05", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
+
 #Telit UC864-G
 ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_TELIT_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_TELIT_TYPE}=3D"GPS"
-- =

1.7.1


--===============0766537690928498316==--

