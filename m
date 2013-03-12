Content-Type: multipart/mixed; boundary="===============1584409116757541259=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 04/20] handsfree-audio: Add user data to connect declaration
Date: Tue, 12 Mar 2013 11:21:28 -0300
Message-ID: <1363098104-16467-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1584409116757541259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the user data in the Handsfree Audio driver connect
callback declaration.
---
 include/handsfree-audio.h | 3 ++-
 src/handsfree-audio.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 1a059b3..c7a37dc 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -35,7 +35,8 @@ struct ofono_handsfree_card_driver {
 	uint16_t version;
 	int (*probe) (struct ofono_handsfree_card *card, void *data);
 	void (*remove) (struct ofono_handsfree_card *card);
-	int (*audio_connect) (const char *remote, const char *local);
+	int (*audio_connect) (const char *remote, const char *local,
+							void *data);
 };
 =

 int ofono_handsfree_card_driver_register(
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 52e1ede..c9fed48 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -290,7 +290,7 @@ static DBusMessage *card_connect(DBusConnection *conn,
 	if (card->msg)
 		return __ofono_error_busy(msg);
 =

-	sk =3D driver->audio_connect(card->remote, card->local);
+	sk =3D driver->audio_connect(card->remote, card->local, card->data);
 	if (sk < 0)
 		return __ofono_error_failed(msg);
 =

-- =

1.7.11.7


--===============1584409116757541259==--

