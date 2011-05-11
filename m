Content-Type: multipart/mixed; boundary="===============6307997494917058409=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 1/5] controlbase: Add call state management buttons
Date: Wed, 11 May 2011 13:46:43 +0200
Message-ID: <1305114407-23796-2-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1305114407-23796-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6307997494917058409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/controlbase.ui |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/controlbase.ui b/src/controlbase.ui
index dd60cda..45b60f9 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -1395,6 +1395,24 @@ p, li { white-space: pre-wrap; }
         </widget>
        </item>
        <item>
+        <layout class=3D"QHBoxLayout" name=3D"horizontalLayout_4">
+         <item>
+          <widget class=3D"QPushButton" name=3D"pbAlerting">
+           <property name=3D"text">
+            <string>Alerting</string>
+           </property>
+          </widget>
+         </item>
+         <item>
+          <widget class=3D"QPushButton" name=3D"pbActive">
+           <property name=3D"text">
+            <string>Active</string>
+           </property>
+          </widget>
+         </item>
+        </layout>
+       </item>
+       <item>
         <layout class=3D"QHBoxLayout" name=3D"horizontalLayout_3">
          <item>
           <widget class=3D"QGroupBox" name=3D"gbIncomingCall">
-- =

1.7.1


--===============6307997494917058409==--

