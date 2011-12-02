Content-Type: multipart/mixed; boundary="===============9134762082072994713=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/9] network: Add CPHS SPN fallback
Date: Fri, 02 Dec 2011 16:35:12 -0600
Message-ID: <4ED952A0.6000903@gmail.com>
In-Reply-To: <1322824237-10039-8-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9134762082072994713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 12/02/2011 05:10 AM, Oleg Zhurakivskyy wrote:
> ---
>  src/network.c |   32 ++++++++++++++++++++++++--------
>  1 files changed, 24 insertions(+), 8 deletions(-)
> =

> diff --git a/src/network.c b/src/network.c
> index 6e08876..1354edf 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -1719,21 +1719,37 @@ static void sim_spn_read_cb(int ok, int length, i=
nt record,
>  				int record_length, void *user_data)
>  {
>  	struct ofono_netreg *netreg =3D user_data;
> -	unsigned char dcbyte;
> +	const unsigned char *dcbyte =3D NULL;
> +	int offset =3D 0;
>  =

> -	if (!ok)
> +	if (!ok) {
> +		if (!(netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN)) {
> +
> +			netreg->flags |=3D NETWORK_REGISTRATION_FLAG_CPHS_SPN;
> +
> +			ofono_sim_read(netreg->sim_context,
> +					SIM_EF_CPHS_SPN_FILEID,
> +					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> +					sim_spn_read_cb, netreg);
> +		}
>  		return;
> +	}
>  =

> -	dcbyte =3D data[0];
> +	if (!(netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN)) {
> +		dcbyte =3D data;
> +		offset =3D 1;
> +	}
>  =

> -	if (!sim_spn_parse(data + 1, length - 1, &netreg->spn))
> +	if (!sim_spn_parse(data + offset, length - offset, &netreg->spn))
>  		return;
>  =

> -	ofono_sim_read(netreg->sim_context, SIM_EFSPDI_FILEID,
> -			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> -			sim_spdi_read_cb, netreg);
> +	if (!(netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN))
> +		ofono_sim_read(netreg->sim_context, SIM_EFSPDI_FILEID,
> +				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> +				sim_spdi_read_cb, netreg);
>  =

> -	sim_spn_display_condition_parse(netreg, dcbyte);
> +	if (dcbyte !=3D NULL)
> +		sim_spn_display_condition_parse(netreg, *dcbyte);
>  =

>  	if (netreg->current_operator)
>  		ofono_netreg_operator_display_name_notify(netreg);

Actually I don't like this approach.  There are some interactions with
the SIM refresh logic triggered by sim_spn_changed and this approach
makes it very hard to puzzle out whether all cases are covered properly.
 Also, the preference is always towards clearer, more readable code,
even if at the expense of being more verbose.  Given how tiny
sim_spn_read_cb is now, I'd rather you handle the CPHS variants separately.

You are also not taking care of the CAT/SAT Refresh cases for the CPHS
variants.

Thinking more about it, the way I'd try to do this is to look up the
necessary bits in the CPHS Information Service Table (CPHS 4.2 Section
B.3.1.1).  Then only read CPHS SPN if the service is active / allocated.
 Only read the short form if CPHS SPN is not available and the short SPN is.

Regards,
-Denis

--===============9134762082072994713==--

