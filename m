Content-Type: multipart/mixed; boundary="===============4092888300836229961=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 4/6] sim: read EFiidf
Date: Wed, 25 Aug 2010 15:36:02 -0700
Message-ID: <20100825153602.100e6132@kcaccard-MOBL3>
In-Reply-To: <4C758859.5060001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4092888300836229961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Aug 2010 16:17:13 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> From: Denis Kenzior <denkenz@gmail.com>
> To: ofono(a)ofono.org
> CC: Kristen Carlson Accardi <kristen@linux.intel.com>,  Andrzej Zaborow=
ski <andrew.zaborowski@intel.com>
> Subject: Re: [PATCH 4/6] sim: read EFiidf
> Date: Wed, 25 Aug 2010 16:17:13 -0500
> User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/=
20100528 Lightning/1.0b1 Thunderbird/3.0.5
> =

> Hi Kristen,
> =

> On 08/25/2010 06:00 AM, Kristen Carlson Accardi wrote:
> > EFiidf can be larger than 256 bytes, so allow callers to read
> > portions of the EFiidf from a specified offset.  Cache EFiidf
> > files as blocks of 256 bytes so that it's not necessary to
> > read the entire (potentially large) file.
> > ---
> >  src/sim.c |  201 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 files changed, 198 insertions(+), 3 deletions(-)
> > =

> > diff --git a/src/sim.c b/src/sim.c
> > index b273bdb..a9557fc 100644
> > --- a/src/sim.c
> > +++ b/src/sim.c
> > @@ -47,6 +47,7 @@
> >  #define SIM_CACHE_PATH STORAGEDIR "/%s-%i/%04x"
> >  #define SIM_CACHE_PATH_LEN(imsilen) (strlen(SIM_CACHE_PATH) - 3 + imsi=
len)
> >  #define SIM_CACHE_HEADER_SIZE 6
> > +#define SIM_IIDF_CACHE_PATH SIM_CACHE_PATH ".%02x"
> >  =

> >  static GSList *g_drivers =3D NULL;
> >  =

> > @@ -55,16 +56,20 @@ static gboolean sim_op_retrieve_next(gpointer user);
> >  static void sim_own_numbers_update(struct ofono_sim *sim);
> >  static void sim_pin_check(struct ofono_sim *sim);
> >  static void sim_set_ready(struct ofono_sim *sim);
> > +static gboolean sim_op_read_block(gpointer user_data);
> >  =

> >  struct sim_file_op {
> >  	int id;
> >  	gboolean cache;
> >  	enum ofono_sim_file_structure structure;
> > +	unsigned short offset;
> > +	int num_bytes;
> >  	int length;
> >  	int record_length;
> >  	int current;
> >  	gconstpointer cb;
> >  	gboolean is_read;
> > +	gboolean is_image;
> >  	void *buffer;
> >  	void *userdata;
> >  };
> > @@ -1666,9 +1671,13 @@ static void sim_op_info_cb(const struct ofono_er=
ror *error, int length,
> >  	else
> >  		op->record_length =3D record_length;
> >  =

> > -	op->current =3D 1;
> >  =

> > -	sim->simop_source =3D g_timeout_add(0, sim_op_retrieve_next, sim);
> > +	if (op->is_image)
> > +		sim->simop_source =3D g_timeout_add(0, sim_op_read_block, sim);
> > +	else {
> > +		op->current =3D 1;
> > +		sim->simop_source =3D g_timeout_add(0, sim_op_retrieve_next, sim);
> > +	}
> >  =

> >  	if (op->cache && imsi) {
> >  		unsigned char fileinfo[6];
> > @@ -1750,6 +1759,12 @@ static gboolean sim_op_check_cached(struct ofono=
_sim *sim)
> >  	structure =3D fileinfo[3];
> >  	record_length =3D (fileinfo[4] << 8) | fileinfo[5];
> >  =

> > +	if (op->is_image) {
> > +		op->length =3D file_length;
> > +		ret =3D TRUE;
> > +		goto cleanup;
> > +	}
> > +
> >  	if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
> >  		record_length =3D file_length;
> >  =

> > @@ -1789,6 +1804,170 @@ cleanup:
> >  	return ret;
> >  }
> >  =

> > +static void sim_op_read_block_cb(const struct ofono_error *error,
> > +				const unsigned char *data, int len, void *user)
> > +{
> > +	struct ofono_sim *sim =3D user;
> > +	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
> > +	int start_block, end_block;
> > +	int start, length;
> > +	unsigned char *buf;
> > +
> > +	if ((error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) || (len =3D=3D 0)) {
> > +		sim_op_error(sim);
> > +		return;
> > +	}
> > +
> > +	/* cache this block */
> > +	write_file(data, len, SIM_CACHE_MODE, SIM_IIDF_CACHE_PATH,
> > +			sim->imsi, sim->phase, op->id, op->current);
> > +
> > +	/* buffer this block */
> > +	start_block =3D op->offset / 256;
> > +	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
> > +
> > +	if (op->current =3D=3D start_block) {
> > +		start =3D op->offset % 256;
> > +		buf =3D op->buffer;
> > +	} else {
> > +		start =3D 0;
> > +		buf =3D op->buffer + (op->current * 256);
> > +	}
> > +
> > +	length =3D op->num_bytes % 256;
> > +
> > +	if ((length =3D=3D 0) || (op->current !=3D end_block))
> > +		length =3D 256;
> > +
> > +	memcpy(buf, &data[start], length);
> > +
> > +	op->current++;
> > +
> > +	sim->simop_source =3D g_timeout_add(0, sim_op_read_block, sim);
> > +}
> > +
> > +static gboolean sim_op_check_cached_block(struct ofono_sim *sim)
> > +{
> > +	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
> > +	char *path;
> > +	int fd;
> > +	char *imsi =3D sim->imsi;
> > +	int start_block, end_block;
> > +	int start, length, len;
> > +	unsigned char *buf;
> > +
> > +	if (!imsi)
> > +		return FALSE;
> > +
> > +	path =3D g_strdup_printf(SIM_IIDF_CACHE_PATH, imsi, sim->phase, op->i=
d,
> > +					op->current);  =

> =

> My initial feeling is that we should treat blocks just like we treat
> records today. We should not write them to separate files.
> =

> Can we unify the two approaches somehow?  Perhaps by storing a bitmap in
> the cache header, and update the bitmap every time we write the record /
> block to the cache.  We can use idmap.c for bitmap management easily
> enough...

The complication is that you can read blocks out of order.  For example,
say you want to retrieve an image that is contained in blocks 4 and 5
of the EFiidf.  But you don=C2=B4t care about blocks 1,2,3 and we don=C2=B4t
read them.  So to cache blocks 4 and 5 when blocks 1, 2, 3 don=C2=B4t exist
in the same file would mean either writing blocks 4 and 5 before blocks
1,2,3 and then keeping a map of where each block would be located in
the file (which would require more space than a bit), or leaving a lot
of blank space for blocks 1, 2, 3 and putting blocks 4 and 5 into the file
after the blank space, which seems wasteful to me since we may never
need to read 1, 2, 3.

--===============4092888300836229961==--

