Content-Type: multipart/mixed; boundary="===============7462524291102396896=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/6] include: Add ofono_handsfree_audio_has_wideband()
Date: Mon, 08 Apr 2013 19:40:59 -0300
Message-ID: <1365460863-14645-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365460863-14645-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7462524291102396896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As we can assume that the CVSD codec will be always available, the only
information that we need to export is if we have support for wideband codec=
s,
right now, only mSBC is defined.
---
 include/handsfree-audio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 49b0605..82d1312 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -49,6 +49,8 @@ struct ofono_handsfree_card *ofono_handsfree_card_create(=
unsigned int vendor,
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
 =

+ofono_bool_t ofono_handsfree_audio_has_wideband(void);
+
 void ofono_handsfree_card_set_data(struct ofono_handsfree_card *card,
 					void *data);
 void *ofono_handsfree_card_get_data(struct ofono_handsfree_card *card);
-- =

1.8.2


--===============7462524291102396896==--

