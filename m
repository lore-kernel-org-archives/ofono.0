Content-Type: multipart/mixed; boundary="===============4247131808713920312=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC] voice call API changes (proposal)
Date: Wed, 02 Feb 2011 09:51:51 +0200
Message-ID: <4D490D17.3040405@nokia.com>
In-Reply-To: <4D482C99.8080409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4247131808713920312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/01/2011 05:54 PM, ext Denis Kenzior wrote:
> Hi Andras,
>
>>>> +
>>>> +        boolean Forwarded
>>>> +
>>>> +            Contains the indication whether the voice call is a
>>>> +            forwarded call or not.
>>>> +
>>> So just to clarify, this is usually set on a local Incoming / Waiting
>>> call, correct?
>> This property would apply to both, outgoing and incoming calls.
>>
>> When the incoming call is a forwarded call the call is accompanied
>> by a "forwarded call" SS notification.
>>
>> When the call is an outgoing call and the call is forwarded due to the
>> remote party having a conditional or unconditional forwarding enabled,
>> the outgoing call is accompanied by a "call has been forwarded"
>> SS notification.
>>
>> I think would be a good idea, if not mandatory, to have a voice call
>> property indicating the call direction.
> So why do we need the below two signals if the Forwarded property
> applies to both incoming and outgoing calls?
These are optional in fact, let's ignore them for now.
What about the rest, are we OK now?
>>>> +        UnconditionalForwardingInEffect
>>>> +
>>>> +            Signal is emitted when a call is made and unconditional
>>>> +            call forwarding supplementary service is active.
>>> This is for a local dialing / alerting call.  Correct?
>> The notification is sent in connection with an outgoing call when
>> the remote party has unconditional call forwarding enabled that
>> is enforced by the network.
>>>> +
>>>> +        ConditionalForwardingInEffect
>>>> +
>>>> +            Signal is emitted when a call is made and some of the
>>>> +            conditional call forwarding supplementary services are
>>>> +            active.
>>>> +
>>> Same as above?
>> The notification is sent in connection with an outgoing call when
>> the remote party has such conditional call forwarding enabled
>> that is enforced by the network.
>>
> Regards,
> -Denis
Regards,
Andras

--===============4247131808713920312==--

