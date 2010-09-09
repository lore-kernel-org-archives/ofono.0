Content-Type: multipart/mixed; boundary="===============6460566164203208348=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] sim: Implement GetIcon
Date: Thu, 09 Sep 2010 09:16:03 -0500
Message-ID: <4C88EC23.9000506@gmail.com>
In-Reply-To: <1282925966-14419-3-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6460566164203208348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 08/27/2010 11:19 AM, Kristen Carlson Accardi wrote:
> ---
>  src/sim.c |  220 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 220 insertions(+), 0 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index bbcf609..d8c0d37 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -42,12 +42,14 @@
>  #include "smsutil.h"
>  #include "simutil.h"
>  #include "storage.h"
> +#include "stkutil.h"
>  =

>  #define SIM_CACHE_MODE 0600
>  #define SIM_CACHE_PATH STORAGEDIR "/%s-%i/%04x"
>  #define SIM_CACHE_PATH_LEN(imsilen) (strlen(SIM_CACHE_PATH) - 3 + imsile=
n)
>  #define SIM_CACHE_HEADER_SIZE 38
>  #define SIM_FILE_INFO_SIZE 6
> +#define SIM_IMAGE_CACHE_PATH STORAGEDIR "/%s-%i/images/%d.xpm"
>  =

>  static GSList *g_drivers =3D NULL;
>  =

> @@ -58,6 +60,11 @@ static void sim_pin_check(struct ofono_sim *sim);
>  static void sim_set_ready(struct ofono_sim *sim);
>  static gboolean sim_op_read_block(gpointer user_data);
>  =

> +typedef void (*sim_get_image_cb_t)(int ok, const char *xpm, int xpm_len,
> +						void *user_data);
> +static void sim_get_image(struct ofono_sim *sim, unsigned char id,
> +			sim_get_image_cb_t cb, gpointer user_data);
> +

I'd like to get rid of the typedef and the forward declaration.  The
typedef is not necessary since only 1 client will ever need this, so
hardcoding it is fine for now.

>  struct sim_file_op {
>  	int id;
>  	gboolean cache;
> @@ -93,6 +100,7 @@ struct ofono_sim {
>  	unsigned char *efli;
>  	unsigned char efli_length;
>  	unsigned char *efimg;
> +	unsigned short image_cache[256];

Let us get rid of this part.  You can easily stat() the file to figure
out whether it has been cached.

>  	int efimg_length;
>  	enum ofono_sim_cphs_phase cphs_phase;
>  	unsigned char cphs_service_table[2];
> @@ -736,6 +744,50 @@ static DBusMessage *sim_enter_pin(DBusConnection *co=
nn, DBusMessage *msg,
>  	return NULL;
>  }
>  =

> +static void sim_get_image_cb(int ok, const char *xpm, int xpm_len,
> +					void *userdata)

Please use gboolean ok instead of int

> +{
> +	struct ofono_sim *sim =3D userdata;
> +	DBusMessage *reply;
> +
> +	if (!ok)
> +		reply =3D __ofono_error_failed(sim->pending);
> +	else {
> +		reply =3D dbus_message_new_method_return(sim->pending);
> +		dbus_message_append_args(reply, DBUS_TYPE_STRING, &xpm,
> +					DBUS_TYPE_INVALID);
> +	}
> +
> +	__ofono_dbus_pending_reply(&sim->pending, reply);
> +}
> +
> +static DBusMessage *sim_get_icon(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_sim *sim =3D data;
> +	unsigned char id;
> +
> +	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_BYTE, &id,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	/* zero means no icon */
> +	if (id =3D=3D 0)
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (sim->pending)
> +		return __ofono_error_busy(msg);
> +
> +	if (sim->efimg =3D=3D NULL)
> +		return __ofono_error_not_implemented(msg);
> +
> +	sim->pending =3D dbus_message_ref(msg);
> +
> +	sim_get_image(sim, id, sim_get_image_cb, sim);
> +
> +	return NULL;
> +}
> +
>  static DBusMessage *sim_reset_pin(DBusConnection *conn, DBusMessage *msg,
>  					void *data)
>  {
> @@ -788,6 +840,8 @@ static GDBusMethodTable sim_methods[] =3D {
>  							G_DBUS_METHOD_FLAG_ASYNC },
>  	{ "UnlockPin",		"ss",	"",		sim_unlock_pin,
>  							G_DBUS_METHOD_FLAG_ASYNC },
> +	{ "GetIcon",		"y",	"s",		sim_get_icon,
> +							G_DBUS_METHOD_FLAG_ASYNC },
>  	{ }
>  };
>  =

> @@ -2549,3 +2603,169 @@ void *ofono_sim_get_data(struct ofono_sim *sim)
>  {
>  	return sim->driver_data;
>  }
> +
> +struct image_data {
> +	struct ofono_sim *sim;
> +	unsigned char width;
> +	unsigned char height;
> +	enum stk_img_scheme scheme;
> +	unsigned short iidf_id;
> +	unsigned short iidf_offset;
> +	unsigned short iid_len;
> +	void *image;
> +	unsigned short clut_len;
> +	gboolean need_clut;
> +	sim_get_image_cb_t user_cb;
> +	gpointer user_data;
> +	unsigned char id;
> +};
> +
> +static void sim_iidf_read_cb(int ok, int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct image_data *image =3D userdata;
> +	unsigned short offset;
> +	unsigned short num_entries;
> +	char *xpm;
> +	struct ofono_sim *sim =3D image->sim;
> +
> +	if (!ok) {
> +		image->user_cb(ok, NULL, 0, image->user_data);
> +		goto iidf_read_out;
> +	}
> +
> +	if (image->need_clut =3D=3D FALSE) {
> +		if (image->scheme =3D=3D STK_IMG_SCHEME_BASIC) {
> +			xpm =3D stk_image_to_xpm(data, image->iid_len,
> +						image->scheme, NULL, 0);
> +		} else {
> +			xpm =3D stk_image_to_xpm(image->image, image->iid_len,
> +						image->scheme, data,
> +						image->clut_len);
> +		}
> +
> +		if (sim->imsi) {
> +			write_file((const unsigned char *) xpm, strlen(xpm),
> +					SIM_CACHE_MODE, SIM_IMAGE_CACHE_PATH,
> +					sim->imsi, sim->phase, image->id);
> +
> +			sim->image_cache[image->id] =3D strlen(xpm);
> +		}
> +
> +		image->user_cb(ok, xpm, strlen(xpm), image->user_data);
> +
> +		g_free(xpm);
> +
> +		goto iidf_read_out;
> +	}
> +
> +	offset =3D data[4] << 8 | data[5];
> +	num_entries =3D data[3];
> +
> +	if (num_entries =3D=3D 0)
> +		num_entries =3D 256;
> +
> +	/* indicate that we're on our second read */
> +	image->need_clut =3D FALSE;
> +
> +	image->clut_len =3D num_entries * 3;
> +
> +	image->image =3D g_memdup(data, length);
> +
> +	/* read the clut data */
> +	ofono_sim_read_bytes(image->sim, image->iidf_id,
> +				offset, image->clut_len,
> +				sim_iidf_read_cb, image);
> +
> +	return;
> +
> +iidf_read_out:
> +	g_free(image->image);
> +	g_free(image);
> +}
> +
> +static void sim_get_image(struct ofono_sim *sim, unsigned char id,
> +			sim_get_image_cb_t cb, gpointer user_data)
> +{
> +	struct image_data *data;
> +	unsigned char *efimg;
> +	unsigned short image_length;
> +
> +	/* icon ids should start at 1, our array starts at zero */
> +	if (id =3D=3D 0) {
> +		cb(-1, NULL, 0, user_data);

-1 is actually wrong here, it should be 0.

> +		return;
> +	}
> +
> +	id--;
> +
> +	/* check the image cache to see if we've already got this one */
> +	image_length =3D sim->image_cache[id];
> +
> +	if (image_length > 0) {
> +		int fd;
> +		char *imsi =3D sim->imsi;
> +		char *buffer;
> +		char *path =3D g_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi,
> +						sim->phase,
> +						id);
> +		int len;
> +
> +		fd =3D TFR(open(path, O_RDONLY));
> +
> +		g_free(path);
> +
> +		if (fd < 0)
> +			goto read_image;
> +
> +		buffer =3D g_try_malloc0(image_length + 1);
> +
> +		len =3D TFR(read(fd, buffer, image_length));
> +
> +		if (len =3D=3D image_length)
> +			cb(1, buffer, image_length, user_data);
> +		else {
> +			g_free(buffer);
> +			goto read_image;
> +		}
> +
> +		g_free(buffer);
> +
> +		return;
> +	}
> +
> +read_image:
> +
> +	if (sim->efimg_length < (id * 9)) {
> +		cb(-1, NULL, 0, user_data);
> +		return;
> +	}
> +
> +	efimg =3D &sim->efimg[id * 9];
> +
> +	data =3D g_try_new0(struct image_data, 1);
> +	if (data =3D=3D NULL)
> +		return;
> +
> +	data->width =3D efimg[0];
> +	data->height =3D efimg[1];
> +	data->scheme =3D efimg[2];
> +	data->iidf_id =3D efimg[3] << 8 | efimg[4];
> +	data->iidf_offset =3D efimg[5] << 8 | efimg[6];
> +	data->iid_len =3D efimg[7] << 8 | efimg[8];
> +	data->user_cb =3D cb;
> +	data->user_data =3D user_data;
> +	data->sim =3D sim;
> +	data->id =3D id;
> +
> +	if (data->scheme =3D=3D STK_IMG_SCHEME_BASIC)
> +		data->need_clut =3D FALSE;
> +	else
> +		data->need_clut =3D TRUE;
> +
> +	/* read the image data */
> +	ofono_sim_read_bytes(sim, data->iidf_id,
> +				data->iidf_offset, data->iid_len,
> +				sim_iidf_read_cb, data);
> +}

Otherwise patch looks good.  Can you rebase and resubmit?

Thanks,
-Denis

--===============6460566164203208348==--

