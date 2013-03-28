Content-Type: multipart/mixed; boundary="===============7078632670315057094=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv4 1/8] hfpmodem: Add modem vendor stub
Date: Thu, 28 Mar 2013 14:36:55 +0100
Message-ID: <1d65943189c7e91e69bd00b20436479753e360d9.1364477353.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1364477353.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7078632670315057094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

---
 drivers/hfpmodem/vendor.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 drivers/hfpmodem/vendor.h

diff --git a/drivers/hfpmodem/vendor.h b/drivers/hfpmodem/vendor.h
new file mode 100644
index 0000000..fca847a
--- /dev/null
+++ b/drivers/hfpmodem/vendor.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013  BWM Car IT GmbH. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+enum ofono_vendor {
+	OFONO_VENDOR_GENERIC =3D 0
+};
-- =

1.7.11.7


--===============7078632670315057094==--

