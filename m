Content-Type: multipart/mixed; boundary="===============1063090005753287837=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 09/20] handsfree-audio: Add function to get the codecs
Date: Tue, 12 Mar 2013 11:21:33 -0300
Message-ID: <1363098104-16467-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1063090005753287837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a new handsfree-audio public function to read the
available codecs registered by the agent.
---
 include/handsfree-audio.h |  1 +
 src/handsfree-audio.c     | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index c7a37dc..839f0f8 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -49,6 +49,7 @@ struct ofono_handsfree_card *ofono_handsfree_card_create(=
const char *remote,
 					void *data);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
+int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len);
 =

 void ofono_handsfree_audio_ref(void);
 void ofono_handsfree_audio_unref(void);
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 3a7dcee..2cbdb57 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -462,6 +462,19 @@ void ofono_handsfree_card_remove(struct ofono_handsfre=
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

1.7.11.7


--===============1063090005753287837==--

