Content-Type: multipart/mixed; boundary="===============7693503392404589427=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 12/12] hfpmodem: Support for AT+BVRA
Date: Thu, 15 Sep 2011 18:34:43 +0200
Message-ID: <1316104483-13144-13-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1316104483-13144-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7693503392404589427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/handsfree.c |   49 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index cd6afc7..c061aa8 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -42,12 +42,25 @@
 #include "slc.h"
 =

 static const char *binp_prefix[] =3D { "+BINP:", NULL };
+static const char *bvra_prefix[] =3D { "+BVRA:", NULL };
 =

 struct hf_data {
 	GAtChat *chat;
 	unsigned int vendor;
 };
 =

+static void hf_generic_set_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_handsfree_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
 static gboolean hfp_handsfree_register(gpointer user_data)
 {
 	struct ofono_handsfree *hf =3D user_data;
@@ -70,6 +83,19 @@ static void bsir_notify(GAtResult *result, gpointer user=
_data)
 	ofono_handsfree_set_inband_ringing(hf, (ofono_bool_t) value);
 }
 =

+static void bvra_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_handsfree *hf =3D user_data;
+	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
+	int value;
+
+	if (at_util_parse_reg_unsolicited(result, "+BVRA:", &value,
+				NULL, NULL, NULL, hd->vendor) =3D=3D FALSE)
+		return;
+
+	ofono_handsfree_set_voice_recognition(hf, (ofono_bool_t) value);
+}
+
 static int hfp_handsfree_probe(struct ofono_handsfree *hf,
 				unsigned int vendor, void *data)
 {
@@ -84,6 +110,7 @@ static int hfp_handsfree_probe(struct ofono_handsfree *h=
f,
 	ofono_handsfree_set_data(hf, hd);
 =

 	g_at_chat_register(hd->chat, "+BSIR:", bsir_notify, FALSE, hf, NULL);
+	g_at_chat_register(hd->chat, "+BVRA:", bvra_notify, FALSE, hf, NULL);
 =

 	g_idle_add(hfp_handsfree_register, hf);
 =

@@ -156,11 +183,33 @@ static void hfp_request_phone_number(struct ofono_han=
dsfree *hf,
 	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

+static void hfp_voice_recognition(struct ofono_handsfree *hf,
+					ofono_bool_t enabled,
+					ofono_handsfree_cb_t cb, void *data)
+{
+	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+
+	snprintf(buf, sizeof(buf), "AT+BVRA=3D%d",
+				(int)(enabled));
+
+	if (g_at_chat_send(hd->chat, buf, bvra_prefix,
+				hf_generic_set_cb,
+				cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static struct ofono_handsfree_driver driver =3D {
 	.name			=3D "hfpmodem",
 	.probe			=3D hfp_handsfree_probe,
 	.remove			=3D hfp_handsfree_remove,
 	.request_phone_number	=3D hfp_request_phone_number,
+	.voice_recognition	=3D hfp_voice_recognition,
 };
 =

 void hfp_handsfree_init(void)
-- =

1.7.6


--===============7693503392404589427==--

