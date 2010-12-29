Content-Type: multipart/mixed; boundary="===============8843801747038676172=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH 9/9] D-Bus rules for SMS history plugin.
Date: Wed, 29 Dec 2010 14:51:25 +0200
Message-ID: <1293627085-24428-10-git-send-email-oleg.zhurakivskyy@nokia.com>
In-Reply-To: <1293627085-24428-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8843801747038676172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.conf |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/ofono.conf b/src/ofono.conf
index 0dfa038..18221f9 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -13,6 +13,7 @@
     <allow send_interface=3D"org.ofono.SimToolkitAgent"/>
     <allow send_interface=3D"org.ofono.PushNotificationAgent"/>
     <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>
+    <allow send_interface=3D"org.ofono.MessagingAgent"/>
   </policy>
 =

   <policy at_console=3D"true">
-- =

1.7.1


--===============8843801747038676172==--

