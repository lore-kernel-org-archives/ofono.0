Content-Type: multipart/mixed; boundary="===============4123440302286875483=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] sim: Implement file watching and basic refresh.
Date: Mon, 07 Feb 2011 13:34:13 -0600
Message-ID: <4D504935.60802@gmail.com>
In-Reply-To: <1296782434-11008-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4123440302286875483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> +void __ofono_sim_refresh(struct ofono_sim *sim, GSList *file_list,
> +			ofono_bool_t full_file_change, ofono_bool_t naa_init)
> +{
> +	GSList *l, *fl;
> +	enum sim_reset {
> +		RESET_REMOVE_ATOMS	=3D OFONO_SIM_STATE_INSERTED,
> +		RESET_SIGNAL_READY	=3D OFONO_SIM_STATE_READY,
> +		RESET_NONE,
> +	} reset_state =3D RESET_NONE;
> +
> +	/* Flush cached content for affected files */
> +	if (full_file_change)
> +		sim_fs_cache_flush(sim->simfs);
> +	else {
> +		for (fl =3D file_list; fl; fl =3D fl->next) {
> +			struct stk_file *file =3D fl->data;
> +			int id =3D (file->file[file->len - 2] << 8) |
> +				(file->file[file->len - 1] << 0);
> +
> +			sim_file_changed_flush(sim, id);
> +		}
> +	}
> +
> +	if (naa_init)
> +		reset_state =3D RESET_REMOVE_ATOMS;
> +
> +	/*
> +	 * Check if we have file change handlers for all of the affected
> +	 * files.  If not, we will fall back to re-initialising the
> +	 * application which ensures that all files are re-read.
> +	 */
> +	for (l =3D sim->fs_watches; l; l =3D l->next) {
> +		struct fs_watch *w =3D l->data;
> +
> +		if (full_file_change) {
> +			if (w->notify)
> +				continue;
> +
> +			if (w->reset_state < reset_state)
> +				reset_state =3D reset_state;
> +
> +			continue;
> +		}

What exactly is this if statement accomplishing? If we have a
full_file_change notification we have to always re-init the SIM.

> +
> +		for (fl =3D file_list; fl; fl =3D fl->next) {
> +			struct stk_file *file =3D fl->data;
> +			int id =3D (file->file[file->len - 2] << 8) |
> +				(file->file[file->len - 1] << 0);
> +
> +			if (id !=3D w->id)
> +				continue;
> +
> +			if (w->notify)
> +				break;
> +
> +			if (w->reset_state < reset_state)
> +				reset_state =3D reset_state;
> +
> +			break;
> +		}
> +	}
> +

And I'm pretty sure we can just skip this one as well, a NULL callback
is just that.

> +	/*
> +	 * Notify the subscribers of files that have changed unless we
> +	 * have determined that a re-initialisation is necessary and
> +	 * will trigger re-reading of those files anyway.
> +	 */
> +	for (l =3D sim->fs_watches; l; l =3D l->next) {
> +		struct fs_watch *w =3D l->data;
> +
> +		if (full_file_change) {
> +			if (w->reset_state < reset_state)
> +				w->notify(w->id, w->notify_data);
> +
> +			continue;
> +		}
> +
> +		for (fl =3D file_list; fl; fl =3D fl->next) {
> +			struct stk_file *file =3D fl->data;
> +			int id =3D (file->file[file->len - 2] << 8) |
> +				(file->file[file->len - 1] << 0);
> +
> +			if (id !=3D w->id)
> +				continue;
> +
> +			if (w->reset_state < reset_state)
> +				w->notify(w->id, w->notify_data);
> +
> +			break;
> +		}
> +	}
> +

So again, this seems entirely way too complicated.  I'd suggest
something like:

if full_file_change or changed ef in (EFbdn, EFfdn, EFest, EFust, EFsst,
EFphase, EFad, EFcphs_info):
	Remove all atoms in post_sim and post_online
	Restart SIM initialization procedure

if full_file_change:
	notify all remaining watches
else
	for each file changed:
		notify matching remaining watches

Incidentally the above list of files to re-read is exactly the same
files we need to re-initialize when we lock ourselves out when trying to
lock/unlock/change the PIN.

> +	switch (reset_state) {
> +	case RESET_REMOVE_ATOMS:
> +		/*
> +		 * REVISIT: There's some concern that on re-insertion the
> +		 * atoms will start to talk to the SIM before it becomes
> +		 * ready, on certain SIMs.
> +		 */
> +		ofono_sim_inserted_notify(sim, FALSE);
> +		ofono_sim_inserted_notify(sim, TRUE);
> +		break;

This is not really a good idea semantics wise.  The SIM hasn't really
been removed and a UICC reset / NAA application reset / NAA session
reset is not being performed either.

> +	case RESET_SIGNAL_READY:
> +		sim->state =3D OFONO_SIM_STATE_INSERTED;
> +		sim_set_ready(sim);
> +		break;

I still don't see a reason for this one, isn't the file_changed watch
enough?

Regards,
-Denis

--===============4123440302286875483==--

