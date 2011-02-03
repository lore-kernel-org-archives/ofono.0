Content-Type: multipart/mixed; boundary="===============5335337373652981464=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC] voicecall API changes (proposal 2)
Date: Thu, 03 Feb 2011 12:53:58 +0200
Message-ID: <4D4A8946.8050208@nokia.com>
In-Reply-To: <4D49B803.8030108@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5335337373652981464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/02/2011 10:01 PM, ext Denis Kenzior wrote:
> Hi Andras,
>
>> +
>> +		boolean ForwardedCall
>> +
>> +			Contains the indication whether the incoming voice call
>> +			is a redirected call due to a call forwarding operation
>> +			or not.
> Please drop the Call suffix, you are already on the VoiceCall interface,
> so putting 'Call' at the end is redundant.
OK, I am fine with shorter name.
>> +
>> +		boolean RemoteHoldActive
>> +
>> +			Contains the indication whether the voice call is put on
>> +			hold by the remote party or not.
>> +
> RemoteHeld might be a better name here, but I'm fine either way.
I will go with RemoteHeld, it's shorter.
>> +		boolean RemoteMultiparty
>> +
>> +			Contains the indication whether the voice call is joined
>> +			in a multiparty call by the remote party or not.
>> +
>> diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
>> index 5415345..7517a7c 100644
>> --- a/doc/voicecallmanager-api.txt
>> +++ b/doc/voicecallmanager-api.txt
>> @@ -144,6 +144,34 @@ Signals		CallAdded(object path, dict properties)
>>   			Signal is emitted whenever a property has changed.
>>   			The new value is passed as the signal argument.
>>
>> +		RemoteCallBarringActive()
>> +
>> +			Signal is emitted when an outgoing voice call is made
>> +			and the call has been barred by the network due to the
>> +			remote party's "Call Barring" Supplementary Services
>> +			settings for incoming calls.
>> +
>> +		LocalCallBarringActive()
>> +
>> +			Signal is emitted when an outgoing voice call is made
>> +			and the call has been barred by the network due to the
>> +			local party's "Call Barring" Supplementary Services
>> +			settings for outgoing calls.
>> +
> I suggest to combine these two signals into one:
> BarringActive(string type)
>
> where type is:
> "remote" or "local".
OK, let's combine them into a single signal.
> The explanations you have should be applied to the type.  Another point
> is whether we want this signal on the call object itself.  Question is
> how reliably we can figure out the call index.  At what point does CSSI
> / CSSU fire, before or after the call goes to active / disconnected state?
Usually, the user is informed about the call barred situation in a
very generic wording, like "call barring active" with no interest
in the call index information.
I prefer to keep it simple and make this signal call index "free". I
suggest keeping it on the VoiceCallManager interface.
The CSSI indication comes right after when call reached the MO
dialing state and an operator announcement is played over
and over again telling the caller the reason why calls are not
possible.

>> +		OutgoingCallCondForwarded()
>> +
>> +			Signal is emitted when an outgoing voice call is made
>> +			and the call has been redirected to another number due
>> +			to the remote party's conditional "Call Forwarding"
>> +			Supplementary Service settings.
>> +
>> +		OutgoingCallUncondForwarded()
>> +
>> +			Signal is emitted when an outgoing voice call is made
>> +			and the call has been redirected to another number due
>> +			to the remote party's unconditional "Call Forwarding"
>> +			Supplementary Service settings.
>> +
> Same with these two, lets call it CallForwarded(string type)
>
> where type is:
> "conditional" or "unconditional"
I'll combine them into one, that's fine.
> And the same question applies here as well, do we want this on the call
> object itself?  If so, then calling this signal Forwarded(string type)
> would be better.  Perhaps adding another type for incoming calls that
> are forwarded and removing the 'Forwarded' property would be a good idea
> as well.  e.g. something like "incoming" type.
I am thinking along the same line. Let's replace the "Forwarded"
property with the "Forwarded" signal and add the "incoming" type
you were suggesting to this signal.
And we shall not care about the call index, since most probably
is not going to be used anywhere, in this respect this cases is
pretty similar to the call barring signaling case; signal will be
emitted on the VoiceCallManager interface.

> Regards,
> -Denis

Regards,
Andras

--===============5335337373652981464==--

