Content-Type: multipart/mixed; boundary="===============4118114390608156401=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] handsfree-audio: Fix not emitting CardRemoved
Date: Tue, 26 Feb 2013 18:04:43 -0300
Message-ID: <1361912683-18938-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4118114390608156401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index db65971..c99d65b 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -194,10 +194,10 @@ static void card_unregister(struct ofono_handsfree_ca=
rd *card)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 =

-	g_dbus_unregister_interface(conn, card->path, HFP_AUDIO_CARD_INTERFACE);
-
 	emit_card_removed(card);
 =

+	g_dbus_unregister_interface(conn, card->path, HFP_AUDIO_CARD_INTERFACE);
+
 	g_free(card->path);
 	card->path =3D NULL;
 }
-- =

1.7.11.7


--===============4118114390608156401==--

