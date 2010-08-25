Content-Type: multipart/mixed; boundary="===============1246752421550297446=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] sim: read EFiidf
Date: Wed, 25 Aug 2010 16:17:13 -0500
Message-ID: <4C758859.5060001@gmail.com>
In-Reply-To: <1282734025-3375-5-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1246752421550297446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 08/25/2010 06:00 AM, Kristen Carlson Accardi wrote:
> EFiidf can be larger than 256 bytes, so allow callers to read
> portions of the EFiidf from a specified offset.  Cache EFiidf
> files as blocks of 256 bytes so that it's not necessary to
> read the entire (potentially large) file.
> ---
>  src/sim.c |  201 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 198 insertions(+), 3 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index b273bdb..a9557fc 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -47,6 +47,7 @@
>  #define SIM_CACHE_PATH STORAGEDIR "/%s-%i/%04x"
>  #define SIM_CACHE_PATH_LEN(imsilen) (strlen(SIM_CACHE_PATH) - 3 + imsile=
n)
>  #define SIM_CACHE_HEADER_SIZE 6
> +#define SIM_IIDF_CACHE_PATH SIM_CACHE_PATH ".%02x"
>  =

>  static GSList *g_drivers =3D NULL;
>  =

> @@ -55,16 +56,20 @@ static gboolean sim_op_retrieve_next(gpointer user);
>  static void sim_own_numbers_update(struct ofono_sim *sim);
>  static void sim_pin_check(struct ofono_sim *sim);
>  static void sim_set_ready(struct ofono_sim *sim);
> +static gboolean sim_op_read_block(gpointer user_data);
>  =

>  struct sim_file_op {
>  	int id;
>  	gboolean cache;
>  	enum ofono_sim_file_structure structure;
> +	unsigned short offset;
> +	int num_bytes;
>  	int length;
>  	int record_length;
>  	int current;
>  	gconstpointer cb;
>  	gboolean is_read;
> +	gboolean is_image;
>  	void *buffer;
>  	void *userdata;
>  };
> @@ -1666,9 +1671,13 @@ static void sim_op_info_cb(const struct ofono_erro=
r *error, int length,
>  	else
>  		op->record_length =3D record_length;
>  =

> -	op->current =3D 1;
>  =

> -	sim->simop_source =3D g_timeout_add(0, sim_op_retrieve_next, sim);
> +	if (op->is_image)
> +		sim->simop_source =3D g_timeout_add(0, sim_op_read_block, sim);
> +	else {
> +		op->current =3D 1;
> +		sim->simop_source =3D g_timeout_add(0, sim_op_retrieve_next, sim);
> +	}
>  =

>  	if (op->cache && imsi) {
>  		unsigned char fileinfo[6];
> @@ -1750,6 +1759,12 @@ static gboolean sim_op_check_cached(struct ofono_s=
im *sim)
>  	structure =3D fileinfo[3];
>  	record_length =3D (fileinfo[4] << 8) | fileinfo[5];
>  =

> +	if (op->is_image) {
> +		op->length =3D file_length;
> +		ret =3D TRUE;
> +		goto cleanup;
> +	}
> +
>  	if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
>  		record_length =3D file_length;
>  =

> @@ -1789,6 +1804,170 @@ cleanup:
>  	return ret;
>  }
>  =

> +static void sim_op_read_block_cb(const struct ofono_error *error,
> +				const unsigned char *data, int len, void *user)
> +{
> +	struct ofono_sim *sim =3D user;
> +	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
> +	int start_block, end_block;
> +	int start, length;
> +	unsigned char *buf;
> +
> +	if ((error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) || (len =3D=3D 0)) {
> +		sim_op_error(sim);
> +		return;
> +	}
> +
> +	/* cache this block */
> +	write_file(data, len, SIM_CACHE_MODE, SIM_IIDF_CACHE_PATH,
> +			sim->imsi, sim->phase, op->id, op->current);
> +
> +	/* buffer this block */
> +	start_block =3D op->offset / 256;
> +	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
> +
> +	if (op->current =3D=3D start_block) {
> +		start =3D op->offset % 256;
> +		buf =3D op->buffer;
> +	} else {
> +		start =3D 0;
> +		buf =3D op->buffer + (op->current * 256);
> +	}
> +
> +	length =3D op->num_bytes % 256;
> +
> +	if ((length =3D=3D 0) || (op->current !=3D end_block))
> +		length =3D 256;
> +
> +	memcpy(buf, &data[start], length);
> +
> +	op->current++;
> +
> +	sim->simop_source =3D g_timeout_add(0, sim_op_read_block, sim);
> +}
> +
> +static gboolean sim_op_check_cached_block(struct ofono_sim *sim)
> +{
> +	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
> +	char *path;
> +	int fd;
> +	char *imsi =3D sim->imsi;
> +	int start_block, end_block;
> +	int start, length, len;
> +	unsigned char *buf;
> +
> +	if (!imsi)
> +		return FALSE;
> +
> +	path =3D g_strdup_printf(SIM_IIDF_CACHE_PATH, imsi, sim->phase, op->id,
> +					op->current);

My initial feeling is that we should treat blocks just like we treat
records today. We should not write them to separate files.

Can we unify the two approaches somehow?  Perhaps by storing a bitmap in
the cache header, and update the bitmap every time we write the record /
block to the cache.  We can use idmap.c for bitmap management easily
enough...

Andrew you know this part pretty well, what's your opinion?

> +
> +	if (path =3D=3D NULL)
> +		return FALSE;
> +
> +	fd =3D TFR(open(path, O_RDONLY));
> +	g_free(path);
> +
> +	if (fd =3D=3D -1) {
> +		if (errno !=3D ENOENT)
> +			DBG("Error %i opening cache file for "
> +					"fileid %04x, IMSI %s",
> +					errno, op->id, imsi);
> +
> +		return FALSE;
> +	}
> +
> +	/* figure out where we should start reading from */
> +	start_block =3D op->offset / 256;
> +	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
> +
> +	if (op->current =3D=3D start_block) {
> +		start =3D op->offset % 256;
> +		buf =3D op->buffer;
> +	} else {
> +		start =3D 0;
> +		buf =3D op->buffer + (op->current * 256);
> +	}
> +
> +	length =3D op->num_bytes % 256;
> +
> +	if ((length =3D=3D 0) || (op->current !=3D end_block))
> +		length =3D 256;
> +
> +	/* lseek to the right place in the file */
> +	TFR(lseek(fd, start, SEEK_CUR));
> +
> +	len =3D TFR(read(fd, buf, length));
> +
> +	if (len !=3D length)
> +		return FALSE;
> +
> +	op->current++;
> +
> +	sim->simop_source =3D g_timeout_add(0, sim_op_read_block, sim);
> +
> +	return TRUE;
> +}
> +
> +static gboolean sim_op_read_block(gpointer user_data)
> +{
> +	struct ofono_sim *sim =3D user_data;
> +	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
> +	int end_block;
> +	ofono_sim_file_read_cb_t cb =3D op->cb;
> +	int read_bytes;
> +
> +	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
> +
> +	if (op->current > end_block) {
> +		cb(1, op->num_bytes, op->current, op->buffer,
> +				op->record_length, op->userdata);
> +
> +		op =3D g_queue_pop_head(sim->simop_q);
> +
> +		g_free(op->buffer);
> +
> +		sim_file_op_free(op);
> +
> +		if (g_queue_get_length(sim->simop_q) > 0)
> +			sim->simop_source =3D g_timeout_add(0, sim_op_next, sim);
> +
> +		return FALSE;
> +	}
> +
> +	/* see if this block is cached */
> +	if (sim_op_check_cached_block(sim) =3D=3D TRUE)
> +		return FALSE;
> +
> +	if (op->length < ((op->current + 1) * 256))
> +		read_bytes =3D op->length % 256;
> +	else
> +		read_bytes =3D 256;
> +
> +	sim->driver->read_file_transparent(sim, op->id,
> +						op->current * 256,
> +						read_bytes,
> +						sim_op_read_block_cb, sim);
> +	return FALSE;
> +}
> +
> +static void sim_op_get_image(struct ofono_sim *sim)
> +{
> +	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
> +
> +	/* allocate space to buffer the data till we've collected it all */
> +	op->buffer =3D g_try_malloc0(op->num_bytes);
> +
> +	/* initialize current */
> +	op->current =3D op->offset / 256;
> +
> +	/* need to get the length of the file */
> +	if (sim_op_check_cached(sim) =3D=3D FALSE)
> +		sim->driver->read_file_info(sim, op->id, sim_op_info_cb, sim);
> +	else
> +		sim->simop_source =3D g_timeout_add(0, sim_op_read_block, sim);
> +}
> +
>  static gboolean sim_op_next(gpointer user_data)
>  {
>  	struct ofono_sim *sim =3D user_data;
> @@ -1801,6 +1980,11 @@ static gboolean sim_op_next(gpointer user_data)
>  =

>  	op =3D g_queue_peek_head(sim->simop_q);
>  =

> +	if (op->is_image) {
> +		sim_op_get_image(sim);
> +		return FALSE;
> +	}
> +
>  	if (op->is_read =3D=3D TRUE) {
>  		if (sim_op_check_cached(sim)) {
>  			op =3D g_queue_pop_head(sim->simop_q);
> @@ -1843,8 +2027,9 @@ static gboolean sim_op_next(gpointer user_data)
>  	return FALSE;
>  }
>  =

> -int ofono_sim_read(struct ofono_sim *sim, int id,
> +static int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
>  			enum ofono_sim_file_structure expected_type,
> +			unsigned short offset, int num_bytes,
>  			ofono_sim_file_read_cb_t cb, void *data)

Please don't give static functions an ofono_ prefix.  ofono_ prefix is
reserved for public API only.  __ofono prefix is reserved for private API.

Lets make this into proper oFono public API and unify 'reading at
offset' and 'reading the entire file' types into a single architecture.
 E.g. ofono_sim_read for a transparent file results in us reading all
blocks of that file and caching them.  read_bytes only results in us
caching the blocks we read...

Reading of files at a certain offset is only supported for transparent
files, so passing expected_type is not needed.

Something like
ofono_sim_read_bytes(sim, id, offset, num_bytes, cb, data);

>  {
>  	struct sim_file_op *op;
> @@ -1875,6 +2060,9 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
>  	op->cb =3D cb;
>  	op->userdata =3D data;
>  	op->is_read =3D TRUE;
> +	op->offset =3D offset;
> +	op->num_bytes =3D num_bytes;
> +	op->is_image =3D ((((id >> 8) & 0xFF) =3D=3D 0x4F) && (id !=3D 0x4F20));

Perhaps use num_bytes =3D=3D -1 for 'read everything' type.  Let us drop the
is_image flag completely.

>  =

>  	g_queue_push_tail(sim->simop_q, op);
>  =

> @@ -1884,6 +2072,13 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
>  	return 0;
>  }
>  =

> +int ofono_sim_read(struct ofono_sim *sim, int id,
> +			enum ofono_sim_file_structure expected_type,
> +			ofono_sim_file_read_cb_t cb, void *data)
> +{
> +	return ofono_sim_read_bytes(sim, id, expected_type, 0, -1, cb, data);
> +}
> +
>  int ofono_sim_write(struct ofono_sim *sim, int id,
>  			ofono_sim_file_write_cb_t cb,
>  			enum ofono_sim_file_structure structure, int record,

Regards,
-Denis

--===============1246752421550297446==--

