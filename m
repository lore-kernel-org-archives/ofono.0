Content-Type: multipart/mixed; boundary="===============2572042392606367483=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH v2 5/6] controlbase.ui: Add call mangement tab
Date: Mon, 02 May 2011 11:17:17 +0200
Message-ID: <1304327838-11164-6-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1304327838-11164-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2572042392606367483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/controlbase.ui |   61 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/src/controlbase.ui b/src/controlbase.ui
index cfadfe8..41c6d12 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -1458,6 +1458,67 @@ p, li { white-space: pre-wrap; }
        </property>
       </widget>
      </widget>
+     <widget class=3D"QWidget" name=3D"tab_9">
+      <attribute name=3D"title">
+       <string>Call</string>
+      </attribute>
+      <layout class=3D"QVBoxLayout" name=3D"verticalLayout_3">
+       <item>
+        <widget class=3D"QTableWidget" name=3D"twCallMgt">
+         <property name=3D"columnCount">
+          <number>5</number>
+         </property>
+         <attribute name=3D"horizontalHeaderMinimumSectionSize">
+          <number>50</number>
+         </attribute>
+         <attribute name=3D"horizontalHeaderShowSortIndicator" stdset=3D"0=
">
+          <bool>true</bool>
+         </attribute>
+         <attribute name=3D"verticalHeaderDefaultSectionSize">
+          <number>50</number>
+         </attribute>
+         <column>
+          <property name=3D"text">
+           <string>id</string>
+          </property>
+         </column>
+         <column>
+          <property name=3D"text">
+           <string>number</string>
+          </property>
+         </column>
+         <column>
+          <property name=3D"text">
+           <string>state</string>
+          </property>
+         </column>
+         <column>
+          <property name=3D"text">
+           <string>name</string>
+          </property>
+         </column>
+         <column>
+          <property name=3D"text">
+           <string>type</string>
+          </property>
+         </column>
+        </widget>
+       </item>
+       <item>
+        <spacer name=3D"verticalSpacer">
+         <property name=3D"orientation">
+          <enum>Qt::Vertical</enum>
+         </property>
+         <property name=3D"sizeHint" stdset=3D"0">
+          <size>
+           <width>20</width>
+           <height>40</height>
+          </size>
+         </property>
+        </spacer>
+       </item>
+      </layout>
+     </widget>
     </widget>
    </item>
    <item>
-- =

1.7.1


--===============2572042392606367483==--

