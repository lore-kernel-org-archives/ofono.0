Content-Type: multipart/mixed; boundary="===============8082411962823904333=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 4/4] network: Use sim SPN watch API
Date: Sun, 15 Jan 2012 20:14:43 -0600
Message-ID: <4F138813.8090608@gmail.com>
In-Reply-To: <1326105044-26408-5-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8082411962823904333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 01/09/2012 04:30 AM, Oleg Zhurakivskyy wrote:
> ---
>  src/network.c |  163 +++++++--------------------------------------------=
-----
>  1 files changed, 21 insertions(+), 142 deletions(-)

<snip>

> =

> +static void spn_read_cb(const char *spn, const char *dc, void *data)
> -static void sim_spn_changed(int id, void *userdata)
> -{
> -	struct ofono_netreg *netreg =3D userdata;
> -	gboolean had_spn;
> -
> -	if (netreg->flags & NETWORK_REGISTRATION_FLAG_READING_SPN)
> -		return;
> -
> -	had_spn =3D netreg->spn !=3D NULL && strlen(netreg->spn) > 0;
> -	netreg->flags &=3D ~(NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN |
> -				NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN);
> +	struct ofono_netreg *netreg =3D data;
> +	gboolean had_spn =3D netreg->spn !=3D NULL && strlen(netreg->spn) > 0;
>  =

>  	g_free(netreg->spn);
>  	netreg->spn =3D NULL;
> +	netreg->flags &=3D ~(NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN |
> +				NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN);
>  =

>  	/*
>  	 * We can't determine whether the property really changed
> @@ -1778,10 +1666,13 @@ static void sim_spn_changed(int id, void *userdat=
a)
>  	if (had_spn && netreg->current_operator)
>  		netreg_emit_operator_display_name(netreg);
>  =

> -	netreg->flags |=3D NETWORK_REGISTRATION_FLAG_READING_SPN;
> -	ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
> -			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> -			sim_spn_read_cb, netreg);
> +	if (dc)
> +		sim_spn_display_condition_parse(netreg, *dc);
> +
> +	netreg->spn =3D g_strdup(spn);
> +
> +	if (netreg->current_operator)
> +		netreg_emit_operator_display_name(netreg);

This function ends up calling netreg_emit_operator_display_name twice,
once if had_spn is true and once here.  That doesn't seem quite right.

The original implementation was actually reacting to a SIM refresh,
basically if any of the SPN files was updated, we'd switch to operator
name as reported by NITZ (e.g. from +COPS) and wait for the SPN/CPHS SPN
reading to finish.  Then issue another signal.

In your implementation it is likely safe to simply always emit, in which
case you do not need any of the above logic.  Given the likelihood of
the above scenario it is probably fine to simply wait for the new
SPN/CPHS name to be read before emitting the signal.

>  }
>  =

>  int ofono_netreg_get_location(struct ofono_netreg *netreg)
> @@ -1919,6 +1810,12 @@ static void netreg_unregister(struct ofono_atom *a=
tom)
>  		netreg->settings =3D NULL;
>  	}
>  =

> +	if (netreg->spn_watch)
> +		ofono_sim_remove_spn_watch(netreg->sim, &netreg->spn_watch);
> +
> +	g_free(netreg->spn);
> +	netreg->spn =3D NULL;
> +

With the above in mind, you could actually access netreg->spn directly
from the sim atom and save some memory, but the current implementation
is fine as well.

Regards,
-Denis

--===============8082411962823904333==--

