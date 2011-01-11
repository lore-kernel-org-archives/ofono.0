Content-Type: multipart/mixed; boundary="===============0882195446907745421=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/6] phonesim: add ui support for sim app selection
Date: Tue, 11 Jan 2011 16:16:05 +0200
Message-ID: <1294755370-12442-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294755370-12442-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0882195446907745421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp             |    5 ++---
 src/controlbase.ui          |   10 +++-------
 src/hardwaremanipulator.cpp |   19 ++++++++++---------
 src/hardwaremanipulator.h   |    4 ++--
 src/phonesim.cpp            |   23 +++++++++++++++++------
 src/phonesim.h              |    3 +++
 6 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 68c5584..2cbb91a 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -457,8 +457,7 @@ void ControlWidget::simInsertRemove()
 =

 void ControlWidget::handleNewApp()
 {
-    ui->lblApplicationName->setText( "Current application: " +
-            p->getSimAppName() );
+    ui->cbSimApps->insertItems( 0, p->getSimAppsNameList() );
 }
 =

 void Control::handleNewApp()
@@ -468,7 +467,7 @@ void Control::handleNewApp()
 =

 void ControlWidget::simAppStart()
 {
-    p->simAppStart();
+    p->simAppStart( ui->cbSimApps->currentIndex() );
 }
 =

 void ControlWidget::simAppAbort()
diff --git a/src/controlbase.ui b/src/controlbase.ui
index 669078c..36fe3cd 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -1288,6 +1288,9 @@ p, li { white-space: pre-wrap; }
          </property>
          <layout class=3D"QHBoxLayout">
           <item>
+           <widget class=3D"QComboBox" name=3D"cbSimApps"/>
+          </item>
+          <item>
            <widget class=3D"QPushButton" name=3D"pbStart">
             <property name=3D"text">
              <string>Start</string>
@@ -1301,13 +1304,6 @@ p, li { white-space: pre-wrap; }
             </property>
            </widget>
           </item>
-          <item>
-           <widget class=3D"QLabel" name=3D"lblApplicationName">
-            <property name=3D"toolTip">
-             <string>Shows current selected application's name</string>
-            </property>
-           </widget>
-          </item>
          </layout>
         </widget>
        </item>
diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index 8ed8227..c7bbe6a 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -307,26 +307,27 @@ void HardwareManipulator::setSimPresent( bool present=
 )
     simPresent =3D present;
 }
 =

-QString HardwareManipulator::getSimAppName()
+QStringList HardwareManipulator::getSimAppsNameList()
 {
-    SimApplication *app =3D rules->simApplication();
+    const QList<SimApplication *> simApps =3D rules->getSimApps();
+    QStringList nameList;
 =

-    if (app)
-        return app->getName();
+    for ( int i =3D 0; i  < simApps.count(); i++ )
+        nameList.append( simApps.at( i )->getName() );
 =

-    return "None";
+    return nameList;
 }
 =

 void HardwareManipulator::handleNewApp()
 {
 }
 =

-void HardwareManipulator::simAppStart()
+void HardwareManipulator::simAppStart( int appIndex )
 {
-    SimApplication *app =3D rules->simApplication();
+    const QList<SimApplication *> simApps =3D rules->getSimApps();
 =

-    if (app)
-        return app->start();
+    rules->setSimApplication( simApps.at( appIndex ) );
+    simApps.at( appIndex )->start();
 }
 =

 void HardwareManipulator::simAppAbort()
diff --git a/src/hardwaremanipulator.h b/src/hardwaremanipulator.h
index d8ab11e..86afbb5 100644
--- a/src/hardwaremanipulator.h
+++ b/src/hardwaremanipulator.h
@@ -35,7 +35,7 @@ public:
     HardwareManipulator(SimRules *sr, QObject *parent=3D0);
     QSMSMessageList & getSMSList();
     bool getSimPresent();
-    QString getSimAppName();
+    QStringList getSimAppsNameList();
 =

 public slots:
     virtual void handleFromData( const QString& );
@@ -46,7 +46,7 @@ public slots:
     virtual void sendVMNotify( int type, int count, const QList<QVMMessage=
> &received, const QList<QVMMessage> &deleted, const QString &mailbox );
     virtual void sendUSSD( bool cancel, bool response, const QString &cont=
ent );
     virtual void setSimPresent( bool present );
-    virtual void simAppStart();
+    virtual void simAppStart( int appIndex );
     virtual void simAppAbort();
     virtual void handleNewApp();
 =

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 8ca5b23..f0c93f1 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -548,6 +548,9 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
     defaultToolkitApp =3D toolkitApp =3D new DemoSimApplication( this, thi=
s );
     connect( _callManager, SIGNAL(controlEvent(QSimControlEvent)),
              toolkitApp, SLOT(controlEvent(QSimControlEvent)) );
+
+    simApps.append( toolkitApp );
+
     if ( machine )
         machine->handleNewApp();
 =

@@ -844,6 +847,9 @@ void SimRules::destruct()
     delete defaultToolkitApp;
     toolkitApp =3D NULL;
 =

+    for ( int i =3D 0; i < simApps.count(); i++ )
+        simApps.removeAt( i );
+
     if ( getMachine() )
         getMachine()->handleNewApp();
 =

@@ -877,13 +883,18 @@ HardwareManipulator * SimRules::getMachine() const
 =

 void SimRules::setSimApplication( SimApplication *app )
 {
-    if ( toolkitApp !=3D defaultToolkitApp )
-        delete toolkitApp;
-    toolkitApp =3D ( app ? app : defaultToolkitApp );
-    toolkitApp->start();
+    if ( toolkitApp =3D=3D app )
+        return;
 =

-    if ( getMachine() )
-        getMachine()->handleNewApp();
+    if ( toolkitApp )
+        toolkitApp->abort();
+
+    toolkitApp =3D app;
+}
+
+const QList<SimApplication *> SimRules::getSimApps()
+{
+    return simApps;
 }
 =

 void SimRules::switchTo(const QString& name)
diff --git a/src/phonesim.h b/src/phonesim.h
index cb7a5e1..33b0b31 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -284,6 +284,8 @@ public:
     SimApplication *simApplication() const { return toolkitApp; }
     void setSimApplication( SimApplication *app );
 =

+    const QList<SimApplication *> getSimApps();
+
 signals:
     void returnQueryVariable( const QString&, const QString & );
     void returnQueryState( const QString& );
@@ -332,6 +334,7 @@ private:
     SimFileSystem *fileSystem;
     SimApplication *defaultToolkitApp;
     SimApplication *toolkitApp;
+    QList<SimApplication *> simApps;
 =

     // Get a particular state object.
     SimState *state( const QString& name ) const;
-- =

1.7.0.4


--===============0882195446907745421==--

