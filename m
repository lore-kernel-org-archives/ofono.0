Content-Type: multipart/mixed; boundary="===============3083826716798088002=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 07/10] hfpmodem: Send the AT+BAC command with the supported
 codecs
Date: Fri, 18 Jan 2013 20:38:57 -0300
Message-ID: <1358552340-29393-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358552340-29393-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3083826716798088002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Before, the AT+BAC command was being sent with fixed information,
now we send the command (that inform the AG of the codecs supported by
the HF) with the codecs that come from the profile implementation.
---
 drivers/hfpmodem/slc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index f088a46..54766bb 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -316,10 +316,21 @@ static void brsf_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 =

 	if (info->ag_features & HFP_AG_FEATURE_CODEC_NEGOTIATION &&
 			info->hf_features & HFP_HF_FEATURE_CODEC_NEGOTIATION) {
+		GString *str =3D g_string_new("AT+BAC=3D");
+		int i;
+
+		for (i =3D 0; i < info->codecs_len; i++) {
+			g_string_append_printf(str, "%d", info->codecs[i]);
+			if (i + 1 < info->codecs_len)
+				str =3D g_string_append(str, ",");
+		}
 =

 		slc_establish_data_ref(sed);
-		g_at_chat_send(info->chat, "AT+BAC=3D1", NULL, bac_cb, sed,
+		g_at_chat_send(info->chat, str->str, NULL, bac_cb, sed,
 						slc_establish_data_unref);
+
+		g_string_free(str, TRUE);
+
 		return;
 	}
 =

-- =

1.7.11.7


--===============3083826716798088002==--

