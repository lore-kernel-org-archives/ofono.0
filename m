Content-Type: multipart/mixed; boundary="===============7118900438211548993=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] stk-api.txt: Describe new d-bus APIs related to BIP
 commands.
Date: Wed, 23 Mar 2011 20:26:24 -0500
Message-ID: <4D8A9DC0.3080101@gmail.com>
In-Reply-To: <1300798280-4281-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7118900438211548993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 03/22/2011 07:51 AM, Philippe Nunes wrote:
> ---
>  doc/stk-api.txt |   27 ++++++++++++++++++++++++++-
>  1 files changed, 26 insertions(+), 1 deletions(-)
> =

> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> index 529c734..772e4ce 100644
> --- a/doc/stk-api.txt
> +++ b/doc/stk-api.txt
> @@ -96,6 +96,7 @@ Methods		byte RequestSelection(string title, byte icon_=
id,
>  			an error given below.
>  =

>  			Possible Errors: [service].Error.SimToolkit.GoBack
> +					 [service].Error.SimToolkit.EndSession
>  =

>  			Implementation notes:
>  =

> @@ -111,6 +112,7 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
>  			cleared prior to the display of this text.
>  =

>  			Possible Errors: [service].Error.SimToolkit.GoBack
> +					 [service].Error.SimToolkit.EndSession
>  					 [service].Error.SimToolkit.Busy
>  =

>  			Implementation notes:
> @@ -154,6 +156,7 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
>  			should be opaque.
>  =

>  			Possible Errors: [service].Error.SimToolkit.GoBack
> +					 [service].Error.SimToolkit.EndSession
>  =

>  			Implementation notes:
>  =

> @@ -171,6 +174,7 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
>  			are expected.
>  =

>  			Possible Errors: [service].Error.SimToolkit.GoBack
> +					 [service].Error.SimToolkit.EndSession
>  =

>  		string RequestKey(string alpha, byte icon_id)
>  =

> @@ -179,6 +183,7 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
>  			for the request.
>  =

>  			Possible Errors: [service].Error.SimToolkit.GoBack
> +					 [service].Error.SimToolkit.EndSession
>  =

>  		string RequestDigit(string alpha, byte icon_id)
>  =

> @@ -186,12 +191,14 @@ Methods		byte RequestSelection(string title, byte i=
con_id,
>  			expected.
>  =

>  			Possible Errors: [service].Error.SimToolkit.GoBack
> +					 [service].Error.SimToolkit.EndSession
>  =

>  		boolean RequestConfirmation(string alpha, byte icon_id)
>  =

>  			Asks the agent to get confirmation from the user.
>  =

>  			Possible Errors: [service].Error.SimToolkit.GoBack
> +					 [service].Error.SimToolkit.EndSession
>  =


That's great that you're fixing up the possible errors in the
documentation, but they really need to be in a separate patch.

>  		boolean ConfirmCallSetup(string information, byte icon_id)
>  =

> @@ -245,6 +252,7 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
>  			Possible Errors: [service].Error.SimToolkit.EndSession
>  =

>  		void DisplayActionInformation(string text, byte icon_id)
> +						[noreply]
>  =


Why are you marking this noreply when we do actually expect one?

>  			Supplies a text string and/or icon concerning the
>  			current activity in the terminal and UICC.  The
> @@ -260,6 +268,23 @@ Methods		byte RequestSelection(string title, byte ic=
on_id,
>  			confirmation message to oFono and then should open
>  			the launch browser with the given url.
>  =

> +		boolean ConfirmOpenChannel(string information, byte icon_id)
> +
> +			Asks the agent to request user to confirm the channel
> +			set-up.
> +
> +			Possible Errors: [service].Error.SimToolkit.EndSession
> +
> +		void DisplayChannelActivity(string text, byte icon_id)
> +
> +			Supplies a text string and/or icon concerning the
> +			current activity linked to the channel set-up. The
> +			text should be displayed to the user on screen
> +			until the call is canceled using Cancel() or until the
> +			user decides to end the session.
> +

Why can we not re-use DisplayActionInformation here?

> +			Possible Errors: [service].Error.SimToolkit.EndSession
> +
>  		void Cancel() [noreply]
>  =

>  			Asks the agent to cancel any ongoing operation in
> @@ -270,6 +295,6 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
>  		void Release() [noreply]
>  =

>  			Agent is being released, possibly because of oFono
> -			terminating, SimToolkit interface torn down or modem
> +			terminating, SimToolkit interface turn down or modem

The original is actually correct, but should probably have the word
'being' in front of torn.  e.g. SimToolkit interface is being torn down
or modem terminating...

>  			off.  If the agent is registered as a global agent,
>  			no UnregisterAgent call is expected.

Regards,
-Denis

--===============7118900438211548993==--

