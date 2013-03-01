Content-Type: multipart/mixed; boundary="===============3571075008036149839=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [RFC 5/5] handsfree-audio: Implement alsa playback
Date: Fri, 01 Mar 2013 19:42:46 +0100
Message-ID: <1362163366-11027-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1362163366-11027-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3571075008036149839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/handsfree-audio.c |  273 +++++++++++++++++++++++++++++++++++++++----=
----
 1 file changed, 230 insertions(+), 43 deletions(-)

diff --git a/tools/handsfree-audio.c b/tools/handsfree-audio.c
index 88310aa..b5f05d3 100644
--- a/tools/handsfree-audio.c
+++ b/tools/handsfree-audio.c
@@ -30,10 +30,16 @@
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
+#include <sys/time.h>
 =

 #include <gdbus.h>
 #include <glib.h>
 =

+#include <alsa/asoundlib.h>
+#include <pthread.h>
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sco.h>
+
 #define OFONO_SERVICE			"org.ofono"
 #define HFP_AUDIO_MANAGER_PATH		"/"
 #define HFP_AUDIO_MANAGER_INTERFACE	OFONO_SERVICE ".HandsfreeAudioManager"
@@ -50,57 +56,226 @@
 /* DBus related */
 static GMainLoop *main_loop =3D NULL;
 static DBusConnection *conn;
-static GSList *hcons =3D NULL;
+static GSList *threads =3D NULL;
 =

 static gboolean option_nocvsd =3D FALSE;
 static gboolean option_nomsbc =3D FALSE;
 =

-struct hfp_audio_conn {
+enum {
+	THREAD_STATE_DEFERED,
+	THREAD_STATE_TRANSMIT
+};
+
+struct hfp_audio_thread {
+	int state;
 	unsigned char codec;
-	int watch;
+	int fd;
+	int running;
+	pthread_t thread;
 };
 =

-static void hfp_audio_conn_free(struct hfp_audio_conn *hcon)
+static snd_pcm_t *hfp_audio_pcm_init(snd_pcm_stream_t stream)
+{
+	snd_pcm_t *pcm;
+	DBG("Initializing pcm for %s", (stream =3D=3D SND_PCM_STREAM_CAPTURE) ?
+			"capture" : "playback");
+
+	if (snd_pcm_open(&pcm, "default", stream, SND_PCM_NONBLOCK) < 0) {
+		DBG("Failed to open pcm");
+		return NULL;
+	}
+
+	/* 8000 khz, 16 bits, 128000 bytes/s, 48 bytes/frame, 6000 fps */
+	if (snd_pcm_set_params(pcm, SND_PCM_FORMAT_S16_LE,
+					SND_PCM_ACCESS_RW_INTERLEAVED,
+					1, 8000, 1, 20000) < 0) {
+		DBG("Failed to set pcm params");
+		snd_pcm_close(pcm);
+		pcm =3D NULL;
+	}
+
+	return pcm;
+}
+
+static void hfp_audio_thread_free(struct hfp_audio_thread *hcon)
 {
 	DBG("Freeing audio connection %p", hcon);
+	if (!hcon)
+		return;
+
+	hcon->running =3D 0;
+	if (hcon->thread)
+		pthread_join(hcon->thread, NULL);
 =

-	hcons =3D g_slist_remove(hcons, hcon);
-	g_source_remove(hcon->watch);
+	threads =3D g_slist_remove(threads, hcon);
 	g_free(hcon);
+	DBG("freed %p", hcon);
 }
 =

-static gboolean hfp_audio_cb(GIOChannel *io, GIOCondition cond, gpointer d=
ata)
+/* Returns the number of data on sco socket */
+static int hfp_audio_playback(int fd, snd_pcm_t *playback)
 {
-	struct hfp_audio_conn *hcon =3D data;
-	gsize read;
-	gsize written;
-	char buf[60];
+	char buf[800];
+	snd_pcm_sframes_t frames;
+	int total, captured, written, bytes;
+
+	bytes =3D read(fd, buf, sizeof(buf));
+	if (bytes < 0) {
+		DBG("Failed to read: bytes %d, errno %d", bytes, errno);
+		switch (errno) {
+		case ENOTCONN:
+			return -ENOTCONN;
+		case EAGAIN:
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	}
 =

-	if (cond & (G_IO_HUP | G_IO_NVAL | G_IO_ERR))
-		goto fail;
+	frames =3D snd_pcm_writei(playback, buf, bytes / 2);
+	switch (frames) {
+	case -EPIPE:
+		DBG("Playback underrun");
+		snd_pcm_prepare(playback);
+		return bytes;
+	case -EAGAIN:
+		DBG("??? %d", bytes / 2);
+		return bytes;
+	case -EBADFD:
+	case -ESTRPIPE:
+		return -EINVAL;
+	}
 =

-	if (g_io_channel_read_chars(io, buf, sizeof(buf), &read, NULL) !=3D
-			G_IO_STATUS_NORMAL)
-		goto fail;
+	if (frames < bytes / 2)
+		DBG("played %d < requested %d", (int)frames, bytes / 2);
 =

-	g_io_channel_write_chars(io, buf+written, read, &written, NULL);
+	return bytes;
+}
 =

-	return TRUE;
+/* Returns the number of data on sco socket */
+static int hfp_audio_capture(int fd, snd_pcm_t *capture, GList **outq, int=
 mtu)
+{
+	snd_pcm_sframes_t frames;
+	int totalbytes, captured, written, bytes, tosend;
+	gchar *buf;
+
+	buf =3D g_try_malloc(mtu);
+	if (!buf)
+		return -ENOMEM;
+
+	frames =3D snd_pcm_readi(capture, buf, mtu / 2);
+	switch (frames) {
+	case -EPIPE:
+		DBG("Capture overrun");
+		snd_pcm_prepare(capture);
+		return 0;
+	case -EAGAIN:
+		DBG("No data to capture");
+		return 0;
+	case -EBADFD:
+	case -ESTRPIPE:
+		return -EINVAL;
+	}
 =

-fail:
-	DBG("Disconnected");
-	hfp_audio_conn_free(hcon);
-	return FALSE;
+	*outq =3D g_list_append(*outq, buf);
+
+	return frames * 2;
+}
+
+static void pop_outq(int fd, GList **outq, int qsize, int mtu)
+{
+	GList *el;
+
+	el =3D g_list_first(*outq);
+	if (!el)
+		return;
+
+	*outq =3D g_list_remove_link(*outq, el);
+	write(fd, el->data, mtu);
+
+	g_free(el->data);
+	g_list_free(el);
+}
+
+static void *thread_func(void *userdata)
+{
+	struct hfp_audio_thread *hcon =3D userdata;
+	snd_pcm_t *playback, *capture;
+	int in, totalread =3D 0;
+	int out, totalwrite =3D 0;
+	int total, captured, written, bytes;
+	GList *outq =3D NULL;
+	struct timeval t0, t1, t;
+	struct sco_options  opts;
+
+	/* Add SCO options
+	bytes =3D sizeof(opts);
+	if (getsockopt(hcon->fd, SOL_SCO, SCO_OPTIONS, &opts, &bytes) < 0) {
+		DBG("getsockopt failed");
+		return NULL;
+	}*/
+	opts.mtu =3D 48;
+
+	DBG("thread started mtu %d", opts.mtu);
+
+	playback =3D hfp_audio_pcm_init(SND_PCM_STREAM_PLAYBACK);
+	if (!playback)
+		return NULL;
+
+	capture =3D hfp_audio_pcm_init(SND_PCM_STREAM_CAPTURE);
+	if (!capture) {
+		snd_pcm_close(playback);
+		return NULL;
+	}
+
+	gettimeofday(&t0, NULL);
+	while (hcon->running) {
+		in =3D hfp_audio_playback(hcon->fd, playback);
+		if (hcon->state =3D=3D THREAD_STATE_DEFERED)
+			DBG("in %d", in);
+		if ((in =3D=3D 0 || in =3D=3D -ENOTCONN) &&
+				hcon->state =3D=3D THREAD_STATE_DEFERED)
+			goto schedule;
+		else if (in < 0)
+			break;
+		else if (in > 0)
+			hcon->state =3D THREAD_STATE_TRANSMIT;
+
+		out =3D hfp_audio_capture(hcon->fd, capture, &outq, opts.mtu);
+		if (out < 0)
+			break;
+
+		totalread +=3D in;
+		totalwrite +=3D out;
+
+		gettimeofday(&t1, NULL);
+		pop_outq(hcon->fd, &outq, 20, opts.mtu);
+
+		timersub(&t1, &t0, &t);
+		/* More than one second passed? */
+		if (t.tv_sec) {
+			DBG("total: read %d, write %d", totalread, totalwrite);
+			gettimeofday(&t0, NULL);
+		}
+schedule:
+		usleep(2000);
+	}
+
+	DBG("thread terminating");
+	snd_pcm_close(playback);
+	snd_pcm_close(capture);
+	return NULL;
 }
 =

 static DBusMessage *agent_newconnection(DBusConnection *conn, DBusMessage =
*msg,
 					void *data)
 {
 	const char *card;
-	int fd;
+	int fd, err;
 	unsigned char codec;
-	GIOChannel *io;
-	struct hfp_audio_conn *hcon;
+	struct hfp_audio_thread *hcon;
+	DBusMessage *reply;
+	pthread_attr_t attr;
 =

 	DBG("New connection");
 =

@@ -114,28 +289,45 @@ static DBusMessage *agent_newconnection(DBusConnectio=
n *conn, DBusMessage *msg,
 =

 	DBG("New connection: card=3D%s fd=3D%d codec=3D%d", card, fd, codec);
 =

-	io =3D g_io_channel_unix_new(fd);
-
-	hcon =3D g_try_malloc0(sizeof(struct hfp_audio_conn));
+	hcon =3D g_try_malloc0(sizeof(struct hfp_audio_thread));
 	if (hcon =3D=3D NULL)
-		return NULL;
+		goto fail;
 =

+	hcon->state =3D THREAD_STATE_DEFERED;
+	hcon->fd =3D fd;
 	hcon->codec =3D codec;
-	hcon->watch =3D g_io_add_watch(io, G_IO_IN, hfp_audio_cb, hcon);
-	hcons =3D g_slist_prepend(hcons, hcon);
 =

-	return dbus_message_new_method_return(msg);
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		goto fail;
+
+	hcon->running =3D 1;
+	if (pthread_create(&hcon->thread, NULL, thread_func, hcon) < 0)
+		goto fail;
+	/* FIXME thread is not joined until we quit */
+
+	threads =3D g_slist_prepend(threads, hcon);
+
+	return reply;
+
+fail:
+	hfp_audio_thread_free(hcon);
+	return g_dbus_create_error(msg,
+			HFP_AUDIO_AGENT_INTERFACE ".Failed", "Failed to start");
 }
 =

 static DBusMessage *agent_release(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
 	DBG("HFP audio agent released");
+	/* agent will be registered on next oFono startup */
 	return dbus_message_new_method_return(msg);
 }
 =

 static const GDBusMethodTable agent_methods[] =3D {
-	{ GDBUS_METHOD("NewConnection", NULL, NULL, agent_newconnection) },
+	{ GDBUS_METHOD("NewConnection",
+		GDBUS_ARGS({ "path", "o" }, { "fd", "h" }, { "codec", "y" }),
+		NULL, agent_newconnection) },
 	{ GDBUS_METHOD("Release", NULL, NULL, agent_release) },
 	{ },
 };
@@ -167,7 +359,7 @@ static void hfp_audio_agent_register(DBusConnection *co=
nn)
 	const unsigned char *pcodecs =3D codecs;
 	int ncodecs =3D 0;
 =

-	DBG("Registering audio agent");
+	DBG("Registering audio agent in oFono");
 =

 	msg =3D dbus_message_new_method_call(OFONO_SERVICE,
 						HFP_AUDIO_MANAGER_PATH,
@@ -196,11 +388,6 @@ static void hfp_audio_agent_register(DBusConnection *c=
onn)
 =

 	dbus_message_unref(msg);
 =

-	if (call =3D=3D NULL) {
-		DBG("Unable to register agent");
-		return;
-	}
-
 	dbus_pending_call_set_notify(call, hfp_audio_agent_register_reply,
 						NULL, NULL);
 =

@@ -209,7 +396,7 @@ static void hfp_audio_agent_register(DBusConnection *co=
nn)
 =

 static void hfp_audio_agent_create(DBusConnection *conn)
 {
-	DBG("Creating audio agent");
+	DBG("Registering audio agent on DBUS");
 =

 	if (!g_dbus_register_interface(conn, HFP_AUDIO_AGENT_PATH,
 					HFP_AUDIO_AGENT_INTERFACE,
@@ -222,7 +409,7 @@ static void hfp_audio_agent_create(DBusConnection *conn)
 =

 static void hfp_audio_agent_destroy(DBusConnection *conn)
 {
-	DBG("Destroying audio agent");
+	DBG("Unregistering audio agent on DBUS");
 =

 	g_dbus_unregister_interface(conn, HFP_AUDIO_AGENT_PATH,
 						HFP_AUDIO_AGENT_INTERFACE);
@@ -319,8 +506,8 @@ int main(int argc, char **argv)
 =

 	g_dbus_remove_watch(conn, watch);
 =

-	while (hcons !=3D NULL)
-		hfp_audio_conn_free(hcons->data);
+	while (threads !=3D NULL)
+		hfp_audio_thread_free(threads->data);
 =

 	hfp_audio_agent_destroy(conn);
 =

-- =

1.7.9.5


--===============3571075008036149839==--

