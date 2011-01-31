Content-Type: multipart/mixed; boundary="===============3569727125321679315=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] sim: Implement file watching and basic refresh.
Date: Mon, 31 Jan 2011 11:45:20 -0600
Message-ID: <4D46F530.1090702@gmail.com>
In-Reply-To: <AANLkTimOvh07RL3c_3KfOJBQhv-fDjCkPU0Z8b7cJBU=@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3569727125321679315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> +     switch (reset_state) {
>>> +     case RESET_STATE_NOT_PRESENT:
>>> +             ofono_sim_inserted_notify(sim, FALSE);
>>> +             ofono_sim_inserted_notify(sim, TRUE);
>>
>> Are you sure we can do it this way?  I would assume that the modem might
>> require some time to perform its own SIM initialization and would have
>> to signal the sim_inserted itself...
> =

> I assume that the modem would send the refresh command only once it
> has done all its internal housekeeping and is ready for us to re-read
> the changed files.  If not then probably the AT interface will block
> for as much time as needed?
> =


So I think we have to double check this part.  There are definitely STK
implementations which send the Refresh and then look at the terminal
response to see whether the refresh should succeed or not.

>>
>>> +             break;
>>> +     case RESET_STATE_INSERTED:
>>> +             sim_free_state(sim);
>>> +             sim->state =3D OFONO_SIM_STATE_INSERTED;
>>> +             sim_initialize(sim);
>>
>> What about removing all the post_sim / online atoms?  In theory
>> something like EFfdn could have been changed and now we're stuck in
>> fixed dialing mode.  We should not keep the atoms around in this case.
> =

> So in the next patch I add a "watch" for every file in the SIM that we
> care about.  Every watch has a sort of "reset level", which tells
> sim.c how much of our state needs to be reinitialised, so that we
> don't reset the atoms if that is not necessary.  For example for EFust
> / EFest we set the level to RESET_STATE_INSERTED.
> =

> This is the case for FDN, because will be re-read EFust/EFest as a
> result of sim_initialize() and later at some point we will signal
> OFONO_SIM_STATE_READY so all the concerned atoms will take note.  It's
> not necessary to remove the atoms in this case.
> =


Still not sure this works.  Lets say you have a SIM that can change FDN
mode based on STK refresh.  If it sends us such a command and FDN is now
enabled, we should remove all atoms except pre-sim, as they are no
longer relevant.  If we start oFono up and FDN is enabled, the atoms
won't be present, why is the case via refresh different?

>>
>>> +             break;
>>> +     case RESET_STATE_READY:
>>> +             sim->state =3D OFONO_SIM_STATE_INSERTED;
>>> +             for (l =3D sim->state_watches->items; l; l =3D l->next) {
>>> +                     struct ofono_watchlist_item *item =3D l->data;
>>> +                     ofono_sim_state_event_cb_t notify =3D item->notif=
y;
>>> +
>>> +                     notify(sim->state, item->notify_data);
>>
>> I'm having trouble understanding the need for this for loop.  Isn't the
>> SIM already inserted?
> =

> I initially didn't have this loop, but I thought it might be better to
> signal "INSERTED" just before "READY", so that atoms see a *change* if
> they though that the sim was READY before.  But looking at the current
> users of the sim state watch, it makes no difference.
> =


Then lets drop it.

>> Overall it seems like there are two categories of files that we should
>> worry about:
>>
>> - Those handled inside sim.c that affect sim initialization:
>>        - EFust, EFest, EFsst
>>        - EFbdn, EFfdn
>>        - EFphase, EFcphs_info (these ones are really unlikely outside of=
 a
>> full sim reset)
>>        - EFad (This one is unlikely as it would affect the IMSI)
>> - The ones that don't
>>
>> To me it sounds like we should just special case the ones affecting sim
>> initialization inside this function and use a simplified API for the res=
t.
> =

> So I think this wouldn't make the api much better because:
> =

> * These files you listed are the majority of all files we read, so the
> "normal" users are in minority.

I'm not so sure, I counted at least 15 instances of 'normal' files.

> =

> * The only simplification I see would be removal of one parameter in
> add_file_watch_call
> =

> int ofono_sim_add_file_watch(struct ofono_sim *sim, int id,
>                        enum ofono_sim_state reset_state,
>                        ofono_sim_file_notify_t notify, void *userdata);
> =

> or are you thinking about a different simplifaction?

Yes, I would yang the reset_state parameter.  That one is really
confusing and not needed outside the sim atom anyway.  So my proposal is
to make this as complicated as you need inside sim atom, but expose a
specialized API to the rest of the system.

Regards,
-Denis

--===============3569727125321679315==--

