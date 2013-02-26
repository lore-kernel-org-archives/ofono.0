Content-Type: multipart/mixed; boundary="===============2524576015626891952=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 8/9] handsfree-audio: Add Audio Cards hash table
Date: Tue, 26 Feb 2013 10:50:52 -0300
Message-ID: <1361886653-30873-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361886653-30873-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2524576015626891952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a hash table to store the created Audio Cards. This
hash is required to create Audio Manager GetCards() reply.
---
 src/handsfree-audio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index f8c598f..d839131 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -57,6 +57,7 @@ struct audio_card {
 =

 static struct agent *agent =3D NULL;
 static int ref_count =3D 0;
+static GHashTable *cards_hash =3D NULL;
 =

 static void agent_free(struct agent *agent)
 {
@@ -327,6 +328,8 @@ char *ofono_handsfree_card_create(const char *remote)
 	card->remote =3D g_strdup(remote);
 	am_emit_card_added(path, card);
 =

+	g_hash_table_insert(cards_hash, g_strdup(path), card);
+
 	DBG("Audio Card added: %s", path);
 =

 	return path;
@@ -334,6 +337,9 @@ char *ofono_handsfree_card_create(const char *remote)
 =

 void ofono_handsfree_card_remove(const char *path)
 {
+	if (!g_hash_table_remove(cards_hash, path))
+		return;
+
 	am_emit_card_removed(path);
 =

 	g_dbus_unregister_interface(ofono_dbus_get_connection(), path,
@@ -344,6 +350,8 @@ void ofono_handsfree_card_remove(const char *path)
 =

 int __ofono_handsfree_audio_manager_init(void)
 {
+	cards_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+							g_free, NULL);
 	return 0;
 }
 =

@@ -357,4 +365,6 @@ void __ofono_handsfree_audio_manager_cleanup(void)
 =

 	ref_count =3D 1;
 	ofono_handsfree_audio_unref();
+
+	g_hash_table_destroy(cards_hash);
 }
-- =

1.7.11.7


--===============2524576015626891952==--

