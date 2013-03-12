Content-Type: multipart/mixed; boundary="===============0373658351602571529=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 12/20] hfp_hf_bluez5: Register codec watcher
Date: Tue, 12 Mar 2013 11:21:36 -0300
Message-ID: <1363098104-16467-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0373658351602571529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch registers the codec watcher when the Handsfree Audio Card
driver probe callback gets called.
---
 plugins/hfp_hf_bluez5.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 6c55657..f20aff7 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -64,6 +64,7 @@ struct hfp {
 	struct hfp_slc_info info;
 	DBusMessage *msg;
 	struct ofono_handsfree_card *card;
+	guint codec_watch;
 };
 =

 static GDBusClient *bluez =3D NULL;
@@ -75,6 +76,14 @@ static void hfp_debug(const char *str, void *user_data)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static void codec_watcher_cb(unsigned char codec, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+
+	DBG("Card: %p selected codec: %d", hfp->card, codec);
+}
+
 static void slc_established(gpointer userdata)
 {
 	struct ofono_modem *modem =3D userdata;
@@ -312,6 +321,13 @@ static struct ofono_modem_driver hfp_driver =3D {
 =

 static int card_probe(struct ofono_handsfree_card *card, void *data)
 {
+	struct ofono_modem *modem =3D data;
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	struct hfp_slc_info *info =3D &hfp->info;
+
+	hfp->codec_watch =3D hfp_slc_codec_watch_register(info, codec_watcher_cb,
+									modem);
+
 	return 0;
 }
 =

-- =

1.7.11.7


--===============0373658351602571529==--

