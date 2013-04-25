Content-Type: multipart/mixed; boundary="===============3703104555000128202=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/3] handsfree-audio: Implement
 ofono_handsfree_audio_has_defer_setup()
Date: Thu, 25 Apr 2013 16:05:16 -0300
Message-ID: <1366916717-30796-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366916717-30796-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3703104555000128202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index dc37853..d78498a 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -562,6 +562,11 @@ ofono_bool_t ofono_handsfree_audio_has_wideband(void)
 	return has_wideband;
 }
 =

+ofono_bool_t ofono_handsfree_audio_has_defer_setup(void)
+{
+	return defer_setup =3D=3D 1;
+}
+
 static void agent_free(struct agent *agent)
 {
 	if (agent->watch > 0)
-- =

1.8.2.1


--===============3703104555000128202==--

