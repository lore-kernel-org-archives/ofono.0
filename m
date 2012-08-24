Content-Type: multipart/mixed; boundary="===============4002281014356357798=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 2/3] controlbase_ui: Add manual stk command editor
Date: Fri, 24 Aug 2012 10:32:34 +0200
Message-ID: <1345797155-27517-3-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1345797155-27517-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4002281014356357798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/controlbase.ui |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/src/controlbase.ui b/src/controlbase.ui
index 4eb1355..e230d7c 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -1161,6 +1161,52 @@
         </widget>
        </item>
        <item>
+        <widget class=3D"QGroupBox" name=3D"gbSTKCmd">
+         <property name=3D"title">
+          <string>STK Command</string>
+         </property>
+         <property name=3D"flat">
+          <bool>false</bool>
+         </property>
+         <widget class=3D"QPushButton" name=3D"pbSTKCmdSend">
+          <property name=3D"geometry">
+           <rect>
+            <x>80</x>
+            <y>150</y>
+            <width>141</width>
+            <height>31</height>
+           </rect>
+          </property>
+          <property name=3D"text">
+           <string>Send</string>
+          </property>
+         </widget>
+         <widget class=3D"QTextEdit" name=3D"teSTKCmdEditor">
+          <property name=3D"geometry">
+           <rect>
+            <x>235</x>
+            <y>20</y>
+            <width>401</width>
+            <height>161</height>
+           </rect>
+          </property>
+         </widget>
+         <widget class=3D"QPushButton" name=3D"pbSTKClear">
+          <property name=3D"geometry">
+           <rect>
+            <x>80</x>
+            <y>100</y>
+            <width>141</width>
+            <height>31</height>
+           </rect>
+          </property>
+          <property name=3D"text">
+           <string>Clear</string>
+          </property>
+         </widget>
+        </widget>
+       </item>
+       <item>
         <widget class=3D"QGroupBox" name=3D"gbSATK">
          <property name=3D"title">
           <string>Application</string>
-- =

1.7.9.5


--===============4002281014356357798==--

