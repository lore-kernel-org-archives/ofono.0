Content-Type: multipart/mixed; boundary="===============5288143755539829786=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] voicecall API changes (proposal 2)
Date: Wed, 02 Feb 2011 14:01:07 -0600
Message-ID: <4D49B803.8030108@gmail.com>
In-Reply-To: <33f41837f16b650f6595e1004b82a7ea6ba2ed54.1296668679.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5288143755539829786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

> +
> +		boolean ForwardedCall
> +
> +			Contains the indication whether the incoming voice call
> +			is a redirected call due to a call forwarding operation
> +			or not.

Please drop the Call suffix, you are already on the VoiceCall interface,
so putting 'Call' at the end is redundant.

> +
> +		boolean RemoteHoldActive
> +
> +			Contains the indication whether the voice call is put on
> +			hold by the remote party or not.
> +

RemoteHeld might be a better name here, but I'm fine either way.

> +		boolean RemoteMultiparty
> +
> +			Contains the indication whether the voice call is joined
> +			in a multiparty call by the remote party or not.
> +
> diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
> index 5415345..7517a7c 100644
> --- a/doc/voicecallmanager-api.txt
> +++ b/doc/voicecallmanager-api.txt
> @@ -144,6 +144,34 @@ Signals		CallAdded(object path, dict properties)
>  			Signal is emitted whenever a property has changed.
>  			The new value is passed as the signal argument.
>  =

> +		RemoteCallBarringActive()
> +
> +			Signal is emitted when an outgoing voice call is made
> +			and the call has been barred by the network due to the
> +			remote party's "Call Barring" Supplementary Services
> +			settings for incoming calls.
> +
> +		LocalCallBarringActive()
> +
> +			Signal is emitted when an outgoing voice call is made
> +			and the call has been barred by the network due to the
> +			local party's "Call Barring" Supplementary Services
> +			settings for outgoing calls.
> +

I suggest to combine these two signals into one:
BarringActive(string type)

where type is:
"remote" or "local".

The explanations you have should be applied to the type.  Another point
is whether we want this signal on the call object itself.  Question is
how reliably we can figure out the call index.  At what point does CSSI
/ CSSU fire, before or after the call goes to active / disconnected state?

> +		OutgoingCallCondForwarded()
> +
> +			Signal is emitted when an outgoing voice call is made
> +			and the call has been redirected to another number due
> +			to the remote party's conditional "Call Forwarding"
> +			Supplementary Service settings.
> +
> +		OutgoingCallUncondForwarded()
> +
> +			Signal is emitted when an outgoing voice call is made
> +			and the call has been redirected to another number due
> +			to the remote party's unconditional "Call Forwarding"
> +			Supplementary Service settings.
> +

Same with these two, lets call it CallForwarded(string type)

where type is:
"conditional" or "unconditional"

And the same question applies here as well, do we want this on the call
object itself?  If so, then calling this signal Forwarded(string type)
would be better.  Perhaps adding another type for incoming calls that
are forwarded and removing the 'Forwarded' property would be a good idea
as well.  e.g. something like "incoming" type.

Regards,
-Denis

--===============5288143755539829786==--

