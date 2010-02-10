Content-Type: multipart/mixed; boundary="===============1929050501817719263=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 1/4] Add write ring buffer for non-blocking write
Date: Wed, 10 Feb 2010 15:23:37 -0200
Message-ID: <20100210172337.GC6797@vigoh>
In-Reply-To: <1265789623-30146-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1929050501817719263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Zhenhua Zhang <zhenhua.zhang@intel.com> [2010-02-10 16:13:40 +0800]:

> Use two layers to cache server side response data to client.
> 1. A fixed-length ring buffer.
> 2. A list of free ring buffers and a list of empty full ring buffer.
> =

> If current ring buffer is full, put it into full buffer list and fetch
> a free buffer frome free list.
> ---
>  gatchat/gatserver.c |  111 +++++++++++++++++++++++++++++++++++++++++++++=
++---
>  1 files changed, 104 insertions(+), 7 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index bf7e847..6b40084 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -32,6 +32,9 @@
>  #include "ringbuffer.h"
>  #include "gatserver.h"
>  =

> +#define MAX_BUFFER_NUM 5
> +/* #define WRITE_SCHEDULER_DEBUG 1 */
> +
>  enum ParserState {
>  	PARSER_STATE_IDLE,
>  	PARSER_STATE_A,
> @@ -90,17 +93,54 @@ struct _GAtServer {
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
>  	guint max_read_attempts;		/* Max reads per select */
>  	enum ParserState parser_state;
>  	gboolean destroyed;			/* Re-entrancy guard */
>  };
>  =

> +static void g_at_server_wakeup_writer(GAtServer *server);
> +
> +static gboolean alloc_free_list(GAtServer *server)
> +{
> +	struct ring_buffer *buf;
> +	guint i;
> +
> +	for (i =3D 0; i < MAX_BUFFER_NUM; i++) {
> +#ifdef WRITE_SCHEDULER_DEBUG
> +		buf =3D ring_buffer_new(4);
> +#else
> +		buf =3D ring_buffer_new(4096);
> +#endif

Why not a macro to define buf size? So you don't need to use ifdef
everytime

#ifdef WRITE_SCHEDULER_DEBUG
		BUF_SIZE =3D 4
#else
		BUF_SIZE =3D 4096	=

#endif

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
> +
> +	if (avail >=3D len)
> +		ring_buffer_write(server->write_buf, buf, len);
> +
> +	g_at_server_wakeup_writer(server);
> +}
> +
>  static void g_at_server_send_result(GAtServer *server, GAtServerResult r=
esult)
>  {
>  	struct v250_settings v250 =3D server->v250;
> @@ -108,7 +148,6 @@ static void g_at_server_send_result(GAtServer *server=
, GAtServerResult result)
>  	char buf[1024];
>  	char t =3D v250.s3;
>  	char r =3D v250.s4;
> -	gsize wbuf;
>  =

>  	if (v250.quiet)
>  		return;
> @@ -125,8 +164,7 @@ static void g_at_server_send_result(GAtServer *server=
, GAtServerResult result)
>  	g_at_util_debug_chat(FALSE, buf, strlen(buf),
>  				server->debugf, server->debug_data);
>  =

> -	g_io_channel_write(server->channel, (char *) buf, strlen(buf),
> -							&wbuf);
> +	send_common(server, buf);
>  }
>  =

>  static inline gboolean is_at_command_prefix(const char c)
> @@ -432,12 +470,35 @@ static gboolean received_data(GIOChannel *channel, =
GIOCondition cond,
>  	return TRUE;
>  }
>  =

> +static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
> +				gpointer data)
> +{
> +	return FALSE;
> +}
> +
> +static void free_ring_buffer(struct ring_buffer *buf)
> +{
> +	ring_buffer_free(buf);
> +}

This seems pointless to me.

> +
>  static void g_at_server_cleanup(GAtServer *server)
>  {
>  	/* Cleanup all received data */
>  	ring_buffer_free(server->read_buf);
>  	server->read_buf =3D NULL;
>  =

> +	/* Cleanup pending data to write */
> +	ring_buffer_free(server->write_buf);
> +	server->write_buf =3D NULL;
> +
> +	if (server->full_list)
> +		g_slist_foreach(server->full_list, (GFunc)free_ring_buffer,
> +					NULL);
> +
> +	if (server->free_list)
> +		g_slist_foreach(server->free_list, (GFunc)free_ring_buffer,
> +					NULL);
> +
>  	server->channel =3D NULL;
>  }
>  =

> @@ -446,8 +507,6 @@ static void read_watcher_destroy_notify(GAtServer *se=
rver)
>  	g_at_server_cleanup(server);
>  	server->read_watch =3D 0;
>  =

> -	server->channel =3D NULL;
> -
>  	if (server->user_disconnect)
>  		server->user_disconnect(server->user_disconnect_data);
>  =

> @@ -455,6 +514,23 @@ static void read_watcher_destroy_notify(GAtServer *s=
erver)
>  		g_free(server);
>  }
>  =

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
> @@ -483,11 +559,22 @@ GAtServer *g_at_server_new(GIOChannel *io)
>  	v250_settings_create(&server->v250);
>  	server->channel =3D io;
>  	server->read_buf =3D ring_buffer_new(4096);
> -	server->max_read_attempts =3D 3;
> -
>  	if (!server->read_buf)
>  		goto error;
>  =

> +#ifdef WRITE_SCHEDULER_DEBUG
> +	server->write_buf =3D ring_buffer_new(4);
> +#else
> +	server->write_buf =3D ring_buffer_new(4096);
> +#endif
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
>  =

> @@ -502,6 +589,13 @@ error:
>  	if (server->read_buf)
>  		ring_buffer_free(server->read_buf);
>  =

> +	if (server->write_buf)
> +		ring_buffer_free(server->write_buf);
> +
> +	if (server->free_list)
> +		g_slist_foreach(server->free_list, (GFunc)free_ring_buffer,
> +					NULL);
> +
>  	if (server)
>  		g_free(server);
>  =

> @@ -552,6 +646,9 @@ gboolean g_at_server_shutdown(GAtServer *server)
>  	server->user_disconnect =3D NULL;
>  	server->user_disconnect_data =3D NULL;
>  =

> +	if (server->write_watch)
> +		g_source_remove(server->write_watch);
> +
>  	if (server->read_watch)
>  		g_source_remove(server->read_watch);
>  =

> -- =

> 1.6.6.1
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

-- =

Gustavo F. Padovan
http://padovan.org

ProFUSION embedded systems - http://profusion.mobi

--===============1929050501817719263==--

