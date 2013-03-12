Content-Type: multipart/mixed; boundary="===============3778799052265143640=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 06/20] hfp_hf_bluez5: Add HFP 1.6 connect implementation
Date: Tue, 12 Mar 2013 11:21:30 -0300
Message-ID: <1363098104-16467-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3778799052265143640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implements the HF initiate SCO connection for devices
compliant with HFP 1.6. HF sends AT+BCC to inform the AG that audio
connection is required.
---
 plugins/hfp_hf_bluez5.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 0d5d5c7..6c55657 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -364,7 +364,18 @@ static struct ofono_handsfree_card_driver card_driver1=
5 =3D {
 static int card_audio_connect16(const char *remote, const char *local,
 								void *data)
 {
-	return 0;
+	struct ofono_modem *modem =3D data;
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	struct hfp_slc_info *info =3D &hfp->info;
+
+	if (info->chat =3D=3D NULL)
+		return -ENOTCONN;
+
+	info->chat =3D g_at_chat_ref(info->chat);
+	g_at_chat_send(info->chat, "AT+BCC", NULL, NULL, info->chat,
+					(GDestroyNotify) g_at_chat_unref);
+
+	return -EINPROGRESS;
 }
 =

 static struct ofono_handsfree_card_driver card_driver16 =3D {
-- =

1.7.11.7


--===============3778799052265143640==--

