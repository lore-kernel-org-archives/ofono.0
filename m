Content-Type: multipart/mixed; boundary="===============7949996718222572396=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 7/7] hardwaremanipulator: Add USC2 encoding support for USSD.
Date: Mon, 25 Jun 2012 16:38:03 +0200
Message-ID: <1340635083-5877-8-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340635083-5877-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7949996718222572396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hardwaremanipulator.cpp |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index b746229..056480c 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -320,14 +320,37 @@ void HardwareManipulator::sendVMNotify( int type, int=
 count, const QList<QVMMess
 void HardwareManipulator::sendUSSD( bool cancel, bool response,
 		const QString &content )
 {
-    QTextCodec *codec =3D QAtUtils::codec( rules->variable("SCS") );
     /* TODO: if rules->variable("USD") =3D=3D "0" then return */
     if (cancel)
         emit unsolicitedCommand( "+CUSD: 2" );
-    else
+    else {
+        QTextCodec *codec =3D QAtUtils::codec( "gsm-noloss" );
+        bool gsmSafe;
+        QString request;
+
+        // Check the body for non-GSM characters.
+        gsmSafe =3D codec->canEncode( content );
+
+        // Use the default alphabet if everything is GSM-compatible.
+        if ( gsmSafe ) {
+            QTextCodec *codec =3D QAtUtils::codec( rules->variable("SCS") =
);
+            request=3D QAtUtils::quote( content, codec );
+        } else {
+            // Encode the text using the 16-bit UCS2 alphabet.
+            uint u;
+            QByteArray binary;
+            uint len =3D content.length();
+
+            for ( u =3D 0; u < len; u++ ) {
+                binary +=3D (unsigned char)(content[u].unicode() >> 8);
+                binary +=3D (unsigned char)(content[u].unicode() & 0xFF);
+            }
+            request =3D PS_toHex( binary );
+        }
         emit unsolicitedCommand( "+CUSD: " +
-                        QString::number( response ? 1 : 0 ) + ",\"" +
-                        QAtUtils::quote( content, codec ) + "\",0" );
+                    QString::number( response ? 1 : 0 ) + ",\"" +
+                    request + "\"," + QString::number( gsmSafe ? 0 : 0x48 =
));
+    }
 }
 =

 bool HardwareManipulator::getSimPresent()
-- =

1.7.9.5


--===============7949996718222572396==--

