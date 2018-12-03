Content-Type: multipart/mixed; boundary="===============0774245347700059463=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 3/3] coex: modified ofono.conf for coex agent
Date: Mon, 03 Dec 2018 14:50:41 +0530
Message-ID: <1543828841-31979-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0774245347700059463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

Added coex agent interface to ofono.conf
---
 src/ofono.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ofono.conf b/src/ofono.conf
index 61e0bde..45cb15c 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -16,6 +16,7 @@
     <allow send_interface=3D"org.ofono.PositioningRequestAgent"/>
     <allow send_interface=3D"org.ofono.HandsfreeAudioAgent"/>
     <allow send_interface=3D"org.ofono.NetworkMonitorAgent"/>
+    <allow send_interface=3D"org.ofono.intel.LteCoexistenceAgent"/>
   </policy>
 =

   <policy at_console=3D"true">
-- =

1.9.1


--===============0774245347700059463==--

