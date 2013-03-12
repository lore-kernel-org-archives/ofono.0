Content-Type: multipart/mixed; boundary="===============4436955340103684334=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 16/20] handsfree-audio: Set CVSD as default in the card
Date: Tue, 12 Mar 2013 11:21:40 -0300
Message-ID: <1363098104-16467-17-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4436955340103684334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the device doesn't support codec negotiation, the selected codec is
not being initialized. For this case set CVSD as default.
---
 src/handsfree-audio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 0d31712..0eb5c70 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -348,6 +348,7 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(const char *remote,
 	card->remote =3D g_strdup(remote);
 	card->local =3D g_strdup(local);
 	card->data =3D data;
+	card->selected_codec =3D HFP_CODEC_CVSD;
 =

 	card_list =3D g_slist_prepend(card_list, card);
 =

-- =

1.7.11.7


--===============4436955340103684334==--

