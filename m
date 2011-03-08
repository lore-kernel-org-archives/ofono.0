Content-Type: multipart/mixed; boundary="===============7629056119911740347=="
MIME-Version: 1.0
From: Paavo Leinonen <paavo.leinonen@tieto.com>
Subject: [PATCH] phonesim: add support for +CPOSR unsolicited code
Date: Tue, 08 Mar 2011 15:59:59 +0200
Message-ID: <1299592799-6628-1-git-send-email-paavo.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7629056119911740347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enables positioning XML sending from PhoneSIM
---

This patch is related to Jarko's GNSS patch. Patch will enable GNSS
testing with PhoneSIM.

 src/control.cpp    |   32 ++++++++++++++++++++++++
 src/control.h      |    2 +
 src/controlbase.ui |   68 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/default.xml    |   49 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 34c109a..279bade 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -85,6 +85,8 @@ ControlWidget::ControlWidget(const QString &ruleFile, Con=
trol *parent)
     connect(ui->pbStart, SIGNAL(clicked()), this, SLOT(simAppStart()));
     connect(ui->pbAbort, SIGNAL(clicked()), this, SLOT(simAppAbort()));
     connect(ui->pbReset, SIGNAL(clicked()), this, SLOT(modemSilentReset())=
);
+    connect(ui->pbSendGNSSData, SIGNAL(clicked()), this, SLOT(sendGNSSData=
()));
+    connect(ui->pbGNSSDefault, SIGNAL(clicked()), this, SLOT(setDefaultGNS=
SData()));
 =

     QStringList headers;
     headers << "Sender" << "Priority" << "Notification Status";
@@ -222,6 +224,33 @@ void ControlWidget::sendSMSMessage()
     p->constructSMSMessage(ui->leSMSClass->text().toInt(), ui->leMessageSe=
nder->text(), ui->leSMSServiceCenter->text(), ui->teSMSText->toPlainText());
 }
 =

+void ControlWidget::setDefaultGNSSData()
+{
+    ui->teGNSStext->clear();
+
+    ui->teGNSStext->append("<?xml version=3D\"1.0\" ?>");
+    ui->teGNSStext->append("<pos>");
+    ui->teGNSStext->append("  <pos_err>");
+    ui->teGNSStext->append("    <err_reason literal=3D\"not_enough_gps_sat=
ellites\" />");
+    ui->teGNSStext->append("  </pos_err>");
+    ui->teGNSStext->append("</pos>");
+}
+
+void ControlWidget::sendGNSSData()
+{
+    QStringList xml =3D ui->teGNSStext->toPlainText().split("\n");
+
+    foreach ( QString line, xml )
+    {
+        if (!line.isEmpty()) {
+            QString cposr =3D  "+CPOSR: " + line;
+
+            emit unsolicitedCommand(cposr);
+            handleFromData( cposr );
+        }
+    }
+}
+
 void ControlWidget::sendMGD()
 {
     emit command("AT+CMGD=3D1");
@@ -505,6 +534,9 @@ Script::Script(QObject *obj, Ui_ControlBase *ui) : QDBu=
sAbstractAdaptor(obj)
 =

     QScriptValue qsTab6 =3D engine.newQObject(ui->tab_6);
     engine.globalObject().setProperty("tabSIM", qsTab6);
+
+    QScriptValue qsTab8 =3D engine.newQObject(ui->tab_8);
+    engine.globalObject().setProperty("tabPosition", qsTab8);
 }
 =

 void Script::SetPath(const QString &path, const QDBusMessage &msg)
diff --git a/src/control.h b/src/control.h
index 2c14863..eac4288 100644
--- a/src/control.h
+++ b/src/control.h
@@ -95,6 +95,8 @@ private slots:
     void simAppStart();
     void simAppAbort();
     void modemSilentReset();
+    void sendGNSSData();
+    void setDefaultGNSSData();
 =

 signals:
     void unsolicitedCommand(const QString &);
diff --git a/src/controlbase.ui b/src/controlbase.ui
index 36fe3cd..11943ed 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -818,7 +818,13 @@
 &lt;html&gt;&lt;head&gt;&lt;meta name=3D&quot;qrichtext&quot; content=3D&q=
uot;1&quot; /&gt;&lt;style type=3D&quot;text/css&quot;&gt;
 p, li { white-space: pre-wrap; }
 &lt;/style&gt;&lt;/head&gt;&lt;body style=3D&quot; font-family:'Sans Serif=
'; font-size:9pt; font-weight:400; font-style:normal;&quot;&gt;
-&lt;p style=3D&quot;-qt-paragraph-type:empty; margin-top:0px; margin-botto=
m:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0=
px;&quot;&gt;&lt;/p&gt;&lt;/body&gt;&lt;/html&gt;</string>
+&lt;table border=3D&quot;0&quot; style=3D&quot;-qt-table-type: root; margi=
n-top:4px; margin-bottom:4px; margin-left:4px; margin-right:4px;&quot;&gt;
+&lt;tr&gt;
+&lt;td style=3D&quot;border: none;&quot;&gt;
+&lt;p style=3D&quot;-qt-paragraph-type:empty; margin-top:0px; margin-botto=
m:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0=
px;&quot;&gt;&lt;/p&gt;
+&lt;p style=3D&quot;-qt-paragraph-type:empty; margin-top:0px; margin-botto=
m:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0=
px;&quot;&gt;&lt;/p&gt;
+&lt;p style=3D&quot;-qt-paragraph-type:empty; margin-top:0px; margin-botto=
m:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0=
px;&quot;&gt;&lt;/p&gt;
+&lt;p style=3D&quot;-qt-paragraph-type:empty; margin-top:0px; margin-botto=
m:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0=
px;&quot;&gt;&lt;/p&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;&lt;/body&gt;&lt=
;/html&gt;</string>
             </property>
            </widget>
           </item>
@@ -1349,6 +1355,66 @@ p, li { white-space: pre-wrap; }
        </layout>
       </widget>
      </widget>
+     <widget class=3D"QWidget" name=3D"tab_8">
+      <attribute name=3D"title">
+       <string>Positioning</string>
+      </attribute>
+      <widget class=3D"QLabel" name=3D"lbGNSSdata">
+       <property name=3D"geometry">
+        <rect>
+         <x>10</x>
+         <y>10</y>
+         <width>271</width>
+         <height>31</height>
+        </rect>
+       </property>
+       <property name=3D"text">
+        <string>Positioning Reporting XML Data (+CPOSR)</string>
+       </property>
+      </widget>
+      <widget class=3D"QTextEdit" name=3D"teGNSStext">
+       <property name=3D"geometry">
+        <rect>
+         <x>10</x>
+         <y>40</y>
+         <width>601</width>
+         <height>311</height>
+        </rect>
+       </property>
+       <property name=3D"lineWrapMode">
+        <enum>QTextEdit::NoWrap</enum>
+       </property>
+       <property name=3D"acceptRichText">
+        <bool>false</bool>
+       </property>
+      </widget>
+      <widget class=3D"QPushButton" name=3D"pbSendGNSSData">
+       <property name=3D"geometry">
+        <rect>
+         <x>10</x>
+         <y>360</y>
+         <width>80</width>
+         <height>26</height>
+        </rect>
+       </property>
+       <property name=3D"text">
+        <string>SendData</string>
+       </property>
+      </widget>
+      <widget class=3D"QPushButton" name=3D"pbGNSSDefault">
+       <property name=3D"geometry">
+        <rect>
+         <x>100</x>
+         <y>360</y>
+         <width>80</width>
+         <height>26</height>
+        </rect>
+       </property>
+       <property name=3D"text">
+        <string>Default</string>
+       </property>
+      </widget>
+     </widget>
     </widget>
    </item>
    <item>
diff --git a/src/default.xml b/src/default.xml
index 00b4381..4d4b1a1 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -303,6 +303,9 @@
 =

     <!-- TTY (hearing impared) state -->
     <set name=3D"PTTY" value=3D"1" />
+
+    <!-- Positioning reporting state -->
+    <set name=3D"CPOSR" value=3D"0" />
 =

 <!-- Time -->
 <!-- Enable for testing
@@ -310,7 +313,6 @@
 <unsolicited delay=3D"3000" once=3D"true">*TTZ: 2, "Cingluar", 0</unsolici=
ted>
 -->
 =

-
 <!-- GSM 07.07: General commands -->
 =

 <chat>
@@ -2993,6 +2995,49 @@
     <response>ERROR</response>
 </chat>
 =

+<!-- Positioning related commands -->
+
+<chat>
+    <!-- Query if CPOSR is supported -->
+    <command>AT+CPOSR=3D?</command>
+    <response>OK</response>
+</chat>
+
+<chat>
+    <!-- Set unsolicited position reporting -->
+    <command>AT+CPOSR=3D*</command>
+    <response>OK</response>
+    <set name=3D"CPOSR" value=3D"*"/>
+</chat>
+
+<chat>
+    <!-- Read unsolicited position reporting state -->
+    <command>AT+CPOSR?</command>
+    <response>+CPOSR: ${CPOSR}\n\nOK</response>
+</chat>
+
+<chat>
+    <!-- Query if CPOS supported -->
+    <command>AT+CPOS=3D?</command>
+    <response>OK</response>
+</chat>
+
+<chat>
+    <!-- Send positioning element -->
+    <command>AT+CPOS</command>
+<!--    <response eol=3D"false">&gt; </response> -->
+    <response eol=3D"false"></response>
+    <switch name=3D"cposread"/>
+</chat>
+
+<state name=3D"cposread">
+    <chat>
+        <command wildcard=3D"true"></command>
+        <response>OK</response>
+        <switch name=3D"default"/>
+    </chat>
+</state>
+
 <!-- Modem compatibility commands for phones that support data services -->
 =

 <chat>
@@ -3200,6 +3245,8 @@
 +CPBR
 +CPBF
 +CPBW
++CPOS
++CPOSR
 +CMEE
 +CMGF
 +CMGS
-- =

1.7.1


--===============7629056119911740347==--

