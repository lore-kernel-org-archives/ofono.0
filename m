Content-Type: multipart/mixed; boundary="===============2220564112531126691=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/5] include: Add ofono_handsfree_card_connect_sco()
Date: Wed, 27 Mar 2013 21:12:59 -0300
Message-ID: <1364429582-12518-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1364429582-12518-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2220564112531126691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will be used by HFP plugins to tell the core that a SCO connection
needs to be established.
---
 include/handsfree-audio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 8c16b22..49b0605 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -61,6 +61,8 @@ void ofono_handsfree_card_set_local(struct ofono_handsfre=
e_card *card,
 					const char *local);
 const char *ofono_handsfree_card_get_local(struct ofono_handsfree_card *ca=
rd);
 =

+int ofono_handsfree_card_connect_sco(struct ofono_handsfree_card *card);
+
 void ofono_handsfree_audio_ref(void);
 void ofono_handsfree_audio_unref(void);
 =

-- =

1.8.2


--===============2220564112531126691==--

