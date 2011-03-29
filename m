Content-Type: multipart/mixed; boundary="===============1777751082573767745=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 1/2] phonesim: add CSSU/CSSI UI
Date: Tue, 29 Mar 2011 17:16:35 +0200
Message-ID: <1301411796-18027-2-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1301411796-18027-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1777751082573767745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/controlbase.ui |   65 +++++++++++++++++++++++++++++++++++++++++++-----=
---
 1 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/src/controlbase.ui b/src/controlbase.ui
index 11943ed..cfadfe8 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -195,17 +195,60 @@
         </layout>
        </item>
        <item>
-        <spacer>
-         <property name=3D"orientation">
-          <enum>Qt::Vertical</enum>
-         </property>
-         <property name=3D"sizeHint" stdset=3D"0">
-          <size>
-           <width>566</width>
-           <height>101</height>
-          </size>
-         </property>
-        </spacer>
+        <layout class=3D"QHBoxLayout" name=3D"horizontalLayout_3">
+         <item>
+          <spacer name=3D"horizontalSpacer">
+           <property name=3D"orientation">
+            <enum>Qt::Horizontal</enum>
+           </property>
+           <property name=3D"sizeType">
+            <enum>QSizePolicy::Fixed</enum>
+           </property>
+           <property name=3D"sizeHint" stdset=3D"0">
+            <size>
+             <width>322</width>
+             <height>20</height>
+            </size>
+           </property>
+          </spacer>
+         </item>
+         <item>
+          <widget class=3D"QGroupBox" name=3D"gbCallSettings">
+           <property name=3D"title">
+            <string>Call Settings</string>
+           </property>
+           <layout class=3D"QGridLayout" name=3D"gridLayout_2">
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
        <item>
         <widget class=3D"QCheckBox" name=3D"atCheckBox">
-- =

1.7.1


--===============1777751082573767745==--

