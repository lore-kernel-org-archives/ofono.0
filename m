Content-Type: multipart/mixed; boundary="===============3970947160279983583=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 6/7] hfpmodem: Add EchoCancelingNoiseReduction
Date: Mon, 22 Apr 2013 09:58:42 -0300
Message-ID: <1366635523-8272-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366635523-8272-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3970947160279983583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds echo canceling and noise reduction implementation to
hfpmodem.
---
 drivers/hfpmodem/handsfree.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index ce28de3..2b96566 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -260,12 +260,32 @@ static void hfp_voice_recognition(struct ofono_handsf=
ree *hf,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void hfp_echocanceling_noisereduction(struct ofono_handsfree *hf,
+				ofono_bool_t enabled, ofono_handsfree_cb_t cb,
+				void *data)
+{
+	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "AT+NREC=3D%d", (int)(enabled));
+
+	if (g_at_chat_send(hd->chat, buf, NULL, hf_generic_set_cb,
+							cbd, g_free) > 0)
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
 	.voice_recognition	=3D hfp_voice_recognition,
+	.echocanceling_noisereduction =3D hfp_echocanceling_noisereduction,
 };
 =

 void hfp_handsfree_init(void)
-- =

1.7.11.7


--===============3970947160279983583==--

