Content-Type: multipart/mixed; boundary="===============1180502939396485198=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 6/7] ofono.conf: Punch hole for HistoryAgent
Date: Thu, 19 Apr 2012 11:20:55 +0300
Message-ID: <1334823656-3366-7-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334823656-3366-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1180502939396485198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.conf |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/ofono.conf b/src/ofono.conf
index 8a83cd0..9f0d1ae 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -14,6 +14,7 @@
     <allow send_interface=3D"org.ofono.PushNotificationAgent"/>
     <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>
     <allow send_interface=3D"org.ofono.PositioningRequestAgent"/>
+    <allow send_interface=3D"org.ofono.HistoryAgent"/>
   </policy>
 =

   <policy at_console=3D"true">
-- =

1.7.5.4


--===============1180502939396485198==--

