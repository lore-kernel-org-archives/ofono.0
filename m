Content-Type: multipart/mixed; boundary="===============1924940119580878448=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 3/7] emulator: Add removed notification mechanism
Date: Fri, 12 Apr 2013 17:41:01 -0300
Message-ID: <1365799265-19946-4-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365799265-19946-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1924940119580878448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This mechanism is used to notify when an emulator is about to be freed.
---
 src/emulator.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 6071615..890ea20 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -75,6 +75,7 @@ struct ofono_emulator {
 	gboolean clip;
 	gboolean ccwa;
 	int pns_id;
+	struct cb_data *removed_cb;
 };
 =

 struct indicator {
@@ -985,6 +986,13 @@ static void emulator_remove(struct ofono_atom *atom)
 =

 	DBG("atom: %p", atom);
 =

+	if (em->removed_cb) {
+		ofono_emulator_removed_cb_t cb =3D em->removed_cb->cb;
+
+		cb(em->removed_cb->data);
+		g_free(em->removed_cb);
+	}
+
 	g_free(em);
 }
 =

@@ -1028,6 +1036,15 @@ void ofono_emulator_remove(struct ofono_emulator *em)
 	__ofono_atom_free(em->atom);
 }
 =

+void ofono_emulator_set_removed_cb(struct ofono_emulator* em,
+				ofono_emulator_removed_cb_t cb, void *data)
+{
+	if (em =3D=3D NULL)
+		return;
+
+	em->removed_cb =3D cb_data_new(cb, data);
+}
+
 void ofono_emulator_send_final(struct ofono_emulator *em,
 				const struct ofono_error *final)
 {
-- =

1.7.9.5


--===============1924940119580878448==--

