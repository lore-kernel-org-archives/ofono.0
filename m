Content-Type: multipart/mixed; boundary="===============2605205352484506267=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/3] ofono.conf: Punch hole for HandsfreeAudioAgent
Date: Tue, 19 Mar 2013 21:10:33 -0300
Message-ID: <1363738235-15211-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2605205352484506267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ofono.conf b/src/ofono.conf
index 8a83cd0..ed56d3b 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -14,6 +14,7 @@
     <allow send_interface=3D"org.ofono.PushNotificationAgent"/>
     <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>
     <allow send_interface=3D"org.ofono.PositioningRequestAgent"/>
+    <allow send_interface=3D"org.ofono.HandsfreeAudioAgent"/>
   </policy>
 =

   <policy at_console=3D"true">
-- =

1.8.1.5


--===============2605205352484506267==--

