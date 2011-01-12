Content-Type: multipart/mixed; boundary="===============9207122140051196236=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] sim: Implement file watching and basic refresh.
Date: Wed, 12 Jan 2011 15:55:38 -0600
Message-ID: <4D2E235A.5000006@gmail.com>
In-Reply-To: <1294657295-14041-3-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9207122140051196236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> +void __ofono_sim_refresh(struct ofono_sim *sim, GSList *file_list,
> +			ofono_bool_t full_file_change, ofono_bool_t naa_init)
> +{
> +	GSList *l, *filel;
> +	enum sim_reset_state {
> +		RESET_STATE_NOT_PRESENT	=3D OFONO_SIM_STATE_NOT_PRESENT,
> +		RESET_STATE_INSERTED	=3D OFONO_SIM_STATE_INSERTED,
> +		RESET_STATE_READY	=3D OFONO_SIM_STATE_READY,
> +		RESET_STATE_NONE,
> +	} reset_state =3D RESET_STATE_NONE;
> +
> +	/* Flush cached content for affected files */
> +	if (full_file_change)
> +		sim_fs_cache_flush(sim->simfs);
> +	else
> +		for (filel =3D file_list; filel; filel =3D filel->next) {
> +			struct stk_file *file =3D filel->data;
> +			int id =3D (file->file[file->len - 2] << 8) |
> +				(file->file[file->len - 1] << 0);
> +
> +			sim_file_changed_flush(sim, id);
> +		}

Just a nitpick, but when you have such compound statements inside
if/while/for, could you enclose them in parentheses?  I think that makes
the code a bit more readable.

e.g.
if (foo)
else {
	for () {

	}
}

> +
> +	if (naa_init)
> +		reset_state =3D RESET_STATE_INSERTED;
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
> +
> +		for (filel =3D file_list; filel; filel =3D filel->next) {
> +			struct stk_file *file =3D filel->data;
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
> +		for (filel =3D file_list; filel; filel =3D filel->next) {
> +			struct stk_file *file =3D filel->data;
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
> +	switch (reset_state) {
> +	case RESET_STATE_NOT_PRESENT:
> +		ofono_sim_inserted_notify(sim, FALSE);
> +		ofono_sim_inserted_notify(sim, TRUE);

Are you sure we can do it this way?  I would assume that the modem might
require some time to perform its own SIM initialization and would have
to signal the sim_inserted itself...

> +		break;
> +	case RESET_STATE_INSERTED:
> +		sim_free_state(sim);
> +		sim->state =3D OFONO_SIM_STATE_INSERTED;
> +		sim_initialize(sim);

What about removing all the post_sim / online atoms?  In theory
something like EFfdn could have been changed and now we're stuck in
fixed dialing mode.  We should not keep the atoms around in this case.

> +		break;
> +	case RESET_STATE_READY:
> +		sim->state =3D OFONO_SIM_STATE_INSERTED;
> +		for (l =3D sim->state_watches->items; l; l =3D l->next) {
> +			struct ofono_watchlist_item *item =3D l->data;
> +			ofono_sim_state_event_cb_t notify =3D item->notify;
> +
> +			notify(sim->state, item->notify_data);

I'm having trouble understanding the need for this for loop.  Isn't the
SIM already inserted?

> +		}
> +
> +		sim_set_ready(sim);
> +		break;
> +	case RESET_STATE_NONE:
> +		break;
> +	}
> +}

Overall it seems like there are two categories of files that we should
worry about:

- Those handled inside sim.c that affect sim initialization:
	- EFust, EFest, EFsst
	- EFbdn, EFfdn
	- EFphase, EFcphs_info (these ones are really unlikely outside of a
full sim reset)
	- EFad (This one is unlikely as it would affect the IMSI)
- The ones that don't

To me it sounds like we should just special case the ones affecting sim
initialization inside this function and use a simplified API for the rest.

Regards,
-Denis

--===============9207122140051196236==--

