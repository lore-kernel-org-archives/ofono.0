Content-Type: multipart/mixed; boundary="===============2029526674453781732=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] phonesim: Extend STK conformance menu with Setup Call
 items
Date: Thu, 06 Sep 2012 10:25:39 -0500
Message-ID: <5048C073.3080907@gmail.com>
In-Reply-To: <1346942582-4873-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2029526674453781732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 09/06/2012 09:43 AM, Philippe Nunes wrote:
> ---
>   src/conformancesimapplication.cpp |  247 ++++++++++++++++++++++++++++++=
+++++++
>   src/simapplication.h              |    2 +
>   2 files changed, 249 insertions(+)

Patch has been applied, but I still had to amend a spot you missed:

> +        case SetupCall_Two_AID:
> +        {
> +            cmd.setType( QSimCommand::SetupCall );
> +            cmd.setDestinationDevice( QSimCommand::Network );
> +            cmd.setText( "CONFIRMATION" );
> +            cmd.setOtherText( "CALL" );
> +            cmd.setNumber( "+012340123456p1p2" );
> +            cmd.setDisposition( QSimCommand::Disconnect );
> +            command( cmd, this, SLOT(sendSetupCallMenu()) );
> +         }
> +         break;

^^^

Regards,
-Denis

--===============2029526674453781732==--

