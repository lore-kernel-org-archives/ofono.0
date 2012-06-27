Content-Type: multipart/mixed; boundary="===============0617184376741279971=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 4/6] hardwaremanipulator: Add multi-page support for CBS
 message
Date: Wed, 27 Jun 2012 17:10:43 +0200
Message-ID: <1340809845-26595-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340809845-26595-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0617184376741279971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hardwaremanipulator.cpp |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index 3d0f54a..6753da1 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -127,8 +127,17 @@ void HardwareManipulator::constructCBMessage(const QSt=
ring &messageCode, int geo
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


--===============0617184376741279971==--

