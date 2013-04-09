Content-Type: multipart/mixed; boundary="===============7325002188283887837=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 5/8] hfp_hf_bluez5: Set the audio codec in the card
Date: Tue, 09 Apr 2013 17:45:40 -0300
Message-ID: <1365540343-8394-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365540343-8394-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7325002188283887837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch updates the handsfree audio card codec when the AG notifies
the codec for the succeeding incoming SCO connection.
---
 plugins/hfp_hf_bluez5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 63af484..85b8de9 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -85,6 +85,7 @@ static void codec_watcher_cb(unsigned char codec, gpointe=
r user_data)
 	struct hfp *hfp =3D user_data;;
 =

 	DBG("Card: %p selected codec: %d", hfp->card, codec);
+	ofono_handsfree_card_select_codec(hfp->card, codec);
 }
 =

 static void slc_established(gpointer userdata)
-- =

1.8.2


--===============7325002188283887837==--

