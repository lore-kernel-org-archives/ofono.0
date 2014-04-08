Content-Type: multipart/mixed; boundary="===============8554157649874283869=="
MIME-Version: 1.0
From: Andrew Earl <andrewx.earl@intel.com>
Subject: [PATCH 4/4] hfp: Add CNUM query to handsfree interface for subscriber
 number
Date: Tue, 08 Apr 2014 09:21:47 +0100
Message-ID: <1396945307-12195-5-git-send-email-andrewx.earl@intel.com>
In-Reply-To: <1396945307-12195-1-git-send-email-andrewx.earl@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8554157649874283869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/handsfree.c | 88 ++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index e62fa26..81baaa1 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -43,6 +43,8 @@
 #include "hfp.h"
 #include "slc.h"
 =

+#define OFONO_HANDSFREE_CNUM_SERVICE_VOICE 4
+
 static const char *binp_prefix[] =3D { "+BINP:", NULL };
 static const char *bvra_prefix[] =3D { "+BVRA:", NULL };
 =

@@ -125,6 +127,91 @@ static void ciev_notify(GAtResult *result, gpointer us=
er_data)
 	ofono_handsfree_battchg_notify(hf, value);
 }
 =

+static void cnum_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_handsfree_cnum_query_cb_t cb =3D cbd->cb;
+	GAtResultIter iter;
+	struct ofono_phone_number *list =3D NULL;
+	int num =3D 0;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto out;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CNUM:"))
+		num++;
+
+	if (num =3D=3D 0)
+		goto out;
+
+	list =3D g_new(struct ofono_phone_number, num);
+
+	g_at_result_iter_init(&iter, result);
+
+	for (num =3D 0; g_at_result_iter_next(&iter, "+CNUM:"); ) {
+		const char *number;
+		int len;
+		int service;
+		int type;
+
+		list[num].number[0] =3D '\0';
+		list[num].type =3D 129;
+
+		if (!g_at_result_iter_skip_next(&iter))
+			continue;
+
+		if (!g_at_result_iter_next_string(&iter, &number))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &type))
+			continue;
+
+		if (!g_at_result_iter_skip_next(&iter))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &service))
+			continue;
+
+		if (service =3D=3D OFONO_HANDSFREE_CNUM_SERVICE_VOICE) {
+			len =3D strlen(number);
+			if (len > OFONO_MAX_PHONE_NUMBER_LENGTH)
+				len =3D OFONO_MAX_PHONE_NUMBER_LENGTH;
+			strncpy(list[num].number, number, len);
+			list[num].number[len] =3D '\0';
+			list[num].type =3D type;
+
+			DBG("cnum_notify:%s", list[num].number);
+			num++;
+		}
+	}
+
+out:
+	cb(&error, num, list, cbd->data);
+
+	g_free(list);
+
+}
+
+static void at_cnum_query(struct ofono_handsfree *hf,
+			ofono_handsfree_cnum_query_cb_t cb, void *data)
+{
+	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(hd->chat, "AT+CNUM", NULL,
+					cnum_query_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, NULL, data);
+}
+
 static gboolean hfp_handsfree_register(gpointer user_data)
 {
 	struct ofono_handsfree *hf =3D user_data;
@@ -283,6 +370,7 @@ static struct ofono_handsfree_driver driver =3D {
 	.name			=3D "hfpmodem",
 	.probe			=3D hfp_handsfree_probe,
 	.remove			=3D hfp_handsfree_remove,
+	.cnum_query		=3D at_cnum_query,
 	.request_phone_number	=3D hfp_request_phone_number,
 	.voice_recognition	=3D hfp_voice_recognition,
 	.disable_nrec		=3D hfp_disable_nrec,
-- =

1.7.11.7


--===============8554157649874283869==--

