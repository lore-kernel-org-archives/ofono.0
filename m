Content-Type: multipart/mixed; boundary="===============5595998031129739649=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/8] hfp_hf_bluez5: Register codec watcher
Date: Tue, 09 Apr 2013 17:45:37 -0300
Message-ID: <1365540343-8394-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365540343-8394-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5595998031129739649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch registers the codec watcher when the Handsfree Audio Card
driver probe callback gets called.
---
 plugins/hfp_hf_bluez5.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index c63b1a2..63af484 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -68,6 +68,7 @@ struct hfp {
 	struct hfp_slc_info info;
 	DBusMessage *msg;
 	struct ofono_handsfree_card *card;
+	guint codec_watch;
 };
 =

 static GDBusClient *bluez =3D NULL;
@@ -79,6 +80,13 @@ static void hfp_debug(const char *str, void *user_data)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static void codec_watcher_cb(unsigned char codec, gpointer user_data)
+{
+	struct hfp *hfp =3D user_data;;
+
+	DBG("Card: %p selected codec: %d", hfp->card, codec);
+}
+
 static void slc_established(gpointer userdata)
 {
 	struct ofono_modem *modem =3D userdata;
@@ -317,6 +325,12 @@ static struct ofono_modem_driver hfp_driver =3D {
 static int hfp16_card_probe(struct ofono_handsfree_card *card,
 					unsigned int vendor, void *data)
 {
+	struct hfp *hfp =3D data;
+	struct hfp_slc_info *info =3D &hfp->info;
+
+	hfp->codec_watch =3D hfp_slc_codec_watch_register(info, codec_watcher_cb,
+									hfp);
+
 	return 0;
 }
 =

-- =

1.8.2


--===============5595998031129739649==--

