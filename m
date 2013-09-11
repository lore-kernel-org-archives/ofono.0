Content-Type: multipart/mixed; boundary="===============6920846196772366613=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 1/7] handsfree-audio: Add setting SCO air mode
Date: Tue, 10 Sep 2013 21:09:40 -0300
Message-ID: <1378858186-683-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6920846196772366613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

I did a few quick tests here, but it would be much appreciated if
someone with access to more devices could test it.

Sorry for the delay.

Cheers,

 src/handsfree-audio.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 0bdeb99..c311b04 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -68,6 +68,33 @@ static GSList *drivers =3D 0;
 static ofono_bool_t has_wideband =3D FALSE;
 static int defer_setup =3D 1;

+static uint16_t codec2setting(uint8_t codec)
+{
+	switch (codec) {
+		case HFP_CODEC_CVSD:
+			return BT_VOICE_CVSD_16BIT;
+		default:
+			return BT_VOICE_TRANSPARENT;
+	}
+}
+
+static ofono_bool_t apply_settings_from_codec(int fd, uint8_t codec)
+{
+	struct bt_voice voice;
+
+	/* CVSD is the default, no need to set BT_VOICE. */
+	if (codec =3D=3D HFP_CODEC_CVSD)
+		return TRUE;
+
+	memset(&voice, 0, sizeof(voice));
+	voice.setting =3D codec2setting(codec);
+
+	if (setsockopt(fd, SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice)) < 0)
+		return FALSE;
+
+	return TRUE;
+}
+
 static void send_new_connection(const char *card, int fd, uint8_t codec)
 {
 	DBusMessage *msg;
@@ -150,6 +177,11 @@ static gboolean sco_accept(GIOChannel *io, GIOConditio=
n cond,
 		return TRUE;
 	}

+	if (apply_settings_from_codec(nsk, card->selected_codec) =3D=3D FALSE) {
+		close(nsk);
+		return TRUE;
+	}
+
 	send_new_connection(card->path, nsk, card->selected_codec);
 	close(nsk);

--
1.8.4


--===============6920846196772366613==--

