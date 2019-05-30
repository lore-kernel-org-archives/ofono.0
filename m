Content-Type: multipart/mixed; boundary="===============4304524354058084029=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/4] netmon: adding method to fetch neighbouring cell
 mesurement
Date: Thu, 30 May 2019 14:50:31 +0530
Message-ID: <1559208031-3447-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4304524354058084029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added new method to fetch neighbouring cell information.
---
 doc/networkmonitor-api.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/networkmonitor-api.txt b/doc/networkmonitor-api.txt
index f8cc1c2..1cc73d2 100644
--- a/doc/networkmonitor-api.txt
+++ b/doc/networkmonitor-api.txt
@@ -22,6 +22,23 @@ Methods		a{sv} GetServingCellInformation()
 			are available, their valid value ranges and
 			applicability to different cell types.
 =

+			a{a{sv}} GetNeighbouringCellsInformation()
+
+			Requests the neighbouring cells information and basic
+			measurements from oFono.  The returned value is a
+			dictionary with the possible key / values documented
+			below.  The type of cell is given by the 'Technology'
+			property.
+
+			Based on the type of cell, the dictionary will contain
+			additional key/value pairs.  If a given key/value pair
+			is not present, then it is not known or unsupported
+			by the underlying driver.
+
+			Refer to the sections below for which property types
+			are available, their valid value ranges and
+			applicability to different cell types.
+
 		void RegisterAgent(object path)
 =

 			Registers an agent which will be called whenever the
-- =

1.9.1


--===============4304524354058084029==--

