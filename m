Content-Type: multipart/mixed; boundary="===============2897419134416714684=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Add write ring buffer for non-blocking write
Date: Thu, 11 Feb 2010 12:44:43 -0600
Message-ID: <201002111244.44412.denkenz@gmail.com>
In-Reply-To: <1265856962-5871-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2897419134416714684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Use two layers to cache server side response data to client.
> 1. A fixed-length ring buffer.
> 2. A list of free ring buffers and a list of empty full ring buffer.
> =

> If current ring buffer is full, put it into full buffer list and fetch
> a free buffer frome free list.
> ---
>  gatchat/gatserver.c |  106
>  +++++++++++++++++++++++++++++++++++++++++++++++---- 1 files changed, 98
>  insertions(+), 8 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index bf7e847..6e76016 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -32,6 +32,15 @@
>  #include "ringbuffer.h"
>  #include "gatserver.h"
> =

> +#define MAX_BUFFER_NUM 5
> +#define READ_BUF_SIZE 4096
> +/* #define WRITE_SCHEDULER_DEBUG 1 */
> +#ifdef WRITE_SCHEDULER_DEBUG
> +#define WRITE_BUF_SIZE 4
> +#else
> +#define WRITE_BUF_SIZE 4096
> +#endif
> +

So I don't like this limitation, we should simply alloc a new buffer when w=
e =

run out of space.

>  enum ParserState {
>  	PARSER_STATE_IDLE,
>  	PARSER_STATE_A,
> @@ -90,17 +99,50 @@ struct _GAtServer {
>  	struct v250_settings v250;		/* V.250 command setting */
>  	GIOChannel *channel;			/* Server IO */
>  	guint read_watch;			/* GSource read id, 0 if none */
> +	guint write_watch;			/* GSource write id, 0 if none */
>  	guint read_so_far;			/* Number of bytes processed */
>  	GAtDisconnectFunc user_disconnect;	/* User disconnect func */
>  	gpointer user_disconnect_data;		/* User disconnect data */
>  	GAtDebugFunc debugf;			/* Debugging output function */
>  	gpointer debug_data;			/* Data to pass to debug func */
>  	struct ring_buffer *read_buf;		/* Current read buffer */
> +	struct ring_buffer *write_buf;		/* Current write buffer */
> +	GSList *full_list;			/* List of full ring buffer */
> +	GSList *free_list;			/* List of free ring buffer */

See above, we can really just maintain one list, the full list.  The head a=
nd =

tail pointers should be easily accessible (write new data out from the head=
, =

put data on the tail.) Maintain at least one buffer in the list.

>  	guint max_read_attempts;		/* Max reads per select */
>  	enum ParserState parser_state;
>  	gboolean destroyed;			/* Re-entrancy guard */
>  };
> =

> +static void g_at_server_wakeup_writer(GAtServer *server);
> +
> +static gboolean alloc_free_list(GAtServer *server)
> +{
> +	struct ring_buffer *buf;
> +	guint i;
> +
> +	for (i =3D 0; i < MAX_BUFFER_NUM; i++) {
> +		buf =3D ring_buffer_new(WRITE_BUF_SIZE);
> +		if (!buf)
> +			return FALSE;
> +
> +		server->free_list =3D g_slist_prepend(server->free_list, buf);
> +	}
> +
> +	return TRUE;
> +}
> +
> +static void send_common(GAtServer *server, const char *buf)
> +{
> +	gsize avail =3D ring_buffer_avail(server->write_buf);
> +	gsize len =3D strlen(buf);

This part is wrong, the data can actually be binary as well.

> +
> +	if (avail >=3D len)
> +		ring_buffer_write(server->write_buf, buf, len);
> +
> +	g_at_server_wakeup_writer(server);
> +}
> +
>  static void g_at_server_send_result(GAtServer *server, GAtServerResult
>  result) {
>  	struct v250_settings v250 =3D server->v250;
> @@ -108,7 +150,6 @@ static void g_at_server_send_result(GAtServer *server,
>  GAtServerResult result) char buf[1024];
>  	char t =3D v250.s3;
>  	char r =3D v250.s4;
> -	gsize wbuf;
> =

>  	if (v250.quiet)
>  		return;
> @@ -125,8 +166,7 @@ static void g_at_server_send_result(GAtServer *server,
>  GAtServerResult result) g_at_util_debug_chat(FALSE, buf, strlen(buf),
>  				server->debugf, server->debug_data);
> =

> -	g_io_channel_write(server->channel, (char *) buf, strlen(buf),
> -							&wbuf);
> +	send_common(server, buf);
>  }
> =

>  static inline gboolean is_at_command_prefix(const char c)
> @@ -432,12 +472,30 @@ static gboolean received_data(GIOChannel *channel,
>  GIOCondition cond, return TRUE;
>  }
> =

> +static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
> +				gpointer data)
> +{
> +	return FALSE;
> +}
> +
>  static void g_at_server_cleanup(GAtServer *server)
>  {
>  	/* Cleanup all received data */
>  	ring_buffer_free(server->read_buf);
>  	server->read_buf =3D NULL;
> =

> +	/* Cleanup pending data to write */
> +	ring_buffer_free(server->write_buf);
> +	server->write_buf =3D NULL;
> +
> +	if (server->full_list)
> +		g_slist_foreach(server->full_list, (GFunc)ring_buffer_free,
> +					NULL);
> +
> +	if (server->free_list)
> +		g_slist_foreach(server->free_list, (GFunc)ring_buffer_free,
> +					NULL);
> +
>  	server->channel =3D NULL;
>  }
> =

> @@ -446,8 +504,6 @@ static void read_watcher_destroy_notify(GAtServer
>  *server) g_at_server_cleanup(server);
>  	server->read_watch =3D 0;
> =

> -	server->channel =3D NULL;
> -
>  	if (server->user_disconnect)
>  		server->user_disconnect(server->user_disconnect_data);
> =

> @@ -455,6 +511,23 @@ static void read_watcher_destroy_notify(GAtServer
>  *server) g_free(server);
>  }
> =

> +static void write_watcher_destroy_notify(GAtServer *server)
> +{
> +	server->write_watch =3D 0;
> +}
> +
> +static void g_at_server_wakeup_writer(GAtServer *server)
> +{
> +	if (server->write_watch !=3D 0)
> +		return;
> +
> +	server->write_watch =3D g_io_add_watch_full(server->channel,
> +			G_PRIORITY_DEFAULT,
> +			G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +			can_write_data, server,
> +			(GDestroyNotify)write_watcher_destroy_notify);
> +}
> +
>  static void v250_settings_create(struct v250_settings *v250)
>  {
>  	v250->s3 =3D '\r';
> @@ -482,12 +555,19 @@ GAtServer *g_at_server_new(GIOChannel *io)
>  	server->ref_count =3D 1;
>  	v250_settings_create(&server->v250);
>  	server->channel =3D io;
> -	server->read_buf =3D ring_buffer_new(4096);
> -	server->max_read_attempts =3D 3;
> -
> +	server->read_buf =3D ring_buffer_new(READ_BUF_SIZE);
>  	if (!server->read_buf)
>  		goto error;
> =

> +	server->write_buf =3D ring_buffer_new(WRITE_BUF_SIZE);
> +	if (!server->write_buf)
> +		goto error;
> +
> +	if (!alloc_free_list(server))
> +		goto error;
> +
> +	server->max_read_attempts =3D 3;
> +
>  	if (!g_at_util_setup_io(server->channel, G_IO_FLAG_NONBLOCK))
>  		goto error;
> =

> @@ -502,6 +582,13 @@ error:
>  	if (server->read_buf)
>  		ring_buffer_free(server->read_buf);
> =

> +	if (server->write_buf)
> +		ring_buffer_free(server->write_buf);
> +
> +	if (server->free_list)
> +		g_slist_foreach(server->free_list, (GFunc)ring_buffer_free,
> +					NULL);
> +
>  	if (server)
>  		g_free(server);
> =

> @@ -552,6 +639,9 @@ gboolean g_at_server_shutdown(GAtServer *server)
>  	server->user_disconnect =3D NULL;
>  	server->user_disconnect_data =3D NULL;
> =

> +	if (server->write_watch)
> +		g_source_remove(server->write_watch);
> +
>  	if (server->read_watch)
>  		g_source_remove(server->read_watch);
> =


Regards,
-Denis

--===============2897419134416714684==--

