Content-Type: multipart/mixed; boundary="===============1580281428761145134=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/4] sim: Implement file watching and basic refresh.
Date: Tue, 08 Feb 2011 03:22:26 +0100
Message-ID: <AANLkTikfzUHRWtWRzOo07FNXoJ9-53JeEen2hNTZg+_0@mail.gmail.com>
In-Reply-To: <4D509B93.6070701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1580281428761145134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 8 February 2011 02:25, Denis Kenzior <denkenz@gmail.com> wrote:
>>> Actually we should for files that are read during pre-sim but are not
>>> important enough. =C2=A0E.g. EFecc, EFli, EFpl, EFiccid, etc.
>>
>> But if we "restart SIM initialization procedure", we already re-read
>> those files so there's nothing more we need to do. =C2=A0The sim
>> initialization in 51.011 includes reading those files if I remember
>> correctly.
>>
>
> I'm still fuzzy on this one. =C2=A0EFpl/EFli and EFiccid are in a differe=
nt
> DF than the rest of the files, so they might not need to be initialized
> again in practice, unless we're performing a full reset.

Maybe, although it's such a rare situation that I don't think we're
gaining anything here by making an assumption that is not documented
in any spec.

I'm also fuzzy on what the differences between the Refresh types are
for us but we can't go wrong by re-reading all files.

>
> In the case of EFecc, the file is on voicecall atom, so the change watch
> has to be fired anyway. =C2=A0So using my approach it works out nicely.
>
>>>
>>>>
>>>>> else
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for each file changed:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0notify matchin=
g remaining watches
>>>>
>>>> What if a file is changed which doesn't have a handler implemented?
>>>> Shouldn't we fall back to removing the atom? That was the idea of
>>>> those "complicated" loops above.
>>>
>>> If it should be handled, then its a bug. =C2=A0Removing all atoms just
>>> because someone forgot to handle a file is bad anyway.
>>
>> We don't need to remove atoms, in this patch series we simply signal
>> "sim ready" to atoms in those cases. =C2=A0Otherwise all those NULL watc=
hes
>> are useless, right? =C2=A0The reason I introduced the NULL-callback watc=
hes
>> is because there are many files, like EFcfis, which are unlikely to be
>> changed by the SIM application or operator. =C2=A0Yet we can't ignore th=
em,
>> in case we receive a Refresh on those files. =C2=A0We have two dozens of
>> such files and it's not practical to add notifiers for all of them,
>> it's easier to fall back to re-reading all of the post-sim files.
>
> Honestly I think we should handle all of them, one by one. =C2=A0It might
> take a little while, but we have to anyway in the long run. =C2=A0We can
> concentrate on the important ones first, e.g. EFcsp, EFspn, EFopl,
> EFecc, etc. =C2=A0Sure, in the short term we might not handle each and ev=
ery
> file that could be sent via Refresh. =C2=A0But then we just acknowledge i=
t as
> a bug and fix it later. =C2=A0Re-initializing everything just because e.g.
> EFmbdn or some other unimportant file changed and we're too lazy to fix
> it is just not a good idea anyway.

So maybe we should return "Not capable" to a refresh that touches any
of those files?  At the very least we would need to log some kind of
warning.  (Then again these user-writable files are so unlikely to be
changed that I don't think we're losing anything by being safe and
re-reading everything)

>
>>
>> In the patch 3/4 I've added watches for all of the files where changes
>> need to be somehow handled. =C2=A0Most of them have NULL callback because
>> they're not really important and it would be a huge patch if wanted to
>> have a handler for every single file, although we can add them
>> gradually later. =C2=A0The files where changes don't need to be handled,
>> don't register a watch at all (like EFcbmi, EFcbmir which are only
>> used for initialising our own topics list)
>
> I know what you're trying to accomplish, but I don't think we need this
> flexibility. =C2=A0The 'important' files that are likely to change have t=
o be
> handled anyway. =C2=A0For the 2G/3G/CPHS cases we cover most of the EFs t=
hat
> are required, so we have a good handle on what is needed. =C2=A0We might =
be
> missing one or two, but certainly not dozens. =C2=A0So let us keep things=
 simple.
>
>>
>>>
>>>>
>>>>>
>>>>> Incidentally the above list of files to re-read is exactly the same
>>>>> files we need to re-initialize when we lock ourselves out when trying=
 to
>>>>> lock/unlock/change the PIN.
>>>>>
>>>>>> + =C2=A0 =C2=A0 switch (reset_state) {
>>>>>> + =C2=A0 =C2=A0 case RESET_REMOVE_ATOMS:
>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* REVISIT: There's=
 some concern that on re-insertion the
>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* atoms will start=
 to talk to the SIM before it becomes
>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ready, on certai=
n SIMs.
>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_inserted_notif=
y(sim, FALSE);
>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_inserted_notif=
y(sim, TRUE);
>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>>>
>>>>> This is not really a good idea semantics wise. =C2=A0The SIM hasn't r=
eally
>>>>> been removed and a UICC reset / NAA application reset / NAA session
>>>>> reset is not being performed either.
>>>>
>>>> Hmm probably. =C2=A0Although from our point of view the NAA initialisa=
tion
>>>> looks the same as sim re-insertion so we end up inlining that fuction.
>>>>
>>>
>>> I'm still fuzzy on what NAA initialization actually does. =C2=A0Right n=
ow my
>>> interpretation is that EFpl/EFli and EFiccid have not changed. =C2=A0So=
 it is
>>> not quite the same as a reset.
>>
>> However with Full file change notification they may have changed, so
>> it's a safe fallback to re-read them.
>
> Your guess is as good as mine right now, however we need this
> functionality anyway for the 'SIM PIN locked out after we're in
> sim_ready state' case anyway. =C2=A0Or if lets say we get a File Changed
> Notification with EFfdn for example. =C2=A0There's no sense in re-reading
> EFiccid, EFpl/EFli as well.

In case of EFfdn I think we should eventually have a handler which
will do the right thing and remove or create the affected atoms as
necessary.

But I don't see why EFpl shouldn't change during a Refresh with Full
file change notification.  I wouldn't call it a guess as much as being
ready for anything :)  It's not like this is not allowed to happen, so
there's no reason to think it can't happen.

Any of those files can also be explicitly speciied in the changed
files list.  Maybe the solution is to just use a different reset_level
value when calling sim_add_file_watch for such files.

Best regards

--===============1580281428761145134==--

