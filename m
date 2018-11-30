Content-Type: multipart/mixed; boundary="===============3318620139672201983=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 3/3] coex: modified ofono.conf for coex agent
Date: Fri, 30 Nov 2018 15:13:39 +0530
Message-ID: <1543571019-20631-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3318620139672201983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

Added coex agent interface to ofono.conf
---
 src/ofono.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ofono.conf b/src/ofono.conf
index 61e0bde..5a3afaa 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -16,6 +16,7 @@
     <allow send_interface=3D"org.ofono.PositioningRequestAgent"/>
     <allow send_interface=3D"org.ofono.HandsfreeAudioAgent"/>
     <allow send_interface=3D"org.ofono.NetworkMonitorAgent"/>
+    <allow send_interface=3D"org.ofono.LTECoexAgent"/>
   </policy>
 =

   <policy at_console=3D"true">
-- =

1.9.1


--===============3318620139672201983==--

