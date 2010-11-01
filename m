Content-Type: multipart/mixed; boundary="===============4995784743703491263=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC PATCH 2/3] voicecall: emergency call handling added
Date: Mon, 01 Nov 2010 13:23:38 +0200
Message-ID: <4CCEA33A.70406@nokia.com>
In-Reply-To: <4CCB0531.2040208@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4995784743703491263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 10/29/2010 08:32 PM, ext Denis Kenzior wrote:
> Hi Andras,
>
>    =

>>> Just some general comments, but this patch seems to be backwards from
>>> the earlier proposal.  Namely EmergencyMode is a property on the Modem
>>> interface, not on the VoiceCallManager.  See doc/modem-api.txt,
>>> Emergency property.
>>>
>>>        =

>> I thought it was more logical to have the EmergencyMode property
>> linked to voicecall since it is about a special call case, but I am fine
>> with moving that property up to modem level.
>>
>>      =

> Oh I can see that as well, but I think earlier we agreed that it should
> be on the Modem interface.  This has several advantages: offline /
> online toggling has to happen in the modem and it is easier for the
> power management framework to monitor it there.  So unless you feel
> really strongly against that I suggest we stick with the earlier proposal.
>
>    =

I see the advantage of using the Modem interface and I am fine
with basing the implementation on it.
>>> In general I think that the emergency_watch is unnecessary.  Having a
>>> reference counted emergency tracking inside the modem object and a modem
>>> online state watch should be sufficient.
>>>
>>>
>>>        =

>> The idea with the emergency watch is that any subsystem can get the
>> notification  when the emergency mode is entered and react on it.
>>      =

> Don't get me wrong, it might be useful in the future.  But for the
> context of supporting emergency calls in the voicecall driver the
> emergency watch is not really needed.  In general I prefer to review
> code which has an immediate or foreseeable need.
>
> In this case if we detect an emergency call dial and we're offline, we:
>
> - Save the pending call
> - establish an online watch
> - ofono_modem_inc_emergency_mode()
>
> Once we are online:
> - Dial the call
>
> Once the call ends
> - ofono_modem_dec_emergency_mode()
>
> Nowhere do we actually need to use an emergency watch itself.
>
>    =

>> To give you a more complex example, it might well be that the gprs
>> connection needs to be torn down when making an emergency call in
>> 2G mode, there are such networks out there that prevents you from
>> making an emergency call if your device is attached to a PDP context.
>> In this given situation it comes to the question how to bring down the
>> gprs connection. It can be done such that the gprs atom will tear down
>> the connection after receiving the EmergencyMode notification, or
>> another option is to have gprs connection handling functions made
>>      =

> Have we established that this is actually still needed?  I thought you
> guys said all the networks that have this problem have been fixed by now?
>
> If this is still required, I suggest you group the emergency watch
> functions with patches implementing the above functionality.
>
>    =

>> available by gprs and to deal with the gprs connection within voicecall
>> (or somewhere else). The online/offline mode change handling in fact is
>> bringing up the some issue, how the mode change handling should be
>> implemented when making the emergency call. My idea was let every
>> subsystem deal with the specifics of its own subsystem.
>>      =

> Let the modem figure out the specifics.  Basically as long as the count
> for emergency is greater than 1, Offline mode should not be entered.
> Once it reaches 0, the online mode should go back to the previous value.
>    =


Based on the comments and after some clarifications made in our
team, I consider the emergency watch unnecessary. We can forget
about the very corner case and go with the simpler approach.

OK, I am going to come up with a new set of patches.

> Regards,
> -Denis
>    =


Regards,
Andras

--===============4995784743703491263==--

