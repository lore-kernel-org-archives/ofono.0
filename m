Content-Type: multipart/mixed; boundary="===============1177820006580929495=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] sim: read EFimg
Date: Wed, 25 Aug 2010 13:03:33 -0500
Message-ID: <4C755AF5.7010100@gmail.com>
In-Reply-To: <1282130723-10488-4-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1177820006580929495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 08/18/2010 06:25 AM, Kristen Carlson Accardi wrote:
> Read EFimg when the sim is ready, and store it in memory.
> ---
>  src/sim.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 47 insertions(+), 0 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index d2ed780..6d723bb 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -88,6 +88,8 @@ struct ofono_sim {
>  	unsigned char efmsisdn_records;
>  	unsigned char *efli;
>  	unsigned char efli_length;
> +	unsigned char *efimg;
> +	int efimg_length;
>  	enum ofono_sim_cphs_phase cphs_phase;
>  	unsigned char cphs_service_table[2];
>  	struct ofono_watchlist *state_watches;
> @@ -1001,6 +1003,44 @@ static void sim_own_numbers_update(struct ofono_si=
m *sim)
>  			sim_msisdn_read_cb, sim);
>  }
>  =

> +static void sim_efimg_read_cb(int ok, int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct ofono_sim *sim =3D userdata;
> +	unsigned char *efimg;
> +	int num_records =3D length / record_length;

Doing this before checking OK will result in a division by zero.

> +
> +	if (!ok)
> +		return;
> +
> +	/*
> +	 * EFimg descriptors are 9 bytes long.
> +	 * Byte 1 of the record is the number of descriptors per record.
> +	 */
> +	if (record_length < 10)
> +		return;

I also suggest doing something like:

if ((record_length % 9) !=3D 2 && (record_length % 9) !=3D 1)
	return;

to be very pedantic.

> +
> +	if (sim->efimg =3D=3D NULL) {
> +		sim->efimg =3D g_try_malloc0(num_records * 9);
> +
> +		if (sim->efimg =3D=3D NULL)
> +			return;
> +
> +		sim->efimg_length =3D num_records * 9;
> +	}
> +
> +	/*
> +	 * TBD - if we have more than one descriptor per record,
> +	 * pick the nicest one.  For now we use the first one.
> +	 */
> +
> +	/* copy descriptor into slot for this record */
> +	efimg =3D &sim->efimg[(record - 1) * 9];
> +
> +	memcpy(efimg, &data[1], 9);
> +}
> +
>  static void sim_ready(void *user, enum ofono_sim_state new_state)
>  {
>  	struct ofono_sim *sim =3D user;
> @@ -1015,6 +1055,8 @@ static void sim_ready(void *user, enum ofono_sim_st=
ate new_state)
>  			sim_ad_read_cb, sim);
>  	ofono_sim_read(sim, SIM_EFSDN_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
>  			sim_sdn_read_cb, sim);
> +	ofono_sim_read(sim, SIM_EFIMG_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
> +			sim_efimg_read_cb, sim);
>  }
>  =

>  static void sim_cphs_information_read_cb(int ok, int length, int record,
> @@ -1934,6 +1976,11 @@ static void sim_free_state(struct ofono_sim *sim)
>  		g_strfreev(sim->language_prefs);
>  		sim->language_prefs =3D NULL;
>  	}
> +
> +	if (sim->efimg) {
> +		g_free(sim->efimg);
> +		sim->efimg =3D NULL;
> +	}
>  }
>  =

>  void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inser=
ted)

Otherwise looks fine.

Regards,
-Denis

--===============1177820006580929495==--

