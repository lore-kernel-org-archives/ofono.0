Content-Type: multipart/mixed; boundary="===============6653238751557020672=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH v2 6/6] control: Update call view
Date: Mon, 02 May 2011 11:17:18 +0200
Message-ID: <1304327838-11164-7-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1304327838-11164-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6653238751557020672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp |  100 +++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 src/control.h   |    3 +-
 2 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 1e71593..a9b2fd5 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -136,14 +136,79 @@ Control::~Control()
 =

 void Control::callManagement( QList<CallInfo> *list )
 {
+    int row =3D 0;
     bool enableCSSU =3D false;
     bool enableCSSI =3D false;
 =

+    widget->clearCallView();
+
     foreach( CallInfo i, *list ) {
+        QString param[5];
+
         if ( i.incoming && !enableCSSU )
             enableCSSU =3D true;
         if ( !i.incoming && !enableCSSI )
             enableCSSI =3D true;
+
+        param[0].setNum( i.id );
+        param[1] =3D i.number;
+
+        switch( i.state ) {
+
+            case CallState_Active:
+            {
+                param[2] =3D "Active";
+            }
+            break;
+
+            case CallState_Held:
+            {
+                param[2] =3D "Held";
+            }
+            break;
+
+            case CallState_Dialing:
+            {
+                param[2] =3D "Dialing";
+            }
+            break;
+
+            case CallState_Alerting:
+            {
+                param[2] =3D "Alerting";
+            }
+            break;
+
+            case CallState_Incoming:
+            {
+                param[2] =3D "Incoming";
+            }
+            break;
+
+            case CallState_Waiting:
+            {
+                param[2] =3D "Waiting";
+            }
+            break;
+
+            case CallState_Hangup:
+            {
+                param[2] =3D "Hangup";
+            }
+            break;
+
+            case CallState_SwapDummy:
+            {
+                param[2] =3D "SwapDummy";
+            }
+            break;
+        }
+
+        param[3] =3D i.name;
+        param[4] =3D i.incoming ? "incoming" : "outgoing";
+
+        widget->updateCallView( param, row );
+        row++;
     }
 =

     widget->setCssiEnabled( enableCSSI );
@@ -160,6 +225,20 @@ void ControlWidget::setCssuEnabled( bool enableCSSU )
     ui->cbCSSU->setEnabled( enableCSSU );
 }
 =

+void ControlWidget::clearCallView()
+{
+    ui->twCallMgt->clearContents();
+}
+
+void ControlWidget::updateCallView( QString callParameters [5], int row )
+{
+    if ( row > ui->twCallMgt->rowCount() - 1 )
+        ui->twCallMgt->insertRow( row );
+
+    for ( int i =3D 0; i < 5; i++ )
+        ui->twCallMgt->setItem( row, i, new QTableWidgetItem( callParamete=
rs[i] ) );
+}
+
 void Control::setPhoneNumber( const QString &number )
 {
     widget->setWindowTitle("Phonesim - Number: " + number);
@@ -172,20 +251,19 @@ void Control::warning( const QString &title, const QS=
tring &message )
 =

 void ControlWidget::handleCSSNNotif()
 {
-
     ui->cbCSSU->setEnabled( false );
     ui->cbCSSI->setEnabled( false );
 =

-    ui->cbCSSU->insertItem(0, "");
-    ui->cbCSSU->insertItem(1, "0 - forwarded", 0);
-    ui->cbCSSU->insertItem(3, "2 - on hold", 2);
-    ui->cbCSSU->insertItem(4, "3 - retrieved", 3);
-    ui->cbCSSU->insertItem(5, "4 - multiparty", 4);
+    ui->cbCSSU->insertItem( 0, "" );
+    ui->cbCSSU->insertItem( 1, "0 - forwarded", 0 );
+    ui->cbCSSU->insertItem( 3, "2 - on hold", 2 );
+    ui->cbCSSU->insertItem( 4, "3 - retrieved", 3 );
+    ui->cbCSSU->insertItem( 5, "4 - multiparty", 4 );
 =

-    ui->cbCSSI->insertItem(0, "");
-    ui->cbCSSI->insertItem(3, "2 - forwarded", 2);
-    ui->cbCSSI->insertItem(6, "5 - outgoing barred", 5);
-    ui->cbCSSI->insertItem(7, "6 - incomming barred", 6);
+    ui->cbCSSI->insertItem( 0, "" );
+    ui->cbCSSI->insertItem( 3, "2 - forwarded", 2 );
+    ui->cbCSSI->insertItem( 6, "5 - outgoing barred", 5 );
+    ui->cbCSSI->insertItem( 7, "6 - incomming barred", 6 );
 }
 =

 void ControlWidget::sendCSSN()
@@ -195,7 +273,7 @@ void ControlWidget::sendCSSN()
     if ( v.canConvert<int>() && ui->cbCSSU->isEnabled() )
         emit unsolicitedCommand( "+CSSU: "+QString::number( v.toInt() ) );
 =

-    v =3D ui->cbCSSI->itemData(ui->cbCSSI->currentIndex());
+    v =3D ui->cbCSSI->itemData( ui->cbCSSI->currentIndex() );
 =

     if ( v.canConvert<int>() && ui->cbCSSI->isEnabled() )
         emit unsolicitedCommand( "+CSSI: "+QString::number( v.toInt() ) );
diff --git a/src/control.h b/src/control.h
index 3acffc9..ac39eb3 100644
--- a/src/control.h
+++ b/src/control.h
@@ -74,7 +74,8 @@ public:
     void handleCSSNNotif();
     void setCssuEnabled( bool enableCSSU );
     void setCssiEnabled( bool enableCSSI );
-
+    void updateCallView( QString callParameters [5], int row );
+    void clearCallView();
 =

 private slots:
     void sendSQ();
-- =

1.7.1


--===============6653238751557020672==--

