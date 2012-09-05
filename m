Content-Type: multipart/mixed; boundary="===============3166519445282285356=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] phonesim: Extend conformance menu with Setup Call
 items
Date: Wed, 05 Sep 2012 15:12:23 -0500
Message-ID: <5047B227.2020004@gmail.com>
In-Reply-To: <1346865667-24888-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3166519445282285356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 09/05/2012 12:21 PM, Philippe Nunes wrote:
> ---
>   src/conformancesimapplication.cpp |  247 ++++++++++++++++++++++++++++++=
+++++++
>   src/simapplication.h              |    2 +
>   2 files changed, 249 insertions(+)

<snip>

>
> +        case SetupCall_Max_Dialing_Number:
> +          {
> +              cmd.setType( QSimCommand::SetupCall );
> +              cmd.setDestinationDevice( QSimCommand::Network );
> +              cmd.setNumber( "+01234567890123456789012345678901" );
> +              cmd.setDisposition( QSimCommand::Disconnect );
> +              command( cmd, this, SLOT(sendSetupCallMenu()) );
> +          }
> +          break;

Can we actually fix the inconsistent indentation here?

> +
> +        case SetupCall_Two_AID:
> +         {
> +             cmd.setType( QSimCommand::SetupCall );
> +             cmd.setDestinationDevice( QSimCommand::Network );
> +             cmd.setText( "CONFIRMATION" );
> +             cmd.setOtherText( "CALL" );
> +             cmd.setNumber( "+012340123456p1p2" );
> +             cmd.setDisposition( QSimCommand::Disconnect );
> +             command( cmd, this, SLOT(sendSetupCallMenu()) );
> +         }
> +         break;

And here?

> +
> +        case SetupCall_Basic_icon:
> +        {
> +            cmd.setType( QSimCommand::SetupCall );
> +            cmd.setDestinationDevice( QSimCommand::Network );
> +            cmd.setText( "Set up call Icon 3.1.1" );
> +            cmd.setNumber( "+012340123456p1p2" );
> +            cmd.setIconId( 1 );
> +            cmd.setIconSelfExplanatory( false );
> +            cmd.setDisposition( QSimCommand::IfNoOtherCalls );
> +            command( cmd, this, SLOT(sendSetupCallMenu()) );
> +        }
> +        break;
> +
> +        case SetupCall_Self_basic_icon:
> +         {
> +             cmd.setType( QSimCommand::SetupCall );
> +             cmd.setDestinationDevice( QSimCommand::Network );
> +             cmd.setText( "Set up call Icon 3.2.1" );
> +             cmd.setNumber( "+012340123456p1p2" );
> +             cmd.setIconId( 1 );
> +             cmd.setIconSelfExplanatory( true );
> +             cmd.setDisposition( QSimCommand::IfNoOtherCalls );
> +             command( cmd, this, SLOT(sendSetupCallMenu()) );
> +         }
> +         break;

And here

> +
> +        case SetupCall_Basic_icon_during_call:
> +         {
> +             cmd.setType( QSimCommand::SetupCall );
> +             cmd.setDestinationDevice( QSimCommand::Network );
> +             cmd.setText( "Set up call Icon 3.4.1" );
> +             cmd.setNumber( "+012340123456p1p2" );
> +             cmd.setIconId( 1 );
> +             cmd.setIconSelfExplanatory( true );
> +             cmd.setOtherText( "Set up call Icon 3.4.2" );
> +             cmd.setOtherIconId( 1 );
> +             cmd.setOtherIconSelfExplanatory( true );
> +             cmd.setDisposition( QSimCommand::IfNoOtherCalls );
> +             command( cmd, this, SLOT(sendSetupCallMenu()) );
> +         }
> +         break;

And here.

> +
> +        default:
> +            endSession();
> +        break;
> +    }
> +}

Regards,
-Denis

--===============3166519445282285356==--

