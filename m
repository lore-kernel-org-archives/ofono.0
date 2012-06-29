Content-Type: multipart/mixed; boundary="===============7997907484454120403=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 2/4] qcbsmessage: apply the same coding scheme for all the
 pages
Date: Fri, 29 Jun 2012 17:53:01 +0200
Message-ID: <1340985183-22049-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340985183-22049-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7997907484454120403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qcbsmessage.cpp |   38 ++++++++++++++------------------------
 src/qcbsmessage.h   |    1 -
 2 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/src/qcbsmessage.cpp b/src/qcbsmessage.cpp
index e4403ae..da975dd 100644
--- a/src/qcbsmessage.cpp
+++ b/src/qcbsmessage.cpp
@@ -408,6 +408,9 @@ int QCBSMessage::bestScheme() const
     uint len =3D body.length();
     bool gsmSafe;
 =

+    if ( d->mDataCodingScheme !=3D (QSMSDataCodingScheme)-1 )
+        return d->mDataCodingScheme;
+
     // Encode zero-length bodies in the default alphabet.
     if ( len =3D=3D 0 )
         return QSMS_DefaultAlphabet;
@@ -430,14 +433,8 @@ int QCBSMessage::bestScheme() const
 QByteArray QCBSMessage::toPdu() const
 {
     QCBSDeliverMessage deliver;
-    QSMSDataCodingScheme scheme;
-
-    if(dataCodingScheme() =3D=3D -1)
-        scheme =3D (QSMSDataCodingScheme)bestScheme();
-    else
-        scheme =3D (QSMSDataCodingScheme)dataCodingScheme();
 =

-    deliver.pack( *this, scheme );
+    deliver.pack( *this, (QSMSDataCodingScheme)bestScheme() );
     return deliver.toByteArray();
 }
 =

@@ -461,7 +458,7 @@ void QCBSMessage::computeSize( uint& numPages, uint& sp=
aceLeftInLast ) const
 {
     QString body =3D text();
     uint len =3D body.length();
-    uint scheme=3D dataCodingScheme();
+    uint scheme=3D bestScheme();
 =

     if ( scheme =3D=3D QSMS_DefaultAlphabet ) {
         // Encode the message using 7-bit GSM.
@@ -493,19 +490,6 @@ void QCBSMessage::computeSize( uint& numPages, uint& s=
paceLeftInLast ) const
 }
 =

 /*!
-    Returns true if this message needs to be split into multiple messages
-    before being transmitted over a GSM network; otherwise returns false.
-
-    \sa split()
-*/
-bool QCBSMessage::shouldSplit() const
-{
-    uint numPages, spaceLeftInLast;
-    this->computeSize( numPages, spaceLeftInLast );
-    return ( numPages <=3D1 ? false : true );
-}
-
-/*!
     Split this message into several pages of 88 bytes for
     transmission over a GSM network.
 =

@@ -521,11 +505,13 @@ QList<QCBSMessage> QCBSMessage::split() const
         // Splitting is not necessary, so return a list with one page.
         list +=3D *this;
         return list;
-    }
+    } else if ( numPages > 15)
+        //Up to 15 pages can be concatenated to form a CBS message
+        numPages =3D 15;
 =

     // Get the number of characters to transmit in each page.
     int split;
-    uint scheme=3D dataCodingScheme();
+    uint scheme=3D bestScheme();
 =

     switch ( scheme ) {
         case QSMS_UCS2Alphabet:
@@ -542,7 +528,7 @@ QList<QCBSMessage> QCBSMessage::split() const
     QCBSMessage tmp;
     number =3D 1;
     QString txt =3D text();
-    while ( posn < txt.length() ) {
+    while ( posn < txt.length() && number <=3D numPages ) {
         tmp =3D *this;
         len =3D txt.length() - posn;
         if ( len > split ) {
@@ -550,6 +536,10 @@ QList<QCBSMessage> QCBSMessage::split() const
         }
         tmp.setText( txt.mid( posn, len ) );
         tmp.setPage( number++ );
+        tmp.setNumPages(numPages);
+        // Set mDataCodingScheme to apply the same scheme for all the pages
+        // of the CBS message
+        tmp.setDataCodingScheme(scheme);
         posn +=3D len;
         list.append(tmp);
     }
diff --git a/src/qcbsmessage.h b/src/qcbsmessage.h
index 0f055b7..bfb879a 100644
--- a/src/qcbsmessage.h
+++ b/src/qcbsmessage.h
@@ -97,7 +97,6 @@ public:
     static QCBSMessage fromPdu( const QByteArray& pdu );
 =

     int bestScheme() const;
-    bool shouldSplit() const;
     QList<QCBSMessage> split() const;
     void computeSize( uint& numPages, uint& spaceLeftInLast ) const;
 =

-- =

1.7.9.5


--===============7997907484454120403==--

