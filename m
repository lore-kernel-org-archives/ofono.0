Content-Type: multipart/mixed; boundary="===============2081013724960956672=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 6/7] sms: Extend CBS message formating to use UCS2 scheme
Date: Mon, 25 Jun 2012 16:38:02 +0200
Message-ID: <1340635083-5877-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340635083-5877-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2081013724960956672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qsmsmessage.cpp |  119 +++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 111 insertions(+), 8 deletions(-)

diff --git a/src/qsmsmessage.cpp b/src/qsmsmessage.cpp
index 1e2a317..c2eeb29 100644
--- a/src/qsmsmessage.cpp
+++ b/src/qsmsmessage.cpp
@@ -20,6 +20,7 @@
 #include <stdlib.h>
 =

 #include <qsmsmessage.h>
+#include <qcbsmessage.h>
 #include "qsmsmessage_p.h"
 #include <qatutils.h>
 #include <qgsmcodec.h>
@@ -2462,6 +2463,93 @@ QSMSMessage QSMSDeliverMessage::unpack(QTextCodec *c=
odec)
     return m;
 }
 =

+static void iso639_2_from_language(QCBSMessage::Language lang, char *iso63=
9)
+{
+    switch (lang) {
+    case QCBSMessage::German:
+        iso639[0] =3D 'd';
+        iso639[1] =3D 'e';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::English:
+        iso639[0] =3D 'e';
+        iso639[1] =3D 'n';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Italian:
+        iso639[0] =3D 'i';
+        iso639[1] =3D 't';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::French:
+        iso639[0] =3D 'f';
+        iso639[1] =3D 'r';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Spanish:
+        iso639[0] =3D 'e';
+        iso639[1] =3D 's';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Dutch:
+        iso639[0] =3D 'n';
+        iso639[1] =3D 'l';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Swedish:
+        iso639[0] =3D 's';
+        iso639[1] =3D 'v';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Danish:
+        iso639[0] =3D 'd';
+        iso639[1] =3D 'a';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Portuguese:
+        iso639[0] =3D 'p';
+        iso639[1] =3D 't';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Finnish:
+        iso639[0] =3D 'f';
+        iso639[1] =3D 'i';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Norwegian:
+        iso639[0] =3D 'n';
+        iso639[1] =3D 'o';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Greek:
+        iso639[0] =3D 'e';
+        iso639[1] =3D 'l';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Turkish:
+        iso639[0] =3D 't';
+        iso639[1] =3D 'r';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Hungarian:
+        iso639[0] =3D 'h';
+        iso639[1] =3D 'u';
+        iso639[2] =3D '\0';
+        break;
+    case QCBSMessage::Polish:
+        iso639[0] =3D 'p';
+        iso639[1] =3D 'l';
+        iso639[2] =3D '\0';
+        break;
+    default:
+        iso639[0] =3D '\0';
+        iso639[1] =3D '\0';
+        iso639[2] =3D '\0';
+        break;
+    }
+
+    return;
+}
 =

 QCBSDeliverMessage::QCBSDeliverMessage()
     : QPDUMessage()
@@ -2518,29 +2606,44 @@ QCBSMessage QCBSDeliverMessage::unpack(QTextCodec *=
codec)
 =

 void QCBSDeliverMessage::pack(const QCBSMessage &m, QSMSDataCodingScheme s=
cheme)
 {
+    int numPad;
+    QTextCodec *codec =3D QAtUtils::codec( "gsm" );
+    QByteArray header;
+
     // Clear the pdu before we start.
     mBuffer =3D QByteArray();
     mPosn =3D 0;
     mBits =3D 0;
 =

-    scheme =3D QSMS_DefaultAlphabet;
-    QByteArray data;
     mBuffer.append( (char) (((m.messageCode() >> 4) & 0x3F) | (m.scope() <=
< 6)) );
     mBuffer.append( (char)(((m.messageCode() & 0xF) << 4) | (m.updateNumbe=
r() & 0xF)) );
     mBuffer.append( (char)((m.channel() & 0x0000FF00) >> 8) );
     mBuffer.append( (char)(m.channel() & 0x000000FF) );
-    mBuffer.append( (char)(((scheme & 0x0F)<<4) | (m.language() & 0x0F)) );
-    mBuffer.append( (char)((m.numPages() & 0x0F) | ((m.page() & 0x0F) << 4=
)) );
 =

-    QTextCodec *codec =3D QAtUtils::codec( "gsm" );
-    QByteArray header;
+    if (scheme =3D=3D QSMS_UCS2Alphabet)
+        mBuffer.append( 0x11 );
+    else
+        mBuffer.append( (char)(((scheme & 0x0F)<<4) | (m.language() & 0x0F=
)) );
+
+    mBuffer.append( (char)((m.numPages() & 0x0F) | ((m.page() & 0x0F) << 4=
)) );
 =

     QString paddedText =3D m.text();
 =

-    int numPad =3D 93 - getEncodedLength(paddedText, paddedText.length());
+    if (scheme =3D=3D QSMS_UCS2Alphabet) {
+        char iso639[3];
+        unsigned short c;
+
+        iso639_2_from_language(m.language(), iso639);
+        c =3D ((iso639[1] & 0x7F)<<7) | (iso639[0] & 0x7F);
+        mBuffer.append( (char)(c & 0xFF) );
+        mBuffer.append( (char)(c >> 8) );
+        numPad =3D 40 - (paddedText.length());
+    }
+    else
+        numPad =3D 93 - getEncodedLength(paddedText, paddedText.length());
 =

     for (int i =3D 0; i < numPad; i++)
-    	paddedText.append(QChar(0x0D));
+        paddedText.append(QChar(0x0D));
 =

     setUserData(paddedText, scheme, codec, header,true);
 }
-- =

1.7.9.5


--===============2081013724960956672==--

