Content-Type: multipart/mixed; boundary="===============3022434928210867613=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC ssn PATCH 4/4] D-Bus API for Supplementary Service
 Notifications
Date: Fri, 22 Oct 2010 12:47:57 -0500
Message-ID: <4CC1CE4D.1020007@gmail.com>
In-Reply-To: <1286552200-18282-5-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3022434928210867613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 10/08/2010 10:36 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> ---
>  doc/call-barring-api.txt     |   10 -------
>  doc/call-forwarding-api.txt  |    9 +++++++
>  doc/voicecall-api.txt        |   55 ++++++++++++++++++++++++++++++++++++=
+++++-
>  doc/voicecallmanager-api.txt |    5 ++++
>  4 files changed, 68 insertions(+), 11 deletions(-)
> =

> diff --git a/doc/call-barring-api.txt b/doc/call-barring-api.txt
> index 41ae4b1..1534494 100644
> --- a/doc/call-barring-api.txt
> +++ b/doc/call-barring-api.txt
> @@ -37,16 +37,6 @@ Signals		PropertyChanged(string property, variant valu=
e)
>  			Signal is emitted whenever a property has changed.
>  			The new value is passed as the signal argument.
>  =

> -		IncomingBarringInEffect()
> -
> -			Signal is emitted when a call is made and an
> -			incoming call barring supplementary service is in use.
> -
> -		OutgoingBarringInEffect()
> -
> -			Signal is emitted when a call is made and an
> -			outgoing call barring supplementary service is in use.
> -
>  Properties	string VoiceIncoming [readwrite]
>  =

>  			Contains the value of the barrings for the incoming
> diff --git a/doc/call-forwarding-api.txt b/doc/call-forwarding-api.txt
> index 067531a..a97165b 100644
> --- a/doc/call-forwarding-api.txt
> +++ b/doc/call-forwarding-api.txt
> @@ -26,6 +26,15 @@ Signals		PropertyChanged(string property, variant valu=
e)
>  			Signal is emitted whenever a property has changed.
>  			The new value is passed as the signal argument.
>  =

> +		ForwardingInEffect(string condition)
> +
> +			This informational signal is emitted when an outgoing
> +			call is made. It indicates that a voice call
> +			forwarding for incoming calls is in use. Condition can
> +			be either of:
> +				"unconditional" - VoiceUnconditional is active
> +				"conditional" - A conditional rule is active
> +

So this maps to CSSI <code1> 0 or 1.  Sounds like this belongs on the
voicecall interface (or perhaps voicecallmanager) as well.

>  Properties	string VoiceUnconditional [readwrite]
>  =

>  			Contains the value of the voice unconditional call
> diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
> index f0ba316..a6c0b42 100644
> --- a/doc/voicecall-api.txt
> +++ b/doc/voicecall-api.txt
> @@ -73,6 +73,54 @@ Signals		PropertyChanged(string property, variant valu=
e)
>  			of this signal as optional. This signal will be
>  			emitted before the PropertyChanged signal.
>  =

> +		JoinedMultiparty()
> +
> +			Signal is emitted when remote party joins the
> +			call into a multiparty conference.
> +
> +			Note that there is no corresponding event when
> +			remote party splits call from the multiparty
> +			conference.
> +
> +		Waiting()
> +
> +			Signal is emitted when an outgoing call is waiting.

I'm fine with this one, but have you considered putting this on a the
voicecallmanager interface?  This can only be emitted for dialing /
alerting calls, so the scope is inherently known.  But I'm fine either way.

> +
> +		OutgoingBarred()
> +
> +			Signal is emitted when caller's outgoing barring
> +			services prevent call from being connected.
> +
> +			This signal can be emitted while call is being
> +			disconnected or while a recorded announcement is
> +			played.
> +

I'm not so sure about this assessment on AT modems...

> +		IngomingBarred()
> +
> +			Signal is emitted when callee's incoming barring
> +			services prevent call from being connected.
> +
> +			This signal can be emitted while call is being
> +			disconnected or while a recorded announcement is
> +			played.

Please name this RemoteBarred()

> +
> +		IncomingRedirected(string)
> +
> +			Signal is emitted when network indicates that an
> +			incoming call has been redirected.  The value
> +			contains the phone number of the party that
> +			redirected the call if available.

Why is this one on the voice call interface while IncomingForwarded is
on the voicecall manager interface?  I assume this refers to an incoming
or waiting call being signaled as part of a deflection procedure?

> +
> +		OutgoingRedirected()
> +
> +			Signal is emitted when an outgoing call has been
> +			redirected.

Please stick with our terminology and name this Deflected().

> +
> +		CallerIDRestrictionRejected()
> +
> +			Signal is emitted when caller requested Caller
> +			ID Restriction but network rejects it.

Again for consistency, please use CallingLineRestrictionRejected()

> +
>  Properties	string LineIdentification [readonly]
>  =

>  			Contains the Line Identification information returned
> @@ -90,7 +138,7 @@ Properties	string LineIdentification [readonly]
>  		boolean Multiparty [readonly]
>  =

>  			Contains the indication if the voice call is part
> -			of a multiparty call or not.
> +			of a multiparty call set up by user or not.
>  =

>  			Notifications if a call becomes part or leaves a
>  			multipart call are sent.
> @@ -115,6 +163,11 @@ Properties	string LineIdentification [readonly]
>  			Client applications can use this to infer somewhat
>  			reliable call duration information.
>  =

> +		boolean OnHold [readonly]
> +
> +			Contains the indication if the remote party has
> +			put call on hold.
> +

I'm not sure you can ever make this work on AT modems.  Perhaps making
this a signal on the VoiceCallManager interface is better.

>  		string Information [readonly, optional]
>  =

>  			Contains information related to the call for the
> diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
> index 11af23a..34ed9de 100644
> --- a/doc/voicecallmanager-api.txt
> +++ b/doc/voicecallmanager-api.txt
> @@ -132,6 +132,11 @@ Signals		CallAdded(object path, dict properties)
>  			released.  The object path is no longer accessible
>  			after this signal and only emitted for reference.
>  =

> +		IncomingCallForwarded
> +
> +			This signal is sent when an incoming voice call
> +			has been forwarded by the network.
> +

What is this one referring to?  Is it a result of a transfer procedure?

>  Properties	array{string} EmergencyNumbers
>  =

>  			Contains the list of emergency numbers recognized

Regards,
-Denis

--===============3022434928210867613==--

