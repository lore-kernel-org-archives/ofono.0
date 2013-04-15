Content-Type: multipart/mixed; boundary="===============5988184902747677588=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 2/2] handsfree-audio: Add setting SCO air mode
Date: Mon, 15 Apr 2013 16:03:51 -0300
Message-ID: <1366052631-19705-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366052631-19705-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5988184902747677588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 src/handsfree-audio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index c24e787..a7da523 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -68,6 +68,16 @@ static GSList *drivers =3D 0;
 static ofono_bool_t has_wideband =3D FALSE;
 static int defer_setup =3D 1;
 =

+static uint16_t codec2setting(uint8_t codec)
+{
+	switch (codec) {
+		case HFP_CODEC_CVSD:
+			return SCO_SETTING_CVSD;
+		default:
+			return SCO_SETTING_TRANSPARENT;
+	}
+}
+
 static void send_new_connection(const char *card, int fd, uint8_t codec)
 {
 	DBusMessage *msg;
@@ -107,6 +117,7 @@ static gboolean sco_accept(GIOChannel *io, GIOCondition=
 cond,
 {
 	struct ofono_handsfree_card *card;
 	struct sockaddr_sco saddr;
+	struct sco_settings options;
 	socklen_t alen;
 	int sk, nsk;
 	char local[18], remote[18];
@@ -150,6 +161,14 @@ static gboolean sco_accept(GIOChannel *io, GIOConditio=
n cond,
 		return TRUE;
 	}
 =

+	memset(&options, 0, sizeof(options));
+	options.settings =3D codec2setting(card->selected_codec);
+
+	if (setsockopt(nsk, SOL_SCO, SCO_SETTINGS, &options,
+						sizeof(options)) < 0)
+		ofono_error("Can't set SCO options: %s (%d)", strerror(errno),
+									errno);
+
 	send_new_connection(card->path, nsk, card->selected_codec);
 	close(nsk);
 =

-- =

1.8.2.1


--===============5988184902747677588==--

