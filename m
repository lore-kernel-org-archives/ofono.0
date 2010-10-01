Content-Type: multipart/mixed; boundary="===============7227844580722707115=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH TODO 1/1] Take ownership of fast dormancy
Date: Fri, 01 Oct 2010 11:14:13 +0300
Message-ID: <1285920853-4004-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1285920853-4004-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7227844580722707115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/TODO b/TODO
index 643c828..6d9a7f0 100644
--- a/TODO
+++ b/TODO
@@ -517,11 +517,15 @@ Miscellaneous
   Priority: Medium
   Complexity: C2
 =

-- Add a property for Automatic Idle (sometimes referred to as Fast Dormanc=
y)
-  in the RadioSettings atom.  This property will enable or disable the use=
 of
-  automatic connection release by the modem for power consumption reasons.
-  This is a major power-saving feature for phones, but can be ignored for =
USB
-  sticks or PCI devices.
+- Add a property for Fast Dormancy in the RadioSettings atom. This property
+  will enable or disable Fast Dormancy. Fast Dormancy refers to UE initiat=
ed
+  release of radio resources quickly after a burst of data transfer has en=
ded.
+  Normally, radio resources are released by the network after a timeout
+  configured by the network operator. Fast Dormancy allows the modem to re=
lease
+  radio resources more quickly. Typically, fast dormancy would be enabled
+  if no data transfer is predicted to occur in the near future (e.g. end u=
ser
+  is not actively using the device). This is a major power-saving feature =
for
+  mobile devices, but can be ignored for USB sticks or PCI devices.
 =

   If the modem does not support such a feature the property should never be
   exposed to the user.
@@ -531,6 +535,7 @@ Miscellaneous
 =

   Priority: High
   Complexity: C1
+  Owner: Mika Liljeberg <mika.liljeberg@nokia.com>
 =

 - TTY (hearing impaired) support.  Add a new oFono atom type that will ena=
ble
   the user to enable or disable the TTY support on the modem.  Support for
-- =

1.7.0.4


--===============7227844580722707115==--

