Content-Type: multipart/mixed; boundary="===============0278463489308463101=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 04/15] handsfree-audio: Add version to card driver
Date: Tue, 12 Mar 2013 09:42:02 -0300
Message-ID: <1363092133-1092-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0278463489308463101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch extends the Handsfree Audio Card driver adding the Handsfree
Profile version to allow switching different drivers to manage SCO
connections or any other specific action related to a given profile
version.
---
 include/handsfree-audio.h | 4 +++-
 src/handsfree-audio.c     | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 69f5a8e..e99a2dd 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -26,11 +26,13 @@
 extern "C" {
 #endif
 =

+#include <stdint.h>
 #include <ofono/types.h>
 =

 struct ofono_handsfree_card;
 =

 struct ofono_handsfree_card_driver {
+	uint16_t version;
 	int (*probe) (struct ofono_handsfree_card *card, void *data);
 	void (*remove) (struct ofono_handsfree_card *card);
 	int (*audio_connect) (const char *remote, const char *local);
@@ -42,7 +44,7 @@ void ofono_handsfree_card_driver_unregister(
 			const struct ofono_handsfree_card_driver *d);
 =

 struct ofono_handsfree_card *ofono_handsfree_card_create(const char *remot=
e,
-							const char *local);
+					const char *local, uint16_t version);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
 =

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index ffae47b..1e636cc 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -254,7 +254,7 @@ static const GDBusSignalTable card_signals[] =3D {
 };
 =

 struct ofono_handsfree_card *ofono_handsfree_card_create(const char *remot=
e,
-							const char *local)
+					const char *local, uint16_t version)
 {
 	struct ofono_handsfree_card *card;
 	GSList *l;
@@ -269,6 +269,9 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(const char *remote,
 	for (l =3D g_drivers; l; l =3D g_slist_next(l)) {
 		const struct ofono_handsfree_card_driver *drv =3D l->data;
 =

+		if (drv->version !=3D version)
+			continue;
+
 		if (drv->probe(card, NULL) < 0)
 			continue;
 =

-- =

1.7.11.7


--===============0278463489308463101==--

