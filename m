Content-Type: multipart/mixed; boundary="===============8998792874544935944=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/6] qcbsmessage: Add bestScheme method in QCBSMessage class
Date: Wed, 27 Jun 2012 17:10:41 +0200
Message-ID: <1340809845-26595-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340809845-26595-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8998792874544935944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qcbsmessage.cpp |   10 ++++++++--
 src/qcbsmessage.h   |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/qcbsmessage.cpp b/src/qcbsmessage.cpp
index 0556cc0..e4403ae 100644
--- a/src/qcbsmessage.cpp
+++ b/src/qcbsmessage.cpp
@@ -396,9 +396,15 @@ void QCBSMessage::print()
                   << ", text=3D" << text();
 }
 =

-static QSMSDataCodingScheme bestScheme( const QString& body )
+/*!
+    Returns the best CBS data coding scheme to use for this
+    message, determined by an inspection of the plain text body.
+
+*/
+int QCBSMessage::bestScheme() const
 {
     QTextCodec *codec =3D QAtUtils::codec( "gsm-noloss" );
+    QString body =3D text();
     uint len =3D body.length();
     bool gsmSafe;
 =

@@ -427,7 +433,7 @@ QByteArray QCBSMessage::toPdu() const
     QSMSDataCodingScheme scheme;
 =

     if(dataCodingScheme() =3D=3D -1)
-        scheme =3D bestScheme( text() );
+        scheme =3D (QSMSDataCodingScheme)bestScheme();
     else
         scheme =3D (QSMSDataCodingScheme)dataCodingScheme();
 =

diff --git a/src/qcbsmessage.h b/src/qcbsmessage.h
index f6ed364..0f055b7 100644
--- a/src/qcbsmessage.h
+++ b/src/qcbsmessage.h
@@ -96,6 +96,7 @@ public:
     QByteArray toPdu() const;
     static QCBSMessage fromPdu( const QByteArray& pdu );
 =

+    int bestScheme() const;
     bool shouldSplit() const;
     QList<QCBSMessage> split() const;
     void computeSize( uint& numPages, uint& spaceLeftInLast ) const;
-- =

1.7.9.5


--===============8998792874544935944==--

