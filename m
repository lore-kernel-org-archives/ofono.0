Content-Type: multipart/mixed; boundary="===============3861970016094390238=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 09/19] hfpmodem: Support of number requests (AT+BINP=1)
Date: Wed, 12 Oct 2011 14:35:30 +0200
Message-ID: <1318422940-14955-10-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3861970016094390238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/handsfree.c |   59 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index be6b83c..392e5b7 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -42,6 +42,8 @@
 #include "hfpmodem.h"
 #include "slc.h"
 =

+static const char *binp_prefix[] =3D { "+BINP:", NULL };
+
 struct hf_data {
 	GAtChat *chat;
 	unsigned int ag_features;
@@ -105,10 +107,67 @@ static void hfp_handsfree_remove(struct ofono_handsfr=
ee *hf)
 	g_free(hd);
 }
 =

+static void hfp_request_phone_number_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_handsfree_phone_cb_t cb =3D cbd->cb;
+	void *data =3D cbd->data;
+	GAtResultIter iter;
+	const char *num;
+	int type;
+	struct ofono_phone_number phone_number;
+
+	if (!ok)
+		goto fail;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+BINP:"))
+		goto fail;
+
+	if (!g_at_result_iter_next_string(&iter, &num))
+		goto fail;
+
+	if (!g_at_result_iter_next_number(&iter, &type))
+		goto fail;
+
+	DBG("AT+BINP=3D1 response: %s %d", num, type);
+
+	strncpy(phone_number.number, num,
+		OFONO_MAX_PHONE_NUMBER_LENGTH);
+	phone_number.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+	phone_number.type =3D type;
+
+	CALLBACK_WITH_SUCCESS(cb, &phone_number, data);
+	return;
+
+fail:
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void hfp_request_phone_number(struct ofono_handsfree *hf,
+					ofono_handsfree_phone_cb_t cb,
+					void *data)
+{
+	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(hd->chat, "AT+BINP=3D1", binp_prefix,
+				hfp_request_phone_number_cb,
+				cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
 static struct ofono_handsfree_driver driver =3D {
 	.name			=3D "hfpmodem",
 	.probe			=3D hfp_handsfree_probe,
 	.remove			=3D hfp_handsfree_remove,
+	.request_phone_number	=3D hfp_request_phone_number,
 };
 =

 void hfp_handsfree_init(void)
-- =

1.7.6.4


--===============3861970016094390238==--

