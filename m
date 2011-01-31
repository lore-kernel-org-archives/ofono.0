Content-Type: multipart/mixed; boundary="===============5836682522816463507=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 3/5] sim: Implement file watching and basic refresh.
Date: Mon, 31 Jan 2011 19:29:04 +0100
Message-ID: <AANLkTinvOfKFchvX33nwnbUbK8Knhf7B2Zu5Ucs=E-6f@mail.gmail.com>
In-Reply-To: <4D46F530.1090702@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5836682522816463507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 31 January 2011 18:45, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> + =C2=A0 =C2=A0 switch (reset_state) {
>>>> + =C2=A0 =C2=A0 case RESET_STATE_NOT_PRESENT:
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_inserted_notify(=
sim, FALSE);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_inserted_notify(=
sim, TRUE);
>>>
>>> Are you sure we can do it this way? =C2=A0I would assume that the modem=
 might
>>> require some time to perform its own SIM initialization and would have
>>> to signal the sim_inserted itself...
>>
>> I assume that the modem would send the refresh command only once it
>> has done all its internal housekeeping and is ready for us to re-read
>> the changed files. =C2=A0If not then probably the AT interface will block
>> for as much time as needed?
>>
>
> So I think we have to double check this part. =C2=A0There are definitely =
STK
> implementations which send the Refresh and then look at the terminal
> response to see whether the refresh should succeed or not.

Yes, it would be good to confirm, at this point I have no data.
However I can't see a good way to find out when the SIM is ready to
accept new commands (except sending the commands away and waiting
until we get called back).

>
>>>
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>> + =C2=A0 =C2=A0 case RESET_STATE_INSERTED:
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_free_state(sim);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->state =3D OFONO_SIM_S=
TATE_INSERTED;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_initialize(sim);
>>>
>>> What about removing all the post_sim / online atoms? =C2=A0In theory
>>> something like EFfdn could have been changed and now we're stuck in
>>> fixed dialing mode. =C2=A0We should not keep the atoms around in this c=
ase.
>>
>> So in the next patch I add a "watch" for every file in the SIM that we
>> care about. =C2=A0Every watch has a sort of "reset level", which tells
>> sim.c how much of our state needs to be reinitialised, so that we
>> don't reset the atoms if that is not necessary. =C2=A0For example for EF=
ust
>> / EFest we set the level to RESET_STATE_INSERTED.
>>
>> This is the case for FDN, because will be re-read EFust/EFest as a
>> result of sim_initialize() and later at some point we will signal
>> OFONO_SIM_STATE_READY so all the concerned atoms will take note. =C2=A0I=
t's
>> not necessary to remove the atoms in this case.
>>
>
> Still not sure this works. =C2=A0Lets say you have a SIM that can change =
FDN
> mode based on STK refresh. =C2=A0If it sends us such a command and FDN is=
 now
> enabled, we should remove all atoms except pre-sim, as they are no
> longer relevant. =C2=A0If we start oFono up and FDN is enabled, the atoms
> won't be present, why is the case via refresh different?

You're right, my logic has failed somewhere.. I see that the
"RESET_STATE_INSERTED" state is actually unneeded, it should just be
same as NOT_PRESENT and drop all post-sim atoms and then potentially
re-create.

>
>>>
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>> + =C2=A0 =C2=A0 case RESET_STATE_READY:
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->state =3D OFONO_SIM_S=
TATE_INSERTED;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (l =3D sim->state_watc=
hes->items; l; l =3D l->next) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct ofono_watchlist_item *item =3D l->data;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ofono_sim_state_event_cb_t notify =3D item->notify;
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 notify(sim->state, item->notify_data);
>>>
>>> I'm having trouble understanding the need for this for loop. =C2=A0Isn'=
t the
>>> SIM already inserted?
>>
>> I initially didn't have this loop, but I thought it might be better to
>> signal "INSERTED" just before "READY", so that atoms see a *change* if
>> they though that the sim was READY before. =C2=A0But looking at the curr=
ent
>> users of the sim state watch, it makes no difference.
>>
>
> Then lets drop it.
>
>>> Overall it seems like there are two categories of files that we should
>>> worry about:
>>>
>>> - Those handled inside sim.c that affect sim initialization:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- EFust, EFest, EFsst
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- EFbdn, EFfdn
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- EFphase, EFcphs_info (these ones are reall=
y unlikely outside of a
>>> full sim reset)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- EFad (This one is unlikely as it would aff=
ect the IMSI)
>>> - The ones that don't
>>>
>>> To me it sounds like we should just special case the ones affecting sim
>>> initialization inside this function and use a simplified API for the re=
st.
>>
>> So I think this wouldn't make the api much better because:
>>
>> * These files you listed are the majority of all files we read, so the
>> "normal" users are in minority.
>
> I'm not so sure, I counted at least 15 instances of 'normal' files.
>
>>
>> * The only simplification I see would be removal of one parameter in
>> add_file_watch_call
>>
>> int ofono_sim_add_file_watch(struct ofono_sim *sim, int id,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0enum ofono_sim_state reset_state,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ofono_sim_file_notify_t notify, void *userdata);
>>
>> or are you thinking about a different simplifaction?
>
> Yes, I would yang the reset_state parameter. =C2=A0That one is really
> confusing and not needed outside the sim atom anyway. =C2=A0So my proposa=
l is
> to make this as complicated as you need inside sim atom, but expose a
> specialized API to the rest of the system.

Ok, sounds good.

Best regards

--===============5836682522816463507==--

