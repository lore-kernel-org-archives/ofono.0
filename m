Content-Type: multipart/mixed; boundary="===============6610827417500194575=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] handsfree-audio: Fix missing card index increment
Date: Tue, 26 Feb 2013 18:42:43 -0300
Message-ID: <1361914963-24197-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6610827417500194575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index db65971..acd08e4 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -165,7 +165,7 @@ int ofono_handsfree_card_register(struct ofono_handsfre=
e_card *card)
 	if (card =3D=3D NULL)
 		return -EINVAL;
 =

-	snprintf(path, sizeof(path), "/card_%d", next_card_id);
+	snprintf(path, sizeof(path), "/card_%d", next_card_id++);
 =

 	if (!g_dbus_register_interface(ofono_dbus_get_connection(), path,
 					HFP_AUDIO_CARD_INTERFACE,
-- =

1.7.11.7


--===============6610827417500194575==--

