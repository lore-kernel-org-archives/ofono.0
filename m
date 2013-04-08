Content-Type: multipart/mixed; boundary="===============1636215121087661735=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 5/6] hfpmodem: Send AT+BAC with the supported codecs
Date: Mon, 08 Apr 2013 19:41:02 -0300
Message-ID: <1365460863-14645-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365460863-14645-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1636215121087661735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Before, the AT+BAC command was being sent with fixed information,
now we send the command (that inform the AG of the codecs supported by
the HF) with the codecs supported by the registered Handsfree Audio
Agent.
---
 drivers/hfpmodem/slc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 646befa..6423791 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -34,6 +34,7 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/emulator.h>
+#include <ofono/handsfree-audio.h>
 =

 #include <drivers/atmodem/atutil.h>
 =

@@ -304,9 +305,18 @@ static void brsf_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 =

 	if (info->ag_features & HFP_AG_FEATURE_CODEC_NEGOTIATION &&
 			info->hf_features & HFP_HF_FEATURE_CODEC_NEGOTIATION) {
+		char str[32];
+
+		memset(str, 0, sizeof(str));
+
+		if (ofono_handsfree_audio_has_wideband())
+			sprintf(str, "AT+BAC=3D%d,%d", HFP_CODEC_CVSD,
+							HFP_CODEC_MSBC);
+		else
+			sprintf(str, "AT+BAC=3D%d", HFP_CODEC_CVSD);
 =

 		slc_establish_data_ref(sed);
-		g_at_chat_send(info->chat, "AT+BAC=3D1", NULL, bac_cb, sed,
+		g_at_chat_send(info->chat, str, NULL, bac_cb, sed,
 						slc_establish_data_unref);
 		return;
 	}
-- =

1.8.2


--===============1636215121087661735==--

