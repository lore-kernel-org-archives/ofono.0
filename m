Content-Type: multipart/mixed; boundary="===============0759564997217387600=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/4] sim: Implement file watching and basic refresh.
Date: Tue, 08 Feb 2011 01:13:55 +0100
Message-ID: <AANLkTimPQ8W057Nk8dfFaz9Y2GbcdYRW_Sm6_9Y0wqsY@mail.gmail.com>
In-Reply-To: <4D506072.2090300@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0759564997217387600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 7 February 2011 22:13, Denis Kenzior <denkenz@gmail.com> wrote:
>>> if full_file_change or changed ef in (EFbdn, EFfdn, EFest, EFust, EFsst,
>>> EFphase, EFad, EFcphs_info):
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Remove all atoms in post_sim and post_online
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Restart SIM initialization procedure
>>
>> I guess that is okay, as long as we remember to keep this list updated
>> (there are various other important files which we may not be using
>> yet)
>>
>
> That is fine, we fix these during the pre-certification / certification,
> etc.
>
>>>
>>> if full_file_change:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0notify all remaining watches
>>
>> In this case we have already reinitialised the SIM, so I think we
>> don't need to do that.
>
> Actually we should for files that are read during pre-sim but are not
> important enough. =C2=A0E.g. EFecc, EFli, EFpl, EFiccid, etc.

But if we "restart SIM initialization procedure", we already re-read
those files so there's nothing more we need to do.  The sim
initialization in 51.011 includes reading those files if I remember
correctly.

>
>>
>>> else
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for each file changed:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0notify matching =
remaining watches
>>
>> What if a file is changed which doesn't have a handler implemented?
>> Shouldn't we fall back to removing the atom? That was the idea of
>> those "complicated" loops above.
>
> If it should be handled, then its a bug. =C2=A0Removing all atoms just
> because someone forgot to handle a file is bad anyway.

We don't need to remove atoms, in this patch series we simply signal
"sim ready" to atoms in those cases.  Otherwise all those NULL watches
are useless, right?  The reason I introduced the NULL-callback watches
is because there are many files, like EFcfis, which are unlikely to be
changed by the SIM application or operator.  Yet we can't ignore them,
in case we receive a Refresh on those files.  We have two dozens of
such files and it's not practical to add notifiers for all of them,
it's easier to fall back to re-reading all of the post-sim files.

In the patch 3/4 I've added watches for all of the files where changes
need to be somehow handled.  Most of them have NULL callback because
they're not really important and it would be a huge patch if wanted to
have a handler for every single file, although we can add them
gradually later.  The files where changes don't need to be handled,
don't register a watch at all (like EFcbmi, EFcbmir which are only
used for initialising our own topics list)

>
>>
>>>
>>> Incidentally the above list of files to re-read is exactly the same
>>> files we need to re-initialize when we lock ourselves out when trying to
>>> lock/unlock/change the PIN.
>>>
>>>> + =C2=A0 =C2=A0 switch (reset_state) {
>>>> + =C2=A0 =C2=A0 case RESET_REMOVE_ATOMS:
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* REVISIT: There's s=
ome concern that on re-insertion the
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* atoms will start t=
o talk to the SIM before it becomes
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ready, on certain =
SIMs.
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_inserted_notify(=
sim, FALSE);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_inserted_notify(=
sim, TRUE);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>
>>> This is not really a good idea semantics wise. =C2=A0The SIM hasn't rea=
lly
>>> been removed and a UICC reset / NAA application reset / NAA session
>>> reset is not being performed either.
>>
>> Hmm probably. =C2=A0Although from our point of view the NAA initialisati=
on
>> looks the same as sim re-insertion so we end up inlining that fuction.
>>
>
> I'm still fuzzy on what NAA initialization actually does. =C2=A0Right now=
 my
> interpretation is that EFpl/EFli and EFiccid have not changed. =C2=A0So i=
t is
> not quite the same as a reset.

However with Full file change notification they may have changed, so
it's a safe fallback to re-read them.

Best regards

--===============0759564997217387600==--

