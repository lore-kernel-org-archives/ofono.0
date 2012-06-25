Content-Type: multipart/mixed; boundary="===============8969246877782395172=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 4/7] hardwaremanipulator: Add UCS2 encoding support for CBS
 message
Date: Mon, 25 Jun 2012 16:38:00 +0200
Message-ID: <1340635083-5877-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340635083-5877-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8969246877782395172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp             |    6 ++----
 src/hardwaremanipulator.cpp |   28 +++++++++++++++-------------
 src/hardwaremanipulator.h   |    6 ++++--
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 27910c2..89dd294 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -329,12 +329,10 @@ void ControlWidget::sendREG()
 =

 void ControlWidget::sendCBM()
 {
-    QString pdu =3D p->constructCBMessage(ui->leMessageCode->text(),ui->cb=
GeographicalScope->currentIndex(),
-                       ui->leUpdateNumber->text(),ui->leChannel->text(),ui=
->leScheme->text(),
+    p->constructCBMessage(ui->leMessageCode->text(),ui->cbGeographicalScop=
e->currentIndex(),
+                       ui->leUpdateNumber->text(),ui->leChannel->text(),ui=
->cbScheme->currentIndex(),
                        ui->cbLanguage->currentIndex(),ui->leNumPages->text=
(),ui->lePage->text(),
                        ui->teContent->toPlainText());
-
-    emit unsolicitedCommand(QString("+CBM: ")+QString::number(pdu.length()=
/2)+'\r'+'\n'+ pdu);
 }
 =

 void ControlWidget::sendSMSMessage()
diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index 909ce2a..c19b507 100644
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
+    const QString &channel, int scheme, int language, const QString &numPa=
ges, const QString &page, const QString &content)
 {
 =

     bool ok;
@@ -71,7 +71,7 @@ QString HardwareManipulator::constructCBMessage(const QSt=
ring &messageCode, int
     if ( !ok ) {
         warning(tr("Invalid Message Code"),
                 tr("Message code 3 hex digits long and no larger than 3FF"=
));
-        return "";
+        return;
     }
 =

 =

@@ -82,7 +82,7 @@ QString HardwareManipulator::constructCBMessage(const QSt=
ring &messageCode, int
         warning(tr("Invalid Update Number"),
                 tr("Update number must be 1 hex digit long"
                    "and no larger than F"));
-        return "";
+        return;
     }
 =

 =

@@ -91,14 +91,9 @@ QString HardwareManipulator::constructCBMessage(const QS=
tring &messageCode, int
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

     uint npag =3D convertString(numPages, NIBBLE_MAX,ONE_CHAR,HEX_BASE,&ok=
);
@@ -106,7 +101,7 @@ QString HardwareManipulator::constructCBMessage(const Q=
String &messageCode, int
         warning(tr("Invalid number of pages,"),
                 tr("Number of pages  must be 1 hex digit long "
                    "and no larger than F"));
-        return "";
+        return;
     }
 =

     uint pag =3D convertString(page, NIBBLE_MAX,ONE_CHAR,HEX_BASE,&ok);
@@ -114,7 +109,7 @@ QString HardwareManipulator::constructCBMessage(const Q=
String &messageCode, int
         warning(tr("Invalid page number,"),
                 tr("Page number  must be 1 hex digit long "
                    "and no larger than F"));
-        return "";
+        return;
     }
 =

     QCBSMessage m;
@@ -123,11 +118,18 @@ QString HardwareManipulator::constructCBMessage(const=
 QString &messageCode, int
     m.setUpdateNumber(un);
     m.setChannel(ch);
     m.setLanguage(lang);
+    m.setDataCodingScheme(scheme =3D=3D 0 ? QSMS_DefaultAlphabet : QSMS_UC=
S2Alphabet);
     m.setNumPages(npag);
     m.setPage(pag);
     m.setText(content);
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
index 881125e..75e0a94 100644
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
+    int scheme, int language, const QString &numPages, const QString &page=
, const QString &content);
     virtual void constructSMSDatagram(int src, int dst, const QString &sen=
der,  const QByteArray &data, const QByteArray &contentType);
 =

     virtual void warning(const QString &title, const QString &message);
-- =

1.7.9.5


--===============8969246877782395172==--

