Content-Type: multipart/mixed; boundary="===============7863557449183234141=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [V3 PATCH 3/3] Huawei: set Huawei EM770W modem device to 00
Date: Sat, 12 Feb 2011 17:41:15 +0800
Message-ID: <1297503675-32491-3-git-send-email-martin.xu@intel.com>
In-Reply-To: <1297503675-32491-2-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7863557449183234141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Xu <martin.xu@intel.com>

Device 00 is ppp port. Setting it as 01, my Huawei EM770W modem PPP
connection can't work
---
 plugins/ofono.rules |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 111f071..7dec243 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -37,7 +37,7 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1401"=
, ENV{OFONO_IFACE_NUM}=3D=3D"02", E
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 =

-ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_HUAWE=
I_VOICE}=3D"1"
 =

-- =

1.6.1.3


--===============7863557449183234141==--

