Content-Type: multipart/mixed; boundary="===============0160371341817548075=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 6/7] handsfree-audio: mSBC support
Date: Tue, 27 Aug 2013 18:59:42 +0200
Message-ID: <1377622783-22845-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1377622783-22845-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0160371341817548075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/handsfree-audio.c |  204 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 204 insertions(+)

diff --git a/tools/handsfree-audio.c b/tools/handsfree-audio.c
index f4699f8..1201a62 100644
--- a/tools/handsfree-audio.c
+++ b/tools/handsfree-audio.c
@@ -40,6 +40,8 @@
 #include <glib.h>
 =

 #include <alsa/asoundlib.h>
+#include <sbc/sbc.h>
+#include "bluetooth.h"
 =

 #define OFONO_SERVICE			"org.ofono"
 #define HFP_AUDIO_MANAGER_PATH		"/"
@@ -62,6 +64,28 @@ static GSList *threads =3D NULL;
 static gboolean option_nocvsd =3D FALSE;
 static gboolean option_nomsbc =3D FALSE;
 =

+static const char sntable[4] =3D { 0x08, 0x38, 0xC8, 0xF8 };
+static const int audio_rates[3] =3D { 0, 8000, 16000 };
+
+struct msbc_parser {
+	uint8_t buffer[60];
+	int parsed;
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
 struct hfp_thread {
 	int fd;
 	int running;
@@ -78,8 +102,78 @@ struct hfp_thread {
 	int (*encode)(struct hfp_thread *, char *data, int len);
 	int (*decode)(struct hfp_thread *, char *data, int len, char *out,
 								int outlen);
+	struct msbc_codec msbc;
 };
 =

+static void msbc_parser_reset(struct msbc_parser *p)
+{
+	p->parsed =3D 0;
+}
+
+static int msbc_state_machine(struct msbc_parser *p, uint8_t byte)
+{
+	switch (p->parsed) {
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
+	msbc_parser_reset(p);
+	return 0;
+
+copy:
+	p->buffer[p->parsed] =3D byte;
+	p->parsed++;
+
+	return p->parsed;
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
+					p->parsed - 2 - 1, out, outlen,
+					&written);
+			if (decoded > 0) {
+				totalwritten +=3D written;
+				*bytes +=3D decoded;
+			} else {
+				DBG("Error while decoding: %d", decoded);
+			}
+			msbc_parser_reset(p);
+		}
+	}
+
+	return totalwritten;
+}
 =

 static int hfp_audio_cvsd_init(struct hfp_thread *thread)
 {
@@ -125,6 +219,109 @@ static int hfp_audio_cvsd_decode(struct hfp_thread *t=
hread, char *data,
 	return size;
 }
 =

+/* Run from IO thread */
+static int hfp_audio_msbc_init(struct hfp_thread *thread)
+{
+	struct msbc_codec *codec =3D &thread->msbc;
+	struct bt_voice voice;
+
+	thread->rate =3D 16000;
+	thread->capture_size =3D 240; /* decoded mSBC frame */
+
+	memset(&voice, 0, sizeof(voice));
+	voice.setting =3D BT_VOICE_TRANSPARENT;
+	if (setsockopt(thread->fd, SOL_BLUETOOTH, BT_VOICE,
+					&voice, sizeof(voice)) < 0) {
+		DBG("Can't set transparent mode: %s (%d)",
+				strerror(errno), errno);
+		return -EOPNOTSUPP;
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
+
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
+		memcpy(qbuf, codec->ebuffer + codec->ebuffer_start,
+								thread->mtu);
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
 =

 static snd_pcm_t *hfp_audio_pcm_init(snd_pcm_stream_t stream, int rate)
 {
@@ -360,6 +557,13 @@ static int new_connection(int fd, int codec)
 		thread->decode =3D hfp_audio_cvsd_decode;
 		thread->encode =3D hfp_audio_cvsd_encode;
 		break;
+	case HFP_AUDIO_MSBC:
+		thread->rate =3D 16000;
+		thread->init =3D hfp_audio_msbc_init;
+		thread->free =3D hfp_audio_msbc_free;
+		thread->decode =3D hfp_audio_msbc_decode;
+		thread->encode =3D hfp_audio_msbc_encode;
+		break;
 	default:
 		return -EINVAL;
 	}
-- =

1.7.9.5


--===============0160371341817548075==--

