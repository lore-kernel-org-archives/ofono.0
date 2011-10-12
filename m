Content-Type: multipart/mixed; boundary="===============3137170001831588506=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 06/19] hfpmodem: Support for +BSIR unsol. result codes
Date: Wed, 12 Oct 2011 14:35:27 +0200
Message-ID: <1318422940-14955-7-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3137170001831588506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/handsfree.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index 12a23fc..be6b83c 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -45,11 +45,28 @@
 struct hf_data {
 	GAtChat *chat;
 	unsigned int ag_features;
+	unsigned int vendor;
 };
 =

+static void bsir_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_handsfree *hf =3D user_data;
+	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
+	int value;
+
+	if (at_util_parse_reg_unsolicited(result, "+BSIR:", &value,
+				NULL, NULL, NULL, hd->vendor) =3D=3D FALSE)
+		return;
+
+	ofono_handsfree_set_inband_ringing(hf, (ofono_bool_t) value);
+}
+
 static gboolean hfp_handsfree_register(gpointer user_data)
 {
 	struct ofono_handsfree *hf =3D user_data;
+	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
+
+	g_at_chat_register(hd->chat, "+BSIR:", bsir_notify, FALSE, hf, NULL);
 =

 	ofono_handsfree_register(hf);
 =

@@ -69,6 +86,7 @@ static int hfp_handsfree_probe(struct ofono_handsfree *hf,
 	hd =3D g_new0(struct hf_data, 1);
 	hd->chat =3D g_at_chat_clone(info->chat);
 	hd->ag_features =3D info->ag_features;
+	hd->vendor =3D vendor;
 =

 	ofono_handsfree_set_data(hf, hd);
 =

-- =

1.7.6.4


--===============3137170001831588506==--

