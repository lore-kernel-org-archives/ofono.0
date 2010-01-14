Content-Type: multipart/mixed; boundary="===============4683697033494450277=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Add GAtServer basic parsing support
Date: Thu, 14 Jan 2010 11:24:30 -0600
Message-ID: <201001141124.30514.denkenz@gmail.com>
In-Reply-To: <1263207230-22036-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4683697033494450277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> +
> +#include <glib.h>
> +
> +#include "ringbuffer.h"
> +#include "gatresult.h"

Is this include really necessary?

> +#include "gatserver.h"
> +
> +#define DBG(fmt, arg...) g_print("%s:%s() " fmt, __FILE__, __FUNCTION__ ,
>  ## arg) +

Move this to gat.h

> +struct _GAtServer {
> +	gint ref_count;				/* Ref count */
> +	struct v250_settings *v250;		/* V.250 command setting */

This one doesn't need to be a pointer.

> +	GIOChannel *server_io;			/* Server IO */
> +	int server_watch;			/* Watch for server IO */
> +	char *modem_path;			/* Emulated modem path */

Get rid of this, there's no purpose for it.

> +static int at_server_parse(GAtServer *server, char *buf)
> +{
> +	int res =3D G_AT_SERVER_RESULT_ERROR;
> +	struct v250_settings *v250 =3D server->v250;
> +	gsize i =3D 0;
> +	char c;
> +
> +	/* skip space after "AT" or previous command */
> +	i =3D skip_space(buf, i);
> +
> +	c =3D buf[i];
> +	/* skip semicolon */
> +	if (c =3D=3D ';')
> +		c =3D buf[++i];
> +
> +	if (g_ascii_isalpha(c) || c =3D=3D '&')
> +		res =3D parse_v250_settings(server, buf + i);

This part makes no sense

> +	else if (c =3D=3D v250->s3)
> +		res =3D G_AT_SERVER_RESULT_OK;
> +
> +	return res;
> +}
> +
> +static void parse_buffer(GAtServer *server, unsigned int len)
> +{
> +	int res =3D G_AT_SERVER_RESULT_ERROR;
> +	gsize i =3D 0;
> +	char *buf =3D NULL;
> +
> +	g_at_server_ref(server);

Lets get rid of this part for now.  It was a necessary evil inside GAtChat =

since the client can close the channel in the command result callback.  I =

don't think this is relevant for GAtServer.  If it ever becomes relevant we =

can add this back in.

> +
> +	buf =3D g_try_new0(char, len+1);

You're leaking the buf memory in this function.

> +
> +	if (!buf)
> +		goto out;
> +
> +	if (-1 =3D=3D ring_buffer_read(server->buf, buf, len))
> +		goto out;
> +
> +	buf[len] =3D '\0';
> +
> +	DBG("received %s\n", buf);
> +
> +	/* skip header space */
> +	buf +=3D skip_space(buf, i);
> +
> +	/* Make sure the command line prefix is "AT" or "at" */
> +	if (g_str_has_prefix(buf, "AT") ||
> +				g_str_has_prefix(buf, "at"))
> +		res =3D at_server_parse(server, (char *) buf + 2);
> +
> +	g_at_server_send_result_code(server, res);
> +
> +out:
> +	/* We're overflowing the buffer, shutdown the socket */
> +	if (server->buf && ring_buffer_avail(server->buf) =3D=3D 0)
> +		g_at_server_shutdown(server);
> +
> +	g_at_server_unref(server);

Same here, see above.

> +}
> +
> +static gboolean received_data(GIOChannel *chan, GIOCondition cond,
> +				gpointer data)
> +{
> +	GAtServer *server =3D data;
> +	struct v250_settings *v250 =3D server->v250;
> +	GIOError err;
> +	gsize rbytes;
> +	gsize total_read =3D 0;
> +	unsigned char *total_buf =3D ring_buffer_write_ptr(server->buf);

You're totally abusing the ring buffer concept here, the fact that this wor=
ks =

is pure luck.

> +	static gsize total_len;
> +
> +	if (cond & G_IO_NVAL)
> +		return FALSE;
> +
> +	if (cond & (G_IO_HUP | G_IO_ERR)) {
> +		g_at_server_shutdown(server);
> +
> +		return FALSE;
> +	}
> +
> +	/* Regardless of condition, try to read all the data available */
> +	do {
> +		unsigned char *buf;
> +		gsize toread;
> +
> +		rbytes =3D 0;
> +
> +		toread =3D ring_buffer_avail_no_wrap(server->buf);
> +
> +		if (toread =3D=3D 0)
> +			break;
> +
> +		buf =3D ring_buffer_write_ptr(server->buf);
> +
> +		err =3D g_io_channel_read(chan, (char *) buf, toread, &rbytes);
> +
> +		total_read +=3D rbytes;
> +
> +		if (rbytes > 0)
> +			ring_buffer_write_advance(server->buf, rbytes);
> +
> +	} while (err =3D=3D G_IO_ERROR_NONE && rbytes > 0);
> +
> +	g_at_util_debug_chat(server->debugf, TRUE, (char *) total_buf,
> +						total_read, server->debug_data);
> +
> +	if (total_read =3D=3D 0) {
> +		g_at_server_shutdown(server);

You should be checking rbytes =3D=3D 0 && err !=3D EAGAIN here.  Your check=
 below is =

also redundant.

> +
> +		return FALSE;
> +	}
> +
> +	total_len +=3D total_read;
> +
> +	/* Add '\0' to perform strchr */
> +	total_buf[total_read] =3D '\0';
> +
> +	/* Parse buffer until we meet the terminator so that
> +	 * all preceding characters will be processed
> +	 */
> +	if (strchr((char *) total_buf, v250->s3)) {
> +		parse_buffer(server, total_len);
> +
> +		total_len =3D 0;
> +	}

Should this be inside a while loop? Several commands can come in at once.

> +
> +	if (err !=3D G_IO_ERROR_NONE && err !=3D G_IO_ERROR_AGAIN)
> +		return FALSE;
> +
> +	return TRUE;
> +}
> +

> +GAtServer *g_at_server_new(GIOChannel *io, const char *modem_path)

Get rid of modem_path

> +{
> +	GAtServer *server;
> +
> +	if (!io || !modem_path)
> +		return NULL;
> +
> +	server =3D g_try_new0(GAtServer, 1);
> +	if (!server)
> +		return NULL;
> +
> +	server->ref_count =3D 1;
> +	server->v250 =3D v250_settings_create();
> +	server->server_io =3D io;
> +	server->modem_path =3D g_strdup(modem_path);

And here

> +	server->user_disconnect =3D NULL;
> +	server->user_disconnect_data =3D NULL;
> +	server->debugf =3D NULL;
> +	server->debug_data =3D NULL;
> +	server->buf =3D ring_buffer_new(4096);
> +
> +	if (!server->v250)
> +		goto error;
> +
> +	if (!server->buf)
> +		goto error;
> +
> +	if (!g_at_util_set_io(server->server_io))
> +		goto error;
> +
> +	server->server_watch =3D g_io_add_watch_full(io,
> +				G_PRIORITY_DEFAULT,
> +				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +				received_data, server, NULL);
> +
> +	return server;
> +
> +error:
> +	if (server->buf)
> +		ring_buffer_free(server->buf);
> +
> +	if (server->modem_path)
> +		g_free(server->modem_path);

And here

> +
> +	if (server->v250)
> +		g_free(server->v250);
> +
> +	if (server)
> +		g_free(server);
> +
> +	return NULL;
> +}
> +
> +gboolean g_at_server_shutdown(GAtServer *server)
> +{
> +	if (!server)
> +		return FALSE;
> +
> +	if (server->modem_path)
> +		g_free(server->modem_path);
> +
> +	if (server->v250)
> +		g_free(server->v250);
> +
> +	ring_buffer_free(server->buf);
> +	server->buf =3D NULL;
> +
> +	if (server->server_watch) {
> +		g_source_remove(server->server_watch);
> +		server->server_watch =3D 0;
> +	}
> +
> +	if (server->server_io) {
> +		g_io_channel_shutdown(server->server_io, FALSE, NULL);
> +		g_io_channel_unref(server->server_io);
> +		server->server_io =3D NULL;
> +	}
> +
> +	if (server->user_disconnect)
> +		server->user_disconnect(server->user_disconnect_data);

We should not trigger a user_disconnect if we're shutting down normally.  T=
he =

purpose is to detect when the remote side has disconnected the connection.

Regards,
-Denis

--===============4683697033494450277==--

