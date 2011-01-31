Content-Type: multipart/mixed; boundary="===============1690420774716349633=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] voice call API changes (proposal)
Date: Mon, 31 Jan 2011 13:58:40 -0600
Message-ID: <4D471470.5050100@gmail.com>
In-Reply-To: <f05c513a9ca1d1a296a8e1dfc6af633e2fb058a1.1296474033.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1690420774716349633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 01/31/2011 05:56 AM, Andras Domokos wrote:
> Here is a proposal for expanding the VoiceCallManager interface with =

> call related Supplementary Services signals, and the VoiceCall
> interface with new properties.
> =

> ---
>  doc/call-barring-api.txt     |   10 ----------
>  doc/voicecall-api.txt        |   15 +++++++++++++++
>  doc/voicecallmanager-api.txt |   21 +++++++++++++++++++++
>  3 files changed, 36 insertions(+), 10 deletions(-)
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
> diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
> index 047b8cb..e7276a3 100644
> --- a/doc/voicecall-api.txt
> +++ b/doc/voicecall-api.txt
> @@ -145,3 +145,18 @@ Properties	string LineIdentification [readonly]
>  =

>  			Contains the indication if the voice call is an
>  			emergency call or not.
> +
> +		boolean Forwarded
> +
> +			Contains the indication whether the voice call is a
> +			forwarded call or not.
> +

So just to clarify, this is usually set on a local Incoming / Waiting
call, correct?

> +		boolean RemoteHold
> +
> +			Contains the indication whether the voice call has been
> +			put on hold by the remote party or not.
> +

This one is rather tricky, since AT modems do not report the index of
the call.  So the only way you can report this is if you have only a
single call active or your modem supports this properly (I know ISI does).

> +		boolean Waiting
> +
> +			Contains the indication whether the outgoing voice call
> +			is waiting or not.

And this is for a local dialing / alerting call.  Correct?

> diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
> index 2bf9ded..bbd80db 100644
> --- a/doc/voicecallmanager-api.txt
> +++ b/doc/voicecallmanager-api.txt
> @@ -144,6 +144,27 @@ Signals		CallAdded(object path, dict properties)
>  			Signal is emitted whenever a property has changed.
>  			The new value is passed as the signal argument.
>  =

> +		UnconditionalForwardingInEffect
> +
> +			Signal is emitted when a call is made and unconditional
> +			call forwarding supplementary service is active.

This is for a local dialing / alerting call.  Correct?

> +
> +		ConditionalForwardingInEffect
> +
> +			Signal is emitted when a call is made and some of the
> +			conditional call forwarding supplementary services are
> +			active.
> +

Same as above?

> +		IncomingBarringInEffect()
> +
> +			Signal is emitted when a call is made and an
> +			incoming call barring supplementary service is in use.
> +

For local outgoing calls telling that the remote side has incoming
barring active?

> +		OutgoingBarringInEffect()
> +
> +			Signal is emitted when a call is made and an
> +			outgoing call barring supplementary service is in use.
> +

And this one telling you that local outgoing barring is active?

>  Properties	array{string} EmergencyNumbers [readonly]
>  =

>  			Contains the list of emergency numbers recognized

Generally I'm fine with these but please document them a bit more
clearly, and we might have to pick names that make a bit more sense.

Other than that, you're missing the mpty join indications that Pekka had
in his earlier proposal.  These suffer from the same problem as RemoteHold.

Regards,
-Denis

--===============1690420774716349633==--

