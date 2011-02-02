Content-Type: multipart/mixed; boundary="===============5139277306638184035=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] voice call API changes (proposal)
Date: Wed, 02 Feb 2011 09:32:28 -0600
Message-ID: <4D49790C.4010807@gmail.com>
In-Reply-To: <4D490D17.3040405@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5139277306638184035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 02/02/2011 01:51 AM, Andras Domokos wrote:
> Hi Denis,
> =

> On 02/01/2011 05:54 PM, ext Denis Kenzior wrote:
>> Hi Andras,
>>
>>>>> +
>>>>> +        boolean Forwarded
>>>>> +
>>>>> +            Contains the indication whether the voice call is a
>>>>> +            forwarded call or not.
>>>>> +
>>>> So just to clarify, this is usually set on a local Incoming / Waiting
>>>> call, correct?
>>> This property would apply to both, outgoing and incoming calls.
>>>
>>> When the incoming call is a forwarded call the call is accompanied
>>> by a "forwarded call" SS notification.
>>>
>>> When the call is an outgoing call and the call is forwarded due to the
>>> remote party having a conditional or unconditional forwarding enabled,
>>> the outgoing call is accompanied by a "call has been forwarded"
>>> SS notification.
>>>
>>> I think would be a good idea, if not mandatory, to have a voice call
>>> property indicating the call direction.
>> So why do we need the below two signals if the Forwarded property
>> applies to both incoming and outgoing calls?
> These are optional in fact, let's ignore them for now.
> What about the rest, are we OK now?

I don't really like this Forwarded property.  I think we should really
break up the indications between the Incoming and Outgoing states.  If
you want Forwarded as a property, then treat it as incoming calls only
and keep the two signals for the outgoing conditions.

Please re-send the entire proposal with all the feedback and extra
documentation integrated in so we can have another look.

Regards,
-Denis

--===============5139277306638184035==--

