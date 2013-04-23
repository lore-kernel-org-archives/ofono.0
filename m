Content-Type: multipart/mixed; boundary="===============9039264475675881606=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 6/7] hfpmodem: Add EchoCancelingNoiseReduction
Date: Tue, 23 Apr 2013 14:21:42 -0300
Message-ID: <1366737703-26883-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366737703-26883-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9039264475675881606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds echo canceling and noise reduction implementation to
hfpmodem. It adds the implementation to send the command "AT+NREC=3D0"
to the AG.
---
 drivers/hfpmodem/handsfree.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index ce28de3..78ee801 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -260,12 +260,29 @@ static void hfp_voice_recognition(struct ofono_handsf=
ree *hf,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void hfp_disable_nrec(struct ofono_handsfree *hf,
+				ofono_handsfree_cb_t cb, void *data)
+{
+	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	const char *buf =3D "AT+NREC=3D0";
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
+	.disable_nrec		=3D hfp_disable_nrec,
 };
 =

 void hfp_handsfree_init(void)
-- =

1.7.11.7


--===============9039264475675881606==--

