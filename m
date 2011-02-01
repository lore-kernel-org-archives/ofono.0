Content-Type: multipart/mixed; boundary="===============6892777750804206383=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC] voice call API changes (proposal)
Date: Tue, 01 Feb 2011 17:43:46 +0200
Message-ID: <4D482A32.1020806@nokia.com>
In-Reply-To: <4D471470.5050100@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6892777750804206383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 01/31/2011 09:58 PM, ext Denis Kenzior wrote:
> Hi Andras,
>
> On 01/31/2011 05:56 AM, Andras Domokos wrote:
>> Here is a proposal for expanding the VoiceCallManager interface with
>> call related Supplementary Services signals, and the VoiceCall
>> interface with new properties.
>>
>> ---
>>   doc/call-barring-api.txt     |   10 ----------
>>   doc/voicecall-api.txt        |   15 +++++++++++++++
>>   doc/voicecallmanager-api.txt |   21 +++++++++++++++++++++
>>   3 files changed, 36 insertions(+), 10 deletions(-)
>>
>> diff --git a/doc/call-barring-api.txt b/doc/call-barring-api.txt
>> index 41ae4b1..1534494 100644
>> --- a/doc/call-barring-api.txt
>> +++ b/doc/call-barring-api.txt
>> @@ -37,16 +37,6 @@ Signals		PropertyChanged(string property, variant val=
ue)
>>   			Signal is emitted whenever a property has changed.
>>   			The new value is passed as the signal argument.
>>
>> -		IncomingBarringInEffect()
>> -
>> -			Signal is emitted when a call is made and an
>> -			incoming call barring supplementary service is in use.
>> -
>> -		OutgoingBarringInEffect()
>> -
>> -			Signal is emitted when a call is made and an
>> -			outgoing call barring supplementary service is in use.
>> -
>>   Properties	string VoiceIncoming [readwrite]
>>
>>   			Contains the value of the barrings for the incoming
>> diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
>> index 047b8cb..e7276a3 100644
>> --- a/doc/voicecall-api.txt
>> +++ b/doc/voicecall-api.txt
>> @@ -145,3 +145,18 @@ Properties	string LineIdentification [readonly]
>>
>>   			Contains the indication if the voice call is an
>>   			emergency call or not.
>> +
>> +		boolean Forwarded
>> +
>> +			Contains the indication whether the voice call is a
>> +			forwarded call or not.
>> +
> So just to clarify, this is usually set on a local Incoming / Waiting
> call, correct?
This property would apply to both, outgoing and incoming calls.

When the incoming call is a forwarded call the call is accompanied
by a "forwarded call" SS notification.

When the call is an outgoing call and the call is forwarded due to the
remote party having a conditional or unconditional forwarding enabled,
the outgoing call is accompanied by a "call has been forwarded"
SS notification.

I think would be a good idea, if not mandatory, to have a voice call
property indicating the call direction.
>> +		boolean RemoteHold
>> +
>> +			Contains the indication whether the voice call has been
>> +			put on hold by the remote party or not.
>> +
> This one is rather tricky, since AT modems do not report the index of
> the call.  So the only way you can report this is if you have only a
> single call active or your modem supports this properly (I know ISI does).
Indeed, this is a tricky case since the standard AT Supplementary
Services notification don't provide the call index within the notifications.
Although in many cases the call index can be inferred correctly, there
are cases when this is impossible and the call index needs to be
provided explicitly, like in the remote hold/multiparty  cases and
assuming 2 local calls. We do best effort guess for modems not
supporting call indexes.

>> +		boolean Waiting
>> +
>> +			Contains the indication whether the outgoing voice call
>> +			is waiting or not.
> And this is for a local dialing / alerting call.  Correct?
This is an indication from the network in connection with an
outgoing call telling that the remote party is already engaged into
a call and your call is waiting to be answered or rejected (handled).

>> diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
>> index 2bf9ded..bbd80db 100644
>> --- a/doc/voicecallmanager-api.txt
>> +++ b/doc/voicecallmanager-api.txt
>> @@ -144,6 +144,27 @@ Signals		CallAdded(object path, dict properties)
>>   			Signal is emitted whenever a property has changed.
>>   			The new value is passed as the signal argument.
>>
>> +		UnconditionalForwardingInEffect
>> +
>> +			Signal is emitted when a call is made and unconditional
>> +			call forwarding supplementary service is active.
> This is for a local dialing / alerting call.  Correct?
The notification is sent in connection with an outgoing call when
the remote party has unconditional call forwarding enabled that
is enforced by the network.
>> +
>> +		ConditionalForwardingInEffect
>> +
>> +			Signal is emitted when a call is made and some of the
>> +			conditional call forwarding supplementary services are
>> +			active.
>> +
> Same as above?
The notification is sent in connection with an outgoing call when
the remote party has such conditional call forwarding enabled
that is enforced by the network.

>> +		IncomingBarringInEffect()
>> +
>> +			Signal is emitted when a call is made and an
>> +			incoming call barring supplementary service is in use.
>> +
> For local outgoing calls telling that the remote side has incoming
> barring active?
Yes.
Emitted when making an outgoing call and the remote party has such an
incoming call barring enabled that is enforced by the network.
>> +		OutgoingBarringInEffect()
>> +
>> +			Signal is emitted when a call is made and an
>> +			outgoing call barring supplementary service is in use.
>> +
> And this one telling you that local outgoing barring is active?
Yes.
Emitted when making an outgoing call and there is such outgoing
call barring enabled that is enforced by the network.
>>   Properties	array{string} EmergencyNumbers [readonly]
>>
>>   			Contains the list of emergency numbers recognized
> Generally I'm fine with these but please document them a bit more
> clearly, and we might have to pick names that make a bit more sense.
>
> Other than that, you're missing the mpty join indications that Pekka had
> in his earlier proposal.  These suffer from the same problem as RemoteHol=
d.
That's true, RemoteMultiparty needs to be added to the the set of call
properties and we are facing the same challenges as with the RemoteHold
case.


> Regards,
> -Denis

Regards,
Andras

--===============6892777750804206383==--

