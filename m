Content-Type: multipart/mixed; boundary="===============3609072526445307583=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 2/6] handsfree-audio: Implement
 ofono_handsfree_card_set_codec()
Date: Mon, 15 Apr 2013 10:54:49 -0300
Message-ID: <1366034093-24084-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366034093-24084-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3609072526445307583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 50be691..8e8d460 100644
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
@@ -342,6 +343,8 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(unsigned int vendor,
 =

 	card =3D g_new0(struct ofono_handsfree_card, 1);
 =

+	card->selected_codec =3D HFP_CODEC_CVSD;
+
 	card_list =3D g_slist_prepend(card_list, card);
 =

 	for (l =3D drivers; l; l =3D l->next) {
@@ -535,6 +538,23 @@ void ofono_handsfree_card_remove(struct ofono_handsfre=
e_card *card)
 	g_free(card);
 }
 =

+ofono_bool_t ofono_handsfree_card_set_codec(struct ofono_handsfree_card *c=
ard,
+							unsigned char codec)
+{
+	if (codec =3D=3D HFP_CODEC_CVSD)
+		goto done;
+
+	if (codec =3D=3D HFP_CODEC_MSBC && has_wideband)
+		goto done;
+
+	return FALSE;
+
+done:
+	card->selected_codec =3D codec;
+
+	return TRUE;
+}
+
 ofono_bool_t ofono_handsfree_audio_has_wideband(void)
 {
 	return has_wideband;
-- =

1.8.2


--===============3609072526445307583==--

