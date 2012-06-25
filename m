Content-Type: multipart/mixed; boundary="===============5424098877707519760=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/7] qcbsmessage: Extend QCBSMessage class
Date: Mon, 25 Jun 2012 16:37:59 +0200
Message-ID: <1340635083-5877-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340635083-5877-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5424098877707519760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qcbsmessage.cpp |  140 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/qcbsmessage.h   |    7 +++
 2 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/src/qcbsmessage.cpp b/src/qcbsmessage.cpp
index fc17ae0..eb360bc 100644
--- a/src/qcbsmessage.cpp
+++ b/src/qcbsmessage.cpp
@@ -51,6 +51,7 @@ public:
     uint mUpdateNumber;
     uint mChannel;
     QCBSMessage::Language mLanguage;
+    uint mDataCodingScheme;
     uint mPage;
     uint mNumPages;
     QString mText;
@@ -268,6 +269,30 @@ void QCBSMessage::setLanguage( QCBSMessage::Language l=
ang )
 }
 =

 /*!
+    Returns the recommended data coding scheme for encoding CBS text strin=
gs.
+    The default value is -1, which indicates that the best scheme should b=
e chosen
+    based on the contents of the CBS text string.
+
+    \sa setDataCodingScheme()
+*/
+int QCBSMessage::dataCodingScheme() const
+{
+    return d->mDataCodingScheme;
+}
+
+/*!
+    Sets the recommended data coding scheme for encoding CBS text strings =
to \a value.
+    The value -1 indicates that the best scheme should be chosen based on =
the contents
+    of the CBS text string.
+
+    \sa dataCodingScheme()
+*/
+void QCBSMessage::setDataCodingScheme( int value )
+{
+    d->mDataCodingScheme =3D value;
+}
+
+/*!
     Returns the page number for this cell broadcast message if the
     information that it contains is split over multiple pages.
 =

@@ -398,7 +423,14 @@ static QSMSDataCodingScheme bestScheme( const QString&=
 body )
 QByteArray QCBSMessage::toPdu() const
 {
     QCBSDeliverMessage deliver;
-    deliver.pack( *this, bestScheme( text() ) );
+    QSMSDataCodingScheme scheme;
+
+	if(dataCodingScheme() =3D=3D -1)
+        scheme =3D bestScheme( text() );
+    else
+        scheme =3D (QSMSDataCodingScheme)dataCodingScheme();
+
+    deliver.pack( *this, scheme );
     return deliver.toByteArray();
 =

 }
@@ -412,3 +444,109 @@ QCBSMessage QCBSMessage::fromPdu( const QByteArray& p=
du )
     QCBSDeliverMessage deliver( pdu );
     return deliver.unpack();
 }
+
+/*!
+    Compute an estimate for the number of pages that will need
+    to be used to send this CBS message (\a numMessages), and the
+    number of spare characters that are left in the last message
+    before it overflows (\a spaceLeftInLast).
+*/
+void QCBSMessage::computeSize( uint& numPages, uint& spaceLeftInLast ) con=
st
+{
+    QString body =3D text();
+    uint len =3D body.length();
+    uint scheme=3D dataCodingScheme();
+
+    if ( scheme =3D=3D QSMS_DefaultAlphabet ) {
+        // Encode the message using 7-bit GSM.
+        if ( len <=3D 93 ) { // (82*8)/7 =3D 93 characters
+            numPages =3D 1;
+            spaceLeftInLast =3D 93 - len;
+        } else {
+            numPages =3D ( len + 92 ) / 93;
+            len %=3D 93;
+            if ( len !=3D 0 )
+                spaceLeftInLast =3D 93 - len;
+            else
+                spaceLeftInLast =3D 0;
+        }
+    } else {
+        // Encode the message with unicode.
+        if ( len <=3D 40 ) { // 40 =3D 82/2 - 2 (2 GSM 7-bit ISO 639 chara=
cters).
+            numPages =3D 1;
+            spaceLeftInLast =3D 40 - len;
+        } else {
+            numPages =3D ( len + 39 ) / 40;
+            len %=3D 40;
+            if ( len !=3D 0 )
+                spaceLeftInLast =3D 40 - len;
+            else
+                spaceLeftInLast =3D 0;
+        }
+    }
+}
+
+/*!
+    Returns true if this message needs to be split into multiple messages
+    before being transmitted over a GSM network; otherwise returns false.
+
+    \sa split()
+*/
+bool QCBSMessage::shouldSplit() const
+{
+    uint numPages, spaceLeftInLast;
+    this->computeSize( numPages, spaceLeftInLast );
+    return ( numPages <=3D1 ? false : true );
+}
+
+/*!
+    Split this message into several pages of 88 bytes for
+    transmission over a GSM network.
+
+    \sa shouldSplit()
+*/
+QList<QCBSMessage> QCBSMessage::split() const
+{
+    QList<QCBSMessage> list;
+    uint numPages, spaceLeftInLast;
+
+    computeSize( numPages, spaceLeftInLast );
+    if ( numPages <=3D 1 ) {
+        // Splitting is not necessary, so return a list with one page.
+        list +=3D *this;
+        return list;
+    }
+
+    // Get the number of characters to transmit in each page.
+    int split;
+    uint scheme=3D dataCodingScheme();
+
+    switch ( scheme ) {
+        case QSMS_UCS2Alphabet:
+            split =3D 40; break;
+        case QSMS_DefaultAlphabet:
+        default:
+            split =3D 93; break;
+    }
+
+    // Split the message to create sub-messages and transmit them.
+    int posn =3D 0;
+    int len;
+    uint number;
+    QCBSMessage tmp;
+    number =3D 1;
+    QString txt =3D text();
+    while ( posn < txt.length() ) {
+        tmp =3D *this;
+        len =3D txt.length() - posn;
+        if ( len > split ) {
+            len =3D split;
+        }
+        tmp.setText( txt.mid( posn, len ) );
+        tmp.setPage( number++ );
+        posn +=3D len;
+        list.append(tmp);
+    }
+
+    return list;
+}
diff --git a/src/qcbsmessage.h b/src/qcbsmessage.h
index 0f86e3e..f6ed364 100644
--- a/src/qcbsmessage.h
+++ b/src/qcbsmessage.h
@@ -76,6 +76,9 @@ public:
     QCBSMessage::Language language() const;
     void setLanguage( QCBSMessage::Language lang );
 =

+    void setDataCodingScheme(int);
+    int dataCodingScheme() const;
+
     uint page() const;
     void setPage( uint page );
 =

@@ -93,6 +96,10 @@ public:
     QByteArray toPdu() const;
     static QCBSMessage fromPdu( const QByteArray& pdu );
 =

+    bool shouldSplit() const;
+    QList<QCBSMessage> split() const;
+    void computeSize( uint& numPages, uint& spaceLeftInLast ) const;
+
 private:
     QCBSMessagePrivate *d;
 };
-- =

1.7.9.5


--===============5424098877707519760==--

