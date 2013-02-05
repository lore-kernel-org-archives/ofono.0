Content-Type: multipart/mixed; boundary="===============6304238083988306549=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 3/5] emulator: Add set/get data APIs
Date: Tue, 05 Feb 2013 17:26:58 +0100
Message-ID: <1360081620-19458-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1360081620-19458-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6304238083988306549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index c3165eb..14a39f3 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -52,6 +52,8 @@ struct ofono_emulator {
 	gboolean clip;
 	gboolean ccwa;
 	int pns_id;
+	void *data;
+	ofono_destroy_func destroy;
 };
 =

 struct indicator {
@@ -951,6 +953,9 @@ static void emulator_remove(struct ofono_atom *atom)
 =

 	DBG("atom: %p", atom);
 =

+	if (em->destroy)
+		em->destroy(em->data);
+
 	g_free(em);
 }
 =

@@ -994,6 +999,18 @@ void ofono_emulator_remove(struct ofono_emulator *em)
 	__ofono_atom_free(em->atom);
 }
 =

+void ofono_emulator_set_data(struct ofono_emulator *em, void *data,
+						ofono_destroy_func destroy)
+{
+	em->data =3D data;
+	em->destroy =3D destroy;
+}
+
+void *ofono_emulator_get_data(struct ofono_emulator *em)
+{
+	return em->data;
+}
+
 void ofono_emulator_send_final(struct ofono_emulator *em,
 				const struct ofono_error *final)
 {
-- =

1.7.9.5


--===============6304238083988306549==--

