Content-Type: multipart/mixed; boundary="===============5089537800419412515=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] voice call API changes (proposal)
Date: Tue, 01 Feb 2011 09:54:01 -0600
Message-ID: <4D482C99.8080409@gmail.com>
In-Reply-To: <4D482A32.1020806@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5089537800419412515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

>>> +
>>> +        boolean Forwarded
>>> +
>>> +            Contains the indication whether the voice call is a
>>> +            forwarded call or not.
>>> +
>> So just to clarify, this is usually set on a local Incoming / Waiting
>> call, correct?
> This property would apply to both, outgoing and incoming calls.
> =

> When the incoming call is a forwarded call the call is accompanied
> by a "forwarded call" SS notification.
> =

> When the call is an outgoing call and the call is forwarded due to the
> remote party having a conditional or unconditional forwarding enabled,
> the outgoing call is accompanied by a "call has been forwarded"
> SS notification.
> =

> I think would be a good idea, if not mandatory, to have a voice call
> property indicating the call direction.

So why do we need the below two signals if the Forwarded property
applies to both incoming and outgoing calls?

>>> +        UnconditionalForwardingInEffect
>>> +
>>> +            Signal is emitted when a call is made and unconditional
>>> +            call forwarding supplementary service is active.
>> This is for a local dialing / alerting call.  Correct?
> The notification is sent in connection with an outgoing call when
> the remote party has unconditional call forwarding enabled that
> is enforced by the network.
>>> +
>>> +        ConditionalForwardingInEffect
>>> +
>>> +            Signal is emitted when a call is made and some of the
>>> +            conditional call forwarding supplementary services are
>>> +            active.
>>> +
>> Same as above?
> The notification is sent in connection with an outgoing call when
> the remote party has such conditional call forwarding enabled
> that is enforced by the network.
> =


Regards,
-Denis

--===============5089537800419412515==--

