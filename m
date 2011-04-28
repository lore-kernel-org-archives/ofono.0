Content-Type: multipart/mixed; boundary="===============1085113596189142411=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 2/6] control: Update UI using call status
Date: Thu, 28 Apr 2011 11:49:35 +0200
Message-ID: <1303984179-8333-3-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1303984179-8333-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1085113596189142411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp |   40 +++++++++++++++++++++++++++++++++++-----
 src/control.h   |    5 +++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 645219c..2f12d91 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -134,6 +134,32 @@ Control::~Control()
     delete widget;
 }
 =

+void Control::callManagement( QList<CallInfo> *list )
+{
+	bool enableCSSU =3D false;
+	bool enableCSSI =3D false;
+
+	foreach( CallInfo i, *list ) {
+		if ( i.incoming && !enableCSSU )
+			enableCSSU =3D true;
+		if ( !i.incoming && !enableCSSI )
+			enableCSSI =3D true;
+	}
+
+	widget->CSSIactivation( enableCSSI );
+	widget->CSSUactivation( enableCSSU );
+}
+
+void ControlWidget::CSSIactivation( bool enableCSSI )
+{
+    ui->cbCSSI->setEnabled( enableCSSI );
+}
+
+void ControlWidget::CSSUactivation( bool enableCSSU )
+{
+    ui->cbCSSU->setEnabled( enableCSSU );
+}
+
 void Control::setPhoneNumber( const QString &number )
 {
     widget->setWindowTitle("Phonesim - Number: " + number);
@@ -146,6 +172,10 @@ void Control::warning( const QString &title, const QSt=
ring &message )
 =

 void ControlWidget::handleCSSNNotif()
 {
+
+    ui->cbCSSU->setEnabled( false );
+    ui->cbCSSI->setEnabled( false );
+
     ui->cbCSSU->insertItem(0, "");
     ui->cbCSSU->insertItem(1, "0 - forwarded", 0);
     ui->cbCSSU->insertItem(3, "2 - on hold", 2);
@@ -160,15 +190,15 @@ void ControlWidget::handleCSSNNotif()
 =

 void ControlWidget::sendCSSN()
 {
-    QVariant v =3D ui->cbCSSU->itemData(ui->cbCSSU->currentIndex());
+    QVariant v =3D ui->cbCSSU->itemData( ui->cbCSSU->currentIndex() );
 =

-    if (v.canConvert<int>())
-        emit unsolicitedCommand("+CSSU: "+QString::number(v.toInt()));
+    if ( v.canConvert<int>() && ui->cbCSSU->isEnabled() )
+        emit unsolicitedCommand( "+CSSU: "+QString::number( v.toInt() ) );
 =

     v =3D ui->cbCSSI->itemData(ui->cbCSSI->currentIndex());
 =

-    if (v.canConvert<int>())
-        emit unsolicitedCommand("+CSSI: "+QString::number(v.toInt()));
+    if ( v.canConvert<int>() && ui->cbCSSI->isEnabled() )
+        emit unsolicitedCommand( "+CSSI: "+QString::number( v.toInt() ) );
 }
 =

 void ControlWidget::sendSQ()
diff --git a/src/control.h b/src/control.h
index c17146a..2ccde29 100644
--- a/src/control.h
+++ b/src/control.h
@@ -25,6 +25,7 @@
 #include <QtScript>
 #include "ui_controlbase.h"
 #include "attranslator.h"
+#include "callmanager.h"
 =

 class Control;
 =

@@ -71,6 +72,9 @@ public:
     void handleToData( const QString& );
     void handleNewApp();
     void handleCSSNNotif();
+    void CSSUactivation( bool enableCSSU );
+    void CSSIactivation( bool enableCSSI );
+
 =

 private slots:
     void sendSQ();
@@ -146,6 +150,7 @@ public slots:
     void handleToData( const QString& );
     void setPhoneNumber( const QString& );
     void handleNewApp();
+    void callManagement( QList<CallInfo> *info );
 =

 protected:
     virtual void warning( const QString&, const QString& );
-- =

1.7.1


--===============1085113596189142411==--

