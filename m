Content-Type: multipart/mixed; boundary="===============2268513840203140036=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Simulate send ss command in sim app
Date: Thu, 09 Sep 2010 12:33:51 -0500
Message-ID: <4C891A7F.7040303@gmail.com>
In-Reply-To: <1284047237-5012-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2268513840203140036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> +void DemoSimApplication::CBMenu( const QSimTerminalResponse& resp )
> +{
> +    QSimCommand cmd;
> +
> +    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
> +        switch ( resp.menuItem() ) {
> +
> +            case CBMenu_Registration:
> +            {
> +                cmd.setType( QSimCommand::SendSS );
> +                cmd.setDestinationDevice( QSimCommand::Network );
> +                cmd.setNumber( "**33#" );
> +                command( cmd, this, SLOT(sendCBMenu()) );
> +            }
> +            break;
> +
> +            case CBMenu_Activation:
> +            {
> +                cmd.setType( QSimCommand::SendSS );
> +                cmd.setDestinationDevice( QSimCommand::Network );
> +                cmd.setNumber( "*33#" );
> +                command( cmd, this, SLOT(sendCBMenu()) );
> +            }
> +            break;

You have to be careful here:
- For call barring, activation and registration are equivalent
- Activation requires PIN2, so this is not a valid request

> +
> +            case CBMenu_Interrogation:
> +            {
> +                cmd.setType( QSimCommand::SendSS );
> +                cmd.setDestinationDevice( QSimCommand::Network );
> +                cmd.setNumber( "*#33#" );
> +                command( cmd, this, SLOT(sendCBMenu()) );
> +            }
> +                break;
> +
> +            case CBMenu_Deactivation:
> +            {
> +                cmd.setType( QSimCommand::SendSS );
> +                cmd.setDestinationDevice( QSimCommand::Network );
> +                cmd.setNumber( "#33#" );
> +                command( cmd, this, SLOT(sendCBMenu()) );
> +            }
> +            break;
> +
> +            case CBMenu_Erasure:
> +            {
> +                cmd.setType( QSimCommand::SendSS );
> +                cmd.setDestinationDevice( QSimCommand::Network );
> +                cmd.setNumber( "##33#" );
> +                command( cmd, this, SLOT(sendCBMenu()) );
> +            }
> +            break;

Same comments as for Activation/Registration above

> +
> +            default:
> +                endSession();
> +                break;
> +        }
> +    } else if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove =
) {
> +        sendSendSSMenu();
> +    } else {
> +        endSession();
> +    }
> +}
> +

<snip>

> +void DemoSimApplication::CFMenu( const QSimTerminalResponse& resp )
> +{
> +    QSimCommand cmd;
> +
> +    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
> +        switch ( resp.menuItem() ) {
> +
> +            case CFMenu_Registration:
> +            {
> +                cmd.setType( QSimCommand::SendSS );
> +                cmd.setDestinationDevice( QSimCommand::Network );
> +                cmd.setNumber( "**002#" );
> +                command( cmd, this, SLOT(sendCFMenu()) );

This is not a valid request, registration must provide a phone number

> +            }
> +            break;
> +
> +            case CFMenu_Activation:
> +            {
> +                cmd.setType( QSimCommand::SendSS );
> +                cmd.setDestinationDevice( QSimCommand::Network );
> +                cmd.setNumber( "*002#" );
> +                command( cmd, this, SLOT(sendCFMenu()) );
> +            }
> +            break;
> +
> +            case CFMenu_Interrogation:
> +            {
> +                cmd.setType( QSimCommand::SendSS );
> +                cmd.setDestinationDevice( QSimCommand::Network );
> +                cmd.setNumber( "*#002#" );
> +                command( cmd, this, SLOT(sendCFMenu()) );
> +            }
> +            break;

Interrogation of 'All CF' is actually not supported natively by GSM.
oFono handles this nicely, but you should filter such requests for Send
SS.  Same goes for call barring '330', '333' and '353' services.  Refer
to 22.004 Section 7.2 for more details.

> +
> +            case CFMenu_Deactivation:
> +            {
> +                cmd.setType( QSimCommand::SendSS );
> +                cmd.setDestinationDevice( QSimCommand::Network );
> +                cmd.setNumber( "#002#" );
> +                command( cmd, this, SLOT(sendCFMenu()) );
> +            }
> +            break;
> +
> +            case CFMenu_Erasure:
> +            {
> +                cmd.setType( QSimCommand::SendSS );
> +                cmd.setDestinationDevice( QSimCommand::Network );
> +                cmd.setNumber( "##002#" );
> +                command( cmd, this, SLOT(sendCFMenu()) );
> +            }
> +            break;
> +
> +            default:
> +                endSession();
> +                break;
> +        }
> +    } else if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove =
) {
> +        sendSendSSMenu();
> +    } else {
> +        endSession();
> +    }
> +}

Please fix up this patch with the call forwarding / call barring
changes.  Otherwise it looks good to me.

Regards,
-Denis

--===============2268513840203140036==--

