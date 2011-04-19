Content-Type: multipart/mixed; boundary="===============6069296884381407073=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] callmanager: change state of waiting call
Date: Tue, 19 Apr 2011 12:01:14 -0500
Message-ID: <4DADBFDA.3000807@gmail.com>
In-Reply-To: <1302870584-20431-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6069296884381407073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 04/15/2011 07:29 AM, Nicolas Bertrand wrote:
> becomes incoming when all active and held are released
> =

> ---
>  src/callmanager.cpp |   25 +++++++++++++++++++++----
>  src/callmanager.h   |    3 +++
>  2 files changed, 24 insertions(+), 4 deletions(-)
> =


Patch has been applied, thanks.

> @@ -709,6 +716,16 @@ void CallManager::dialingToAlerting()
>      sendState( callList[index] );
>  }
>  =

> +void CallManager::waitingToIncoming()
> +{
> +	int index =3D indexForId( idForState( CallState_Waiting ) );
> +	if ( index < 0 )
> +		return;

Quick nitpick: could you please make sure to use spaces for indentation
in phonesim.  Phonesim codebase was developed according to a different
coding style and we should just conform to it, at least as much as
possible.  I fixed this for you and amended the commit.

> +
> +    callList[index].state =3D CallState_Incoming;
> +    sendState( callList[index] );
> +}
> +
>  void CallManager::dialBack()
>  {
>      startIncomingCall( "1234567", "7654321", "Alice", true );

Regards,
-Denis

--===============6069296884381407073==--

