Content-Type: multipart/mixed; boundary="===============6922112231277241091=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/3] include: Add ofono_handsfree_audio_has_defer_setup()
Date: Thu, 25 Apr 2013 16:05:15 -0300
Message-ID: <1366916717-30796-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6922112231277241091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/handsfree-audio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 53e8ab1..846a032 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -53,6 +53,8 @@ ofono_bool_t ofono_handsfree_card_set_codec(struct ofono_=
handsfree_card *card,
 =

 ofono_bool_t ofono_handsfree_audio_has_wideband(void);
 =

+ofono_bool_t ofono_handsfree_audio_has_defer_setup(void);
+
 void ofono_handsfree_card_set_data(struct ofono_handsfree_card *card,
 					void *data);
 void *ofono_handsfree_card_get_data(struct ofono_handsfree_card *card);
-- =

1.8.2.1


--===============6922112231277241091==--

