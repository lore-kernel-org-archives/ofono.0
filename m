Content-Type: multipart/mixed; boundary="===============5416625994891805956=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] sim: read EFimg
Date: Wed, 25 Aug 2010 18:39:26 -0500
Message-ID: <4C75A9AE.8070106@gmail.com>
In-Reply-To: <1282753794-7612-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5416625994891805956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 08/25/2010 11:29 AM, Kristen Carlson Accardi wrote:
> ---
>  src/sim.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 49 insertions(+), 0 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index 04a708b..dc47901 100644
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
> @@ -958,6 +960,46 @@ static void sim_own_numbers_update(struct ofono_sim =
*sim)
>  			sim_msisdn_read_cb, sim);
>  }
>  =

> +static void sim_efimg_read_cb(int ok, int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct ofono_sim *sim =3D userdata;
> +	unsigned char *efimg;
> +	int num_records;
> +
> +	if (!ok)
> +		return;
> +
> +	num_records =3D length / record_length;
> +
> +	/*
> +	 * EFimg descriptors are 9 bytes long.
> +	 * Byte 1 of the record is the number of descriptors per record.
> +	 */
> +	if ((record_length % 9 !=3D 2) && (record_length % 9 !=3D 1))
> +		return;

You want to do this check in addition to ensuring record_length is at
least 10.  Right now records of size 1 and 2 pass this check...

Regards,
-Denis

--===============5416625994891805956==--

