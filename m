Content-Type: multipart/mixed; boundary="===============1909134291043193847=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 14/20] hfp_hf_bluez5: Set the audio codec in the card
Date: Tue, 12 Mar 2013 11:21:38 -0300
Message-ID: <1363098104-16467-15-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1909134291043193847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch updates the handsfree audio card codec when the AG notifies
the codec for the succeeding incoming SCO connection.
---
 plugins/hfp_hf_bluez5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index f20aff7..49cc378 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -82,6 +82,7 @@ static void codec_watcher_cb(unsigned char codec, gpointe=
r user_data)
 	struct hfp *hfp =3D ofono_modem_get_data(modem);
 =

 	DBG("Card: %p selected codec: %d", hfp->card, codec);
+	ofono_handsfree_card_select_codec(hfp->card, codec);
 }
 =

 static void slc_established(gpointer userdata)
-- =

1.7.11.7


--===============1909134291043193847==--

