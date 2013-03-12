Content-Type: multipart/mixed; boundary="===============4819916546615871965=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 20/20] handsfree-audio: Add setting SCO air mode
Date: Tue, 12 Mar 2013 11:21:44 -0300
Message-ID: <1363098104-16467-21-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4819916546615871965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index b644b0b..725b81c 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -91,6 +91,16 @@ static inline void clear_bit(int nr, void *addr)
 	*((uint32_t *) addr + (nr >> 5)) &=3D ~(1 << (nr & 31));
 }
 =

+static uint8_t codec2mode(uint8_t codec)
+{
+	switch (codec) {
+		case HFP_CODEC_CVSD:
+			return SCO_MODE_CVSD;
+		default:
+			return SCO_MODE_TRANSPARENT;
+	}
+}
+
 static void send_new_connection(const char *card, int fd, uint8_t codec)
 {
 	DBusMessage *msg;
@@ -130,6 +140,7 @@ static gboolean sco_accept(GIOChannel *io, GIOCondition=
 cond,
 {
 	struct ofono_handsfree_card *card;
 	struct sockaddr_sco saddr;
+	struct sco_options options;
 	socklen_t alen;
 	int sk, nsk;
 	char local[18], remote[18];
@@ -180,6 +191,14 @@ static gboolean sco_accept(GIOChannel *io, GIOConditio=
n cond,
 		card->msg =3D NULL;
 	}
 =

+	memset(&options, 0, sizeof(options));
+	options.mode =3D codec2mode(card->selected_codec);
+
+	if (setsockopt(sk, SOL_SCO, SCO_OPTIONS, &options,
+						sizeof(options)) < 0)
+		ofono_error("Can't set SCO options: %s (%d)", strerror(errno),
+									errno);
+
 	send_new_connection(card->path, nsk, card->selected_codec);
 	close(nsk);
 =

-- =

1.7.11.7


--===============4819916546615871965==--

