Content-Type: multipart/mixed; boundary="===============0855563015790063882=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 3/3] TODO: Mark RSSI measurement task as done
Date: Thu, 08 Dec 2011 10:58:18 +0100
Message-ID: <1323338298-4625-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323338298-4625-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0855563015790063882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    6 ------
 doc/features.txt |    6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/TODO b/TODO
index 0b25806..df3b422 100644
--- a/TODO
+++ b/TODO
@@ -507,12 +507,6 @@ CDMA CMAS
 CDMA Network Acquisition
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- Support reporting of the received signal strength indicator (RSSI)
-  measurement for the currently acquired CDMA network.
-
-  Priority: Medium
-  Complexity: C1
-
 - Support reporting of the pilot energy ratio (Ec/Io) measurement for the
   currently acquired CDMA network.
 =

diff --git a/doc/features.txt b/doc/features.txt
index d2bb171..2bca0c7 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -690,3 +690,9 @@ CDMA Connection Manager
 =

 - Support Network Initiated disconnection of Packet Data Service over CDMA
   (1xRTT and 1xEV-DO) systems.
+
+CDMA Network Acquisition
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Support reporting of the received signal strength indicator (RSSI)
+  measurement for the currently acquired CDMA network.
-- =

1.7.1


--===============0855563015790063882==--

