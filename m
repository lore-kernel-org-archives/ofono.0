Content-Type: multipart/mixed; boundary="===============4205049994970077404=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/6] handsfree-audio: Implement
 ofono_handsfree_audio_has_wideband
Date: Mon, 08 Apr 2013 19:41:00 -0300
Message-ID: <1365460863-14645-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365460863-14645-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4205049994970077404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 3f24a2a..699c8cc 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -71,6 +71,7 @@ static int ref_count =3D 0;
 static GSList *card_list =3D 0;
 static guint sco_watch =3D 0;
 static GSList *drivers =3D 0;
+static ofono_bool_t has_wideband =3D FALSE;
 =

 static void send_new_connection(const char *card, int fd)
 {
@@ -541,6 +542,11 @@ void ofono_handsfree_card_remove(struct ofono_handsfre=
e_card *card)
 	g_free(card);
 }
 =

+ofono_bool_t ofono_handsfree_audio_has_wideband(void)
+{
+	return has_wideband;
+}
+
 static void agent_free(struct agent *agent)
 {
 	if (agent->watch > 0)
-- =

1.8.2


--===============4205049994970077404==--

