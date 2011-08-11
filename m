Content-Type: multipart/mixed; boundary="===============2033385445789646970=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/3] udev: Use ttyUSB4 for Huawei E367 Pcui port
Date: Thu, 11 Aug 2011 17:38:24 +0200
Message-ID: <1313077104-13397-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1313077104-13397-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2033385445789646970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index a361e70..5e59425 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -363,7 +363,7 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"148=
6", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 =

 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1506", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
-ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1506", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1506", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"04", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 =

 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1c05", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1c05", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
-- =

1.7.1


--===============2033385445789646970==--

