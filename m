Content-Type: multipart/mixed; boundary="===============4294014503653788190=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 4/7] handsfree-audio: Implement alsa playback
Date: Tue, 27 Aug 2013 18:59:40 +0200
Message-ID: <1377622783-22845-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1377622783-22845-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4294014503653788190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The thread is queuing audio captured on alsa.  If the queue is too big,
excess data is dropped.  When some SCO data is received it is sent to
soundcard and the queued audio stream is sent. This avoid having too
much delta between numbers of sent and received SCO packets, some
adapters do not like that.
---
 tools/handsfree-audio.c |  229 +++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 223 insertions(+), 6 deletions(-)

diff --git a/tools/handsfree-audio.c b/tools/handsfree-audio.c
index 8ff2876..f4699f8 100644
--- a/tools/handsfree-audio.c
+++ b/tools/handsfree-audio.c
@@ -28,15 +28,19 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdint.h>
 #include <string.h>
 #include <signal.h>
 #include <pthread.h>
 #include <sys/socket.h>
+#include <sys/time.h>
 #include <poll.h>
 =

 #include <gdbus.h>
 #include <glib.h>
 =

+#include <alsa/asoundlib.h>
+
 #define OFONO_SERVICE			"org.ofono"
 #define HFP_AUDIO_MANAGER_PATH		"/"
 #define HFP_AUDIO_MANAGER_INTERFACE	OFONO_SERVICE ".HandsfreeAudioManager"
@@ -62,8 +66,89 @@ struct hfp_thread {
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
 };
 =

+
+static int hfp_audio_cvsd_init(struct hfp_thread *thread)
+{
+	thread->rate =3D 8000;
+	thread->capture_size =3D 48;
+
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
+
+	memcpy(out, data, size);
+
+	return size;
+}
+
+
+static snd_pcm_t *hfp_audio_pcm_init(snd_pcm_stream_t stream, int rate)
+{
+	snd_pcm_t *pcm;
+	DBG("Initializing pcm for %s", (stream =3D=3D SND_PCM_STREAM_CAPTURE) ?
+							"capture" : "playback");
+
+	if (snd_pcm_open(&pcm, "default", stream, SND_PCM_NONBLOCK) < 0) {
+		DBG("Failed to open pcm");
+		return NULL;
+	}
+
+	/* 16 bits */
+	if (snd_pcm_set_params(pcm, SND_PCM_FORMAT_S16_LE,
+			SND_PCM_ACCESS_RW_INTERLEAVED, 1, rate,
+			1, 120000) < 0) {
+		DBG("Failed to set pcm params");
+		snd_pcm_close(pcm);
+		return NULL;
+	}
+
+	return pcm;
+}
+
 static void hfp_audio_thread_free(struct hfp_thread *thread)
 {
 	DBG("Freeing audio connection %p", thread);
@@ -86,6 +171,92 @@ static void hfp_audio_thread_free(struct hfp_thread *th=
read)
 	DBG("freed %p", thread);
 }
 =

+/* Returns the number of data on sco socket */
+static int hfp_audio_playback(struct hfp_thread *thread,
+		snd_pcm_t *playback)
+{
+	char buf[512], out[512];
+	int bytes, outlen;
+	snd_pcm_sframes_t frames;
+
+	bytes =3D read(thread->fd, buf, sizeof(buf));
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
+
+	outlen =3D thread->decode(thread, buf, bytes, out, sizeof(out));
+
+	frames =3D snd_pcm_writei(playback, out, outlen / 2);
+	switch (frames) {
+	case -EPIPE:
+		snd_pcm_prepare(playback);
+		return bytes;
+	case -EAGAIN:
+		/* Do as if it was written */
+		return bytes;
+	case -EBADFD:
+	case -ESTRPIPE:
+		return -EINVAL;
+	}
+
+	if (frames < outlen / 2)
+		DBG("played %d < requested %d", (int)frames, outlen / 2);
+
+	return bytes;
+}
+
+/* Returns the number of data on sco socket */
+static int hfp_audio_capture(struct hfp_thread *thread, snd_pcm_t *capture)
+{
+	snd_pcm_sframes_t frames;
+
+	frames =3D snd_pcm_readi(capture, thread->capture_buffer+thread->captured,
+				(thread->capture_size - thread->captured) / 2);
+	switch (frames) {
+	case -EPIPE:
+		snd_pcm_prepare(capture);
+		return 0;
+	case -EAGAIN:
+		return 0;
+	case -EBADFD:
+	case -ESTRPIPE:
+		DBG("Other error %s (%d)", strerror(frames), (int) frames);
+		return -EINVAL;
+	}
+
+	thread->captured +=3D frames * 2;
+	if (thread->captured < thread->capture_size)
+		return frames * 2;
+
+	thread->encode(thread, thread->capture_buffer, thread->captured);
+	thread->captured =3D 0;
+
+	return frames * 2;
+}
+
+static void pop_outq(struct hfp_thread *thread)
+{
+	char *qbuf;
+
+	while (thread->outq !=3D NULL) {
+		qbuf =3D thread->outq->data;
+		thread->outq =3D g_slist_remove(thread->outq, qbuf);
+
+		if (write(thread->fd, qbuf, thread->mtu) < 0)
+			DBG("Failed to write: %d", errno);
+
+		g_free(qbuf);
+	}
+}
+
 static gboolean thread_cleanup(gpointer user_data)
 {
 	hfp_audio_thread_free(user_data);
@@ -96,14 +267,42 @@ static void *thread_func(void *userdata)
 {
 	struct hfp_thread *thread =3D userdata;
 	struct pollfd fds[8];
+	snd_pcm_t *playback, *capture;
+
+	DBG("thread started: rate %d", thread->rate);
+
+	if (thread->init(thread) < 0)
+		return NULL;
+
+	capture =3D hfp_audio_pcm_init(SND_PCM_STREAM_CAPTURE, thread->rate);
+	if (!capture)
+		return NULL;
+
+	playback =3D hfp_audio_pcm_init(SND_PCM_STREAM_PLAYBACK, thread->rate);
+	if (!playback) {
+		snd_pcm_close(capture);
+		return NULL;
+	}
+
+	thread->capture_buffer =3D g_try_malloc(thread->capture_size);
+	if (!thread->capture_buffer) {
+		snd_pcm_close(capture);
+		snd_pcm_close(playback);
+		return NULL;
+	}
 =

 	/* Force defered setup */
 	if (recv(thread->fd, NULL, 0, 0) < 0)
 		DBG("Defered setup failed: %d (%s)", errno, strerror(errno));
 =

+	thread->mtu =3D 48;
+	DBG("thread->mtu %d", thread->mtu);
+
 	while (thread->running) {
-		int err;
-		char c[128];
+		if (hfp_audio_capture(thread, capture) < 0) {
+			DBG("Failed to capture");
+			break;
+		}
 =

 		memset(fds, 0, sizeof(fds));
 		fds[0].fd =3D thread->fd;
@@ -120,16 +319,23 @@ static void *thread_func(void *userdata)
 		if (!fds[0].revents & POLLIN)
 			continue;
 =

-		err =3D recv(thread->fd, &c, sizeof(c), 0);
-
-		if (err < 0) {
+		if (hfp_audio_playback(thread, playback) < 0) {
 			DBG("POLLIN triggered, but read error");
 			break;
 		}
 =

-		DBG("%d bytes received", err);
+		/* Dequeue in sync with readings */
+		pop_outq(thread);
 	}
 =

+	DBG("thread terminating");
+	g_slist_free_full(thread->outq, g_free);
+	g_free(thread->capture_buffer);
+	snd_pcm_close(playback);
+	snd_pcm_close(capture);
+
+	thread->free(thread);
+
 	/* Ask main loop to join */
 	g_idle_add(thread_cleanup, userdata);
 	return NULL;
@@ -147,6 +353,17 @@ static int new_connection(int fd, int codec)
 	thread->fd =3D fd;
 	thread->running =3D 1;
 =

+	switch (codec) {
+	case HFP_AUDIO_CVSD:
+		thread->init =3D hfp_audio_cvsd_init;
+		thread->free =3D hfp_audio_cvsd_free;
+		thread->decode =3D hfp_audio_cvsd_decode;
+		thread->encode =3D hfp_audio_cvsd_encode;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (pthread_create(&thread->thread, NULL, thread_func, thread) < 0) {
 		hfp_audio_thread_free(thread);
 		return -EINVAL;
-- =

1.7.9.5


--===============4294014503653788190==--

