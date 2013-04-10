Content-Type: multipart/mixed; boundary="===============2390045553138574509=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 6/7] handsfree-audio: Set CVSD as default in the card
Date: Wed, 10 Apr 2013 16:37:56 -0300
Message-ID: <1365622677-4824-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365622677-4824-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2390045553138574509==
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
index 8fc6f93..a332f68 100644
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


--===============2390045553138574509==--

