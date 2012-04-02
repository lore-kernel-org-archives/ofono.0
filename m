Content-Type: multipart/mixed; boundary="===============0183013474062225814=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v3 06/12] emulator: Add audio transport set
Date: Mon, 02 Apr 2012 15:27:16 +0200
Message-ID: <1333373242-11117-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333373242-11117-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0183013474062225814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index e7c7d41..dc3c10d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -52,6 +52,7 @@ struct ofono_emulator {
 	gboolean clip;
 	gboolean ccwa;
 	int pns_id;
+	char *audio_transport;
 };
 =

 struct indicator {
@@ -954,6 +955,7 @@ static void emulator_remove(struct ofono_atom *atom)
 =

 	DBG("atom: %p", atom);
 =

+	g_free(em->audio_transport);
 	g_free(em);
 }
 =

@@ -997,6 +999,12 @@ void ofono_emulator_remove(struct ofono_emulator *em)
 	__ofono_atom_free(em->atom);
 }
 =

+void ofono_emulator_set_audio_transport(struct ofono_emulator *em,
+						const char *path)
+{
+	em->audio_transport =3D g_strdup(path);
+}
+
 void ofono_emulator_send_final(struct ofono_emulator *em,
 				const struct ofono_error *final)
 {
-- =

1.7.1


--===============0183013474062225814==--

