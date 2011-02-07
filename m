Content-Type: multipart/mixed; boundary="===============3394575610990212963=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] sim: Implement file watching and basic refresh.
Date: Mon, 07 Feb 2011 15:13:22 -0600
Message-ID: <4D506072.2090300@gmail.com>
In-Reply-To: <AANLkTi=tjQm8n9igfyN8DDFjXpchdVYf+P=dWHh5z7uO@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3394575610990212963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> if full_file_change or changed ef in (EFbdn, EFfdn, EFest, EFust, EFsst,
>> EFphase, EFad, EFcphs_info):
>>        Remove all atoms in post_sim and post_online
>>        Restart SIM initialization procedure
> =

> I guess that is okay, as long as we remember to keep this list updated
> (there are various other important files which we may not be using
> yet)
> =


That is fine, we fix these during the pre-certification / certification,
etc.

>>
>> if full_file_change:
>>        notify all remaining watches
> =

> In this case we have already reinitialised the SIM, so I think we
> don't need to do that.

Actually we should for files that are read during pre-sim but are not
important enough.  E.g. EFecc, EFli, EFpl, EFiccid, etc.

> =

>> else
>>        for each file changed:
>>                notify matching remaining watches
> =

> What if a file is changed which doesn't have a handler implemented?
> Shouldn't we fall back to removing the atom? That was the idea of
> those "complicated" loops above.

If it should be handled, then its a bug.  Removing all atoms just
because someone forgot to handle a file is bad anyway.

> =

>>
>> Incidentally the above list of files to re-read is exactly the same
>> files we need to re-initialize when we lock ourselves out when trying to
>> lock/unlock/change the PIN.
>>
>>> +     switch (reset_state) {
>>> +     case RESET_REMOVE_ATOMS:
>>> +             /*
>>> +              * REVISIT: There's some concern that on re-insertion the
>>> +              * atoms will start to talk to the SIM before it becomes
>>> +              * ready, on certain SIMs.
>>> +              */
>>> +             ofono_sim_inserted_notify(sim, FALSE);
>>> +             ofono_sim_inserted_notify(sim, TRUE);
>>> +             break;
>>
>> This is not really a good idea semantics wise.  The SIM hasn't really
>> been removed and a UICC reset / NAA application reset / NAA session
>> reset is not being performed either.
> =

> Hmm probably.  Although from our point of view the NAA initialisation
> looks the same as sim re-insertion so we end up inlining that fuction.
>

I'm still fuzzy on what NAA initialization actually does.  Right now my
interpretation is that EFpl/EFli and EFiccid have not changed.  So it is
not quite the same as a reset.

>>
>>> +     case RESET_SIGNAL_READY:
>>> +             sim->state =3D OFONO_SIM_STATE_INSERTED;
>>> +             sim_set_ready(sim);
>>> +             break;
>>
>> I still don't see a reason for this one, isn't the file_changed watch
>> enough?
> =

> In the long range I guess it should be enough but for the moment we
> only have the handler for EFmsisdn and two more files, for other files
> we rely on the atom's sim_ready notifier to re-read the files, which
> should have the the same effect (right?)

or they can just install a file watch and remove it in case a sim
re-init condition is triggered.  That way if only EFmsisdn is changed,
then the file watch is fired.  If a complete re-init has to be done,
then this watch is removed and the file is re-read during regular
re-initialization procedure.

Regards,
-Denis

--===============3394575610990212963==--

