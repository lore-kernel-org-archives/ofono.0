Content-Type: multipart/mixed; boundary="===============5404497004656762576=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/6] include: Make HFP 1.6 codecs definition public
Date: Mon, 08 Apr 2013 19:41:01 -0300
Message-ID: <1365460863-14645-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365460863-14645-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5404497004656762576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As there is some knowledge about the codecs in both the core
(handsfree-audio) and the hfpmodem driver, this information should
be available from a single location.
---
 include/types.h       | 6 ++++++
 src/handsfree-audio.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/types.h b/include/types.h
index 8c01bf4..93a403b 100644
--- a/include/types.h
+++ b/include/types.h
@@ -141,6 +141,12 @@ enum hfp_hf_feature {
 	HFP_HF_FEATURE_CODEC_NEGOTIATION =3D	0x80,
 };
 =

+/* Defined HFP 1.6 codecs */
+enum hfp_codec {
+	HFP_CODEC_CVSD =3D 0x01,
+	HFP_CODEC_MSBC =3D 0x02,
+};
+
 const char *ofono_uuid_to_str(const struct ofono_uuid *uuid);
 void ofono_call_init(struct ofono_call *call);
 =

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 699c8cc..69d033d 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -43,12 +43,6 @@
 #define HFP_AUDIO_AGENT_INTERFACE	OFONO_SERVICE ".HandsfreeAudioAgent"
 #define HFP_AUDIO_CARD_INTERFACE	OFONO_SERVICE ".HandsfreeAudioCard"
 =

-/* Supported agent codecs */
-enum hfp_codec {
-	HFP_CODEC_CVSD =3D 0x01,
-	HFP_CODEC_MSBC =3D 0x02,
-};
-
 struct ofono_handsfree_card {
 	char *remote;
 	char *local;
-- =

1.8.2


--===============5404497004656762576==--

