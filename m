Content-Type: multipart/mixed; boundary="===============8897377496190796919=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] doc: Play Tone command proposed d-bus API.
Date: Thu, 09 Sep 2010 18:23:42 +0200
Message-ID: <1284049422.20451.5.camel@aeonflux.t-mobile.de>
In-Reply-To: <1283968796-5308-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8897377496190796919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> This is a version with the tone identified by a string based on irc
> discussion, I leave the decision to you about which version to use.
> ---
>  doc/stk-api.txt |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> index d0dd740..14819a7 100644
> --- a/doc/stk-api.txt
> +++ b/doc/stk-api.txt
> @@ -200,6 +200,38 @@ Methods		byte RequestSelection(string title, byte ic=
on_id,
>  =

>  			Possible Errors: [service].Error.SimToolkit.EndSession
>  =

> +		void PlayTone(string tone, boolean loop,
> +				string text, byte icon_id)
> +
> +			Tells the agent to play an audio tone.  A repeatable
> +			tone is played for the duration of the method call
> +			(until it is cancelled), otherwise it is played once
> +			and the method should return.  The text parameter
> +			contains an optional text to be displayed to the
> +			user.  The following tones are defined:

string sounds here more than reasonable. For the looping part we have to
clarify when to return from this method. For non repeating tones it is
pretty clear. It should return when playing the tone finished. For the
repeating one we can return right away, or after the first iteration has
played. That needs to be properly described in what to expect from the
agent.

Also has PlayTone and PlayLoop method calls considered to have a clearer
semantic separation?

> +				"dial tone"
> +				"busy"
> +				"congestion"
> +				"radio path acknowledge"
> +				"radio path not available"
> +				"error"
> +				"call waiting"
> +				"ringing tone"
> +				"general beep"
> +				"positive acknowledgement"
> +				"negative acknowledgement"
> +				"user ringing tone"
> +				"user sms alert"
> +				"critical" (high priority)
> +				"vibrate"
> +				"happy"
> +				"sad"
> +				"urgent action"
> +				"question"
> +				"message received"

I prefer to have them as "call-waiting" with a - in between. Space are
sort of a bad idea for constant type strings. And we do similar things
for "cs-preferred" etc. But essentially I agree that strings are way
better.

Can we also fix the typo in acknowledgment ;)

The alternate text string comes from the SIM Toolkit, right?

Regards

Marcel



--===============8897377496190796919==--

