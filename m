Content-Type: multipart/mixed; boundary="===============4426848109834490422=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH] TODO: Set number of significant digits in settings
Date: Wed, 12 Sep 2012 17:33:30 +0200
Message-ID: <1347464010-30242-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4426848109834490422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch concerns mmsd.
The number of significant digits is country dependant, mmsd cannot know the
local numbering plan and so needs this information from the upper layer.

---
 TODO |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/TODO b/TODO
index 6e54f6f..3635a2f 100644
--- a/TODO
+++ b/TODO
@@ -63,6 +63,19 @@ MMS Delivery Report
   Owner: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>


+MMS Settings
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Add an entry in MMS settings file to set number of significant digits
+  (i.e.: last digits of the phone number).
+  Use this value to match international and local phone number when dealin=
g with
+  conversation or delivery report.
+
+  Priority: Medium
+  Complexity: C2
+  Owner:
+
+
 D-Bus API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D

--
1.7.9.5


--===============4426848109834490422==--

