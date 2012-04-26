Content-Type: multipart/mixed; boundary="===============7340492020366195112=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v5 10/12] emulator: add set/get data APIs
Date: Thu, 26 Apr 2012 16:27:02 +0200
Message-ID: <1335450424-19964-11-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1335450424-19964-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7340492020366195112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index e7c7d41..2c40898 100644
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
@@ -954,6 +956,9 @@ static void emulator_remove(struct ofono_atom *atom)
 =

 	DBG("atom: %p", atom);
 =

+	if (em->destroy)
+		em->destroy(em->data);
+
 	g_free(em);
 }
 =

@@ -997,6 +1002,18 @@ void ofono_emulator_remove(struct ofono_emulator *em)
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

1.7.1


--===============7340492020366195112==--

