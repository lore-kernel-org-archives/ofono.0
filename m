Content-Type: multipart/mixed; boundary="===============8643756628708017058=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 8/9] call-forwarding: Watch for changes to relevant SIM
 files.
Date: Thu, 17 Feb 2011 14:57:33 -0600
Message-ID: <4D5D8BBD.9090207@gmail.com>
In-Reply-To: <1297756739-2958-8-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8643756628708017058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 02/15/2011 01:58 AM, Andrzej Zaborowski wrote:
> ---
>  src/call-forwarding.c |   39 +++++++++++++++++++++++++++++++++++++--
>  1 files changed, 37 insertions(+), 2 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index d13f990..d610521 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -74,6 +74,7 @@ static void get_query_next_cf_cond(struct ofono_call_fo=
rwarding *cf);
>  static void set_query_next_cf_cond(struct ofono_call_forwarding *cf);
>  static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf);
>  static void cf_unregister_ss_controls(struct ofono_call_forwarding *cf);
> +static void sim_read_cf_indicator(struct ofono_call_forwarding *cf);
>  =

>  struct cf_ss_request {
>  	int ss_type;
> @@ -1358,18 +1359,52 @@ static void sim_cphs_cff_read_cb(int ok, int tota=
l_length, int record,
>  					DBUS_TYPE_BOOLEAN, &cfu_voice);
>  }
>  =

> +static void sim_cfis_changed(int id, void *userdata)
> +{
> +	struct ofono_call_forwarding *cf =3D userdata;
> +
> +	if (((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
> +			cf->cfis_record_id > 0) && is_cfu_enabled(cf, NULL)) {
> +		DBusConnection *conn =3D ofono_dbus_get_connection();
> +		const char *path =3D __ofono_atom_get_path(cf->atom);
> +		ofono_bool_t status =3D FALSE;
> +
> +		ofono_dbus_signal_property_changed(conn, path,
> +					OFONO_CALL_FORWARDING_INTERFACE,
> +					"ForwardingFlagOnSim",
> +					DBUS_TYPE_BOOLEAN, &status);
> +	}
> +
> +	cf->cfis_record_id =3D 0;
> +	cf->flags &=3D ~CALL_FORWARDING_FLAG_CPHS_CFF;
> +
> +	/*
> +	 * TODO: remove forwarding rules in
> +	 * cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] that
> +	 * originate from EFcfis before adding the new rules?
> +	 */
> +
> +	sim_read_cf_indicator(cf);

Wouldn't this result in us adding a 2nd, or 3rd, or 4th, etc file watch
here?

> +}
> +
>  static void sim_read_cf_indicator(struct ofono_call_forwarding *cf)
>  {
>  	if (__ofono_sim_service_available(cf->sim,
>  			SIM_UST_SERVICE_CFIS,
> -			SIM_SST_SERVICE_CFIS) =3D=3D TRUE)
> +			SIM_SST_SERVICE_CFIS) =3D=3D TRUE) {
>  		ofono_sim_read(cf->sim_context, SIM_EFCFIS_FILEID,
>  				OFONO_SIM_FILE_STRUCTURE_FIXED,
>  				sim_cfis_read_cb, cf);
> -	else
> +		ofono_sim_add_file_watch(cf->sim_context, SIM_EFCFIS_FILEID,
> +						sim_cfis_changed, cf, NULL);
> +	} else {
>  		ofono_sim_read(cf->sim_context, SIM_EF_CPHS_CFF_FILEID,
>  				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>  				sim_cphs_cff_read_cb, cf);
> +		ofono_sim_add_file_watch(cf->sim_context,
> +						SIM_EF_CPHS_CFF_FILEID,
> +						sim_cfis_changed, cf, NULL);
> +	}
>  }
>  =

>  int ofono_call_forwarding_driver_register(const struct ofono_call_forwar=
ding_driver *d)

Regards,
-Denis

--===============8643756628708017058==--

