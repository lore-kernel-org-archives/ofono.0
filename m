Content-Type: multipart/mixed; boundary="===============8279314707059119740=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 5/9] handsfree-audio: Implement alsa playback
Date: Mon, 01 Apr 2013 11:19:38 -0500
Message-ID: <5159B39A.1000708@gmail.com>
In-Reply-To: <1364231795-13787-6-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8279314707059119740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

On 03/25/2013 12:16 PM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
> ---
>   tools/handsfree-audio.c |  472 ++++++++++++++++++++++++++++++++++++++++=
+------
>   1 file changed, 417 insertions(+), 55 deletions(-)
>
> diff --git a/tools/handsfree-audio.c b/tools/handsfree-audio.c
> index 88310aa..9a4f85b 100644
> --- a/tools/handsfree-audio.c
> +++ b/tools/handsfree-audio.c
> @@ -30,10 +30,17 @@
>   #include<stdlib.h>
>   #include<string.h>
>   #include<signal.h>
> +#include<sys/time.h>
> +#include<poll.h>
>
>   #include<gdbus.h>
>   #include<glib.h>
>
> +#include<alsa/asoundlib.h>
> +#include<pthread.h>
> +#include<bluetooth/bluetooth.h>
> +#include<bluetooth/sco.h>
> +
>   #define OFONO_SERVICE			"org.ofono"
>   #define HFP_AUDIO_MANAGER_PATH		"/"
>   #define HFP_AUDIO_MANAGER_INTERFACE	OFONO_SERVICE ".HandsfreeAudioManag=
er"
> @@ -50,47 +57,257 @@
>   /* DBus related */
>   static GMainLoop *main_loop =3D NULL;
>   static DBusConnection *conn;
> -static GSList *hcons =3D NULL;
> +static GSList *threads =3D NULL;
>
>   static gboolean option_nocvsd =3D FALSE;
>   static gboolean option_nomsbc =3D FALSE;
> +static gboolean option_server =3D FALSE;
> +static gboolean option_defer =3D FALSE;
> +static gchar *option_client_addr =3D NULL;
>
> -struct hfp_audio_conn {
> +struct hfp_audio_thread {
>   	unsigned char codec;
> -	int watch;
> +	int fd;
> +	int running;
> +	pthread_t thread;
>   };
>
> -static void hfp_audio_conn_free(struct hfp_audio_conn *hcon)
> +static int btstr2ba(const char *str, bdaddr_t *ba)
> +{
> +	int i;
> +
> +	for (i =3D 5; i>=3D 0; i--, str +=3D 3)
> +		ba->b[i] =3D strtol(str, NULL, 16);
> +
> +	return 0;
> +}
> +
> +static snd_pcm_t *hfp_audio_pcm_init(snd_pcm_stream_t stream)
> +{
> +	snd_pcm_t *pcm;
> +	DBG("Initializing pcm for %s", (stream =3D=3D SND_PCM_STREAM_CAPTURE) ?
> +			"capture" : "playback");
> +
> +	if (snd_pcm_open(&pcm, "default", stream, SND_PCM_NONBLOCK)<  0) {
> +		DBG("Failed to open pcm");
> +		return NULL;
> +	}
> +
> +	/* 8000 khz, 16 bits, 128000 bytes/s, 48 bytes/frame, 6000 fps */
> +	if (snd_pcm_set_params(pcm, SND_PCM_FORMAT_S16_LE,
> +					SND_PCM_ACCESS_RW_INTERLEAVED,
> +					1, 8000, 1, 20000)<  0) {
> +		DBG("Failed to set pcm params");
> +		snd_pcm_close(pcm);
> +		pcm =3D NULL;
> +	}
> +
> +	return pcm;
> +}
> +
> +static void hfp_audio_thread_free(struct hfp_audio_thread *hcon)
>   {
>   	DBG("Freeing audio connection %p", hcon);
> +	if (!hcon)
> +		return;
> +
> +	hcon->running =3D 0;
> +	if (hcon->thread)
> +		pthread_join(hcon->thread, NULL);
>
> -	hcons =3D g_slist_remove(hcons, hcon);
> -	g_source_remove(hcon->watch);
> +	threads =3D g_slist_remove(threads, hcon);
>   	g_free(hcon);
> +	DBG("freed %p", hcon);
>   }
>
> -static gboolean hfp_audio_cb(GIOChannel *io, GIOCondition cond, gpointer=
 data)
> +/* Returns the number of data on sco socket */
> +static int hfp_audio_playback(int fd, snd_pcm_t *playback)
>   {
> -	struct hfp_audio_conn *hcon =3D data;
> -	gsize read;
> -	gsize written;
> -	char buf[60];
> +	char buf[800];
> +	snd_pcm_sframes_t frames;
> +	int bytes;
> +
> +	bytes =3D read(fd, buf, sizeof(buf));
> +	if (bytes<  0) {
> +		DBG("Failed to read: bytes %d, errno %d", bytes, errno);
> +		switch (errno) {
> +		case ENOTCONN:
> +			return -ENOTCONN;
> +		case EAGAIN:
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
>
> -	if (cond&  (G_IO_HUP | G_IO_NVAL | G_IO_ERR))
> -		goto fail;
> +	frames =3D snd_pcm_writei(playback, buf, bytes / 2);
> +	switch (frames) {
> +	case -EPIPE:
> +		DBG("Playback underrun");
> +		snd_pcm_prepare(playback);
> +		return bytes;
> +	case -EAGAIN:
> +		DBG("??? %d", bytes / 2);
> +		return bytes;
> +	case -EBADFD:
> +	case -ESTRPIPE:
> +		return -EINVAL;
> +	}
>
> -	if (g_io_channel_read_chars(io, buf, sizeof(buf),&read, NULL) !=3D
> -			G_IO_STATUS_NORMAL)
> -		goto fail;
> +	if (frames<  bytes / 2)
> +		DBG("played %d<  requested %d", (int)frames, bytes / 2);
>
> -	g_io_channel_write_chars(io, buf+written, read,&written, NULL);
> +	return bytes;
> +}
>
> -	return TRUE;
> +/* Returns the number of data on sco socket */
> +static int hfp_audio_capture(int fd, snd_pcm_t *capture, GList **outq, i=
nt mtu)
> +{
> +	snd_pcm_sframes_t frames;
> +	gchar *buf;
> +
> +	buf =3D g_try_malloc(mtu);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	frames =3D snd_pcm_readi(capture, buf, mtu / 2);
> +	switch (frames) {
> +	case -EPIPE:
> +		DBG("Capture overrun");
> +		snd_pcm_prepare(capture);
> +		g_free(buf);
> +		return 0;
> +	case -EAGAIN:
> +		DBG("No data to capture");
> +		g_free(buf);
> +		return 0;
> +	case -EBADFD:
> +	case -ESTRPIPE:
> +		DBG("Other error");
> +		g_free(buf);
> +		return -EINVAL;
> +	}
> +
> +	if (frames<  mtu / 2)
> +		DBG("Small frame: %d", (int) frames);
> +
> +	if (g_list_length(*outq)>  32)
> +		DBG("Too many queued packets");
> +
> +	*outq =3D g_list_append(*outq, buf);
> +
> +	return frames * 2;
> +}
> +
> +static void pop_outq(int fd, GList **outq, int mtu)
> +{
> +	GList *el;
> +
> +	el =3D g_list_first(*outq);
> +	if (!el)
> +		return;
> +
> +	*outq =3D g_list_remove_link(*outq, el);
>
> +	if (write(fd, el->data, mtu)<  0)
> +		DBG("Failed to write: %d", errno);
> +
> +	g_free(el->data);
> +	g_list_free(el);
> +}
> +
> +static void *thread_func(void *userdata)
> +{
> +	struct hfp_audio_thread *hcon =3D userdata;
> +	snd_pcm_t *playback, *capture;
> +	GList *outq =3D NULL;
> +	struct sco_options  opts;
> +	struct pollfd fds[8];
> +
> +	DBG("thread started");
> +
> +	capture =3D hfp_audio_pcm_init(SND_PCM_STREAM_CAPTURE);
> +	if (!capture)
> +		return NULL;
> +
> +	playback =3D hfp_audio_pcm_init(SND_PCM_STREAM_PLAYBACK);
> +	if (!playback) {
> +		snd_pcm_close(capture);
> +		return NULL;
> +	}
> +
> +	/* Force defered setup */
> +	if (read(hcon->fd,&opts, sizeof(opts))<  0)
> +		DBG("Defered setup failed: %d (%s)", errno, strerror(errno));
> +
> +	/* Add SCO options
> +	len =3D sizeof(opts);
> +	if (getsockopt(hcon->fd, SOL_SCO, SCO_OPTIONS,&opts,&len)<  0) {
> +		DBG("getsockopt failed %d", errno);
> +		return NULL;
> +	}
> +	*/
> +	opts.mtu =3D 48;
> +	DBG("mtu %d", opts.mtu);
> +
> +	while (hcon->running) {
> +		/* Queue alsa captured data (snd_pcm_poll_descriptors failed) */
> +		if (hfp_audio_capture(hcon->fd, capture,&outq, opts.mtu)<  0) {
> +			DBG("Failed to capture");
> +			break;
> +		}
> +
> +		memset(fds, 0, sizeof(fds));
> +		fds[0].fd =3D hcon->fd;
> +		fds[0].events =3D POLLIN | POLLERR | POLLHUP | POLLNVAL;
> +		if (poll(fds, 1, 200) =3D=3D 0)
> +			continue;
> +
> +		if (fds[0].revents&  (POLLERR | POLLHUP | POLLNVAL)) {
> +			DBG("POLLERR | POLLHUP | POLLNVAL triggered");
> +			break;
> +		}
> +
> +		if (!fds[0].revents&  POLLIN)
> +			continue;
> +
> +		if (hfp_audio_playback(hcon->fd, playback)<  0) {
> +			DBG("POLLIN triggered, but read error");
> +			break;
> +		}
> +
> +		/* Dequeue in sync with readings */
> +		pop_outq(hcon->fd,&outq, opts.mtu);
> +	}
> +
> +	DBG("thread terminating");
> +	snd_pcm_close(playback);
> +	snd_pcm_close(capture);
> +	return NULL;
> +}
> +
> +static int new_connection(int fd, int codec)
> +{
> +	struct hfp_audio_thread *hcon;
> +	DBG("New connection: fd=3D%d codec=3D%d", fd, codec);
> +	hcon =3D g_try_malloc0(sizeof(struct hfp_audio_thread));
> +	if (hcon =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	hcon->fd =3D fd;
> +	hcon->codec =3D codec;
> +	hcon->running =3D 1;
> +
> +	if (pthread_create(&hcon->thread, NULL, thread_func, hcon)<  0)
> +		goto fail;
> +
> +	/* FIXME thread is not detached until we quit */
> +
> +	threads =3D g_slist_prepend(threads, hcon);
> +	return 0;
>   fail:
> -	DBG("Disconnected");
> -	hfp_audio_conn_free(hcon);
> -	return FALSE;
> +	hfp_audio_thread_free(hcon);
> +	return -EINVAL;
>   }
>
>   static DBusMessage *agent_newconnection(DBusConnection *conn, DBusMessa=
ge *msg,
> @@ -99,8 +316,7 @@ static DBusMessage *agent_newconnection(DBusConnection=
 *conn, DBusMessage *msg,
>   	const char *card;
>   	int fd;
>   	unsigned char codec;
> -	GIOChannel *io;
> -	struct hfp_audio_conn *hcon;
> +	DBusMessage *reply;
>
>   	DBG("New connection");
>
> @@ -112,30 +328,34 @@ static DBusMessage *agent_newconnection(DBusConnect=
ion *conn, DBusMessage *msg,
>   				HFP_AUDIO_AGENT_INTERFACE ".InvalidArguments",
>   				"Invalid arguments");
>
> -	DBG("New connection: card=3D%s fd=3D%d codec=3D%d", card, fd, codec);
> +	reply =3D dbus_message_new_method_return(msg);
> +	if (!reply)
> +		goto fail;
>
> -	io =3D g_io_channel_unix_new(fd);
> +	if (new_connection(fd, codec)>=3D 0)
> +		return reply;
>
> -	hcon =3D g_try_malloc0(sizeof(struct hfp_audio_conn));
> -	if (hcon =3D=3D NULL)
> -		return NULL;
> +	dbus_message_unref(reply);
>
> -	hcon->codec =3D codec;
> -	hcon->watch =3D g_io_add_watch(io, G_IO_IN, hfp_audio_cb, hcon);
> -	hcons =3D g_slist_prepend(hcons, hcon);
> +fail:
> +	close(fd);
>
> -	return dbus_message_new_method_return(msg);
> +	return g_dbus_create_error(msg,
> +			HFP_AUDIO_AGENT_INTERFACE ".Failed", "Failed to start");
>   }
>
>   static DBusMessage *agent_release(DBusConnection *conn, DBusMessage *ms=
g,
>   					void *data)
>   {
>   	DBG("HFP audio agent released");
> +	/* agent will be registered on next oFono startup */
>   	return dbus_message_new_method_return(msg);
>   }
>
>   static const GDBusMethodTable agent_methods[] =3D {
> -	{ GDBUS_METHOD("NewConnection", NULL, NULL, agent_newconnection) },
> +	{ GDBUS_METHOD("NewConnection",
> +		GDBUS_ARGS({ "path", "o" }, { "fd", "h" }, { "codec", "y" }),
> +		NULL, agent_newconnection) },
>   	{ GDBUS_METHOD("Release", NULL, NULL, agent_release) },
>   	{ },
>   };
> @@ -167,7 +387,7 @@ static void hfp_audio_agent_register(DBusConnection *=
conn)
>   	const unsigned char *pcodecs =3D codecs;
>   	int ncodecs =3D 0;
>
> -	DBG("Registering audio agent");
> +	DBG("Registering audio agent in oFono");
>
>   	msg =3D dbus_message_new_method_call(OFONO_SERVICE,
>   						HFP_AUDIO_MANAGER_PATH,
> @@ -196,20 +416,147 @@ static void hfp_audio_agent_register(DBusConnectio=
n *conn)
>
>   	dbus_message_unref(msg);
>
> -	if (call =3D=3D NULL) {
> -		DBG("Unable to register agent");
> -		return;
> -	}
> -
>   	dbus_pending_call_set_notify(call, hfp_audio_agent_register_reply,
>   						NULL, NULL);
>
>   	dbus_pending_call_unref(call);
>   }
>
> +static gboolean sco_accept_cb(GIOChannel *io, GIOCondition cond, gpointe=
r data)
> +{
> +	struct sockaddr_sco addr;
> +	socklen_t optlen;
> +	int sk, nsk;
> +
> +	if (cond&  (G_IO_HUP | G_IO_NVAL | G_IO_ERR))
> +		goto fail;
> +
> +	DBG("Incoming connection");
> +	sk =3D g_io_channel_unix_get_fd(io);
> +	nsk =3D accept(sk, (struct sockaddr *)&addr,&optlen);
> +
> +	if (nsk>  0)
> +		new_connection(nsk, HFP_AUDIO_CVSD);
> +
> +	return TRUE;
> +
> +fail:
> +	DBG("Server disconnected");
> +	return FALSE;
> +}

I'm lost, why do we need this part?

> +
> +static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond, gpoint=
er data)
> +{
> +	int sk;
> +
> +	if (cond&  (G_IO_HUP | G_IO_NVAL | G_IO_ERR))
> +		goto fail;
> +
> +	DBG("Connected");
> +	sk =3D g_io_channel_unix_get_fd(io);
> +	if (sk>  0)
> +		new_connection(sk, HFP_AUDIO_CVSD);
> +
> +	return FALSE;
> +
> +fail:
> +	DBG("Connection failed");
> +	return FALSE;
> +}

Or this part?

> +
> +static int sco_listen_watch()
> +{
> +	struct sockaddr_sco saddr;
> +	int sk;
> +	GIOChannel *io;
> +
> +	/* Create socket */
> +	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
> +	if (sk<  0) {
> +		DBG("Can't create socket: %s (%d)", strerror(errno), errno);
> +		return -1;
> +	}
> +
> +	/* Bind to local address */
> +	memset(&saddr, 0, sizeof(saddr));
> +	saddr.sco_family =3D AF_BLUETOOTH;
> +
> +	if (bind(sk, (struct sockaddr *)&saddr, sizeof(saddr))<  0) {
> +		DBG("Can't bind socket: %s (%d)", strerror(errno), errno);
> +		goto error;
> +	}
> +
> +	/* Enable deferred setup */
> +	if (option_defer&&  setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
> +				&option_defer, sizeof(option_defer))<  0) {
> +		DBG("Can't defer setup : %s (%d)", strerror(errno), errno);
> +		goto error;
> +	}
> +
> +	/* Listen for connections */
> +	if (listen(sk, 10)) {
> +		DBG("Can not listen socket: %s (%d)", strerror(errno), errno);
> +		goto error;
> +	}
> +
> +	DBG("Waiting for connection ...");
> +	io =3D g_io_channel_unix_new(sk);
> +	if (!io)
> +		goto error;
> +
> +	return g_io_add_watch(io, G_IO_IN, sco_accept_cb, NULL);
> +
> +error:
> +	close(sk);
> +	return -1;
> +}

Or this part?

> +
> +static int sco_connect_watch()
> +{
> +	struct sockaddr_sco saddr;
> +	int sk;
> +	GIOChannel *io;
> +
> +	/* Create socket */
> +	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
> +	if (sk<  0) {
> +		DBG("Can't create socket: %s (%d)", strerror(errno), errno);
> +		return -1;
> +	}
> +
> +	/* Bind to local address */
> +	memset(&saddr, 0, sizeof(saddr));
> +	saddr.sco_family =3D AF_BLUETOOTH;
> +
> +	if (bind(sk, (struct sockaddr *)&saddr, sizeof(saddr))<  0) {
> +		DBG("Can't bind socket: %s (%d)", strerror(errno), errno);
> +		goto error;
> +	}
> +
> +	/* Connect to remote address */
> +	memset(&saddr, 0, sizeof(saddr));
> +	saddr.sco_family =3D AF_BLUETOOTH;
> +	btstr2ba(option_client_addr,&saddr.sco_bdaddr);
> +	if (connect(sk, (struct sockaddr *)&saddr, sizeof(saddr))) {
> +		DBG("Can not connect socket: %s (%d)", strerror(errno), errno);
> +		goto error;
> +	}
> +
> +	DBG("Connecting to %s...", option_client_addr);
> +	io =3D g_io_channel_unix_new(sk);
> +	if (!io)
> +		goto error;
> +
> +	return g_io_add_watch(io, G_IO_IN|G_IO_OUT, sco_connect_cb, NULL);
> +
> +error:
> +	close(sk);
> +	return -1;
> +}
> +

Or this?  Sounds like these belong in BlueZ, not oFono.

>   static void hfp_audio_agent_create(DBusConnection *conn)
>   {
> -	DBG("Creating audio agent");
> +	DBG("Registering audio agent on DBUS");
>
>   	if (!g_dbus_register_interface(conn, HFP_AUDIO_AGENT_PATH,
>   					HFP_AUDIO_AGENT_INTERFACE,
> @@ -222,7 +569,7 @@ static void hfp_audio_agent_create(DBusConnection *co=
nn)
>
>   static void hfp_audio_agent_destroy(DBusConnection *conn)
>   {
> -	DBG("Destroying audio agent");
> +	DBG("Unregistering audio agent on DBUS");
>
>   	g_dbus_unregister_interface(conn, HFP_AUDIO_AGENT_PATH,
>   						HFP_AUDIO_AGENT_INTERFACE);
> @@ -259,6 +606,12 @@ static GOptionEntry options[] =3D {
>   				"Disable CVSD support" },
>   	{ "nomsbc", 'm', 0, G_OPTION_ARG_NONE,&option_nomsbc,
>   				"Disable MSBC support" },
> +	{ "defer", 'd', 0, G_OPTION_ARG_NONE,&option_defer,
> +				"Defered socket support" },
> +	{ "server", 'S', 0, G_OPTION_ARG_NONE,&option_server,
> +				"Server" },
> +	{ "client", 'C', 1, G_OPTION_ARG_STRING,&option_client_addr,
> +				"Client addr" },
>   	{ NULL },
>   };
>
> @@ -293,6 +646,11 @@ int main(int argc, char **argv)
>
>   	dbus_error_init(&err);
>
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_handler =3D sig_term;
> +	sigaction(SIGINT,&sa, NULL);
> +	sigaction(SIGTERM,&sa, NULL);
> +
>   	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL,&err);
>   	if (conn =3D=3D NULL) {
>   		if (dbus_error_is_set(&err) =3D=3D TRUE) {
> @@ -305,24 +663,28 @@ int main(int argc, char **argv)
>
>   	g_dbus_set_disconnect_function(conn, disconnect_callback, NULL, NULL);
>
> -	memset(&sa, 0, sizeof(sa));
> -	sa.sa_handler =3D sig_term;
> -	sigaction(SIGINT,&sa, NULL);
> -	sigaction(SIGTERM,&sa, NULL);
> -
> -	hfp_audio_agent_create(conn);
> -
> -	watch =3D g_dbus_add_service_watch(conn, OFONO_SERVICE,
> +	if (option_server) {
> +		watch =3D sco_listen_watch();
> +	} else if (option_client_addr !=3D NULL) {
> +		watch =3D sco_connect_watch();
> +	} else {
> +		hfp_audio_agent_create(conn);
> +		watch =3D g_dbus_add_service_watch(conn, OFONO_SERVICE,
>   				ofono_connect, ofono_disconnect, NULL, NULL);
> -
> +	}
>   	g_main_loop_run(main_loop);
>
> -	g_dbus_remove_watch(conn, watch);
> -
> -	while (hcons !=3D NULL)
> -		hfp_audio_conn_free(hcons->data);
> +	while (threads !=3D NULL)
> +		hfp_audio_thread_free(threads->data);
>
> -	hfp_audio_agent_destroy(conn);
> +	if (option_server) {
> +		g_source_remove(watch);
> +	} else if (option_client_addr !=3D NULL) {
> +		g_source_remove(watch);
> +	} else {
> +		g_dbus_remove_watch(conn, watch);
> +		hfp_audio_agent_destroy(conn);
> +	}
>
>   	dbus_connection_unref(conn);
>

Regards,
-Denis

--===============8279314707059119740==--

