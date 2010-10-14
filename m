Content-Type: multipart/mixed; boundary="===============8647170404255462822=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/8] sim: add function to read general info from SIM
 EF-file
Date: Thu, 14 Oct 2010 06:07:12 -0500
Message-ID: <4CB6E460.5040104@gmail.com>
In-Reply-To: <1286896694-3054-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8647170404255462822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 10/12/2010 10:18 AM, Petteri Tikander wrote:
> Function reads file length, record length, file status etc,
> but doesn't retrieve any EF-contents.
> Request for EFadn is added, but this commit just debugs
> the response.
> ---
>  include/sim.h |   11 +++++++++++
>  src/sim.c     |   30 ++++++++++++++++++++++++++++--
>  2 files changed, 39 insertions(+), 2 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 42b19bd..8dd6131 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -82,6 +82,7 @@ typedef void (*ofono_sim_file_info_cb_t)(const struct o=
fono_error *error,
>  					enum ofono_sim_file_structure structure,
>  					int recordlength,
>  					const unsigned char access[3],
> +					unsigned char file_status,
>  					void *data);

I suggest breaking this out into a separate patch and shuffling patch 4
and path 5 to follow after this patch.  This patch should also come
before the changes to ofono_sim_read_info.

>  =

>  typedef void (*ofono_sim_read_cb_t)(const struct ofono_error *error,
> @@ -206,6 +207,16 @@ int ofono_sim_write(struct ofono_sim *sim, int id,
>  int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
>  			unsigned short offset, unsigned short num_bytes,
>  			ofono_sim_file_read_cb_t cb, void *data);
> +
> +/*
> + * This function reads only general info from SIM-file with
> + * requested id (file length, record length, file status etc),
> + * not any records.
> + */
> +int ofono_sim_read_info(struct ofono_sim *sim, int id,
> +			enum ofono_sim_file_structure expected,
> +			ofono_sim_file_read_cb_t cb, void *data);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/src/sim.c b/src/sim.c
> index 6f10d4c..f0633bb 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -1183,6 +1183,15 @@ static void sim_efphase_read_cb(int ok, int length=
, int record,
>  		sim->phase =3D data[0];
>  }
>  =

> +static void sim_info_read_cb(int ok, int length, int record,
> +					const unsigned char *file_status,
> +					int record_length, void *userdata)
> +{
> +	DBG("OK: %d, length: %d, record: %d, \
> +		file_status: %x, record_length: %d",
> +		ok, length, record, file_status[0], record_length);
> +}
> +

Is this function actually used?

>  static void sim_initialize_after_pin(struct ofono_sim *sim)
>  {
>  	ofono_sim_read(sim, SIM_EFPHASE_FILEID,
> @@ -1530,7 +1539,7 @@ int ofono_sim_read_bytes(struct ofono_sim *sim, int=
 id,
>  		return -1;
>  =

>  	return sim_fs_read(sim->simfs, id, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> -				offset, num_bytes, cb, data);
> +				FALSE, offset, num_bytes, cb, data);
>  }
>  =

>  int ofono_sim_read(struct ofono_sim *sim, int id,
> @@ -1540,7 +1549,24 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
>  	if (sim =3D=3D NULL)
>  		return -1;
>  =

> -	return sim_fs_read(sim->simfs, id, expected_type, 0, 0, cb, data);
> +	return sim_fs_read(sim->simfs, id, expected_type, FALSE,
> +				0, 0, cb, data);
> +}
> +
> +int ofono_sim_read_info(struct ofono_sim *sim, int id,
> +			enum ofono_sim_file_structure expected_type,
> +			ofono_sim_file_read_cb_t cb, void *data)
> +{
> +	/*
> +	 * Retrieve EF-info only (file length, record length, file status etc).
> +	 * So this function doesn't retrieve actual EF-contents.
> +	 */
> +
> +	if (sim =3D=3D NULL)
> +		return -1;
> +
> +	return sim_fs_read(sim->simfs, id, expected_type, TRUE,
> +				0, 0, cb, data);

This sim fs changes should precede this patch.

>  }
>  =

>  int ofono_sim_write(struct ofono_sim *sim, int id,

Regards,
-Denis

--===============8647170404255462822==--

