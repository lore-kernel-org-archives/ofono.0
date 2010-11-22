Content-Type: multipart/mixed; boundary="===============0570467958953002203=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] Add modem silent reset button
Date: Mon, 22 Nov 2010 20:05:22 -0200
Message-ID: <1290463522-27458-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0570467958953002203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

+CRST now send a reset resquest command
---
 src/control.cpp    |    6 ++++++
 src/control.h      |    1 +
 src/controlbase.ui |   40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index ab71752..75dae98 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -84,6 +84,7 @@ ControlWidget::ControlWidget(const QString &ruleFile, Con=
trol *parent)
     connect(ui->cbSimInserted, SIGNAL(clicked()), this, SLOT(simInsertRemo=
ve()));
     connect(ui->pbStart, SIGNAL(clicked()), this, SLOT(simAppStart()));
     connect(ui->pbAbort, SIGNAL(clicked()), this, SLOT(simAppAbort()));
+    connect(ui->pbReset, SIGNAL(clicked()), this, SLOT(modemSilentReset())=
);
 =

     QStringList headers;
     headers << "Sender" << "Priority" << "Notification Status";
@@ -466,6 +467,11 @@ void ControlWidget::simAppAbort()
     p->simAppAbort();
 }
 =

+void ControlWidget::modemSilentReset()
+{
+    emit unsolicitedCommand("+CRST:");
+}
+
 Script::Script(QObject *obj, Ui_ControlBase *ui) : QDBusAbstractAdaptor(ob=
j)
 {
     /* Export tabs to be accessed by script */
diff --git a/src/control.h b/src/control.h
index 3c85e22..64a7af7 100644
--- a/src/control.h
+++ b/src/control.h
@@ -94,6 +94,7 @@ private slots:
     void simInsertRemove();
     void simAppStart();
     void simAppAbort();
+    void modemSilentReset();
 =

 signals:
     void unsolicitedCommand(const QString &);
diff --git a/src/controlbase.ui b/src/controlbase.ui
index e0cb5b5..2c91f95 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -1294,6 +1294,46 @@ p, li { white-space: pre-wrap; }
        </item>
       </layout>
      </widget>
+     <widget class=3D"QWidget" name=3D"tab_7">
+      <attribute name=3D"title">
+       <string>Modem</string>
+      </attribute>
+      <widget class=3D"QWidget" name=3D"gridLayoutWidget">
+       <property name=3D"geometry">
+        <rect>
+         <x>9</x>
+         <y>9</y>
+         <width>591</width>
+         <height>511</height>
+        </rect>
+       </property>
+       <layout class=3D"QGridLayout" >
+        <item row=3D"0" column=3D"1">
+         <spacer>
+          <property name=3D"orientation">
+           <enum>Qt::Horizontal</enum>
+          </property>
+          <property name=3D"sizeType">
+           <enum>QSizePolicy::Fixed</enum>
+          </property>
+          <property name=3D"sizeHint" stdset=3D"0">
+           <size>
+            <width>450</width>
+            <height>20</height>
+           </size>
+          </property>
+         </spacer>
+        </item>
+        <item row=3D"0" column=3D"0">
+         <widget class=3D"QPushButton" name=3D"pbReset">
+          <property name=3D"text">
+           <string>Reset</string>
+          </property>
+         </widget>
+        </item>
+       </layout>
+      </widget>
+     </widget>
     </widget>
    </item>
    <item>
-- =

1.7.3.1


--===============0570467958953002203==--

