Content-Type: multipart/mixed; boundary="===============2880993763408943159=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/2] coex: modified ofono.conf for coex agent
Date: Sun, 09 Dec 2018 18:57:13 +0530
Message-ID: <1544362033-26966-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2880993763408943159==
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


--===============2880993763408943159==--

