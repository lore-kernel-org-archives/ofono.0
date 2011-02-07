Content-Type: multipart/mixed; boundary="===============7407022193300375091=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/4] sim: Implement file watching and basic refresh.
Date: Mon, 07 Feb 2011 21:56:17 +0100
Message-ID: <AANLkTi=tjQm8n9igfyN8DDFjXpchdVYf+P=dWHh5z7uO@mail.gmail.com>
In-Reply-To: <4D504935.60802@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7407022193300375091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 7 February 2011 20:34, Denis Kenzior <denkenz@gmail.com> wrote:
>> +void __ofono_sim_refresh(struct ofono_sim *sim, GSList *file_list,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ofono_bool_t full_file_change, ofono_bool_t naa_init)
>> +{
>> + =C2=A0 =C2=A0 GSList *l, *fl;
>> + =C2=A0 =C2=A0 enum sim_reset {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RESET_REMOVE_ATOMS =C2=A0 =
=C2=A0 =C2=A0=3D OFONO_SIM_STATE_INSERTED,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RESET_SIGNAL_READY =C2=A0 =
=C2=A0 =C2=A0=3D OFONO_SIM_STATE_READY,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RESET_NONE,
>> + =C2=A0 =C2=A0 } reset_state =3D RESET_NONE;
>> +
>> + =C2=A0 =C2=A0 /* Flush cached content for affected files */
>> + =C2=A0 =C2=A0 if (full_file_change)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_fs_cache_flush(sim->simf=
s);
>> + =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (fl =3D file_list; fl; f=
l =3D fl->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct stk_file *file =3D fl->data;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
int id =3D (file->file[file->len - 2] << 8) |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (file->file[file->len - 1] << 0);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
sim_file_changed_flush(sim, id);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (naa_init)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset_state =3D RESET_REMOVE=
_ATOMS;
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
>
> What exactly is this if statement accomplishing? If we have a
> full_file_change notification we have to always re-init the SIM.

In practice you're right that we can probably just force SIM
reinitialisation instead.  It seemed logically/semantically easier on
the reader to treat full_file_change =3D=3D TRUE as if the file_list
contained all of the file IDs, which is what this if statement does:
if full_file_change, then act as if every file was on the changed
files list.

>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (fl =3D file_list; fl; f=
l =3D fl->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct stk_file *file =3D fl->data;
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
>
> And I'm pretty sure we can just skip this one as well, a NULL callback
> is just that.

Ok, I think I documented it in the earlier version of this series but
not repeated here.  The idea is that non-null callback means: "notify
me when this file changes, and I'll take care of the changed
contents", while NULL callback means "I haven't implemented a proper
handler yet, so for now you need to reinitialise this atom which will
force it to take the new contents into account".

We go through the list of all changed files.  If any one of them has
no callback, then there's no point calling any notifiers because all
atoms will be reinitialised and will re-read these files anyway.

>
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
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (fl =3D file_list; fl; f=
l =3D fl->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct stk_file *file =3D fl->data;
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
>
> So again, this seems entirely way too complicated. =C2=A0I'd suggest
> something like:
>
> if full_file_change or changed ef in (EFbdn, EFfdn, EFest, EFust, EFsst,
> EFphase, EFad, EFcphs_info):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Remove all atoms in post_sim and post_online
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Restart SIM initialization procedure

I guess that is okay, as long as we remember to keep this list updated
(there are various other important files which we may not be using
yet)

>
> if full_file_change:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0notify all remaining watches

In this case we have already reinitialised the SIM, so I think we
don't need to do that.

> else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for each file changed:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0notify matching re=
maining watches

What if a file is changed which doesn't have a handler implemented?
Shouldn't we fall back to removing the atom? That was the idea of
those "complicated" loops above.

>
> Incidentally the above list of files to re-read is exactly the same
> files we need to re-initialize when we lock ourselves out when trying to
> lock/unlock/change the PIN.
>
>> + =C2=A0 =C2=A0 switch (reset_state) {
>> + =C2=A0 =C2=A0 case RESET_REMOVE_ATOMS:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* REVISIT: There's som=
e concern that on re-insertion the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* atoms will start to =
talk to the SIM before it becomes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ready, on certain SI=
Ms.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_inserted_notify(si=
m, FALSE);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_inserted_notify(si=
m, TRUE);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>
> This is not really a good idea semantics wise. =C2=A0The SIM hasn't really
> been removed and a UICC reset / NAA application reset / NAA session
> reset is not being performed either.

Hmm probably.  Although from our point of view the NAA initialisation
looks the same as sim re-insertion so we end up inlining that fuction.

>
>> + =C2=A0 =C2=A0 case RESET_SIGNAL_READY:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->state =3D OFONO_SIM_STA=
TE_INSERTED;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_set_ready(sim);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>
> I still don't see a reason for this one, isn't the file_changed watch
> enough?

In the long range I guess it should be enough but for the moment we
only have the handler for EFmsisdn and two more files, for other files
we rely on the atom's sim_ready notifier to re-read the files, which
should have the the same effect (right?)

Best regards

--===============7407022193300375091==--

