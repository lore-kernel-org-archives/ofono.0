Content-Type: multipart/mixed; boundary="===============3218623597144827184=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] phonesim: Add GET_INPUT test case
Date: Fri, 24 Aug 2012 10:37:27 -0500
Message-ID: <50379FB7.3080308@gmail.com>
In-Reply-To: <1345818936-17602-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3218623597144827184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 08/24/2012 09:35 AM, Philippe Nunes wrote:
> This test case is used to check the immediate digit response flag.
> ---
>   src/conformancesimapplication.cpp |   25 ++++++++++++++++++++-----
>   src/qsimcommand.cpp               |   32 ++++++++++++++++++++++++++++++=
++
>   src/qsimcommand.h                 |    3 +++

Please break this up into two, one for conformancesimapplication.cpp and =

the rest.

>   3 files changed, 55 insertions(+), 5 deletions(-)
>
> diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplic=
ation.cpp
> index baf3538..a2bd3af 100644
> --- a/src/conformancesimapplication.cpp
> +++ b/src/conformancesimapplication.cpp
> @@ -81,11 +81,12 @@ const QString ConformanceSimApplication::getName()
>   #define GetInkeyMenu_Cyrillic_Display_2  4
>   #define GetInkeyMenu_Cyrillic_Entry      5
>   #define GetInkeyMenu_YesNo_Response      6
> -#define GetInkeyMenu_Icon                7
> -#define GetInkeyMenu_Help                8
> -#define GetInkeyMenu_Variable_Timeout    9
> -#define GetInkeyMenu_Text_Attribute     10
> -#define GetInkeyMenu_Main               11
> +#define GetInkeyMenu_ImmediateResponse   7
> +#define GetInkeyMenu_Icon                8
> +#define GetInkeyMenu_Help                9
> +#define GetInkeyMenu_Variable_Timeout   10
> +#define GetInkeyMenu_Text_Attribute     11
> +#define GetInkeyMenu_Main               12
>
>   #define GetInputMenu_Normal              1
>   #define GetInputMenu_No_Response         2
> @@ -677,6 +678,10 @@ void ConformanceSimApplication::sendGetInkeyMenu()
>       item.setLabel( "Yes/No response for the input" );
>       items +=3D item;
>
> +    item.setIdentifier( GetInkeyMenu_ImmediateResponse );
> +    item.setLabel( "Immediate response for the digit input" );
> +    items +=3D item;
> +
>       item.setIdentifier( GetInkeyMenu_Icon );
>       item.setLabel( "Display of icon" );
>       items +=3D item;
> @@ -887,6 +892,16 @@ void ConformanceSimApplication::GetInkeyMenu( const =
QSimTerminalResponse&  resp )
>           }
>           break;
>
> +        case GetInkeyMenu_ImmediateResponse:
> +        {
> +            cmd.setType( QSimCommand::GetInkey );
> +            cmd.setDestinationDevice( QSimCommand::ME );
> +            cmd.setWantImmediateResponse( true );
> +            cmd.setText( "Enter 1" );
> +            command( cmd, this, SLOT(sendGetInkeyMenu()) );
> +        }
> +        break;
> +
>           case GetInkeyMenu_Icon:
>           {
>               sendGetInkeyIconMenu();
> diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
> index f5dbdf2..7ef9c2e 100644
> --- a/src/qsimcommand.cpp
> +++ b/src/qsimcommand.cpp
> @@ -1312,6 +1312,38 @@ void QSimCommand::setWantYesNo( bool value )
>
>
>   /*!
> +    Returns true if \c GetInkey wants that the response is immediately s=
ent
> +    after key press.  The default value is false.
> +
> +    Applies to: \c GetInkey
> +
> +    \sa setWantImmediateResponse()
> +*/
> +bool QSimCommand::wantImmediateResponse() const
> +{
> +    if ( d->type =3D=3D QSimCommand::GetInkey )
> +        return d->qualifierBit( 0x08 );
> +    else
> +        return false;
> +}
> +
> +

Why two empty lines?

> +/*!
> +    Sets the flag that determines if \c GetInkey wants that
> +    the response is immediately sent after key press.
> +
> +    Applies to: \c GetInkey
> +
> +    \sa wantImmediateResponse()
> +*/
> +void QSimCommand::setWantImmediateResponse( bool value )
> +{
> +    if ( d->type =3D=3D QSimCommand::GetInkey )
> +        dwrite()->setQualifierBit( 0x08, value );
> +}
> +
> +

And again?

> +/*!
>       Returns the minimum text length for input.  The default value is 0.
>
>       Applies to: \c GetInput.
> diff --git a/src/qsimcommand.h b/src/qsimcommand.h
> index 3b34be9..2c1b423 100644
> --- a/src/qsimcommand.h
> +++ b/src/qsimcommand.h
> @@ -292,6 +292,9 @@ public:
>       bool echo() const;
>       void setEcho( bool value );
>
> +    bool wantImmediateResponse() const;
> +    void setWantImmediateResponse( bool value );
> +
>       QSimCommand::Disposition disposition() const;
>       void setDisposition( QSimCommand::Disposition value );
>

Regards,
-Denis

--===============3218623597144827184==--

