Content-Type: multipart/mixed; boundary="===============1842676094981951822=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: allow partial reads of tranparent files
Date: Mon, 02 Aug 2010 12:23:40 -0500
Message-ID: <4C56FF1C.7040506@gmail.com>
In-Reply-To: <1280272927-21803-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1842676094981951822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 07/27/2010 06:22 PM, Kristen Carlson Accardi wrote:
> Implement ofono_sim_read_bytes().  For transparent files, this
> will read num_bytes from a specified offset of a given fileid.
> ---
>  include/sim.h |    5 +++++
>  src/sim.c     |   27 ++++++++++++++++++++++++---
>  2 files changed, 29 insertions(+), 3 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 36a99b9..15cd6b8 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -198,6 +198,11 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
>  			enum ofono_sim_file_structure expected,
>  			ofono_sim_file_read_cb_t cb, void *data);
>  =

> +int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
> +			enum ofono_sim_file_structure expected,
> +			unsigned short offset, int num_bytes,
> +			ofono_sim_file_read_cb_t cb, void *data);
> +

The read_bytes function has a slightly different audience than the
sim_read function.  Namely, ofono_sim_read stats the file first for
structure / length / record size and then reads it.

For EFiidf files you will need to initiate multiple reads, so 'stat'ing
the file first every time is inefficient.  Maybe a more low-level
semantic is in order, i.e one that attempts to read directly.

>  int ofono_sim_write(struct ofono_sim *sim, int id,
>  			ofono_sim_file_write_cb_t cb,
>  			enum ofono_sim_file_structure structure, int record,
> diff --git a/src/sim.c b/src/sim.c
> index 2514e7b..63dea19 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -60,6 +60,8 @@ struct sim_file_op {
>  	int id;
>  	gboolean cache;
>  	enum ofono_sim_file_structure structure;
> +	unsigned short offset;
> +	int num_bytes;
>  	int length;
>  	int record_length;
>  	int current;
> @@ -1434,7 +1436,7 @@ static void sim_op_retrieve_cb(const struct ofono_e=
rror *error,
>  		return;
>  	}
>  =

> -	cb(1, op->length, op->current, data, op->record_length, op->userdata);
> +	cb(1, len, op->current, data, op->record_length, op->userdata);
>  =

>  	if (op->cache && imsi) {
>  		char *path =3D g_strdup_printf(SIM_CACHE_PATH,
> @@ -1472,7 +1474,16 @@ static gboolean sim_op_retrieve_next(gpointer user)
>  			return FALSE;
>  		}
>  =

> -		sim->driver->read_file_transparent(sim, op->id, 0, op->length,
> +		if (op->num_bytes < 0)
> +			op->num_bytes =3D op->length;
> +
> +		if (op->offset + op->num_bytes > op->length) {
> +			sim_op_error(sim);
> +			return FALSE;
> +		}
> +
> +		sim->driver->read_file_transparent(sim, op->id, op->offset,
> +						op->num_bytes,
>  						sim_op_retrieve_cb, sim);

Unfortunately you cannot read large files in one go.  You must separate
the reads into 256 byte chunks.  See 3GPP 11.11 for more details.

My rough thinking is as follows:

- Read EFimg
- Cleverly read chunks of EFiidf 1..n, caching the needed chunks and
minimizing the # of reads.  Perhaps using some sort of a bitmap of 256
byte chunks.
- Generate icons and write to a cache on the filesystem
- Free memory resources
- Use memmap to return icons to the user in GetIcon

Regards,
-Denis

--===============1842676094981951822==--

