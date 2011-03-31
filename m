Content-Type: multipart/mixed; boundary="===============8542045703478390403=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 1/2] qsimcommand: Add properties and TLV builders to
 support BIP commands
Date: Thu, 31 Mar 2011 17:58:09 +0200
Message-ID: <1301587090-5358-1-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8542045703478390403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qsimcommand.cpp |  204 +++++++++++++++++++++++++++++++++++++++++++++++=
++--
 src/qsimcommand.h   |   37 +++++++++
 2 files changed, 235 insertions(+), 6 deletions(-)

diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index ecdf43f..f5dbdf2 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -69,6 +69,8 @@ public:
         timerId =3D 0;
         device =3D -1;
         qualifier =3D 0;
+        bufferSize =3D 0;
+        dataLength =3D 0;
     }
     QSimCommandPrivate( QSimCommandPrivate *other )
     {
@@ -102,6 +104,15 @@ public:
         device =3D other->device;
         qualifier =3D other->qualifier;
         extensionData =3D other->extensionData;
+        bearerDesc =3D other->bearerDesc;
+        bufferSize =3D other->bufferSize;
+        dataLength =3D other->dataLength;
+        apn =3D other->apn;
+        uti =3D other->uti;
+        userLogin =3D other->userLogin;
+        userPassword =3D other->userPassword;
+        destAddress =3D other->destAddress;
+        localAddress =3D other->localAddress;
     }
 =

     bool flag( int bit ) const
@@ -165,7 +176,15 @@ public:
     int device;
     int qualifier;
     QByteArray extensionData;
-
+    QByteArray bearerDesc;
+    ushort bufferSize;
+    uint dataLength;
+    QByteArray apn;
+    QByteArray uti;
+    QString userLogin;
+    QString userPassword;
+    QByteArray destAddress;
+    QByteArray localAddress;
 };
 =

 =

@@ -2202,6 +2221,96 @@ void QSimCommand::setTimerId( int id )
     dwrite()->timerId =3D id;
 }
 =

+ushort QSimCommand::bufferSize() const
+{
+    return d->bufferSize;
+}
+
+void QSimCommand::setBufferSize( ushort value )
+{
+    dwrite()->bufferSize =3D value;
+}
+
+uint QSimCommand::dataLength() const
+{
+    return d->dataLength;
+}
+
+void QSimCommand::setDataLength( uint value )
+{
+    dwrite()->dataLength =3D value;
+}
+
+QString QSimCommand::userLogin() const
+{
+    return d->userLogin;
+}
+
+void QSimCommand::setUserLogin( const QString& value )
+{
+    dwrite()->userLogin =3D value;
+}
+
+QString QSimCommand::userPassword() const
+{
+    return d->userPassword;
+}
+
+void QSimCommand::setUserPassword( const QString& value )
+{
+    dwrite()->userPassword =3D value;
+}
+
+QByteArray QSimCommand::uti() const
+{
+    return d->uti;
+}
+
+void QSimCommand::setUti( const QByteArray& value )
+{
+    dwrite()->uti =3D value;
+}
+
+QByteArray QSimCommand::bearerDesc() const
+{
+    return d->bearerDesc;
+}
+
+void QSimCommand::setBearerDesc( const QByteArray& value )
+{
+    dwrite()->bearerDesc =3D value;
+}
+
+QByteArray QSimCommand::localAddress() const
+{
+    return d->localAddress;
+}
+
+void QSimCommand::setLocalAddress( const QByteArray& value )
+{
+    dwrite()->localAddress =3D value;
+}
+
+QByteArray QSimCommand::destAddress() const
+{
+    return d->destAddress;
+}
+
+void QSimCommand::setDestAddress( const QByteArray& value )
+{
+    dwrite()->destAddress =3D value;
+}
+
+QByteArray QSimCommand::apn() const
+{
+    return d->apn;
+}
+
+void QSimCommand::setApn( const QByteArray& value )
+{
+    dwrite()->apn =3D value;
+}
+
 /*!
     Copy the QSimCommand object \a value.
 */
@@ -3045,6 +3154,64 @@ void _qtopiaphone_writeTimerValue( QByteArray& data,=
 uint value )
 }
 #define writeTimerValue _qtopiaphone_writeTimerValue
 =

+// Write a Bearer description field.
+static void writeBearerDesc( QByteArray& data, const QByteArray& bearerDes=
c )
+{
+    if ( !bearerDesc.isEmpty() ) {
+        data +=3D (char)0x35;
+        writeBerLength( data, bearerDesc.length() );
+        data +=3D bearerDesc;
+    }
+}
+
+// Write a Network Access Name field as specified in TS 23.003
+static void writeApn( QByteArray& data, const QByteArray& apn )
+{
+    if ( !apn.isEmpty() ) {
+        data +=3D (char)0x47;
+        writeBerLength( data, apn.length() );
+        data +=3D apn;
+    }
+}
+
+// Write a Buffer size field.
+static void writeBufferSize( QByteArray& data, ushort size )
+{
+    if ( size ) {
+        data +=3D 0x39;
+        data +=3D 0x02;
+        data +=3D (char)(size >> 8);
+        data +=3D (char)size;
+    }
+}
+
+// Write a data length field.
+static void writeDataLength( QByteArray& data, uint value )
+{
+    data +=3D 0x37;
+    data +=3D 0x01;
+    data +=3D (char)value;
+}
+
+// Write a UICC/terminal interface transport level field
+static void writeUti( QByteArray& data, const QByteArray& uti )
+{
+    if ( !uti.isEmpty() ) {
+        data +=3D (char)0x3C;
+        writeBerLength( data, uti.length() );
+        data +=3D uti;
+    }
+}
+
+// Write the Address information field
+static void writeOtherAddress( QByteArray& data, const QByteArray& otherAd=
dress )
+{
+    if ( !otherAddress.isEmpty() ) {
+        data +=3D (char)0x3E;
+        writeBerLength( data, otherAddress.length() );
+        data +=3D otherAddress;
+    }
+}
 /*!
     \enum QSimCommand::ToPduOptions
     This enum defines additional options to use when encoding SIM commands=
 with QSimCommand::toPdu().
@@ -3324,21 +3491,46 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOp=
tions options ) const
             if ( !text().isEmpty() || ( options & QSimCommand::EncodeEmpty=
Strings ) !=3D 0 )
                 writeEFADN( data, text(), options, 0x05 );
             writeIcon( data, iconId(), iconSelfExplanatory(), true );
-            if ( !number().isEmpty() )
-                writeEFADNNumber( data, number() );
-            if ( !subAddress().isEmpty() )
-                writeSubAddress( data, subAddress() );
+            writeBearerDesc( data, bearerDesc() );
+            writeBufferSize( data, bufferSize() );
+            writeApn( data, apn() );
+            writeOtherAddress( data, localAddress() );
+            if ( !userLogin().isEmpty() )
+                writeTextString( data, userLogin(), QSimCommand::NoPduOpti=
ons, 0x0D );
+            if ( !userPassword().isEmpty() )
+                writeTextString( data, userPassword(), QSimCommand::NoPduO=
ptions, 0x0D );
+            writeUti( data, uti() );
+            writeOtherAddress( data, destAddress() );
             writeTextAttribute( data, textAttribute() );
         }
         break;
 =

-        case CloseChannel:
         case ReceiveData:
+        {
+            if ( !text().isEmpty() || ( options & QSimCommand::EncodeEmpty=
Strings ) !=3D 0 )
+                writeEFADN( data, text(), options, 0x05 );
+            writeIcon( data, iconId(), iconSelfExplanatory(), true );
+            writeDataLength( data, dataLength() );
+            writeTextAttribute( data, textAttribute() );
+        }
+        break;
+
         case SendData:
         {
             if ( !text().isEmpty() || ( options & QSimCommand::EncodeEmpty=
Strings ) !=3D 0 )
                 writeEFADN( data, text(), options, 0x05 );
             writeIcon( data, iconId(), iconSelfExplanatory(), true );
+            data +=3D extData;
+            writeTextAttribute( data, textAttribute() );
+        }
+        break;
+
+        case CloseChannel:
+        case GetChannelStatus:
+        {
+            if ( !text().isEmpty() || ( options & QSimCommand::EncodeEmpty=
Strings ) !=3D 0 )
+                writeEFADN( data, text(), options, 0x05 );
+            writeIcon( data, iconId(), iconSelfExplanatory(), true );
             writeTextAttribute( data, textAttribute() );
         }
         break;
diff --git a/src/qsimcommand.h b/src/qsimcommand.h
index eadd768..ea7f17a 100644
--- a/src/qsimcommand.h
+++ b/src/qsimcommand.h
@@ -215,6 +215,16 @@ public:
         Network             =3D 0x83
     };
 =

+    enum OpenChannelQualifier {
+	    OpenchannelOnDemand	 =3D 0x00,
+	    OpenchannelImmediate =3D 0x01,
+    };
+
+    enum SendDataQualifier {
+	    SendDataStoreData	=3D 0x00,
+	    SendDataImmediately	=3D 0x01,
+    };
+
     int commandNumber() const;
     void setCommandNumber( int value );
 =

@@ -362,6 +372,33 @@ public:
     int qualifier() const;
     void setQualifier( int value );
 =

+    QByteArray bearerDesc() const;
+    void setBearerDesc( const QByteArray& value );
+
+    ushort bufferSize() const;
+    void setBufferSize( ushort value );
+
+    uint dataLength() const;
+    void setDataLength( uint value );
+
+    QByteArray apn() const;
+    void setApn( const QByteArray& value );
+
+    QByteArray destAddress() const;
+    void setDestAddress( const QByteArray& value );
+
+    QByteArray localAddress() const;
+    void setLocalAddress( const QByteArray& value );
+
+    QString userLogin() const;
+    void setUserLogin( const QString& value );
+
+    QString userPassword() const;
+     void setUserPassword( const QString& value );
+
+    QByteArray uti() const;
+    void setUti( const QByteArray& value );
+
     QByteArray extensionData() const;
     void setExtensionData( QByteArray value );
 =

-- =

1.7.1


--===============8542045703478390403==--

