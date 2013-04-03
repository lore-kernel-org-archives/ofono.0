Content-Type: multipart/mixed; boundary="===============0968056703127872016=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/5] handsfree-audio: Add function to get the codecs
Date: Wed, 03 Apr 2013 20:24:40 -0300
Message-ID: <1365031481-10467-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365031481-10467-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0968056703127872016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch adds a new handsfree-audio public function to read the
available codecs registered by the agent.
---
 include/handsfree-audio.h |  1 +
 src/handsfree-audio.c     | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 49b0605..f8a731f 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -48,6 +48,7 @@ struct ofono_handsfree_card *ofono_handsfree_card_create(=
unsigned int vendor,
 							void *data);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
+int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len);
 =

 void ofono_handsfree_card_set_data(struct ofono_handsfree_card *card,
 					void *data);
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 3f24a2a..d1a22db 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -541,6 +541,19 @@ void ofono_handsfree_card_remove(struct ofono_handsfre=
e_card *card)
 	g_free(card);
 }
 =

+int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len)
+{
+	int len;
+
+	if (agent =3D=3D NULL)
+		return -EIO;
+
+	len =3D MIN(buffer_len, agent->codecs_len);
+	memcpy(buffer, agent->codecs, len);
+
+	return len;
+}
+
 static void agent_free(struct agent *agent)
 {
 	if (agent->watch > 0)
-- =

1.8.2


--===============0968056703127872016==--

