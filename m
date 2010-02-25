Content-Type: multipart/mixed; boundary="===============8983292158819520611=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] Add write buffer for non-blocking write
Date: Thu, 25 Feb 2010 16:02:30 -0600
Message-ID: <201002251602.31552.denkenz@gmail.com>
In-Reply-To: <1266817687-28847-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8983292158819520611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Use two layers to cache server side response data to client.
> 1. A fixed-length ring buffer, that is write_buf.
> 2. A list of full ring buffer. The head is to write data out to the
> client and the tail is to cache response data in. At least one buffer
> is in the list.
> =

> When the first layer buffer is full, a free buffer is allocated and
> appended at the tail of the full list. It replaces original write
> buffer as current write_buf.
> ---
>  gatchat/gatserver.c |  130
>  +++++++++++++++++++++++++++++++++++++++++++++----- 1 files changed, 117
>  insertions(+), 13 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index bf7e847..7e11359 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -32,6 +32,14 @@
>  #include "ringbuffer.h"
>  #include "gatserver.h"
> =

> +#define READ_BUF_SIZE 4096

Separate patch please

> +/* #define WRITE_SCHEDULER_DEBUG 1 */
> +#ifdef WRITE_SCHEDULER_DEBUG
> +#define WRITE_BUF_SIZE 4
> +#else
> +#define WRITE_BUF_SIZE 4096
> +#endif
> +

Don't do this, you're confusing the intentions of what WRITE_SCHEDULER_DEBU=
G =

did in atchat vs the way you're using it here.

>  enum ParserState {
>  	PARSER_STATE_IDLE,
>  	PARSER_STATE_A,
> @@ -90,17 +98,75 @@ struct _GAtServer {
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

Use a GQueue here instead of write_buf and full_list.  The head of the queu=
e =

is the stuff to be written, the tail of the queue is the free buffer to stu=
ff =

data into.

>  	guint max_read_attempts;		/* Max reads per select */
>  	enum ParserState parser_state;
>  	gboolean destroyed;			/* Re-entrancy guard */
>  };
> =

> +static void g_at_server_wakeup_writer(GAtServer *server);
> +
> +static gboolean replace_write_buf(GAtServer *server)
> +{
> +	struct ring_buffer *free_buf =3D ring_buffer_new(WRITE_BUF_SIZE);
> +
> +	/* Append this free buf into full list and replace current write
> +	 * buffer by this free buffer */
> +	server->full_list =3D g_slist_append(server->full_list, free_buf);
> +
> +	server->write_buf =3D free_buf;
> +
> +	return TRUE;
> +}
> +
> +static void send_common(GAtServer *server, const char *buf, unsigned int
>  len) +{
> +	gsize avail =3D ring_buffer_avail(server->write_buf);
> +	gsize towrite =3D len;
> +	gsize bytes_written;
> +	gsize offset =3D 0;
> +
> +	if (avail > towrite) {
> +		ring_buffer_write(server->write_buf, buf, towrite);
> +
> +		g_at_server_wakeup_writer(server);
> +
> +		return;
> +	}

I suggest using only the while loop version, no need to short-circuit here.

> +
> +	/* Write as much as we can */
> +	bytes_written =3D ring_buffer_write(server->write_buf, buf, avail);
> +	towrite -=3D bytes_written;
> +	offset =3D bytes_written;
> +
> +	/* If current write buf is full, replace it with next free buffer */
> +	if (!replace_write_buf(server))
> +		return;

This looks wrong, perhaps we should simply forcefully shutdown here in the =

unlikely event that this happens?

> +
> +	bytes_written =3D ring_buffer_write(server->write_buf, buf + offset,
> +						towrite);
> +	while (bytes_written < towrite) {
> +		/* The next free buf is full, replace with next free one */
> +		if (!replace_write_buf(server))
> +			return;
> +
> +		towrite -=3D bytes_written;
> +		offset +=3D bytes_written;
> +		bytes_written =3D ring_buffer_write(server->write_buf,
> +							buf + offset, towrite);
> +	}

My brain hurts, you're using ring_buffer_write like three times.  Please =

restructure the loop to be more concise.  Something like:

while (bytes_written < towrite) {
	bytes_written +=3D ring_buffer_write(buffer,
						MIN(ring_buffer_avail(buffer), towrite-bytes_written);

	if (ring_buffer_avail(buffer) =3D=3D 0)
		allocate_next();
}

> +
> +	g_at_server_wakeup_writer(server);
> +}
> +
>  static void g_at_server_send_result(GAtServer *server, GAtServerResult
>  result) {
>  	struct v250_settings v250 =3D server->v250;
> @@ -108,7 +174,7 @@ static void g_at_server_send_result(GAtServer *server,
>  GAtServerResult result) char buf[1024];
>  	char t =3D v250.s3;
>  	char r =3D v250.s4;
> -	gsize wbuf;
> +	unsigned int len;
> =

>  	if (v250.quiet)
>  		return;
> @@ -117,16 +183,13 @@ static void g_at_server_send_result(GAtServer
>  *server, GAtServerResult result) return;
> =

>  	if (v250.is_v1)
> -		snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result_str,
> +		len =3D snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result_str,
>  				t, r);
>  	else
> -		snprintf(buf, sizeof(buf), "%u%c", (unsigned int) result, t);
> -
> -	g_at_util_debug_chat(FALSE, buf, strlen(buf),
> -				server->debugf, server->debug_data);
> +		len =3D snprintf(buf, sizeof(buf), "%u%c", (unsigned int) result,
> +				t);
> =

> -	g_io_channel_write(server->channel, (char *) buf, strlen(buf),
> -							&wbuf);
> +	send_common(server, buf, len);

So strictly speaking this is wrong.  man snprintf for the Return Value.  If =

you insist on using len, at least use MIN(len, sizeof(buf)-1) or something =

like that.

>  }
> =

>  static inline gboolean is_at_command_prefix(const char c)
> @@ -432,12 +495,23 @@ static gboolean received_data(GIOChannel *channel,
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
> +	if (server->full_list)

Is server->full_list ever NULL?

> +		g_slist_foreach(server->full_list, (GFunc)ring_buffer_free,
> +					NULL);
> +
>  	server->channel =3D NULL;
>  }
> =

> @@ -446,8 +520,6 @@ static void read_watcher_destroy_notify(GAtServer
>  *server) g_at_server_cleanup(server);
>  	server->read_watch =3D 0;
> =

> -	server->channel =3D NULL;
> -
>  	if (server->user_disconnect)
>  		server->user_disconnect(server->user_disconnect_data);
> =

> @@ -455,6 +527,23 @@ static void read_watcher_destroy_notify(GAtServer
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
> @@ -482,12 +571,20 @@ GAtServer *g_at_server_new(GIOChannel *io)
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
> +	/* Current write buf becomes the tail of full list */
> +	server->full_list =3D g_slist_append(server->full_list,
> +						server->write_buf);
> +
> +	server->max_read_attempts =3D 3;
> +
>  	if (!g_at_util_setup_io(server->channel, G_IO_FLAG_NONBLOCK))
>  		goto error;
> =

> @@ -502,6 +599,10 @@ error:
>  	if (server->read_buf)
>  		ring_buffer_free(server->read_buf);
> =

> +	if (server->full_list)
> +		g_slist_foreach(server->full_list, (GFunc)ring_buffer_free,
> +					NULL);
> +

Is server->full_list ever NULL?

>  	if (server)
>  		g_free(server);
> =

> @@ -552,6 +653,9 @@ gboolean g_at_server_shutdown(GAtServer *server)
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

--===============8983292158819520611==--

