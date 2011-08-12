Content-Type: multipart/mixed; boundary="===============1493364837420879234=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] gatserver: add command finished functions
Date: Fri, 12 Aug 2011 02:00:04 -0500
Message-ID: <4E44CF74.6070109@gmail.com>
In-Reply-To: <1312468190-27253-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1493364837420879234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 08/04/2011 09:29 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  gatchat/gatserver.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  gatchat/gatserver.h |    7 +++++++
>  2 files changed, 51 insertions(+), 0 deletions(-)
> =


I haven't forgotten about this patch, but I found a nasty corner case in
GAtServer that breaks the current implementation.  I'm still looking for
a nice solution.

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index ab785f7..8e92071 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -115,6 +115,9 @@ struct _GAtServer {
>  	gpointer user_disconnect_data;		/* User disconnect data */
>  	GAtDebugFunc debugf;			/* Debugging output function */
>  	gpointer debug_data;			/* Data to pass to debug func */
> +	GAtServerFinishFunc finishf;		/* Command finish function */
> +	gpointer finish_data;			/* Finish func data */
> +	guint finish_source;
>  	GHashTable *command_list;		/* List of AT commands */
>  	GQueue *write_queue;			/* Write buffer queue */
>  	guint max_read_attempts;		/* Max reads per select */
> @@ -1177,12 +1180,27 @@ static void server_wakeup_writer(GAtServer *serve=
r)
>  	g_at_io_set_write_handler(server->io, can_write_data, server);
>  }
>  =

> +static gboolean notify_finish(void *user_data)
> +{
> +	GAtServer *server =3D user_data;
> +
> +	server->finishf(server, server->finish_data);
> +	server->finish_source =3D 0;
> +
> +	return FALSE;
> +}
> +
>  static void server_resume(GAtServer *server)
>  {
>  	if (server->suspended =3D=3D FALSE)
>  		return;
>  =

>  	server->suspended =3D FALSE;
> +
> +	if (server->finishf)
> +		server->finish_source =3D g_timeout_add_seconds(0, notify_finish,
> +								server);
> +
>  	g_at_io_set_read_handler(server->io, new_bytes, server);
>  }
>  =


<snip>

Can you brainstorm some ideas of a way not to use a g_timeout_add and do
the finish notify synchronously?  I suspect there is a nice(r) solution.

Regards,
-Denis

--===============1493364837420879234==--

