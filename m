Content-Type: multipart/mixed; boundary="===============7298167166287541192=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 11/12] ofono.conf: add positioning agent interface
Date: Fri, 11 Mar 2011 14:23:08 +0200
Message-ID: <1299846189-15132-12-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1299846189-15132-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7298167166287541192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.conf |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/ofono.conf b/src/ofono.conf
index 0dfa038..8a83cd0 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -13,6 +13,7 @@
     <allow send_interface=3D"org.ofono.SimToolkitAgent"/>
     <allow send_interface=3D"org.ofono.PushNotificationAgent"/>
     <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>
+    <allow send_interface=3D"org.ofono.PositioningRequestAgent"/>
   </policy>
 =

   <policy at_console=3D"true">
-- =

1.7.0.4


--===============7298167166287541192==--

