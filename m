Content-Type: multipart/mixed; boundary="===============3995985732909757501=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/7] controbase: Add combobox for CBS scheme selection
Date: Mon, 25 Jun 2012 16:37:58 +0200
Message-ID: <1340635083-5877-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340635083-5877-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3995985732909757501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/controlbase.ui |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/src/controlbase.ui b/src/controlbase.ui
index ce675d2..b1a9ff1 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -531,7 +531,7 @@
              <string>&amp;Scheme</string>
             </property>
             <property name=3D"buddy">
-             <cstring>leScheme</cstring>
+             <cstring>cbScheme</cstring>
             </property>
            </widget>
           </item>
@@ -555,19 +555,6 @@
             </property>
            </widget>
           </item>
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
-            </property>
-           </widget>
-          </item>
           <item row=3D"0" column=3D"1">
            <widget class=3D"QLineEdit" name=3D"leMessageCode">
             <property name=3D"text">
@@ -635,6 +622,23 @@
             </property>
            </widget>
           </item>
+          <item row=3D"0" column=3D"3">
+           <widget class=3D"QComboBox" name=3D"cbScheme">
+            <property name=3D"currentIndex">
+             <number>0</number>
+            </property>
+            <item>
+             <property name=3D"text">
+              <string>Default GSM</string>
+             </property>
+            </item>
+            <item>
+             <property name=3D"text">
+              <string>UCS2</string>
+             </property>
+            </item>
+           </widget>
+          </item>
          </layout>
         </widget>
        </item>
@@ -1575,7 +1579,8 @@
   <tabstop>pbSendSMSDatagram</tabstop>
   <tabstop>atViewer</tabstop>
   <tabstop>openSpecButton</tabstop>
-  <tabstop>leScheme</tabstop>
+  <tabstop>teContent</tabstop>
+  <tabstop>cbScheme</tabstop>
   <tabstop>leNumPages</tabstop>
   <tabstop>lePage</tabstop>
   <tabstop>cbGeographicalScope</tabstop>
@@ -1591,7 +1596,6 @@
   <tabstop>leLAC</tabstop>
   <tabstop>pbSendCellBroadcast</tabstop>
   <tabstop>leCellID</tabstop>
-  <tabstop>teContent</tabstop>
   <tabstop>tabWidget</tabstop>
   <tabstop>leChannel</tabstop>
   <tabstop>cbLanguage</tabstop>
-- =

1.7.9.5


--===============3995985732909757501==--

