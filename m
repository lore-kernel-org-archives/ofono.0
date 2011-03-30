Content-Type: multipart/mixed; boundary="===============3332553448802921738=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] qsimcommand: Add properties and TLV builders to
 support BIP commands
Date: Tue, 29 Mar 2011 22:35:07 -0500
Message-ID: <4D92A4EB.1090508@gmail.com>
In-Reply-To: <1300799413-4479-2-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3332553448802921738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 03/22/2011 08:10 AM, Philippe Nunes wrote:
> ---
>  src/qsimcommand.cpp |  201 +++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  src/qsimcommand.h   |   34 +++++++++
>  2 files changed, 228 insertions(+), 7 deletions(-)
> =

> diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
> index ecdf43f..46b633f 100644
> --- a/src/qsimcommand.cpp
> +++ b/src/qsimcommand.cpp
> @@ -69,6 +69,8 @@ public:
>          timerId =3D 0;
>          device =3D -1;
>          qualifier =3D 0;
> +        bufferSize =3D 0;
> +        dataLength =3D 0;
>      }
>      QSimCommandPrivate( QSimCommandPrivate *other )
>      {
> @@ -102,6 +104,15 @@ public:
>          device =3D other->device;
>          qualifier =3D other->qualifier;
>          extensionData =3D other->extensionData;
> +        bearerDesc =3D other->bearerDesc;
> +        bufferSize =3D other->bufferSize;
> +        dataLength =3D other->dataLength;
> +        apn =3D other->apn;
> +        uti =3D other->uti;
> +        userLogin =3D other->userLogin;
> +        userPassword =3D other->userPassword;
> +        destAddress =3D other->destAddress;
> +        localAddress =3D other->localAddress;
>      }
>  =

>      bool flag( int bit ) const
> @@ -165,7 +176,15 @@ public:
>      int device;
>      int qualifier;
>      QByteArray extensionData;
> -
> +    QByteArray bearerDesc;
> +    ushort bufferSize;
> +    uint dataLength;
> +    QByteArray apn;
> +    QByteArray uti;
> +    QString userLogin;
> +    QString userPassword;
> +    QByteArray destAddress;
> +    QByteArray localAddress;
>  };
>  =

>  =

> @@ -612,7 +631,7 @@ QSimMenuItem& QSimMenuItem::operator=3D( const QSimMe=
nuItem & value )
>      \enum QSimCommand::Device
>      This enum defines the source or destination device for a SIM command=
, according
>      to 3GPP TS 11.14, section 12.7.
> -    =

> +    \

Not that we care about qdoc, but this doesn't seem useful

>      \value Keypad Keypad device
>      \value Display Display device
>      \value Earpiece Earpiece device
> @@ -2202,6 +2221,86 @@ void QSimCommand::setTimerId( int id )
>      dwrite()->timerId =3D id;
>  }
>  =

> +ushort QSimCommand::bufferSize() const
> +{
> +    return d->bufferSize;
> +}
> +
> +void QSimCommand::setBufferSize( ushort value )
> +{
> +    dwrite()->bufferSize =3D value;
> +}
> +
> +uint QSimCommand::dataLength() const
> +{
> +    return d->dataLength;
> +}
> +
> +void QSimCommand::setDataLength( uint value )
> +{
> +    dwrite()->dataLength =3D value;
> +}
> +
> +QString QSimCommand::userLogin() const
> +{
> +    return d->userLogin;
> +}
> +
> +void QSimCommand::setUserLogin( const QString& value )
> +{
> +    dwrite()->userLogin =3D value;
> +}
> +
> +QString QSimCommand::userPassword() const
> +{
> +    return d->userPassword;
> +}
> +
> +void QSimCommand::setUserPassword( const QString& value )
> +{
> +    dwrite()->userPassword =3D value;
> +}
> +
> +QByteArray QSimCommand::uti() const
> +{
> +    return d->uti;
> +}
> +
> +void QSimCommand::setUti( const QByteArray& value )
> +{
> +    dwrite()->uti =3D value;
> +}
> +
> +QByteArray QSimCommand::bearerDesc() const
> +{
> +    return d->bearerDesc;
> +}
> +
> +void QSimCommand::setBearerDesc( const QByteArray& value )
> +{
> +    dwrite()->bearerDesc =3D value;
> +}
> +
> +QByteArray QSimCommand::destAddress() const
> +{
> +    return d->destAddress;
> +}
> +
> +void QSimCommand::setDestAddress( const QByteArray& value )
> +{
> +    dwrite()->destAddress =3D value;
> +}
> +
> +QByteArray QSimCommand::apn() const
> +{
> +    return d->apn;
> +}
> +
> +void QSimCommand::setApn( const QByteArray& value )
> +{
> +    dwrite()->apn =3D value;
> +}
> +
>  /*!
>      Copy the QSimCommand object \a value.
>  */
> @@ -3045,6 +3144,62 @@ void _qtopiaphone_writeTimerValue( QByteArray& dat=
a, uint value )
>  }
>  #define writeTimerValue _qtopiaphone_writeTimerValue
>  =

> +// Write a Bearer description field.
> +static void writeBearerDesc( QByteArray& data, const QByteArray& bearerD=
esc )
> +{
> +    if ( !bearerDesc.isEmpty() ) {
> +        data +=3D (char)0x35;
> +        writeBerLength( data, bearerDesc.length() );
> +        data +=3D bearerDesc;
> +    }
> +}
> +
> +// Write a Network Access Name field as specified in TS 23.003
> +static void writeApn( QByteArray& data, const QByteArray& apn )
> +{
> +    if ( !apn.isEmpty() ) {
> +	data +=3D (char)0x47;
> +	writeBerLength( data, apn.length() );
> +	data +=3D apn;
> +    }

I'm not particularly picky on phonesim coding style, but lets at least
try to be semi-consistent with indentation.  phonesim uses 4 spaces for
indentation (just because that's what the original Trolltech/Nokia code
used).  So lets at least try to stick to that ;)

> +}
> +
> +// Write a Buffer size field.
> +static void writeBufferSize( QByteArray& data, ushort size )
> +{
> +	if ( size ) {
> +		data +=3D 0x39;
> +		data +=3D 0x02;
> +		data +=3D (char)(size >> 8);
> +		data +=3D (char)size;
> +	}
> +}
> +
> +// Write a data length field.
> +static void writeDataLength( QByteArray& data, uint value )
> +{
> +	data +=3D 0x37;
> +	data +=3D 0x01;
> +	data +=3D (char) value;
> +}
> +
> +static void writeUti( QByteArray& data, const QByteArray& uti )
> +{
> +	if ( !uti.isEmpty() ) {
> +		data +=3D (char)0x3C;
> +		writeBerLength( data, uti.length() );
> +		data +=3D uti;
> +	}
> +}
> +
> +static void writeOtherAddress( QByteArray& data, const QByteArray& other=
Address )
> +{
> +	if ( !otherAddress.isEmpty() ) {
> +			data +=3D (char)0x3E;
> +			writeBerLength( data, otherAddress.length() );
> +			data +=3D otherAddress;
> +	}

And another variation with 3 tabs, why is this one special ;)

> +}
>  /*!
>      \enum QSimCommand::ToPduOptions
>      This enum defines additional options to use when encoding SIM comman=
ds with QSimCommand::toPdu().
> @@ -3324,18 +3479,50 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPdu=
Options options ) const
>              if ( !text().isEmpty() || ( options & QSimCommand::EncodeEmp=
tyStrings ) !=3D 0 )
>                  writeEFADN( data, text(), options, 0x05 );
>              writeIcon( data, iconId(), iconSelfExplanatory(), true );
> -            if ( !number().isEmpty() )
> -                writeEFADNNumber( data, number() );
> -            if ( !subAddress().isEmpty() )
> -                writeSubAddress( data, subAddress() );
> +
> +            writeBearerDesc( data, bearerDesc() );
> +            writeBufferSize( data, bufferSize() );
> +
> +            if ( !apn().isEmpty() ) {
> +        	    writeApn( data, apn() );
> +            }
> +
> +            if ( !userLogin().isEmpty() ) {
> +        	    writeTextString( data, userLogin(), QSimCommand::NoPduOptio=
ns, 0x0D );
> +            }
> +
> +            if ( !userPassword().isEmpty() ) {
> +        	    writeTextString( data, userPassword(), QSimCommand::NoPduOp=
tions, 0x0D );
> +            }
> +            writeUti( data, uti() );
> +            writeOtherAddress( data, destAddress() );
>              writeTextAttribute( data, textAttribute() );
>          }
>          break;
>  =

> -        case CloseChannel:
>          case ReceiveData:
> +        {
> +        	if ( !text().isEmpty() || ( options & QSimCommand::EncodeEmptyS=
trings ) !=3D 0 )
> +        	                writeEFADN( data, text(), options, 0x05 );
> +        	writeDataLength( data, dataLength() );
> +        	writeIcon( data, iconId(), iconSelfExplanatory(), true );
> +        	writeTextAttribute( data, textAttribute() );
> +        }
> +        break;
> +
>          case SendData:
>          {
> +        	if ( !text().isEmpty() || ( options & QSimCommand::EncodeEmptyS=
trings ) !=3D 0 )
> +        			writeEFADN( data, text(), options, 0x05 );
> +        	writeIcon( data, iconId(), iconSelfExplanatory(), true );
> +        	data +=3D extData;
> +        	writeTextAttribute( data, textAttribute() );
> +        }
> +        break;
> +
> +        case CloseChannel:
> +        case GetChannelStatus:
> +        {
>              if ( !text().isEmpty() || ( options & QSimCommand::EncodeEmp=
tyStrings ) !=3D 0 )
>                  writeEFADN( data, text(), options, 0x05 );
>              writeIcon( data, iconId(), iconSelfExplanatory(), true );
> diff --git a/src/qsimcommand.h b/src/qsimcommand.h
> index eadd768..2c55339 100644
> --- a/src/qsimcommand.h
> +++ b/src/qsimcommand.h
> @@ -215,6 +215,16 @@ public:
>          Network             =3D 0x83
>      };
>  =

> +    enum OpenChannelQualifier {
> +	    OpenchannelOnDemand	 =3D 0x00,
> +	    OpenchannelImmediate =3D 0x01,
> +    };
> +
> +    enum SendDataQualifier {
> +	    SendDataStoreData	=3D 0x00,
> +	    SendDataImmediately	=3D 0x01,
> +    };
> +
>      int commandNumber() const;
>      void setCommandNumber( int value );
>  =

> @@ -362,6 +372,30 @@ public:
>      int qualifier() const;
>      void setQualifier( int value );
>  =

> +    QByteArray bearerDesc() const;
> +    void setBearerDesc( const QByteArray& value );
> +
> +    ushort bufferSize() const;
> +    void setBufferSize( ushort value );
> +
> +    uint dataLength() const;
> +    void setDataLength( uint value );
> +
> +    QByteArray apn() const;
> +    void setApn( const QByteArray& value );
> +
> +    QByteArray destAddress() const;
> +    void setDestAddress( const QByteArray& value );
> +
> +    QString userLogin() const;
> +    void setUserLogin( const QString& value );
> +
> +    QString userPassword() const;
> +     void setUserPassword( const QString& value );
> +
> +    QByteArray uti() const;
> +    void setUti( const QByteArray& value );
> +
>      QByteArray extensionData() const;
>      void setExtensionData( QByteArray value );
>  =


Regards,
-Denis

--===============3332553448802921738==--

