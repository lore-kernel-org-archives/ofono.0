Content-Type: multipart/mixed; boundary="===============2073654876408787642=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 3/7] handsfree-audio: Implement
 ofono_handsfree_card_select_codec()
Date: Wed, 10 Apr 2013 16:37:53 -0300
Message-ID: <1365622677-4824-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365622677-4824-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2073654876408787642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 50be691..3d6804d 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -49,6 +49,7 @@ struct ofono_handsfree_card {
 	char *local;
 	char *path;
 	DBusMessage *msg;
+	unsigned char selected_codec;
 	const struct ofono_handsfree_card_driver *driver;
 	void *driver_data;
 };
@@ -535,6 +536,12 @@ void ofono_handsfree_card_remove(struct ofono_handsfre=
e_card *card)
 	g_free(card);
 }
 =

+void ofono_handsfree_card_select_codec(struct ofono_handsfree_card *card,
+							unsigned char codec)
+{
+	card->selected_codec =3D codec;
+}
+
 ofono_bool_t ofono_handsfree_audio_has_wideband(void)
 {
 	return has_wideband;
-- =

1.8.2


--===============2073654876408787642==--

