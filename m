Content-Type: multipart/mixed; boundary="===============1736721559318146654=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 1/3] TODO: Mark network initiated disconnection task as done
Date: Thu, 08 Dec 2011 10:58:16 +0100
Message-ID: <1323338298-4625-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1736721559318146654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    6 ------
 doc/features.txt |    6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/TODO b/TODO
index 159b325..63d28ab 100644
--- a/TODO
+++ b/TODO
@@ -570,9 +570,3 @@ CDMA Connection Manager
 =

   Priority: Medium
   Complexity: C4
-
-- Support Network Initiated disconnection of Packet Data Service over CDMA
-  (1xRTT and 1xEV-DO) systems.
-
-  Priority: Medium
-  Complexity: C2
diff --git a/doc/features.txt b/doc/features.txt
index ad4d176..d2bb171 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -684,3 +684,9 @@ Modem Emulator
 - Support for Bluetooth DUN profile.  oFono supports the Dial Up Networking
   profile and all mandatory commands specified by BT DUN 1.1.  For a list
   of supported commands please see doc/dialup-command-set.txt.
+
+CDMA Connection Manager
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Support Network Initiated disconnection of Packet Data Service over CDMA
+  (1xRTT and 1xEV-DO) systems.
-- =

1.7.1


--===============1736721559318146654==--

