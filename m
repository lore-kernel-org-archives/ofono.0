Content-Type: multipart/mixed; boundary="===============9152320459617549726=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/3] udev: use ttyUSB3 for ZTE K3570 modem port.
Date: Thu, 11 Aug 2011 17:38:22 +0200
Message-ID: <1313077104-13397-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1313077104-13397-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9152320459617549726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 4143e17..82232d9 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -35,7 +35,7 @@ ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0121"=
, ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"04", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

-ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"02", ENV{OFONO_ZTE_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_ZTE_TYPE}=3D"modem"
 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"1008", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
 =

 ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"2003", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_ZTE_TYPE}=3D"modem"
-- =

1.7.1


--===============9152320459617549726==--

