Content-Type: multipart/mixed; boundary="===============8424357835762692453=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 08/13] Port deprecations in controlbase.ui
Date: Tue, 12 Nov 2019 22:37:14 +0100
Message-ID: <20191112213719.9309-9-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8424357835762692453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/controlbase.ui | 158 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 142 insertions(+), 16 deletions(-)

diff --git a/src/controlbase.ui b/src/controlbase.ui
index 4eb1355..c2acbf6 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -17,7 +17,16 @@
    <property name=3D"spacing">
     <number>6</number>
    </property>
-   <property name=3D"margin">
+   <property name=3D"leftMargin">
+    <number>9</number>
+   </property>
+   <property name=3D"topMargin">
+    <number>9</number>
+   </property>
+   <property name=3D"rightMargin">
+    <number>9</number>
+   </property>
+   <property name=3D"bottomMargin">
     <number>9</number>
    </property>
    <item>
@@ -162,7 +171,16 @@
           <property name=3D"spacing">
            <number>6</number>
           </property>
-          <property name=3D"margin">
+          <property name=3D"leftMargin">
+           <number>9</number>
+          </property>
+          <property name=3D"topMargin">
+           <number>9</number>
+          </property>
+          <property name=3D"rightMargin">
+           <number>9</number>
+          </property>
+          <property name=3D"bottomMargin">
            <number>9</number>
           </property>
           <item>
@@ -180,7 +198,16 @@
             <property name=3D"spacing">
              <number>6</number>
             </property>
-            <property name=3D"margin">
+            <property name=3D"leftMargin">
+             <number>0</number>
+            </property>
+            <property name=3D"topMargin">
+             <number>0</number>
+            </property>
+            <property name=3D"rightMargin">
+             <number>0</number>
+            </property>
+            <property name=3D"bottomMargin">
              <number>0</number>
             </property>
             <item>
@@ -197,7 +224,16 @@
           </item>
           <item>
            <layout class=3D"QGridLayout">
-            <property name=3D"margin">
+            <property name=3D"leftMargin">
+             <number>0</number>
+            </property>
+            <property name=3D"topMargin">
+             <number>0</number>
+            </property>
+            <property name=3D"rightMargin">
+             <number>0</number>
+            </property>
+            <property name=3D"bottomMargin">
              <number>0</number>
             </property>
             <property name=3D"spacing">
@@ -319,7 +355,16 @@
        <property name=3D"spacing">
         <number>6</number>
        </property>
-       <property name=3D"margin">
+       <property name=3D"leftMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"topMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"rightMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"bottomMargin">
         <number>9</number>
        </property>
        <item>
@@ -337,8 +382,8 @@
          <property name=3D"tabChangesFocus">
           <bool>true</bool>
          </property>
-         <property name=3D"tabStopWidth">
-          <number>40</number>
+         <property name=3D"tabStopDistance">
+          <double>40.000000000000000</double>
          </property>
          <property name=3D"acceptRichText">
           <bool>false</bool>
@@ -350,7 +395,16 @@
          <property name=3D"spacing">
           <number>6</number>
          </property>
-         <property name=3D"margin">
+         <property name=3D"leftMargin">
+          <number>0</number>
+         </property>
+         <property name=3D"topMargin">
+          <number>0</number>
+         </property>
+         <property name=3D"rightMargin">
+          <number>0</number>
+         </property>
+         <property name=3D"bottomMargin">
           <number>0</number>
          </property>
          <item>
@@ -387,7 +441,16 @@
           <bool>false</bool>
          </property>
          <layout class=3D"QGridLayout">
-          <property name=3D"margin">
+          <property name=3D"leftMargin">
+           <number>9</number>
+          </property>
+          <property name=3D"topMargin">
+           <number>9</number>
+          </property>
+          <property name=3D"rightMargin">
+           <number>9</number>
+          </property>
+          <property name=3D"bottomMargin">
            <number>9</number>
           </property>
           <property name=3D"spacing">
@@ -601,7 +664,16 @@
        <property name=3D"spacing">
         <number>6</number>
        </property>
-       <property name=3D"margin">
+       <property name=3D"leftMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"topMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"rightMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"bottomMargin">
         <number>9</number>
        </property>
        <item>
@@ -867,7 +939,16 @@
             <property name=3D"spacing">
              <number>6</number>
             </property>
-            <property name=3D"margin">
+            <property name=3D"leftMargin">
+             <number>0</number>
+            </property>
+            <property name=3D"topMargin">
+             <number>0</number>
+            </property>
+            <property name=3D"rightMargin">
+             <number>0</number>
+            </property>
+            <property name=3D"bottomMargin">
              <number>0</number>
             </property>
             <item>
@@ -905,7 +986,16 @@
        <property name=3D"spacing">
         <number>6</number>
        </property>
-       <property name=3D"margin">
+       <property name=3D"leftMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"topMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"rightMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"bottomMargin">
         <number>9</number>
        </property>
        <item>
@@ -1077,7 +1167,16 @@
        <property name=3D"spacing">
         <number>6</number>
        </property>
-       <property name=3D"margin">
+       <property name=3D"leftMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"topMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"rightMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"bottomMargin">
         <number>9</number>
        </property>
        <item>
@@ -1138,7 +1237,16 @@
        <property name=3D"spacing">
         <number>6</number>
        </property>
-       <property name=3D"margin">
+       <property name=3D"leftMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"topMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"rightMargin">
+        <number>9</number>
+       </property>
+       <property name=3D"bottomMargin">
         <number>9</number>
        </property>
        <item>
@@ -1413,7 +1521,16 @@
               <property name=3D"spacing">
                <number>6</number>
               </property>
-              <property name=3D"margin">
+              <property name=3D"leftMargin">
+               <number>0</number>
+              </property>
+              <property name=3D"topMargin">
+               <number>0</number>
+              </property>
+              <property name=3D"rightMargin">
+               <number>0</number>
+              </property>
+              <property name=3D"bottomMargin">
                <number>0</number>
               </property>
               <item>
@@ -1492,7 +1609,16 @@
       <property name=3D"spacing">
        <number>6</number>
       </property>
-      <property name=3D"margin">
+      <property name=3D"leftMargin">
+       <number>9</number>
+      </property>
+      <property name=3D"topMargin">
+       <number>9</number>
+      </property>
+      <property name=3D"rightMargin">
+       <number>9</number>
+      </property>
+      <property name=3D"bottomMargin">
        <number>9</number>
       </property>
       <item>
--
2.24.0

--===============8424357835762692453==--

