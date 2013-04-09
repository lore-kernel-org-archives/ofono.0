Content-Type: multipart/mixed; boundary="===============5349445102672770291=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/8] handsfree-audio: Implement
 ofono_handsfree_card_select_codec()
Date: Tue, 09 Apr 2013 17:45:39 -0300
Message-ID: <1365540343-8394-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365540343-8394-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5349445102672770291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 50be691..12d49db 100644
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
@@ -535,6 +536,17 @@ void ofono_handsfree_card_remove(struct ofono_handsfre=
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
 ofono_bool_t ofono_handsfree_audio_has_wideband(void)
 {
 	return has_wideband;
-- =

1.8.2


--===============5349445102672770291==--

