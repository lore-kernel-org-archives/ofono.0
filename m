Content-Type: multipart/mixed; boundary="===============5046427351132563522=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 7/8] handsfree-audio: Set CVSD as default in the card
Date: Tue, 09 Apr 2013 17:45:42 -0300
Message-ID: <1365540343-8394-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365540343-8394-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5046427351132563522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

If the device doesn't support codec negotiation, the selected codec is
not being initialized. For this case set CVSD as default.
---
 src/handsfree-audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index c00697b..d55e6fc 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -342,6 +342,8 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(unsigned int vendor,
 =

 	card =3D g_new0(struct ofono_handsfree_card, 1);
 =

+	card->selected_codec =3D HFP_CODEC_CVSD;
+
 	card_list =3D g_slist_prepend(card_list, card);
 =

 	for (l =3D drivers; l; l =3D l->next) {
-- =

1.8.2


--===============5046427351132563522==--

