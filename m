Content-Type: multipart/mixed; boundary="===============7060319777491741301=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 2/7] include: ofono_handsfree_card_select_codec()
Date: Wed, 10 Apr 2013 16:37:52 -0300
Message-ID: <1365622677-4824-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365622677-4824-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7060319777491741301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will be used by the drivers that a given codec was negotiated
for a card.
---
 include/handsfree-audio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 82d1312..2e58c43 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -48,6 +48,8 @@ struct ofono_handsfree_card *ofono_handsfree_card_create(=
unsigned int vendor,
 							void *data);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
+void ofono_handsfree_card_select_codec(struct ofono_handsfree_card *card,
+							unsigned char codec);
 =

 ofono_bool_t ofono_handsfree_audio_has_wideband(void);
 =

-- =

1.8.2


--===============7060319777491741301==--

