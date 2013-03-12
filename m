Content-Type: multipart/mixed; boundary="===============4216979354782498469=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 13/20] handsfree-audio: Add function to select the codec
Date: Tue, 12 Mar 2013 11:21:37 -0300
Message-ID: <1363098104-16467-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4216979354782498469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a public function to select the active codec in the
Audio Card. The AG informs the HF which codec ID is to be used before
establishing the Synchronous Connection. The selected codec is input
to set properly the SCO parameters.
---
 include/handsfree-audio.h |  2 ++
 src/handsfree-audio.c     | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 839f0f8..696f153 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -49,6 +49,8 @@ struct ofono_handsfree_card *ofono_handsfree_card_create(=
const char *remote,
 					void *data);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
+int ofono_handsfree_card_select_codec(struct ofono_handsfree_card *card,
+							unsigned char codec);
 int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len);
 =

 void ofono_handsfree_audio_ref(void);
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 2cbdb57..1b0a04d 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -57,6 +57,7 @@ struct ofono_handsfree_card {
 	DBusMessage *msg;
 	guint sco_watch;
 	void *data;
+	unsigned char selected_codec;
 };
 =

 struct agent {
@@ -462,6 +463,17 @@ void ofono_handsfree_card_remove(struct ofono_handsfre=
e_card *card)
 	g_free(card);
 }
 =

+int ofono_handsfree_card_select_codec(struct ofono_handsfree_card *card,
+							unsigned char codec)
+{
+	if (card =3D=3D NULL)
+		return -EINVAL;
+
+	card->selected_codec =3D codec;
+
+	return 0;
+}
+
 int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len)
 {
 	int len;
-- =

1.7.11.7


--===============4216979354782498469==--

