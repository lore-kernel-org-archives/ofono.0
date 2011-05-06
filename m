Content-Type: multipart/mixed; boundary="===============3311326533339217458=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] controlbase: Gather call elements on the same tab
Date: Fri, 06 May 2011 15:53:00 +0200
Message-ID: <1304689980-6110-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3311326533339217458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Group CSSU/CSSI and incomming call UI together on the same "Call" tab

---
 src/controlbase.ui |  267 ++++++++++++++++++++++++++----------------------=
----
 1 files changed, 132 insertions(+), 135 deletions(-)

diff --git a/src/controlbase.ui b/src/controlbase.ui
index 41c6d12..dd60cda 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -113,144 +113,34 @@
           </widget>
          </item>
          <item>
-          <widget class=3D"QGroupBox" name=3D"gbIncomingCall">
-           <property name=3D"title">
-            <string>Incoming Call</string>
-           </property>
-           <layout class=3D"QGridLayout" name=3D"gridLayout">
-            <item row=3D"0" column=3D"0">
-             <widget class=3D"QCheckBox" name=3D"cbCaller">
-              <property name=3D"text">
-               <string>Caller Identity</string>
-              </property>
-              <property name=3D"checked">
-               <bool>true</bool>
-              </property>
-             </widget>
-            </item>
-            <item row=3D"0" column=3D"1">
-             <widget class=3D"QLineEdit" name=3D"leCaller"/>
-            </item>
-            <item row=3D"1" column=3D"0">
-             <widget class=3D"QCheckBox" name=3D"cbCallerName">
-              <property name=3D"text">
-               <string>Caller Name</string>
-              </property>
-             </widget>
-            </item>
-            <item row=3D"1" column=3D"1">
-             <widget class=3D"QLineEdit" name=3D"leCallerName">
-              <property name=3D"enabled">
-               <bool>false</bool>
-              </property>
-             </widget>
-            </item>
-            <item row=3D"2" column=3D"0">
-             <widget class=3D"QCheckBox" name=3D"cbCalledLine">
-              <property name=3D"text">
-               <string>Called Line</string>
-              </property>
-             </widget>
-            </item>
-            <item row=3D"2" column=3D"1">
-             <widget class=3D"QLineEdit" name=3D"leCalledLine">
-              <property name=3D"enabled">
-               <bool>false</bool>
-              </property>
-             </widget>
-            </item>
-            <item row=3D"3" column=3D"0" colspan=3D"2">
-             <layout class=3D"QHBoxLayout">
-              <property name=3D"spacing">
-               <number>6</number>
-              </property>
-              <property name=3D"margin">
-               <number>0</number>
-              </property>
-              <item>
-               <spacer>
-                <property name=3D"orientation">
-                 <enum>Qt::Horizontal</enum>
-                </property>
-                <property name=3D"sizeHint" stdset=3D"0">
-                 <size>
-                  <width>111</width>
-                  <height>20</height>
-                 </size>
-                </property>
-               </spacer>
-              </item>
-              <item>
-               <widget class=3D"QPushButton" name=3D"pbIncomingCall">
-                <property name=3D"text">
-                 <string>&amp;Call</string>
-                </property>
-               </widget>
-              </item>
-             </layout>
-            </item>
-           </layout>
-          </widget>
-         </item>
-        </layout>
-       </item>
-       <item>
-        <layout class=3D"QHBoxLayout" name=3D"horizontalLayout_3">
-         <item>
           <spacer name=3D"horizontalSpacer">
            <property name=3D"orientation">
             <enum>Qt::Horizontal</enum>
            </property>
-           <property name=3D"sizeType">
-            <enum>QSizePolicy::Fixed</enum>
-           </property>
            <property name=3D"sizeHint" stdset=3D"0">
             <size>
-             <width>322</width>
+             <width>40</width>
              <height>20</height>
             </size>
            </property>
           </spacer>
          </item>
-         <item>
-          <widget class=3D"QGroupBox" name=3D"gbCallSettings">
-           <property name=3D"title">
-            <string>Call Settings</string>
-           </property>
-           <layout class=3D"QGridLayout" name=3D"gridLayout_2">
-            <item row=3D"0" column=3D"1">
-             <widget class=3D"QComboBox" name=3D"cbCSSU"/>
-            </item>
-            <item row=3D"1" column=3D"1">
-             <widget class=3D"QComboBox" name=3D"cbCSSI"/>
-            </item>
-            <item row=3D"0" column=3D"0">
-             <widget class=3D"QLabel" name=3D"lbCSSU">
-              <property name=3D"text">
-               <string>CSSU</string>
-              </property>
-             </widget>
-            </item>
-            <item row=3D"1" column=3D"0">
-             <widget class=3D"QLabel" name=3D"lbCSSI">
-              <property name=3D"text">
-               <string>CSSI</string>
-              </property>
-             </widget>
-            </item>
-            <item row=3D"2" column=3D"1">
-             <widget class=3D"QPushButton" name=3D"pbSendNotif">
-              <property name=3D"text">
-               <string>Send Notification</string>
-              </property>
-             </widget>
-            </item>
-           </layout>
-          </widget>
-         </item>
         </layout>
        </item>
        <item>
+        <spacer name=3D"verticalSpacer">
+         <property name=3D"orientation">
+          <enum>Qt::Vertical</enum>
+         </property>
+         <property name=3D"sizeHint" stdset=3D"0">
+          <size>
+           <width>20</width>
+           <height>10</height>
+          </size>
+         </property>
+        </spacer>
+       </item>
+       <item>
         <widget class=3D"QCheckBox" name=3D"atCheckBox">
          <property name=3D"layoutDirection">
           <enum>Qt::RightToLeft</enum>
@@ -1505,17 +1395,124 @@ p, li { white-space: pre-wrap; }
         </widget>
        </item>
        <item>
-        <spacer name=3D"verticalSpacer">
-         <property name=3D"orientation">
-          <enum>Qt::Vertical</enum>
-         </property>
-         <property name=3D"sizeHint" stdset=3D"0">
-          <size>
-           <width>20</width>
-           <height>40</height>
-          </size>
-         </property>
-        </spacer>
+        <layout class=3D"QHBoxLayout" name=3D"horizontalLayout_3">
+         <item>
+          <widget class=3D"QGroupBox" name=3D"gbIncomingCall">
+           <property name=3D"title">
+            <string>Incoming Call</string>
+           </property>
+           <layout class=3D"QGridLayout">
+            <item row=3D"0" column=3D"0">
+             <widget class=3D"QCheckBox" name=3D"cbCaller">
+              <property name=3D"text">
+               <string>Caller Identity</string>
+              </property>
+              <property name=3D"checked">
+               <bool>true</bool>
+              </property>
+             </widget>
+            </item>
+            <item row=3D"0" column=3D"1">
+             <widget class=3D"QLineEdit" name=3D"leCaller"/>
+            </item>
+            <item row=3D"1" column=3D"0">
+             <widget class=3D"QCheckBox" name=3D"cbCallerName">
+              <property name=3D"text">
+               <string>Caller Name</string>
+              </property>
+             </widget>
+            </item>
+            <item row=3D"1" column=3D"1">
+             <widget class=3D"QLineEdit" name=3D"leCallerName">
+              <property name=3D"enabled">
+               <bool>false</bool>
+              </property>
+             </widget>
+            </item>
+            <item row=3D"2" column=3D"0">
+             <widget class=3D"QCheckBox" name=3D"cbCalledLine">
+              <property name=3D"text">
+               <string>Called Line</string>
+              </property>
+             </widget>
+            </item>
+            <item row=3D"2" column=3D"1">
+             <widget class=3D"QLineEdit" name=3D"leCalledLine">
+              <property name=3D"enabled">
+               <bool>false</bool>
+              </property>
+             </widget>
+            </item>
+            <item row=3D"3" column=3D"0" colspan=3D"2">
+             <layout class=3D"QHBoxLayout">
+              <property name=3D"spacing">
+               <number>6</number>
+              </property>
+              <property name=3D"margin">
+               <number>0</number>
+              </property>
+              <item>
+               <spacer>
+                <property name=3D"orientation">
+                 <enum>Qt::Horizontal</enum>
+                </property>
+                <property name=3D"sizeHint" stdset=3D"0">
+                 <size>
+                  <width>111</width>
+                  <height>20</height>
+                 </size>
+                </property>
+               </spacer>
+              </item>
+              <item>
+               <widget class=3D"QPushButton" name=3D"pbIncomingCall">
+                <property name=3D"text">
+                 <string>&amp;Call</string>
+                </property>
+               </widget>
+              </item>
+             </layout>
+            </item>
+           </layout>
+          </widget>
+         </item>
+         <item>
+          <widget class=3D"QGroupBox" name=3D"gbCallSettings">
+           <property name=3D"title">
+            <string>Call Settings</string>
+           </property>
+           <layout class=3D"QGridLayout">
+            <item row=3D"0" column=3D"1">
+             <widget class=3D"QComboBox" name=3D"cbCSSU"/>
+            </item>
+            <item row=3D"1" column=3D"1">
+             <widget class=3D"QComboBox" name=3D"cbCSSI"/>
+            </item>
+            <item row=3D"0" column=3D"0">
+             <widget class=3D"QLabel" name=3D"lbCSSU">
+              <property name=3D"text">
+               <string>CSSU</string>
+              </property>
+             </widget>
+            </item>
+            <item row=3D"1" column=3D"0">
+             <widget class=3D"QLabel" name=3D"lbCSSI">
+              <property name=3D"text">
+               <string>CSSI</string>
+              </property>
+             </widget>
+            </item>
+            <item row=3D"2" column=3D"1">
+             <widget class=3D"QPushButton" name=3D"pbSendNotif">
+              <property name=3D"text">
+               <string>Send Notification</string>
+              </property>
+             </widget>
+            </item>
+           </layout>
+          </widget>
+         </item>
+        </layout>
        </item>
       </layout>
      </widget>
-- =

1.7.1


--===============3311326533339217458==--

