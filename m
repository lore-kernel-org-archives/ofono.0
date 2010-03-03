Content-Type: multipart/mixed; boundary="===============5827091935008692571=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/7] Add server at command data structure
Date: Wed, 03 Mar 2010 13:23:37 -0600
Message-ID: <201003031323.38102.denkenz@gmail.com>
In-Reply-To: <1267628212-14079-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5827091935008692571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Implement hashtable to store server supported command list.
> =

> AT command could be action command or parameter command. Defined
> in V.250 5.2.5.
> ---
>  gatchat/gatserver.c |   29 +++++++++++++++++++++++++++++
>  gatchat/gatserver.h |   21 +++++++++++++++++++++
>  2 files changed, 50 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index 4a19b6b..829dc1d 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -75,6 +75,16 @@ static const char
>  *server_result_to_string(GAtServerResult result) }
>  }
> =

> +/* AT command set that server supported */
> +struct at_command {
> +	int id;
> +	char *prefix;

I don't see the point for id or prefix here.  The prefix is already stored =
as =

the key in the hash table and frankly we should always be using that as it =
is =

unique for our purposes.

> +	GAtServerCommandType type;
> +	GAtServerNotifyFunc notify;
> +	gpointer user_data;
> +	GDestroyNotify destroy_notify;
> +};
> +
>  /* Basic command setting for V.250 */
>  struct v250_settings {
>  	char s3;			/* set by S3=3D<val> */
> @@ -99,6 +109,8 @@ struct _GAtServer {
>  	gpointer user_disconnect_data;		/* User disconnect data */
>  	GAtDebugFunc debugf;			/* Debugging output function */
>  	gpointer debug_data;			/* Data to pass to debug func */
> +	GHashTable *command_list;		/* List of supported at command */
> +	guint next_command_id;			/* Next command id */

Get rid of this part

>  	struct ring_buffer *read_buf;		/* Current read buffer */
>  	GQueue *write_queue;			/* Write buffer queue */
>  	guint max_read_attempts;		/* Max reads per select */
> @@ -714,6 +726,14 @@ static gboolean can_write_data(GIOChannel *channel,
>  GIOCondition cond, return FALSE;
>  }
> =

> +static void at_command_free(gpointer key, gpointer value, gpointer data)
> +{
> +	struct at_command *node =3D value;
> +
> +	g_free(node->prefix);
> +	g_free(node);
> +}
> +
>  static void write_queue_free(GQueue *write_queue)
>  {
>  	struct ring_buffer *write_buf;
> @@ -733,6 +753,11 @@ static void g_at_server_cleanup(GAtServer *server)
>  	/* Cleanup pending data to write */
>  	write_queue_free(server->write_queue);
> =

> +	/* Cleanup registered notifications */
> +	g_hash_table_foreach(server->command_list, at_command_free, NULL);

This is unnecessary if you properly initialize the hash table, see below.

> +	g_hash_table_destroy(server->command_list);
> +	server->command_list =3D NULL;
> +
>  	server->channel =3D NULL;
>  }
> =

> @@ -792,6 +817,7 @@ GAtServer *g_at_server_new(GIOChannel *io)
>  	server->ref_count =3D 1;
>  	v250_settings_create(&server->v250);
>  	server->channel =3D io;
> +	server->command_list =3D g_hash_table_new(g_str_hash, g_str_equal);

Use the _new_full version here and specify the destructor.

>  	server->read_buf =3D ring_buffer_new(BUF_SIZE);
>  	if (!server->read_buf)
>  		goto error;
> @@ -816,6 +842,9 @@ GAtServer *g_at_server_new(GIOChannel *io)
>  	return server;
> =

>  error:
> +	if (server->command_list)
> +		g_hash_table_destroy(server->command_list);
> +
>  	if (server->read_buf)
>  		ring_buffer_free(server->read_buf);
> =

> diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
> index 698f7e0..5db9321 100644
> --- a/gatchat/gatserver.h
> +++ b/gatchat/gatserver.h
> @@ -26,6 +26,7 @@
>  extern "C" {
>  #endif
> =

> +#include "gatresult.h"
>  #include "gatutil.h"
> =

>  struct _GAtServer;
> @@ -46,6 +47,26 @@ enum _GAtServerResult {
> =

>  typedef enum _GAtServerResult GAtServerResult;
> =

> +enum _GAtServerRequestType {
> +	G_AT_SERVER_REQUEST_TYPE_NONE,

> +	G_AT_SERVER_REQUEST_TYPE_ACTION,

What exactly does this one mean, how is it different from SET or NONE?

> +	G_AT_SERVER_REQUEST_TYPE_QUERY,
> +	G_AT_SERVER_REQUEST_TYPE_SET,
> +	G_AT_SERVER_REQUEST_TYPE_SUPPORT,
> +};
> +
> +typedef enum _GAtServerRequestType GAtServerRequestType;
> +
> +enum _GAtServerCommandType {
> +	G_AT_SERVER_COMMAND_TYPE_ACTION,
> +	G_AT_SERVER_COMMAND_TYPE_PARAMETER,

Again, what do these mean?  Might want to include a simple comment here.

> +};
> +
> +typedef enum _GAtServerCommandType GAtServerCommandType;
> +
> +typedef int (*GAtServerNotifyFunc)(GAtServerRequestType type, GAtResult
>  *result, +					gpointer user_data);
> +
>  GAtServer *g_at_server_new(GIOChannel *io);
> =

>  GAtServer *g_at_server_ref(GAtServer *server);
>=20

--===============5827091935008692571==--

