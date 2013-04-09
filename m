Content-Type: multipart/mixed; boundary="===============5642738657107191549=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/8] include: ofono_handsfree_card_select_codec()
Date: Tue, 09 Apr 2013 17:45:38 -0300
Message-ID: <1365540343-8394-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365540343-8394-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5642738657107191549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will be used by the drivers that a given codec was negotiated
for a card.
---
 include/handsfree-audio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 82d1312..5d8e2b2 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -48,6 +48,8 @@ struct ofono_handsfree_card *ofono_handsfree_card_create(=
unsigned int vendor,
 							void *data);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
+int ofono_handsfree_card_select_codec(struct ofono_handsfree_card *card,
+							unsigned char codec);
 =

 ofono_bool_t ofono_handsfree_audio_has_wideband(void);
 =

-- =

1.8.2


--===============5642738657107191549==--

