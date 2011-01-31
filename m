Content-Type: multipart/mixed; boundary="===============1689576909587867854=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 3/5] sim: Implement file watching and basic refresh.
Date: Mon, 31 Jan 2011 18:23:04 +0100
Message-ID: <AANLkTimOvh07RL3c_3KfOJBQhv-fDjCkPU0Z8b7cJBU=@mail.gmail.com>
In-Reply-To: <4D2E235A.5000006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1689576909587867854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I took me a while to get back to this, but we need to work it out...

On 12 January 2011 22:55, Denis Kenzior <denkenz@gmail.com> wrote:
>> +void __ofono_sim_refresh(struct ofono_sim *sim, GSList *file_list,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ofono_bool_t full_file_change, ofono_bool_t naa_init)
>> +{
>> + =C2=A0 =C2=A0 GSList *l, *filel;
>> + =C2=A0 =C2=A0 enum sim_reset_state {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RESET_STATE_NOT_PRESENT =3D =
OFONO_SIM_STATE_NOT_PRESENT,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RESET_STATE_INSERTED =C2=A0 =
=C2=A0=3D OFONO_SIM_STATE_INSERTED,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RESET_STATE_READY =C2=A0 =C2=
=A0 =C2=A0 =3D OFONO_SIM_STATE_READY,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RESET_STATE_NONE,
>> + =C2=A0 =C2=A0 } reset_state =3D RESET_STATE_NONE;
>> +
>> + =C2=A0 =C2=A0 /* Flush cached content for affected files */
>> + =C2=A0 =C2=A0 if (full_file_change)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_fs_cache_flush(sim->simf=
s);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (filel =3D file_list; fi=
lel; filel =3D filel->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct stk_file *file =3D filel->data;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
int id =3D (file->file[file->len - 2] << 8) |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (file->file[file->len - 1] << 0);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
sim_file_changed_flush(sim, id);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> Just a nitpick, but when you have such compound statements inside
> if/while/for, could you enclose them in parentheses? =C2=A0I think that m=
akes
> the code a bit more readable.
>
> e.g.
> if (foo)
> else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for () {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> }

Ok, good point.

>
>> +
>> + =C2=A0 =C2=A0 if (naa_init)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset_state =3D RESET_STATE_=
INSERTED;
>> +
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* Check if we have file change handlers for all of=
 the affected
>> + =C2=A0 =C2=A0 =C2=A0* files. =C2=A0If not, we will fall back to re-ini=
tialising the
>> + =C2=A0 =C2=A0 =C2=A0* application which ensures that all files are re-=
read.
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 for (l =3D sim->fs_watches; l; l =3D l->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct fs_watch *w =3D l->da=
ta;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (full_file_change) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (w->notify)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (w->reset_state < reset_state)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 reset_state =3D reset_state;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
continue;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (filel =3D file_list; fi=
lel; filel =3D filel->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct stk_file *file =3D filel->data;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
int id =3D (file->file[file->len - 2] << 8) |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (file->file[file->len - 1] << 0);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (id !=3D w->id)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (w->notify)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (w->reset_state < reset_state)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 reset_state =3D reset_state;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* Notify the subscribers of files that have change=
d unless we
>> + =C2=A0 =C2=A0 =C2=A0* have determined that a re-initialisation is nece=
ssary and
>> + =C2=A0 =C2=A0 =C2=A0* will trigger re-reading of those files anyway.
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 for (l =3D sim->fs_watches; l; l =3D l->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct fs_watch *w =3D l->da=
ta;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (full_file_change) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (w->reset_state < reset_state)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 w->notify(w->id, w->notify_data);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
continue;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (filel =3D file_list; fi=
lel; filel =3D filel->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct stk_file *file =3D filel->data;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
int id =3D (file->file[file->len - 2] << 8) |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (file->file[file->len - 1] << 0);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (id !=3D w->id)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (w->reset_state < reset_state)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 w->notify(w->id, w->notify_data);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 switch (reset_state) {
>> + =C2=A0 =C2=A0 case RESET_STATE_NOT_PRESENT:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_inserted_notify(si=
m, FALSE);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_inserted_notify(si=
m, TRUE);
>
> Are you sure we can do it this way? =C2=A0I would assume that the modem m=
ight
> require some time to perform its own SIM initialization and would have
> to signal the sim_inserted itself...

I assume that the modem would send the refresh command only once it
has done all its internal housekeeping and is ready for us to re-read
the changed files.  If not then probably the AT interface will block
for as much time as needed?

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case RESET_STATE_INSERTED:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_free_state(sim);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->state =3D OFONO_SIM_STA=
TE_INSERTED;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_initialize(sim);
>
> What about removing all the post_sim / online atoms? =C2=A0In theory
> something like EFfdn could have been changed and now we're stuck in
> fixed dialing mode. =C2=A0We should not keep the atoms around in this cas=
e.

So in the next patch I add a "watch" for every file in the SIM that we
care about.  Every watch has a sort of "reset level", which tells
sim.c how much of our state needs to be reinitialised, so that we
don't reset the atoms if that is not necessary.  For example for EFust
/ EFest we set the level to RESET_STATE_INSERTED.

This is the case for FDN, because will be re-read EFust/EFest as a
result of sim_initialize() and later at some point we will signal
OFONO_SIM_STATE_READY so all the concerned atoms will take note.  It's
not necessary to remove the atoms in this case.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case RESET_STATE_READY:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->state =3D OFONO_SIM_STA=
TE_INSERTED;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (l =3D sim->state_watche=
s->items; l; l =3D l->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct ofono_watchlist_item *item =3D l->data;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ofono_sim_state_event_cb_t notify =3D item->notify;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
notify(sim->state, item->notify_data);
>
> I'm having trouble understanding the need for this for loop. =C2=A0Isn't =
the
> SIM already inserted?

I initially didn't have this loop, but I thought it might be better to
signal "INSERTED" just before "READY", so that atoms see a *change* if
they though that the sim was READY before.  But looking at the current
users of the sim state watch, it makes no difference.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_set_ready(sim);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case RESET_STATE_NONE:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 }
>> +}
>
> Overall it seems like there are two categories of files that we should
> worry about:
>
> - Those handled inside sim.c that affect sim initialization:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- EFust, EFest, EFsst
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- EFbdn, EFfdn
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- EFphase, EFcphs_info (these ones are really =
unlikely outside of a
> full sim reset)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- EFad (This one is unlikely as it would affec=
t the IMSI)
> - The ones that don't
>
> To me it sounds like we should just special case the ones affecting sim
> initialization inside this function and use a simplified API for the rest.

So I think this wouldn't make the api much better because:

* These files you listed are the majority of all files we read, so the
"normal" users are in minority.

* The only simplification I see would be removal of one parameter in
add_file_watch_call

int ofono_sim_add_file_watch(struct ofono_sim *sim, int id,
                       enum ofono_sim_state reset_state,
                       ofono_sim_file_notify_t notify, void *userdata);

or are you thinking about a different simplifaction?

Best regards

--===============1689576909587867854==--

