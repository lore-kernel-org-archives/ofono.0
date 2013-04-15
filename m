Content-Type: multipart/mixed; boundary="===============6070443929195530038=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 1/6] include: Add ofono_handsfree_card_set_codec()
Date: Mon, 15 Apr 2013 10:54:48 -0300
Message-ID: <1366034093-24084-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6070443929195530038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will be used by the drivers that a given codec was negotiated
for a card.

It will return FALSE if the codec can't be used. For example, if the select=
ed
codec is mSBC and defer setup is not supported by the kernel.
---
 include/handsfree-audio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 82d1312..53e8ab1 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -48,6 +48,8 @@ struct ofono_handsfree_card *ofono_handsfree_card_create(=
unsigned int vendor,
 							void *data);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
+ofono_bool_t ofono_handsfree_card_set_codec(struct ofono_handsfree_card *c=
ard,
+							unsigned char codec);
 =

 ofono_bool_t ofono_handsfree_audio_has_wideband(void);
 =

-- =

1.8.2


--===============6070443929195530038==--

