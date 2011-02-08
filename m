Content-Type: multipart/mixed; boundary="===============4583229112799525080=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] sim: Implement file watching and basic refresh.
Date: Mon, 07 Feb 2011 19:25:39 -0600
Message-ID: <4D509B93.6070701@gmail.com>
In-Reply-To: <AANLkTimPQ8W057Nk8dfFaz9Y2GbcdYRW_Sm6_9Y0wqsY@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4583229112799525080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>>>
>>>> if full_file_change:
>>>>        notify all remaining watches
>>>
>>> In this case we have already reinitialised the SIM, so I think we
>>> don't need to do that.
>>
>> Actually we should for files that are read during pre-sim but are not
>> important enough.  E.g. EFecc, EFli, EFpl, EFiccid, etc.
> =

> But if we "restart SIM initialization procedure", we already re-read
> those files so there's nothing more we need to do.  The sim
> initialization in 51.011 includes reading those files if I remember
> correctly.
> =


I'm still fuzzy on this one.  EFpl/EFli and EFiccid are in a different
DF than the rest of the files, so they might not need to be initialized
again in practice, unless we're performing a full reset.

In the case of EFecc, the file is on voicecall atom, so the change watch
has to be fired anyway.  So using my approach it works out nicely.

>>
>>>
>>>> else
>>>>        for each file changed:
>>>>                notify matching remaining watches
>>>
>>> What if a file is changed which doesn't have a handler implemented?
>>> Shouldn't we fall back to removing the atom? That was the idea of
>>> those "complicated" loops above.
>>
>> If it should be handled, then its a bug.  Removing all atoms just
>> because someone forgot to handle a file is bad anyway.
> =

> We don't need to remove atoms, in this patch series we simply signal
> "sim ready" to atoms in those cases.  Otherwise all those NULL watches
> are useless, right?  The reason I introduced the NULL-callback watches
> is because there are many files, like EFcfis, which are unlikely to be
> changed by the SIM application or operator.  Yet we can't ignore them,
> in case we receive a Refresh on those files.  We have two dozens of
> such files and it's not practical to add notifiers for all of them,
> it's easier to fall back to re-reading all of the post-sim files.

Honestly I think we should handle all of them, one by one.  It might
take a little while, but we have to anyway in the long run.  We can
concentrate on the important ones first, e.g. EFcsp, EFspn, EFopl,
EFecc, etc.  Sure, in the short term we might not handle each and every
file that could be sent via Refresh.  But then we just acknowledge it as
a bug and fix it later.  Re-initializing everything just because e.g.
EFmbdn or some other unimportant file changed and we're too lazy to fix
it is just not a good idea anyway.

> =

> In the patch 3/4 I've added watches for all of the files where changes
> need to be somehow handled.  Most of them have NULL callback because
> they're not really important and it would be a huge patch if wanted to
> have a handler for every single file, although we can add them
> gradually later.  The files where changes don't need to be handled,
> don't register a watch at all (like EFcbmi, EFcbmir which are only
> used for initialising our own topics list)

I know what you're trying to accomplish, but I don't think we need this
flexibility.  The 'important' files that are likely to change have to be
handled anyway.  For the 2G/3G/CPHS cases we cover most of the EFs that
are required, so we have a good handle on what is needed.  We might be
missing one or two, but certainly not dozens.  So let us keep things simple.

> =

>>
>>>
>>>>
>>>> Incidentally the above list of files to re-read is exactly the same
>>>> files we need to re-initialize when we lock ourselves out when trying =
to
>>>> lock/unlock/change the PIN.
>>>>
>>>>> +     switch (reset_state) {
>>>>> +     case RESET_REMOVE_ATOMS:
>>>>> +             /*
>>>>> +              * REVISIT: There's some concern that on re-insertion t=
he
>>>>> +              * atoms will start to talk to the SIM before it becomes
>>>>> +              * ready, on certain SIMs.
>>>>> +              */
>>>>> +             ofono_sim_inserted_notify(sim, FALSE);
>>>>> +             ofono_sim_inserted_notify(sim, TRUE);
>>>>> +             break;
>>>>
>>>> This is not really a good idea semantics wise.  The SIM hasn't really
>>>> been removed and a UICC reset / NAA application reset / NAA session
>>>> reset is not being performed either.
>>>
>>> Hmm probably.  Although from our point of view the NAA initialisation
>>> looks the same as sim re-insertion so we end up inlining that fuction.
>>>
>>
>> I'm still fuzzy on what NAA initialization actually does.  Right now my
>> interpretation is that EFpl/EFli and EFiccid have not changed.  So it is
>> not quite the same as a reset.
> =

> However with Full file change notification they may have changed, so
> it's a safe fallback to re-read them.

Your guess is as good as mine right now, however we need this
functionality anyway for the 'SIM PIN locked out after we're in
sim_ready state' case anyway.  Or if lets say we get a File Changed
Notification with EFfdn for example.  There's no sense in re-reading
EFiccid, EFpl/EFli as well.

Regards,
-Denis

--===============4583229112799525080==--

