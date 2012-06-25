Content-Type: multipart/mixed; boundary="===============6811328298180084000=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 5/7] hardwaremanipulator: Add multi-page support for CBS
 message
Date: Mon, 25 Jun 2012 16:38:01 +0200
Message-ID: <1340635083-5877-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340635083-5877-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6811328298180084000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hardwaremanipulator.cpp |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index c19b507..b746229 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -123,13 +123,44 @@ void HardwareManipulator::constructCBMessage(const QS=
tring &messageCode, int geo
     m.setPage(pag);
     m.setText(content);
 =

+    uint nbPages, spaceLeftInLast;
+
+    if ( scheme =3D=3D 0 && content.length() > (15*93)) {
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
+    m.computeSize( nbPages, spaceLeftInLast );
+    if ( npag < nbPages ) {
+	    warning(tr("Invalid number of pages"),
+		tr("The required number of pages is "
+	                   "higher than the given number"));
+	    m.setNumPages(nbPages);
+    }
+
     sendCBS(m);
 }
 =

 void HardwareManipulator::sendCBS( const QCBSMessage &m )
 {
-    QByteArray pdu =3D m.toPdu();
-    emit unsolicitedCommand(QString("+CBM: ")+QString::number(pdu.length()=
)+'\r'+'\n'+ PS_toHex(pdu));
+    if( m.shouldSplit() ) {
+        QList<QCBSMessage> list =3D m.split();
+
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


--===============6811328298180084000==--

