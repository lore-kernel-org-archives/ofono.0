Content-Type: multipart/mixed; boundary="===============6396431769616665859=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 2/6] emulator: Add removed notification mechanism
Date: Wed, 10 Apr 2013 16:24:43 -0300
Message-ID: <1365621887-16940-3-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365621887-16940-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6396431769616665859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 0817b5d..4a748f0 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -37,6 +37,11 @@
 =

 #define RING_TIMEOUT 3
 =

+struct removed_cb {
+	ofono_emulator_removed_cb_t cb;
+	void *data;
+};
+
 struct ofono_emulator {
 	struct ofono_atom *atom;
 	enum ofono_emulator_type type;
@@ -53,6 +58,7 @@ struct ofono_emulator {
 	gboolean clip;
 	gboolean ccwa;
 	int pns_id;
+	struct removed_cb *removed_cb;
 };
 =

 struct indicator {
@@ -952,6 +958,11 @@ static void emulator_remove(struct ofono_atom *atom)
 =

 	DBG("atom: %p", atom);
 =

+	if (em->removed_cb) {
+		em->removed_cb->cb(em->removed_cb->data);
+		g_free(em->removed_cb);
+	}
+
 	g_free(em);
 }
 =

@@ -995,6 +1006,21 @@ void ofono_emulator_remove(struct ofono_emulator *em)
 	__ofono_atom_free(em->atom);
 }
 =

+void ofono_emulator_set_removed_cb(struct ofono_emulator* em,
+				ofono_emulator_removed_cb_t cb, void *data)
+{
+	struct removed_cb *removed_cb;
+
+	if (em =3D=3D NULL)
+		return;
+
+	removed_cb =3D g_try_new0(struct removed_cb, 1);
+	removed_cb->cb =3D cb;
+	removed_cb->data =3D data;
+
+	em->removed_cb =3D removed_cb;
+}
+
 void ofono_emulator_send_final(struct ofono_emulator *em,
 				const struct ofono_error *final)
 {
-- =

1.7.9.5


--===============6396431769616665859==--

