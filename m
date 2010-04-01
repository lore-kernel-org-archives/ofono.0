Content-Type: multipart/mixed; boundary="===============8736459802460362417=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5][RfC] Release calls when SIM is removed.
Date: Thu, 01 Apr 2010 10:52:07 -0500
Message-ID: <201004011052.08133.denkenz@gmail.com>
In-Reply-To: <1270011471-6860-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8736459802460362417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> ---
> +static void sim_ready_watch(void *user)
> +{
> +	struct ofono_voicecall *vc =3D user;
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
> +	struct ofono_atom *sim_atom =3D
> +		__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
> +	struct ofono_sim *sim =3D __ofono_atom_get_data(sim_atom);
> +
> +	/* Try both formats, only one or none will work */
> +	ofono_sim_read(sim, SIM_EFECC_FILEID,
> +			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> +			ecc_g2_read_cb, vc);
> +	ofono_sim_read(sim, SIM_EFECC_FILEID,
> +			OFONO_SIM_FILE_STRUCTURE_FIXED,
> +			ecc_g3_read_cb, vc);
> +}

This part needs to be done when SIM is inserted.  If you refactor the previ=
ous =

patch, then we should also easily have INSERTED state notifications too and=
 get =

this taken care of properly.

> +
> +static void sim_removed_watch(void *user)
> +{
> +	struct ofono_voicecall *vc =3D user;
> +
> +	vc->flags |=3D VOICECALLS_FLAG_MULTI_RELEASE;
> +
> +	/* TODO: Don't hang up emergency calls */
> +	voicecalls_release_queue(vc, vc->call_list);
> +	voicecalls_release_next(vc);

I suggest you only shuffle the emergency numbers here.  Let the modem drive=
r =

notify which calls have been terminated.  If this is wrong we can fix it la=
ter, =

but sending a CHLD=3D1X is actually wrong here.

Regards,
-Denis

--===============8736459802460362417==--

