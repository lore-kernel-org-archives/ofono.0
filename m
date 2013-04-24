Content-Type: multipart/mixed; boundary="===============7895417394483322903=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 2/6] emulator: Implement ofono_emulator_create_card()
Date: Wed, 24 Apr 2013 14:13:47 -0300
Message-ID: <1366823631-26262-3-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366823631-26262-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7895417394483322903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 70505b5..8acdae1 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -29,6 +29,9 @@
 =

 #include <glib.h>
 =

+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/handsfree-audio.h>
+
 #include "ofono.h"
 #include "common.h"
 #include "hfp.h"
@@ -53,6 +56,7 @@ struct ofono_emulator {
 	gboolean clip;
 	gboolean ccwa;
 	int pns_id;
+	struct ofono_handsfree_card *card;
 };
 =

 struct indicator {
@@ -880,6 +884,11 @@ static void emulator_unregister(struct ofono_atom *ato=
m)
 =

 	g_at_server_unref(em->server);
 	em->server =3D NULL;
+
+	if (em->card) {
+		ofono_handsfree_card_remove(em->card);
+		em->card =3D NULL;
+	}
 }
 =

 void ofono_emulator_register(struct ofono_emulator *em, int fd)
@@ -990,6 +999,13 @@ struct ofono_emulator *ofono_emulator_create(struct of=
ono_modem *modem,
 	return em;
 }
 =

+int ofono_emulator_create_card(struct ofono_emulator *em, int fd, int vers=
ion)
+{
+	em->card =3D ofono_handsfree_card_create(0, NULL, NULL);
+
+	return 0;
+}
+
 void ofono_emulator_remove(struct ofono_emulator *em)
 {
 	__ofono_atom_free(em->atom);
-- =

1.7.9.5


--===============7895417394483322903==--

