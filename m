Content-Type: multipart/mixed; boundary="===============4961289316827379603=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 4/4] hardwaremanipulator: Add multi-page support for CBS
 message
Date: Fri, 29 Jun 2012 17:53:03 +0200
Message-ID: <1340985183-22049-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340985183-22049-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4961289316827379603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hardwaremanipulator.cpp |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index 93a9e02..528f119 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -108,8 +108,25 @@ void HardwareManipulator::constructCBMessage(const QSt=
ring &messageCode, int geo
 =

 void HardwareManipulator::sendCBS( const QCBSMessage &m )
 {
-    QByteArray pdu =3D m.toPdu();
-    emit unsolicitedCommand(QString("+CBM: ")+QString::number(pdu.length()=
)+'\r'+'\n'+ PS_toHex(pdu));
+    uint numPages, spaceLeftInLast;
+    m.computeSize( numPages, spaceLeftInLast );
+
+    if ( numPages > 15) {
+            warning(tr("Text too long"),
+                    tr("The maximum number of pages (15) is reached"
+                       " - Text is truncated"));
+    }
+
+    if( numPages >1 ) {
+        QList<QCBSMessage> list =3D m.split();
+        for( int i =3D0; i < list.count(); i++ ) {
+            QByteArray pdu =3D list[i].toPdu();
+             emit unsolicitedCommand(QString("+CBM: ")+QString::number(pdu=
.length())+'\r'+'\n'+ PS_toHex(pdu));
+         }
+    } else {
+        QByteArray pdu =3D m.toPdu();
+        emit unsolicitedCommand(QString("+CBM: ")+QString::number(pdu.leng=
th())+'\r'+'\n'+ PS_toHex(pdu));
+    }
 }
 =

 void HardwareManipulator::constructSMSMessage( const int type, const QStri=
ng &sender, const QString &serviceCenter, const QString &text )
-- =

1.7.9.5


--===============4961289316827379603==--

