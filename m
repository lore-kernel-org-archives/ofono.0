Content-Type: multipart/mixed; boundary="===============6723581926637657791=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 09/10] handsfree-audio: Add function to get hfp version
Date: Thu, 28 Feb 2013 15:52:51 -0300
Message-ID: <1362077572-28049-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6723581926637657791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a new function to read the local supported Handsfree
Profile version.
---
 include/handsfree-audio.h | 1 +
 src/handsfree-audio.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index c5403c7..96597c2 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -34,6 +34,7 @@ struct ofono_handsfree_card *ofono_handsfree_card_create(=
const char *remote,
 							const char *local);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
+enum hfp_version ofono_handsfree_get_version();
 =

 void ofono_handsfree_audio_ref(void);
 void ofono_handsfree_audio_unref(void);
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index d0ccf29..955c6ef 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -363,6 +363,11 @@ void ofono_handsfree_card_remove(struct ofono_handsfre=
e_card *card)
 	g_free(card);
 }
 =

+enum hfp_version ofono_handsfree_get_version()
+{
+	return local_hfp_version;
+}
+
 static void agent_free(struct agent *agent)
 {
 	if (agent->watch > 0)
-- =

1.7.11.7


--===============6723581926637657791==--

