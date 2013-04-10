Content-Type: multipart/mixed; boundary="===============8221020464430938303=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 4/7] hfp_hf_bluez5: Set the audio codec in the card
Date: Wed, 10 Apr 2013 16:37:54 -0300
Message-ID: <1365622677-4824-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365622677-4824-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8221020464430938303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch updates the handsfree audio card codec when the AG notifies
the codec for the succeeding incoming SCO connection.
---
 plugins/hfp_hf_bluez5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index efbb209..2279041 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -343,6 +343,8 @@ static void bcs_notify(GAtResult *result, gpointer user=
_data)
 		/* fall through */
 =

 	case HFP_CODEC_CVSD:
+		ofono_handsfree_card_select_codec(hfp->card, value);
+
 		/* Confirm the codec */
 		sprintf(str, "AT+BCS=3D%d", value);
 		break;
-- =

1.8.2


--===============8221020464430938303==--

