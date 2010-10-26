Content-Type: multipart/mixed; boundary="===============0579935985436766735=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 6/6] TODO: mark fast dormancy as done
Date: Tue, 26 Oct 2010 18:31:53 +0300
Message-ID: <1288107113-2740-7-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1288107113-2740-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0579935985436766735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |   20 --------------------
 doc/features.txt |    8 ++++++++
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/TODO b/TODO
index 239bab0..6ac9cea 100644
--- a/TODO
+++ b/TODO
@@ -504,26 +504,6 @@ Miscellaneous
   Priority: Medium
   Complexity: C2
 =

-- Add a property for Fast Dormancy in the RadioSettings atom. This property
-  will enable or disable Fast Dormancy. Fast Dormancy refers to UE initiat=
ed
-  release of radio resources quickly after a burst of data transfer has en=
ded.
-  Normally, radio resources are released by the network after a timeout
-  configured by the network operator. Fast Dormancy allows the modem to re=
lease
-  radio resources more quickly. Typically, fast dormancy would be enabled
-  if no data transfer is predicted to occur in the near future (e.g. end u=
ser
-  is not actively using the device). This is a major power-saving feature =
for
-  mobile devices, but can be ignored for USB sticks or PCI devices.
-
-  If the modem does not support such a feature the property should never be
-  exposed to the user.
-
-  This feature is not discussed in 27.007, thus manufacturer specific comm=
ands
-  are required.
-
-  Priority: High
-  Complexity: C1
-  Owner: Mika Liljeberg <mika.liljeberg@nokia.com>
-
 - TTY (hearing impaired) support.  Add a new oFono atom type that will ena=
ble
   the user to enable or disable the TTY support on the modem.  Support for
   automatic detection of TTY (signaled by the driver) is also desired.
diff --git a/doc/features.txt b/doc/features.txt
index 2acd352..d6365a2 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -147,3 +147,11 @@ SIM
   check if BDN support is allocated and enabled in the SIM.  If enabled,
   oFono halts the SIM initialization procedure and the modem remains in the
   PRESIM state.  In this state oFono will only allow emergency calls.
+
+Radio settings
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Fast dormancy support. A fast dormancy feature can be enabled in the
+  cellular modem to conserve power when the end user is not actively
+  using the device but some networking applications are online using
+  packet data.
-- =

1.7.0.4


--===============0579935985436766735==--

