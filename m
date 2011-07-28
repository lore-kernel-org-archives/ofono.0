Content-Type: multipart/mixed; boundary="===============3010736555362288816=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] udev: assign "huaweicdma" OFONO_DRIVER for E156 dongle
Date: Thu, 28 Jul 2011 16:49:59 +0200
Message-ID: <1311864599-10607-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3010736555362288816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |  217 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 216 insertions(+), 1 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index f8e485b..94eb061 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -412,7 +412,222 @@ ATTRS{idVendor}=3D=3D"1199", ENV{OFONO_DRIVER}=3D"sie=
rra"
 ATTRS{idVendor}=3D=3D"1199", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
 =

 # HUAWEI Technology
-ATTRS{idVendor}=3D=3D"12d1", ENV{OFONO_DRIVER}=3D"huawei"
+
+# Generic 0x1001
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1001", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+# Generic 0x1003
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1003", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1401", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1405", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1406", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1408", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1409", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"140a", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+# E156
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"140b", ENV{OFONO_DRIVE=
R}=3D"huaweicdma"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"140c", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"140d", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"140e", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"140f", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+# E510
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1411", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1412", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1413", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1414", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1415", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1416", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1417", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1418", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1419", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"141a", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"141b", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"141c", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"141d", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"141e", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"141f", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1420", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1421", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1422", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1427", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1428", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1429", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"142a", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1448", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1433", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1434", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1436", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1438", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1439", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"143a", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"143b", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"143e", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"14ac", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1450", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1451", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1452", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1453", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1454", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1455", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1456", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1457", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1458", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1459", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"145a", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"145b", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"145c", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"145d", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"145e", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"145f", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1460", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1461", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1462", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1463", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+# K4505
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1464", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+# K3765
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1465", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1466", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1467", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1468", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1469", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"146a", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"146b", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"146c", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"146d", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"146e", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"146f", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1470", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1471", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1472", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1473", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1474", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1475", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1476", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1477", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1478", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1479", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147a", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147b", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147c", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147d", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147e", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147f", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1480", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1481", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1482", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1483", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1484", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1485", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1506", ENV{OFONO_DRIVE=
R}=3D"huawei"
+
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1c05", ENV{OFONO_DRIVE=
R}=3D"huawei"
 =

 # Qualcomm Incorporated
 ATTRS{idVendor}=3D=3D"05c6", ENV{OFONO_DRIVER}=3D"gobi"
-- =

1.7.1


--===============3010736555362288816==--

