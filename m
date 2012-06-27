Content-Type: multipart/mixed; boundary="===============7010681728485623743=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/6] hardwaremanipulator: Use the best scheme for CBS message
Date: Wed, 27 Jun 2012 17:10:42 +0200
Message-ID: <1340809845-26595-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340809845-26595-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7010681728485623743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp             |    9 +++----
 src/hardwaremanipulator.cpp |   61 ++++++++++++++++++++++-----------------=
----
 src/hardwaremanipulator.h   |    6 +++--
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 27910c2..9085acd 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -329,12 +329,9 @@ void ControlWidget::sendREG()
 =

 void ControlWidget::sendCBM()
 {
-    QString pdu =3D p->constructCBMessage(ui->leMessageCode->text(),ui->cb=
GeographicalScope->currentIndex(),
-                       ui->leUpdateNumber->text(),ui->leChannel->text(),ui=
->leScheme->text(),
-                       ui->cbLanguage->currentIndex(),ui->leNumPages->text=
(),ui->lePage->text(),
-                       ui->teContent->toPlainText());
-
-    emit unsolicitedCommand(QString("+CBM: ")+QString::number(pdu.length()=
/2)+'\r'+'\n'+ pdu);
+    p->constructCBMessage(ui->leMessageCode->text(),ui->cbGeographicalScop=
e->currentIndex(),
+                       ui->leUpdateNumber->text(),ui->leChannel->text(),
+                       ui->cbLanguage->currentIndex(),ui->teContent->toPla=
inText());
 }
 =

 void ControlWidget::sendSMSMessage()
diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index 2d7b141..3d0f54a 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -62,8 +62,8 @@ void HardwareManipulator::setPhoneNumber( const QString& )
 =

 QString PS_toHex( const QByteArray& binary );
 =

-QString HardwareManipulator::constructCBMessage(const QString &messageCode=
, int geographicalScope, const QString &updateNumber,
-    const QString &channel, const QString &/*scheme*/, int language, const=
 QString &numPages, const QString &page, const QString &content)
+void HardwareManipulator::constructCBMessage(const QString &messageCode, i=
nt geographicalScope, const QString &updateNumber,
+    const QString &channel, int language, const QString &content)
 {
 =

     bool ok;
@@ -71,10 +71,9 @@ QString HardwareManipulator::constructCBMessage(const QS=
tring &messageCode, int
     if ( !ok ) {
         warning(tr("Invalid Message Code"),
                 tr("Message code 3 hex digits long and no larger than 3FF"=
));
-        return "";
+        return;
     }
 =

-
     QCBSMessage::GeographicalScope gs =3D (QCBSMessage::GeographicalScope)=
geographicalScope;
 =

     uint un =3D convertString(updateNumber,NIBBLE_MAX,ONE_CHAR,HEX_BASE,&o=
k);
@@ -82,7 +81,7 @@ QString HardwareManipulator::constructCBMessage(const QSt=
ring &messageCode, int
         warning(tr("Invalid Update Number"),
                 tr("Update number must be 1 hex digit long"
                    "and no larger than F"));
-        return "";
+        return;
     }
 =

 =

@@ -91,43 +90,45 @@ QString HardwareManipulator::constructCBMessage(const Q=
String &messageCode, int
         warning(tr("Invalid Channel,"),
                 tr("Channel  must be 4 hex digits long "
                    "and no larger than FFFF"));
-        return "";
+        return;
     }
 =

-    //scheme is currently hardcoded to QSMS8_BitCodingScheme
-    //uint sch =3D convertString(scheme, NIBBLE_MAX, ONE_CHAR,HEX_BASE,&ok=
);
-    //if ( !ok )
-    //    return "";
-
     QCBSMessage::Language lang =3D (QCBSMessage::Language)language;
 =

-    uint npag =3D convertString(numPages, NIBBLE_MAX,ONE_CHAR,HEX_BASE,&ok=
);
-    if ( !ok ) {
-        warning(tr("Invalid number of pages,"),
-                tr("Number of pages  must be 1 hex digit long "
-                   "and no larger than F"));
-        return "";
-    }
-
-    uint pag =3D convertString(page, NIBBLE_MAX,ONE_CHAR,HEX_BASE,&ok);
-    if ( !ok ) {
-        warning(tr("Invalid page number,"),
-                tr("Page number  must be 1 hex digit long "
-                   "and no larger than F"));
-        return "";
-    }
-
     QCBSMessage m;
     m.setMessageCode(mc);
     m.setScope(gs);
     m.setUpdateNumber(un);
     m.setChannel(ch);
     m.setLanguage(lang);
-    m.setNumPages(npag);
-    m.setPage(pag);
+    m.setPage(1);
     m.setText(content);
+    m.setDataCodingScheme(m.bestScheme());
+
+    if ( m.dataCodingScheme() =3D=3D QSMS_DefaultAlphabet &&
+                content.length() > (15*93)) {
+        warning(tr("Text too long"),
+        tr("The maximum number of pages (15) "
+                          "is reached - text is truncated"));
+        m.setText(content.mid( 0, 15*93 ));
+    } else if (content.length() > (15*40)) {
+        warning(tr("Text too long"),
+        tr("The maximum number of pages (15) "
+                           "is reached - text is truncated"));
+        m.setText(content.mid( 0, 15*40 ));
+    }
+
+    uint nbPages, spaceLeftInLast;
+    m.computeSize( nbPages, spaceLeftInLast );
+    m.setNumPages(nbPages);
 =

-    return PS_toHex( m.toPdu() );
+    sendCBS(m);
+}
+
+void HardwareManipulator::sendCBS( const QCBSMessage &m )
+{
+    QByteArray pdu =3D m.toPdu();
+    emit unsolicitedCommand(QString("+CBM: ")+QString::number(pdu.length()=
)+'\r'+'\n'+ PS_toHex(pdu));
 }
 =

 void HardwareManipulator::constructSMSMessage( const int type, const QStri=
ng &sender, const QString &serviceCenter, const QString &text )
diff --git a/src/hardwaremanipulator.h b/src/hardwaremanipulator.h
index 881125e..87a8c6e 100644
--- a/src/hardwaremanipulator.h
+++ b/src/hardwaremanipulator.h
@@ -25,6 +25,7 @@
 #include "qsmsmessagelist.h"
 =

 class QSMSMessage;
+class QCBSMessage;
 class QVMMessage;
 class SimRules;
 struct CallInfo;
@@ -43,6 +44,7 @@ public slots:
     virtual void handleToData( const QString& );
     virtual void setPhoneNumber( const QString& );
     virtual void constructSMSMessage(const int type, const QString &sender=
, const QString &serviceCenter, const QString &text);
+    virtual void sendCBS( const QCBSMessage& m );
     virtual void sendSMS( const QSMSMessage& m );
     virtual void sendVMNotify( int type, int count, const QList<QVMMessage=
> &received, const QList<QVMMessage> &deleted, const QString &mailbox );
     virtual void sendUSSD( bool cancel, bool response, const QString &cont=
ent );
@@ -63,8 +65,8 @@ signals:
     void stateChangedToHangup( int callId );
 =

 protected:
-    virtual QString constructCBMessage(const QString &messageCode, int geo=
graphicalScope, const QString &updateNumber, const QString &channel,
-    const QString &scheme, int language, const QString &numPages, const QS=
tring &page, const QString &content);
+    virtual void constructCBMessage(const QString &messageCode, int geogra=
phicalScope, const QString &updateNumber, const QString &channel,
+    int language, const QString &content);
     virtual void constructSMSDatagram(int src, int dst, const QString &sen=
der,  const QByteArray &data, const QByteArray &contentType);
 =

     virtual void warning(const QString &title, const QString &message);
-- =

1.7.9.5


--===============7010681728485623743==--

