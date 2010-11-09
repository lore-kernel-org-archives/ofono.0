Content-Type: multipart/mixed; boundary="===============8624708772450793820=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] Add SIM reset button
Date: Tue, 09 Nov 2010 18:21:15 -0200
Message-ID: <1289334075-10937-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8624708772450793820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AT+CRST now send a reset resquest command
---
 src/control.cpp    |    6 ++++++
 src/control.h      |    1 +
 src/controlbase.ui |   16 ++++++++++++++++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 2e22f69..1fa1978 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -84,6 +84,7 @@ ControlWidget::ControlWidget(const QString &ruleFile, Con=
trol *parent)
     connect(ui->cbSimInserted, SIGNAL(clicked()), this, SLOT(simInsertRemo=
ve()));
     connect(ui->pbStart, SIGNAL(clicked()), this, SLOT(simAppStart()));
     connect(ui->pbAbort, SIGNAL(clicked()), this, SLOT(simAppAbort()));
+    connect(ui->pbReset, SIGNAL(clicked()), this, SLOT(simAppReset()));
 =

     QStringList headers;
     headers << "Sender" << "Priority" << "Notification Status";
@@ -459,6 +460,11 @@ void ControlWidget::simAppAbort()
     p->simAppAbort();
 }
 =

+void ControlWidget::simAppReset()
+{
+    emit unsolicitedCommand("AT+CRST");
+}
+
 Script::Script(QObject *obj, Ui_ControlBase *ui) : QDBusAbstractAdaptor(ob=
j)
 {
     /* Export tabs to be accessed by script */
diff --git a/src/control.h b/src/control.h
index 3c85e22..6c4d8a8 100644
--- a/src/control.h
+++ b/src/control.h
@@ -94,6 +94,7 @@ private slots:
     void simInsertRemove();
     void simAppStart();
     void simAppAbort();
+    void simAppReset();
 =

 signals:
     void unsolicitedCommand(const QString &);
diff --git a/src/controlbase.ui b/src/controlbase.ui
index eca1898..ab06b51 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -1406,6 +1406,22 @@ p, li { white-space: pre-wrap; }
             </property>
            </widget>
           </item>
+          <item>
+           <widget class=3D"QPushButton" name=3D"pbReset">
+            <property name=3D"enabled">
+             <bool>true</bool>
+            </property>
+            <property name=3D"maximumSize">
+             <size>
+              <width>185</width>
+              <height>25</height>
+             </size>
+            </property>
+            <property name=3D"text">
+             <string>Reset</string>
+            </property>
+           </widget>
+          </item>
          </layout>
         </widget>
        </item>
-- =

1.7.3.1


--===============8624708772450793820==--

