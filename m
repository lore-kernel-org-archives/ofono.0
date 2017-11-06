Content-Type: multipart/mixed; boundary="===============7963440359148314942=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] sim: implement create ISIM context
Date: Mon, 06 Nov 2017 16:22:24 -0600
Message-ID: <fa1fefe9-898a-4bc3-192d-829a1255e859@gmail.com>
In-Reply-To: <1509990574-19950-3-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7963440359148314942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/06/2017 11:49 AM, James Prestwood wrote:
> API to create a sim context for the ISIM application, if found.
> During AID discovery, if an ISIM AID is found, a new fs object is
> initialized for the ISIM which will be used for any future
> ISIM context creation.
> ---
>   src/sim.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> =


Patches 2, 3, and 5 applied.  I made a minor tweak here:

> +	/*
> +	 * Check if the AID is even valid
> +	 */

Updated this comment and

> +	while (iter) {
> +		struct ofono_sim_aid_session *session =3D iter->data;
> +
> +		/*
> +		 * This AID based context is only relevant for an ISIM AID. A
> +		 * USIM application can be accessed with the 'default' FS
> +		 * context API's.
> +		 */

Removed this one.  It didn't make sense to me here.

> +		if (session->record->type =3D=3D SIM_APP_TYPE_ISIM) {
> +			return sim_fs_context_new_with_aid(sim->simfs_isim,
> +					session->record->aid);
> +		}
> +
> +		iter =3D g_slist_next(iter);
> +	}
> +
> +	return NULL;
> +}
> +
>   void ofono_sim_context_free(struct ofono_sim_context *context)
>   {
>   	return sim_fs_context_free(context);

Regards,
-Denis

--===============7963440359148314942==--

