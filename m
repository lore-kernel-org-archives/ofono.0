Content-Type: multipart/mixed; boundary="===============3721552123388554612=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [RFC v3 8/8] handsfree-audio: mSBC support
Date: Tue, 12 Mar 2013 19:00:48 +0100
Message-ID: <1363111248-1694-9-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1363111248-1694-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3721552123388554612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/handsfree-audio.c |  513 ++++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 396 insertions(+), 117 deletions(-)

diff --git a/tools/handsfree-audio.c b/tools/handsfree-audio.c
index a0cb380..ec7b730 100644
--- a/tools/handsfree-audio.c
+++ b/tools/handsfree-audio.c
@@ -40,6 +40,7 @@
 #include <pthread.h>
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sco.h>
+#include <sbc/sbc.h>
 =

 #define OFONO_SERVICE			"org.ofono"
 #define HFP_AUDIO_MANAGER_PATH		"/"
@@ -65,11 +66,45 @@ static gboolean option_server =3D FALSE;
 static gboolean option_defer =3D FALSE;
 static gchar *option_client_addr =3D NULL;
 =

-struct hfp_audio_thread {
-	unsigned char codec;
+static const char sntable[4] =3D { 0x08, 0x38, 0xC8, 0xF8 };
+static const int audio_rates[3] =3D { 0, 8000, 16000 };
+
+struct msbc_parser {
+	int len;
+	uint8_t buffer[60];
+};
+
+struct msbc_codec {
+	sbc_t sbcenc; /* Coder data */
+	char *ebuffer; /* Codec transfer buffer */
+	size_t ebuffer_size; /* Size of the buffer */
+	size_t ebuffer_start; /* start of encoding data */
+	size_t ebuffer_end; /* end of encoding data */
+
+	struct msbc_parser parser; /* mSBC parser for concatenating frames */
+	sbc_t sbcdec; /* Decoder data */
+
+	size_t msbc_frame_size;
+	size_t decoded_frame_size;
+};
+
+struct hfp_thread {
 	int fd;
 	int running;
 	pthread_t thread;
+	GSList *outq;
+
+	int rate;
+	char *capture_buffer;
+	int capture_size;
+	int captured;
+	int mtu;
+	int (*init)(struct hfp_thread *);
+	int (*free)(struct hfp_thread *);
+	int (*encode)(struct hfp_thread *, char *data, int len);
+	int (*decode)(struct hfp_thread *, char *data, int len, char *out,
+								int outlen);
+	struct msbc_codec msbc;
 };
 =

 static int btstr2ba(const char *str, bdaddr_t *ba)
@@ -82,21 +117,237 @@ static int btstr2ba(const char *str, bdaddr_t *ba)
 	return 0;
 }
 =

-static snd_pcm_t *hfp_audio_pcm_init(snd_pcm_stream_t stream)
+static void msbc_parser_reset(struct msbc_parser *p)
+{
+	p->len =3D 0;
+}
+
+static int msbc_state_machine(struct msbc_parser *p, uint8_t byte)
+{
+	switch (p->len) {
+	case 0:
+		if (byte =3D=3D 0x01)
+			goto copy;
+		return 0;
+	case 1:
+		if (byte =3D=3D 0x08 || byte =3D=3D 0x38 || byte =3D=3D 0xC8
+				|| byte =3D=3D 0xF8)
+			goto copy;
+		break;
+	case 2:
+		if (byte =3D=3D 0xAD)
+			goto copy;
+		break;
+	case 3:
+		if (byte =3D=3D 0x00)
+			goto copy;
+		break;
+	case 4:
+		if (byte =3D=3D 0x00)
+			goto copy;
+		break;
+	default:
+		goto copy;
+	}
+
+	p->len =3D 0;
+	return 0;
+
+copy:
+	p->buffer[p->len] =3D byte;
+	p->len++;
+
+	return p->len;
+}
+
+static size_t msbc_parse(sbc_t *sbcdec, struct msbc_parser *p, char *data,
+		int len, char *out, int outlen, int *bytes)
+{
+	size_t totalwritten =3D 0;
+	size_t written =3D 0;
+	int i;
+	*bytes =3D 0;
+
+	for (i =3D 0; i < len; i++) {
+		if (msbc_state_machine(p, data[i]) =3D=3D 60) {
+			int decoded;
+			decoded =3D sbc_decode(sbcdec, p->buffer + 2,
+					p->len - 2 - 1, out, outlen, &written);
+			if (decoded > 0) {
+				totalwritten +=3D written;
+				*bytes +=3D decoded;
+			} else {
+				DBG("Error while decoding: %d", decoded);
+			}
+			msbc_parser_reset(p);
+		}
+	}
+	return totalwritten;
+}
+
+struct hack_sco_options {
+	uint16_t mtu;
+	uint8_t mode;
+};
+
+static int hfp_audio_cvsd_init(struct hfp_thread *thread)
+{
+	thread->rate =3D 8000;
+	thread->capture_size =3D 48;
+	return 0;
+}
+
+static int hfp_audio_cvsd_free(struct hfp_thread *thread)
+{
+	return 0;
+}
+
+static int hfp_audio_cvsd_encode(struct hfp_thread *thread, char *data,
+						int len)
+{
+	char *qbuf;
+
+	if (len > thread->mtu) {
+		DBG("Mtu too small: len %d, mtu %d", len, thread->mtu);
+		return -EINVAL;
+	}
+
+	qbuf =3D g_try_malloc(thread->mtu);
+	if (!qbuf)
+		return -ENOMEM;
+
+	memcpy(qbuf, data, len);
+
+	thread->outq =3D g_slist_insert(thread->outq, qbuf, -1);
+
+	return len;
+}
+
+static int hfp_audio_cvsd_decode(struct hfp_thread *thread, char *data,
+						int len, char *out, int outlen)
+{
+	int size =3D (len < outlen) ? len : outlen;
+	memcpy(out, data, size);
+	return size;
+}
+
+/* Run from IO thread */
+static int hfp_audio_msbc_init(struct hfp_thread *thread)
+{
+	struct msbc_codec *codec =3D &thread->msbc;
+	struct hack_sco_options opts;
+
+	thread->rate =3D 16000;
+	thread->capture_size =3D 240; /* decoded mSBC frame */
+
+	memset(&opts, 0, sizeof(opts));
+	opts.mode =3D 1;
+	if (setsockopt(thread->fd, SOL_SCO, SCO_OPTIONS, &opts, sizeof(opts))
+			< 0) {
+		DBG("Can't set transparent mode: %s (%d)",
+				strerror(errno), errno);
+		return -ENOTSUP;
+	}
+
+	sbc_init_msbc(&codec->sbcenc, 0);
+	sbc_init_msbc(&codec->sbcdec, 0);
+
+	codec->msbc_frame_size =3D 2 + sbc_get_frame_length(&codec->sbcenc) + 1;
+	codec->decoded_frame_size =3D sbc_get_codesize(&codec->sbcenc);
+	msbc_parser_reset(&codec->parser);
+
+	/* 5 * 48 =3D=3D 10 * 24 =3D=3D 4 * 60 */
+	codec->ebuffer_size =3D codec->msbc_frame_size * 4;
+	codec->ebuffer =3D g_try_malloc(codec->ebuffer_size);
+	codec->ebuffer_start =3D 0;
+	codec->ebuffer_end =3D 0;
+
+	DBG("codec->msbc_frame_size %d", (int) codec->msbc_frame_size);
+	DBG("codec->ebuffer_size %d", (int) codec->ebuffer_size);
+	DBG("codec->decoded_frame_size %d", (int) codec->decoded_frame_size);
+	return 0;
+}
+
+/* Run from IO thread */
+static int hfp_audio_msbc_free(struct hfp_thread *thread)
+{
+	struct msbc_codec *codec =3D &thread->msbc;
+
+	g_free(codec->ebuffer);
+	sbc_finish(&codec->sbcenc);
+	sbc_finish(&codec->sbcdec);
+
+	return 0;
+}
+
+/* Run from IO thread */
+static int hfp_audio_msbc_encode(struct hfp_thread *thread, char *data, in=
t len)
+{
+	struct msbc_codec *codec =3D &thread->msbc;
+	char *h2 =3D codec->ebuffer + codec->ebuffer_end;
+	static int sn =3D 0;
+	int written =3D 0;
+	char *qbuf;
+
+	h2[0] =3D 0x01;
+	h2[1] =3D sntable[sn];
+	h2[59] =3D 0xff;
+	sn =3D (sn + 1) % 4;
+
+	sbc_encode(&codec->sbcenc, data, len,
+			codec->ebuffer + codec->ebuffer_end + 2,
+			codec->ebuffer_size - codec->ebuffer_end - 2,
+			(ssize_t *) &written);
+
+	written +=3D 2 /* H2 */ + 1 /* 0xff */;
+	codec->ebuffer_end +=3D written;
+
+	/* Split into MTU sized chunks */
+	while (codec->ebuffer_start + thread->mtu <=3D codec->ebuffer_end) {
+		qbuf =3D g_try_malloc(thread->mtu);
+		if (!qbuf)
+			return -ENOMEM;
+
+		/* DBG("Enqueuing %d bytes", thread->mtu); */
+		memcpy(qbuf, codec->ebuffer + codec->ebuffer_start, thread->mtu);
+
+		thread->outq =3D g_slist_insert(thread->outq, qbuf, -1);
+
+		codec->ebuffer_start +=3D thread->mtu;
+		if (codec->ebuffer_start >=3D codec->ebuffer_end)
+			codec->ebuffer_start =3D codec->ebuffer_end =3D 0;
+	}
+
+	return 0;
+}
+
+/* Run from IO thread */
+static int hfp_audio_msbc_decode(struct hfp_thread *thread, char *data,
+						int len, char *out, int outlen)
+{
+	struct msbc_codec *codec =3D &thread->msbc;
+	int written, decoded;
+
+	written =3D msbc_parse(&codec->sbcdec, &codec->parser, data, len, out,
+			outlen, &decoded);
+
+	return written;
+}
+
+static snd_pcm_t *hfp_audio_pcm_init(snd_pcm_stream_t stream, int rate)
 {
 	snd_pcm_t *pcm;
 	DBG("Initializing pcm for %s", (stream =3D=3D SND_PCM_STREAM_CAPTURE) ?
-			"capture" : "playback");
+							"capture" : "playback");
 =

 	if (snd_pcm_open(&pcm, "default", stream, SND_PCM_NONBLOCK) < 0) {
 		DBG("Failed to open pcm");
 		return NULL;
 	}
 =

-	/* 8000 khz, 16 bits, 128000 bytes/s, 48 bytes/frame, 6000 fps */
+	/* 16 bits */
 	if (snd_pcm_set_params(pcm, SND_PCM_FORMAT_S16_LE,
-					SND_PCM_ACCESS_RW_INTERLEAVED,
-					1, 8000, 1, 20000) < 0) {
+			SND_PCM_ACCESS_RW_INTERLEAVED, 1, rate, 1, 20000) < 0) {
 		DBG("Failed to set pcm params");
 		snd_pcm_close(pcm);
 		pcm =3D NULL;
@@ -105,29 +356,35 @@ static snd_pcm_t *hfp_audio_pcm_init(snd_pcm_stream_t=
 stream)
 	return pcm;
 }
 =

-static void hfp_audio_thread_free(struct hfp_audio_thread *hcon)
+static void hfp_audio_thread_free(struct hfp_thread *thread)
 {
-	DBG("Freeing audio connection %p", hcon);
-	if (!hcon)
+	DBG("Freeing audio connection %p", thread);
+	if (!thread)
 		return;
 =

-	hcon->running =3D 0;
-	if (hcon->thread)
-		pthread_join(hcon->thread, NULL);
+	thread->running =3D 0;
+	if (thread->thread)
+		pthread_join(thread->thread, NULL);
 =

-	threads =3D g_slist_remove(threads, hcon);
-	g_free(hcon);
-	DBG("freed %p", hcon);
+	if (shutdown(thread->fd, SHUT_RDWR) < 0)
+			DBG("Failed to shutdown socket");
+	if (close(thread->fd) < 0)
+		DBG("Failed to close socket");
+
+	threads =3D g_slist_remove(threads, thread);
+	g_free(thread);
+	DBG("freed %p", thread);
 }
 =

 /* Returns the number of data on sco socket */
-static int hfp_audio_playback(int fd, snd_pcm_t *playback)
+static int hfp_audio_playback(struct hfp_thread *thread,
+		snd_pcm_t *playback)
 {
-	char buf[800];
+	char buf[512], out[512];
+	int bytes, outlen;
 	snd_pcm_sframes_t frames;
-	int bytes;
 =

-	bytes =3D read(fd, buf, sizeof(buf));
+	bytes =3D read(thread->fd, buf, sizeof(buf));
 	if (bytes < 0) {
 		DBG("Failed to read: bytes %d, errno %d", bytes, errno);
 		switch (errno) {
@@ -140,178 +397,201 @@ static int hfp_audio_playback(int fd, snd_pcm_t *pl=
ayback)
 		}
 	}
 =

-	frames =3D snd_pcm_writei(playback, buf, bytes / 2);
+	/* DBG("received %d bytes", bytes); */
+	outlen =3D thread->decode(thread, buf, bytes, out, sizeof(out));
+
+	frames =3D snd_pcm_writei(playback, out, outlen / 2);
 	switch (frames) {
 	case -EPIPE:
-		DBG("Playback underrun");
 		snd_pcm_prepare(playback);
 		return bytes;
 	case -EAGAIN:
-		DBG("??? %d", bytes / 2);
 		return bytes;
 	case -EBADFD:
 	case -ESTRPIPE:
 		return -EINVAL;
 	}
 =

-	if (frames < bytes / 2)
-		DBG("played %d < requested %d", (int)frames, bytes / 2);
+	/* if (frames < outlen / 2)
+		DBG("played %d < requested %d", (int)frames, outlen / 2); */
 =

 	return bytes;
 }
 =

 /* Returns the number of data on sco socket */
-static int hfp_audio_capture(int fd, snd_pcm_t *capture, GList **outq, int=
 mtu)
+static int hfp_audio_capture(struct hfp_thread *thread, snd_pcm_t *capture)
 {
 	snd_pcm_sframes_t frames;
-	gchar *buf;
-
-	buf =3D g_try_malloc(mtu);
-	if (!buf)
-		return -ENOMEM;
 =

-	frames =3D snd_pcm_readi(capture, buf, mtu / 2);
+	frames =3D snd_pcm_readi(capture, thread->capture_buffer+thread->captured,
+				(thread->capture_size - thread->captured) / 2);
 	switch (frames) {
 	case -EPIPE:
-		DBG("Capture overrun");
 		snd_pcm_prepare(capture);
-		g_free(buf);
 		return 0;
 	case -EAGAIN:
-		DBG("No data to capture");
-		g_free(buf);
 		return 0;
 	case -EBADFD:
 	case -ESTRPIPE:
-		DBG("Other error");
-		g_free(buf);
+		DBG("Other error %s (%d)", strerror(frames), (int) frames);
 		return -EINVAL;
 	}
 =

-	if (frames < mtu / 2)
-		DBG("Small frame: %d", (int) frames);
+	thread->captured +=3D frames * 2;
+	if (thread->captured < thread->capture_size)
+		return frames * 2;
 =

-	if (g_list_length(*outq) > 32)
-		DBG("Too many queued packets");
-
-	*outq =3D g_list_append(*outq, buf);
+	/* DBG("Encoding %d bytes", (int) thread->captured); */
+	thread->encode(thread, thread->capture_buffer, thread->captured);
+	thread->captured =3D 0;
 =

 	return frames * 2;
 }
 =

-static void pop_outq(int fd, GList **outq, int mtu)
+static void pop_outq(struct hfp_thread *thread)
 {
-	GList *el;
-
-	el =3D g_list_first(*outq);
-	if (!el)
-		return;
+	char *qbuf;
 =

-	*outq =3D g_list_remove_link(*outq, el);
+	while (thread->outq !=3D NULL) {
+		qbuf =3D thread->outq->data;
+		thread->outq =3D g_slist_remove(thread->outq, qbuf);
 =

-	if (write(fd, el->data, mtu) < 0)
-		DBG("Failed to write: %d", errno);
+		if (write(thread->fd, qbuf, thread->mtu) < 0)
+			DBG("Failed to write: %d", errno);
 =

-	g_free(el->data);
-	g_list_free(el);
+		g_free(qbuf);
+	}
 }
 =

 static void *thread_func(void *userdata)
 {
-	struct hfp_audio_thread *hcon =3D userdata;
+	struct hfp_thread *thread =3D userdata;
 	snd_pcm_t *playback, *capture;
-	GList *outq =3D NULL;
-	struct sco_options  opts;
+	struct sco_options opts;
 	struct pollfd fds[8];
 =

-	DBG("thread started");
+	DBG("thread started: rate %d", thread->rate);
+
+	if (thread->init(thread) < 0)
+		return NULL;
 =

-	capture =3D hfp_audio_pcm_init(SND_PCM_STREAM_CAPTURE);
+	capture =3D hfp_audio_pcm_init(SND_PCM_STREAM_CAPTURE, thread->rate);
 	if (!capture)
 		return NULL;
 =

-	playback =3D hfp_audio_pcm_init(SND_PCM_STREAM_PLAYBACK);
+	playback =3D hfp_audio_pcm_init(SND_PCM_STREAM_PLAYBACK, thread->rate);
 	if (!playback) {
 		snd_pcm_close(capture);
 		return NULL;
 	}
 =

+	thread->capture_buffer =3D g_try_malloc(thread->capture_size);
+	if (!thread->capture_buffer) {
+		snd_pcm_close(capture);
+		snd_pcm_close(playback);
+		return NULL;
+	}
+
 	/* Force defered setup */
-	if (read(hcon->fd, &opts, sizeof(opts)) < 0)
+	if (recv(thread->fd, NULL, 0, 0) < 0)
 		DBG("Defered setup failed: %d (%s)", errno, strerror(errno));
 =

 	/* Add SCO options
-	len =3D sizeof(opts);
-	if (getsockopt(hcon->fd, SOL_SCO, SCO_OPTIONS, &opts, &len) < 0) {
-		DBG("getsockopt failed %d", errno);
-		return NULL;
-	}
-	*/
+	 len =3D sizeof(opts);
+	 if (getsockopt(thread->fd, SOL_SCO, SCO_OPTIONS, &opts, &len) < 0) {
+	 DBG("getsockopt failed %d", errno);
+	 return NULL;
+	 }
+	 */
 	opts.mtu =3D 48;
-	DBG("mtu %d", opts.mtu);
+	thread->mtu =3D opts.mtu;
+	DBG("thread->mtu %d", thread->mtu);
 =

-	while (hcon->running) {
+	while (thread->running) {
 		/* Queue alsa captured data (snd_pcm_poll_descriptors failed) */
-		if (hfp_audio_capture(hcon->fd, capture, &outq, opts.mtu) < 0) {
+		if (hfp_audio_capture(thread, capture) < 0) {
 			DBG("Failed to capture");
 			break;
 		}
 =

 		memset(fds, 0, sizeof(fds));
-		fds[0].fd =3D hcon->fd;
+		fds[0].fd =3D thread->fd;
 		fds[0].events =3D POLLIN | POLLERR | POLLHUP | POLLNVAL;
 		if (poll(fds, 1, 200) =3D=3D 0)
 			continue;
 =

 		if (fds[0].revents & (POLLERR | POLLHUP | POLLNVAL)) {
-			DBG("POLLERR | POLLHUP | POLLNVAL triggered");
+			DBG("POLLERR | POLLHUP | POLLNVAL triggered (%d)",
+					fds[0].revents);
 			break;
 		}
 =

 		if (!fds[0].revents & POLLIN)
 			continue;
 =

-		if (hfp_audio_playback(hcon->fd, playback) < 0) {
+		if (hfp_audio_playback(thread, playback) < 0) {
 			DBG("POLLIN triggered, but read error");
 			break;
 		}
 =

+		/* DBG("Received and send"); */
+
 		/* Dequeue in sync with readings */
-		pop_outq(hcon->fd, &outq, opts.mtu);
+		pop_outq(thread);
 	}
 =

 	DBG("thread terminating");
+	g_slist_free_full(thread->outq, g_free);
+	g_free(thread->capture_buffer);
 	snd_pcm_close(playback);
 	snd_pcm_close(capture);
+
+	thread->free(thread);
+
 	return NULL;
 }
 =

 static int new_connection(int fd, int codec)
 {
-	struct hfp_audio_thread *hcon;
+	struct hfp_thread *thread;
+
 	DBG("New connection: fd=3D%d codec=3D%d", fd, codec);
-	hcon =3D g_try_malloc0(sizeof(struct hfp_audio_thread));
-	if (hcon =3D=3D NULL)
+	thread =3D g_try_malloc0(sizeof(struct hfp_thread));
+	if (thread =3D=3D NULL)
 		return -ENOMEM;
 =

-	hcon->fd =3D fd;
-	hcon->codec =3D codec;
-	hcon->running =3D 1;
+	thread->fd =3D fd;
+	thread->running =3D 1;
+
+	switch (codec) {
+	case HFP_AUDIO_CVSD:
+		thread->init =3D hfp_audio_cvsd_init;
+		thread->free =3D hfp_audio_cvsd_free;
+		thread->decode =3D hfp_audio_cvsd_decode;
+		thread->encode =3D hfp_audio_cvsd_encode;
+		break;
+	case HFP_AUDIO_MSBC:
+		thread->rate =3D 16000;
+		thread->init =3D hfp_audio_msbc_init;
+		thread->free =3D hfp_audio_msbc_free;
+		thread->decode =3D hfp_audio_msbc_decode;
+		thread->encode =3D hfp_audio_msbc_encode;
+		break;
+	}
 =

-	if (pthread_create(&hcon->thread, NULL, thread_func, hcon) < 0)
-		goto fail;
+	if (pthread_create(&thread->thread, NULL, thread_func, thread) < 0) {
+		hfp_audio_thread_free(thread);
+		return -EINVAL;
+	}
 =

 	/* FIXME thread is not detached until we quit */
 =

-	threads =3D g_slist_prepend(threads, hcon);
+	threads =3D g_slist_prepend(threads, thread);
 	return 0;
-fail:
-	hfp_audio_thread_free(hcon);
-	return -EINVAL;
 }
 =

 static DBusMessage *agent_newconnection(DBusConnection *conn, DBusMessage =
*msg,
-					void *data)
+								void *data)
 {
 	const char *card;
 	int fd;
@@ -321,9 +601,8 @@ static DBusMessage *agent_newconnection(DBusConnection =
*conn, DBusMessage *msg,
 	DBG("New connection");
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &card,
-						DBUS_TYPE_UNIX_FD, &fd,
-						DBUS_TYPE_BYTE, &codec,
-						DBUS_TYPE_INVALID) =3D=3D FALSE)
+			DBUS_TYPE_UNIX_FD, &fd, DBUS_TYPE_BYTE, &codec,
+			DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return g_dbus_create_error(msg,
 				HFP_AUDIO_AGENT_INTERFACE ".InvalidArguments",
 				"Invalid arguments");
@@ -343,7 +622,7 @@ fail:
 }
 =

 static DBusMessage *agent_release(DBusConnection *conn, DBusMessage *msg,
-					void *data)
+		void *data)
 {
 	DBG("HFP audio agent released");
 	/* agent will be registered on next oFono startup */
@@ -366,8 +645,8 @@ static void hfp_audio_agent_register_reply(DBusPendingC=
all *call, void *data)
 	dbus_error_init(&err);
 =

 	if (dbus_set_error_from_message(&err, reply) =3D=3D TRUE) {
-		DBG("Failed to register audio agent (%s: %s)", err.name,
-								err.message);
+		DBG("Failed to register audio agent (%s: %s)",
+				err.name, err.message);
 		dbus_error_free(&err);
 	} else {
 		DBG("HFP audio agent registered");
@@ -388,9 +667,8 @@ static void hfp_audio_agent_register(DBusConnection *co=
nn)
 	DBG("Registering audio agent in oFono");
 =

 	msg =3D dbus_message_new_method_call(OFONO_SERVICE,
-						HFP_AUDIO_MANAGER_PATH,
-						HFP_AUDIO_MANAGER_INTERFACE,
-						"Register");
+			HFP_AUDIO_MANAGER_PATH, HFP_AUDIO_MANAGER_INTERFACE,
+			"Register");
 	if (msg =3D=3D NULL) {
 		DBG("Not enough memory");
 		return;
@@ -403,8 +681,8 @@ static void hfp_audio_agent_register(DBusConnection *co=
nn)
 		codecs[ncodecs++] =3D HFP_AUDIO_MSBC;
 =

 	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &path,
-					DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
-					&pcodecs, ncodecs, DBUS_TYPE_INVALID);
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &pcodecs, ncodecs,
+			DBUS_TYPE_INVALID);
 =

 	if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
 		dbus_message_unref(msg);
@@ -414,8 +692,8 @@ static void hfp_audio_agent_register(DBusConnection *co=
nn)
 =

 	dbus_message_unref(msg);
 =

-	dbus_pending_call_set_notify(call, hfp_audio_agent_register_reply,
-						NULL, NULL);
+	dbus_pending_call_set_notify(call, hfp_audio_agent_register_reply, NULL,
+			NULL);
 =

 	dbus_pending_call_unref(call);
 }
@@ -481,30 +759,32 @@ static int sco_listen_watch()
 =

 	if (bind(sk, (struct sockaddr *) &saddr, sizeof(saddr)) < 0) {
 		DBG("Can't bind socket: %s (%d)", strerror(errno), errno);
-		goto error;
+		goto fail;
 	}
 =

 	/* Enable deferred setup */
-	if (option_defer && setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
-				&option_defer, sizeof(option_defer)) < 0) {
+	if (option_defer
+			&& setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
+					&option_defer, sizeof(option_defer))
+					< 0) {
 		DBG("Can't defer setup : %s (%d)", strerror(errno), errno);
-		goto error;
+		goto fail;
 	}
 =

 	/* Listen for connections */
 	if (listen(sk, 10)) {
 		DBG("Can not listen socket: %s (%d)", strerror(errno), errno);
-		goto error;
+		goto fail;
 	}
 =

 	DBG("Waiting for connection ...");
 	io =3D g_io_channel_unix_new(sk);
 	if (!io)
-		goto error;
+		goto fail;
 =

 	return g_io_add_watch(io, G_IO_IN, sco_accept_cb, NULL);
 =

-error:
+fail:
 	close(sk);
 	return -1;
 }
@@ -528,7 +808,7 @@ static int sco_connect_watch()
 =

 	if (bind(sk, (struct sockaddr *) &saddr, sizeof(saddr)) < 0) {
 		DBG("Can't bind socket: %s (%d)", strerror(errno), errno);
-		goto error;
+		goto fail;
 	}
 =

 	/* Connect to remote address */
@@ -537,17 +817,17 @@ static int sco_connect_watch()
 	btstr2ba(option_client_addr, &saddr.sco_bdaddr);
 	if (connect(sk, (struct sockaddr *) &saddr, sizeof(saddr))) {
 		DBG("Can not connect socket: %s (%d)", strerror(errno), errno);
-		goto error;
+		goto fail;
 	}
 =

 	DBG("Connecting to %s...", option_client_addr);
 	io =3D g_io_channel_unix_new(sk);
 	if (!io)
-		goto error;
+		goto fail;
 =

-	return g_io_add_watch(io, G_IO_IN|G_IO_OUT, sco_connect_cb, NULL);
+	return g_io_add_watch(io, G_IO_IN | G_IO_OUT, sco_connect_cb, NULL);
 =

-error:
+fail:
 	close(sk);
 	return -1;
 }
@@ -557,9 +837,8 @@ static void hfp_audio_agent_create(DBusConnection *conn)
 	DBG("Registering audio agent on DBUS");
 =

 	if (!g_dbus_register_interface(conn, HFP_AUDIO_AGENT_PATH,
-					HFP_AUDIO_AGENT_INTERFACE,
-					agent_methods, NULL, NULL,
-					NULL, NULL)) {
+			HFP_AUDIO_AGENT_INTERFACE, agent_methods, NULL, NULL,
+			NULL, NULL)) {
 		DBG("Unable to create local agent");
 		g_main_loop_quit(main_loop);
 	}
@@ -570,7 +849,7 @@ static void hfp_audio_agent_destroy(DBusConnection *con=
n)
 	DBG("Unregistering audio agent on DBUS");
 =

 	g_dbus_unregister_interface(conn, HFP_AUDIO_AGENT_PATH,
-						HFP_AUDIO_AGENT_INTERFACE);
+			HFP_AUDIO_AGENT_INTERFACE);
 }
 =

 static void ofono_connect(DBusConnection *conn, void *user_data)
-- =

1.7.9.5


--===============3721552123388554612==--

