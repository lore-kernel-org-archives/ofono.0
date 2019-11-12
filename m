Content-Type: multipart/mixed; boundary="===============1697396211377820222=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 07/13] Port away from Q_FOREACH
Date: Tue, 12 Nov 2019 22:37:13 +0100
Message-ID: <20191112213719.9309-8-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1697396211377820222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/aidapplication.cpp      |  4 ++--
 src/callmanager.cpp         |  6 +++---
 src/control.cpp             | 19 +++++++++----------
 src/hardwaremanipulator.cpp |  4 ++--
 src/phonesim.cpp            |  4 ++--
 src/qsimcommand.cpp         | 10 +++++-----
 src/simfilesystem.cpp       |  8 ++++----
 7 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/src/aidapplication.cpp b/src/aidapplication.cpp
index e255145..16fef0c 100644
--- a/src/aidapplication.cpp
+++ b/src/aidapplication.cpp
@@ -47,7 +47,7 @@ bool AidAppWrapper::command( const QString& cmd )
             return true;
         }

-        foreach ( AidApplication* app, applications )
+        for ( AidApplication* app : qAsConst(applications) )
         response +=3D app->getAid();

         response.append( "\n\nOK" );
@@ -72,7 +72,7 @@ bool AidAppWrapper::command( const QString& cmd )
         aid =3D cmd.split('=3D')[1];
         aid =3D aid.replace("\"", "");

-        foreach ( AidApplication* app, applications ) {
+        for ( AidApplication* app : qAsConst(applications) ) {
             if ( app->getAid().contains( aid ) ) {
                 if ( sessions.size() >=3D MAX_LOGICAL_CHANNELS )
                     break;
diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index fbdb179..1fa13cf 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -195,7 +195,7 @@ bool CallManager::command( const QString& cmd )
     } else if ( cmd =3D=3D "AT+CLCC" ) {

         // List all calls that are presently active.
-        foreach ( CallInfo info, callList ) {
+        for ( const CallInfo &info : qAsConst(callList) ) {
             int multiparty;
             if ( countForState(info.state) >=3D 2 )
                 multiparty =3D 1;
@@ -821,7 +821,7 @@ int CallManager::newId()
     bool seen;
     for ( id =3D 1; id <=3D 32; ++id ) {
         seen =3D false;
-        foreach ( CallInfo info, callList ) {
+        for ( const CallInfo &info : qAsConst(callList) ) {
             if ( info.id =3D=3D id ) {
                 seen =3D true;
                 break;
@@ -879,7 +879,7 @@ int CallManager::indexForId( int id )

 bool CallManager::hasCall( CallState state )
 {
-    foreach ( CallInfo info, callList ) {
+    for ( const CallInfo &info : qAsConst(callList) ) {
         if ( info.state =3D=3D state )
             return true;
     }
diff --git a/src/control.cpp b/src/control.cpp
index 8c1e412..817a0b2 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -147,7 +147,7 @@ void Control::callManagement( QList<CallInfo> *list )

     widget->clearCallView();

-    foreach( CallInfo i, *list ) {
+    for ( const CallInfo &i : qAsConst(*list) ) {
         QString param[5];

         if ( i.incoming && !enableCSSU )
@@ -181,15 +181,15 @@ void ControlWidget::setStateAlerting()

 void ControlWidget::setStateHangup()
 {
-    QList <QTableWidgetItem *> items =3D ui->twCallMgt->selectedItems();
+    const QList <QTableWidgetItem *> items =3D ui->twCallMgt->selectedItem=
s();

-    foreach ( QTableWidgetItem *item, items )
+    for ( QTableWidgetItem *item : items )
     {
         int row =3D item->row();
         if ( row >=3D 0 )
         {
             QTableWidgetItem *itemCallId =3D ui->twCallMgt->item( row, 0 );
-            if ( itemCallId !=3D 0 )
+            if ( itemCallId !=3D nullptr )
             {
                 QString strid =3D itemCallId->text();
                 int id =3D strid.toInt();
@@ -360,9 +360,9 @@ void ControlWidget::setDefaultGNSSData()

 void ControlWidget::sendGNSSData()
 {
-    QStringList xml =3D ui->teGNSStext->toPlainText().split("\n");
+    const QStringList xml =3D ui->teGNSStext->toPlainText().split("\n");

-    foreach ( QString line, xml )
+    for ( const QString &line : xml )
     {
         if (!line.isEmpty()) {
             QString cposr =3D  "+CPOSR: " + line;
@@ -468,9 +468,8 @@ void Control::handleFromData( const QString& cmd )

 void ControlWidget::handleToData( const QString& cmd )
 {
-    QStringList dataList =3D cmd.split("\n");
-    QString dataItem;
-    foreach( dataItem, dataList ){
+    const QStringList dataList =3D cmd.split("\n");
+    for ( auto &dataItem : dataList ){
         if( dataItem !=3D "" ){
             ui->atViewer->append( dataItem + " : " + translator->translate=
Command(dataItem) );
         }
@@ -564,7 +563,7 @@ void ControlWidget::addVoicemail()

 void ControlWidget::delVoicemail()
 {
-    foreach ( QTableWidgetSelectionRange range,
+    for ( QTableWidgetSelectionRange &range :
             ui->twMessageList->selectedRanges() ) {
         for ( int i =3D range.topRow(); i <=3D range.bottomRow(); i ++ ) {
             VoicemailItem &item =3D mailbox[i];
diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index 6c83c8e..7a61c0e 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -239,7 +239,7 @@ void HardwareManipulator::sendVMNotify( int type, int c=
ount, const QList<QVMMess
             mwiUdh.append( count );    // Number of Voice Messages
             mwiUdh.append( received.size() ); // Number of VM Notifications

-            foreach ( QVMMessage msg, received ) {
+            for ( const QVMMessage &msg : received ) {
                 mwiUdh.append( msg.id & 0xff );
                 mwiUdh.append( msg.id >> 8 ); // Endianness doesn't matter=
 here
                 mwiUdh.append( qMin( msg.lengthSecs, 255 ) );
@@ -261,7 +261,7 @@ void HardwareManipulator::sendVMNotify( int type, int c=
ount, const QList<QVMMess
             mwiUdh.append( count ); // Number of Voice Messages
             mwiUdh.append( deleted.size() ); // Number of VM Notifications

-            foreach ( QVMMessage msg, deleted ) {
+            for ( const QVMMessage &msg : deleted ) {
                 mwiUdh.append( msg.id & 0xff );
                 mwiUdh.append( msg.id >> 8 ); // Endianness doesn't matter=
 here
                 mwiUdh.append( qMin( msg.lengthSecs, 255 ) );
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 1fd3c15..0f72a09 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -1380,9 +1380,9 @@ void SimRules::phoneBook( const QString& cmd )
     }

     if ( cmd.startsWith( "AT+CPBS=3D?" ) ) {
-        QStringList names =3D phoneBooks.keys();
+        const QStringList names =3D phoneBooks.keys();
         QString response =3D "+CPBS: (";
-        foreach ( QString name, names ) {
+        for ( const QString &name : names ) {
             if ( response.length() > 8 )
                 response +=3D QChar(',');
             response +=3D "\"" + name + "\"";
diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index 6642035..fb200ed 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -3119,7 +3119,7 @@ static void writeSubAddress( QByteArray& data, const =
QString& value )
     writeBerLength( data, value.length() + 2 );
     data +=3D (char)0x80;     // NSAP address type
     data +=3D (char)0x50;     // NSAP address is BCD-encoded IA5 characters
-    foreach ( QChar ch, value ) {
+    for ( const QChar &ch : value ) {
         int val =3D ch.unicode() - 32;
         if ( val > 127 )
             val =3D 0;
@@ -3368,7 +3368,7 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpti=
ons options ) const
                 data +=3D (char)0x8F;
                 data +=3D (char)0x00;
             }
-            foreach ( QSimMenuItem item, menuItems() ) {
+            for ( QSimMenuItem &item : menuItems() ) {
                 QByteArray contents;
                 contents +=3D (char)item.identifier();
                 writeEFADN( contents, item.label(), options, -1 );
@@ -3386,7 +3386,7 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpti=
ons options ) const
             if ( hasNextActions ) {
                 data +=3D (char)0x18;
                 data +=3D (char)menuItems().size();
-                foreach ( QSimMenuItem item, menuItems() )
+                for ( const QSimMenuItem &item : menuItems() )
                     data +=3D (char)item.nextAction();
             }
             if ( type() =3D=3D SelectItem && defaultItem() !=3D 0 ) {
@@ -3399,14 +3399,14 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOp=
tions options ) const
                 data +=3D (char)0x9F;
                 data +=3D (char)(menuItems().size() + 1);
                 data +=3D (char)(selfExplanatory ? 0x00 : 0x01);
-                foreach ( QSimMenuItem item, menuItems() )
+                for ( const QSimMenuItem &item : menuItems() )
                     data +=3D (char)item.iconId();
             }
             writeTextAttribute( data, titleAttribute() );
             if ( attrLen !=3D 0 ) {
                 data +=3D (char)0xD1;
                 writeBerLength( data, attrLen );
-                foreach ( QSimMenuItem item, menuItems() ) {
+                for ( QSimMenuItem &item : menuItems() ) {
                     data +=3D item.labelAttribute();
                 }
             }
diff --git a/src/simfilesystem.cpp b/src/simfilesystem.cpp
index 0e5c2a9..b3ea8a4 100644
--- a/src/simfilesystem.cpp
+++ b/src/simfilesystem.cpp
@@ -514,9 +514,9 @@ SimFileItem *SimFileSystem::findItemRelative( const QSt=
ring& fileid )
         item =3D currentItem->parentDir();
     } else {
         // Search the current item's immediate children.
-        QList<SimFileItem *> children =3D currentItem->children();
-        item =3D 0;
-        foreach( SimFileItem *temp, children ) {
+        const QList<SimFileItem *> children =3D currentItem->children();
+        item =3D nullptr;
+        for ( SimFileItem *temp : children ) {
             if ( temp->fileid() =3D=3D fileid ) {
                 item =3D temp;
                 break;
@@ -635,7 +635,7 @@ SimFileItem *SimFileItem::findItem( const QString& file=
id )
 {
     if ( fileid =3D=3D _fileid )
         return this;
-    foreach ( SimFileItem *item, _children ) {
+    for ( SimFileItem *item : qAsConst(_children) ) {
         SimFileItem *temp =3D item->findItem( fileid );
         if ( temp )
             return temp;
--
2.24.0

--===============1697396211377820222==--

