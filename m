Content-Type: multipart/mixed; boundary="===============1002295952842176893=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 1/4] controbase: Remove entries in CBM UI
Date: Fri, 29 Jun 2012 17:53:00 +0200
Message-ID: <1340985183-22049-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340985183-22049-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1002295952842176893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/controlbase.ui |  184 +++++++++++++++++++-----------------------------=
----
 1 file changed, 67 insertions(+), 117 deletions(-)

diff --git a/src/controlbase.ui b/src/controlbase.ui
index ce675d2..4eb1355 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -393,7 +393,17 @@
           <property name=3D"spacing">
            <number>6</number>
           </property>
-          <item row=3D"1" column=3D"0">
+          <item row=3D"2" column=3D"0">
+           <widget class=3D"QLabel" name=3D"lblMessageCode">
+            <property name=3D"text">
+             <string>Message C&amp;ode:</string>
+            </property>
+            <property name=3D"buddy">
+             <cstring>leMessageCode</cstring>
+            </property>
+           </widget>
+          </item>
+          <item row=3D"3" column=3D"0">
            <widget class=3D"QLabel" name=3D"lblUpdateNumber">
             <property name=3D"text">
              <string>&amp;Update Number:</string>
@@ -404,6 +414,33 @@
            </widget>
           </item>
           <item row=3D"1" column=3D"1">
+           <widget class=3D"QComboBox" name=3D"cbGeographicalScope">
+            <property name=3D"currentIndex">
+             <number>3</number>
+            </property>
+            <item>
+             <property name=3D"text">
+              <string>Cell wide(immediate)</string>
+             </property>
+            </item>
+            <item>
+             <property name=3D"text">
+              <string>PLMN wide</string>
+             </property>
+            </item>
+            <item>
+             <property name=3D"text">
+              <string>Location Area wide</string>
+             </property>
+            </item>
+            <item>
+             <property name=3D"text">
+              <string>Cell wide(norm)</string>
+             </property>
+            </item>
+           </widget>
+          </item>
+          <item row=3D"3" column=3D"1">
            <widget class=3D"QLineEdit" name=3D"leUpdateNumber">
             <property name=3D"text">
              <string>A</string>
@@ -413,27 +450,27 @@
             </property>
            </widget>
           </item>
-          <item row=3D"1" column=3D"2">
-           <widget class=3D"QLabel" name=3D"lblNumPages">
+          <item row=3D"4" column=3D"1">
+           <widget class=3D"QLineEdit" name=3D"leChannel">
             <property name=3D"text">
-             <string>&amp;Number of Pages</string>
+             <string>0032</string>
             </property>
-            <property name=3D"buddy">
-             <cstring>leNumPages</cstring>
+            <property name=3D"maxLength">
+             <number>4</number>
             </property>
            </widget>
           </item>
-          <item row=3D"3" column=3D"0">
-           <widget class=3D"QLabel" name=3D"lblLanguage">
+          <item row=3D"4" column=3D"0">
+           <widget class=3D"QLabel" name=3D"lblChannel">
             <property name=3D"text">
-             <string>&amp;Language</string>
+             <string>&amp;Channel</string>
             </property>
             <property name=3D"buddy">
-             <cstring>cbLanguage</cstring>
+             <cstring>leChannel</cstring>
             </property>
            </widget>
           </item>
-          <item row=3D"3" column=3D"2">
+          <item row=3D"1" column=3D"0">
            <widget class=3D"QLabel" name=3D"lblGeographicalScope">
             <property name=3D"text">
              <string>&amp;Geographical Scope</string>
@@ -443,17 +480,7 @@
             </property>
            </widget>
           </item>
-          <item row=3D"2" column=3D"3">
-           <widget class=3D"QLineEdit" name=3D"lePage">
-            <property name=3D"text">
-             <string>1</string>
-            </property>
-            <property name=3D"maxLength">
-             <number>1</number>
-            </property>
-           </widget>
-          </item>
-          <item row=3D"3" column=3D"1">
+          <item row=3D"5" column=3D"1">
            <widget class=3D"QComboBox" name=3D"cbLanguage">
             <property name=3D"currentIndex">
              <number>1</number>
@@ -525,50 +552,17 @@
             </item>
            </widget>
           </item>
-          <item row=3D"0" column=3D"2">
-           <widget class=3D"QLabel" name=3D"lblScheme">
-            <property name=3D"text">
-             <string>&amp;Scheme</string>
-            </property>
-            <property name=3D"buddy">
-             <cstring>leScheme</cstring>
-            </property>
-           </widget>
-          </item>
-          <item row=3D"2" column=3D"0">
-           <widget class=3D"QLabel" name=3D"lblChannel">
-            <property name=3D"text">
-             <string>&amp;Channel</string>
-            </property>
-            <property name=3D"buddy">
-             <cstring>leChannel</cstring>
-            </property>
-           </widget>
-          </item>
-          <item row=3D"2" column=3D"2">
-           <widget class=3D"QLabel" name=3D"lblPage">
+          <item row=3D"5" column=3D"0">
+           <widget class=3D"QLabel" name=3D"lblLanguage">
             <property name=3D"text">
-             <string>&amp;Page</string>
+             <string>&amp;Language</string>
             </property>
             <property name=3D"buddy">
-             <cstring>lePage</cstring>
-            </property>
-           </widget>
-          </item>
-          <item row=3D"0" column=3D"3">
-           <widget class=3D"QLineEdit" name=3D"leScheme">
-            <property name=3D"text">
-             <string>4</string>
-            </property>
-            <property name=3D"maxLength">
-             <number>1</number>
-            </property>
-            <property name=3D"readOnly">
-             <bool>true</bool>
+             <cstring>cbLanguage</cstring>
             </property>
            </widget>
           </item>
-          <item row=3D"0" column=3D"1">
+          <item row=3D"2" column=3D"1">
            <widget class=3D"QLineEdit" name=3D"leMessageCode">
             <property name=3D"text">
              <string>012</string>
@@ -578,62 +572,21 @@
             </property>
            </widget>
           </item>
-          <item row=3D"2" column=3D"1">
-           <widget class=3D"QLineEdit" name=3D"leChannel">
-            <property name=3D"text">
-             <string>0032</string>
+          <item row=3D"1" column=3D"2" rowspan=3D"5">
+           <spacer name=3D"verticalSpacer_2">
+            <property name=3D"orientation">
+             <enum>Qt::Vertical</enum>
             </property>
-            <property name=3D"maxLength">
-             <number>4</number>
+            <property name=3D"sizeType">
+             <enum>QSizePolicy::Ignored</enum>
             </property>
-           </widget>
-          </item>
-          <item row=3D"1" column=3D"3">
-           <widget class=3D"QLineEdit" name=3D"leNumPages">
-            <property name=3D"text">
-             <string>1</string>
-            </property>
-            <property name=3D"maxLength">
-             <number>1</number>
+            <property name=3D"sizeHint" stdset=3D"0">
+             <size>
+              <width>290</width>
+              <height>150</height>
+             </size>
             </property>
-           </widget>
-          </item>
-          <item row=3D"3" column=3D"3">
-           <widget class=3D"QComboBox" name=3D"cbGeographicalScope">
-            <property name=3D"currentIndex">
-             <number>3</number>
-            </property>
-            <item>
-             <property name=3D"text">
-              <string>Cell wide(immediate)</string>
-             </property>
-            </item>
-            <item>
-             <property name=3D"text">
-              <string>PLMN wide</string>
-             </property>
-            </item>
-            <item>
-             <property name=3D"text">
-              <string>Location Area wide</string>
-             </property>
-            </item>
-            <item>
-             <property name=3D"text">
-              <string>Cell wide(norm)</string>
-             </property>
-            </item>
-           </widget>
-          </item>
-          <item row=3D"0" column=3D"0">
-           <widget class=3D"QLabel" name=3D"lblMessageCode">
-            <property name=3D"text">
-             <string>Message C&amp;ode:</string>
-            </property>
-            <property name=3D"buddy">
-             <cstring>leMessageCode</cstring>
-            </property>
-           </widget>
+           </spacer>
           </item>
          </layout>
         </widget>
@@ -1575,9 +1528,7 @@
   <tabstop>pbSendSMSDatagram</tabstop>
   <tabstop>atViewer</tabstop>
   <tabstop>openSpecButton</tabstop>
-  <tabstop>leScheme</tabstop>
-  <tabstop>leNumPages</tabstop>
-  <tabstop>lePage</tabstop>
+  <tabstop>teContent</tabstop>
   <tabstop>cbGeographicalScope</tabstop>
   <tabstop>pbSelectOperator</tabstop>
   <tabstop>hsBatteryCharge</tabstop>
@@ -1591,7 +1542,6 @@
   <tabstop>leLAC</tabstop>
   <tabstop>pbSendCellBroadcast</tabstop>
   <tabstop>leCellID</tabstop>
-  <tabstop>teContent</tabstop>
   <tabstop>tabWidget</tabstop>
   <tabstop>leChannel</tabstop>
   <tabstop>cbLanguage</tabstop>
-- =

1.7.9.5


--===============1002295952842176893==--

