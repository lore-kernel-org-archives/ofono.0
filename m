Content-Type: multipart/mixed; boundary="===============2128695131175982565=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 1/4] store: Add utilities for mms settings file access
Date: Mon, 23 Jul 2012 16:18:14 +0200
Message-ID: <1343053097-8908-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1343053097-8908-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2128695131175982565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/store.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/store.h |    4 ++++
 2 files changed, 60 insertions(+)

diff --git a/src/store.c b/src/store.c
index 88d9e77..b09c17b 100644
--- a/src/store.c
+++ b/src/store.c
@@ -358,3 +358,59 @@ void mms_store_meta_close(const char *service_id, cons=
t char *uuid,
 =

 	g_key_file_free(keyfile);
 }
+
+GKeyFile *mms_settings_open(const char *service_id, const char *store)
+{
+	GKeyFile *keyfile;
+	char *path;
+
+	if (store =3D=3D NULL)
+		return NULL;
+
+	path =3D mms_store_get_path(service_id, store);
+	if (path =3D=3D NULL)
+		return NULL;
+
+	if (create_dirs(path, S_IRUSR | S_IWUSR | S_IXUSR) !=3D 0) {
+		mms_error("Failed to create path %s", path);
+
+		g_free(path);
+		return NULL;
+	}
+
+	keyfile =3D g_key_file_new();
+
+	g_key_file_load_from_file(keyfile, path, 0, NULL);
+
+	g_free(path);
+
+	return keyfile;
+}
+
+static void settings_sync(const char *service_id, const char *store,
+							GKeyFile *keyfile)
+{
+	char *path;
+	char *data;
+	gsize length =3D 0;
+
+	path =3D mms_store_get_path(service_id, store);
+	if (path =3D=3D NULL)
+		return;
+
+	data =3D g_key_file_to_data(keyfile, &length, NULL);
+
+	g_file_set_contents(path, data, length, NULL);
+
+	g_free(data);
+	g_free(path);
+}
+
+void mms_settings_close(const char *service_id, const char *store,
+					GKeyFile *keyfile, gboolean save)
+{
+	if (save =3D=3D TRUE)
+		settings_sync(service_id, store, keyfile);
+
+	g_key_file_free(keyfile);
+}
diff --git a/src/store.h b/src/store.h
index 21f11be..ba2c080 100644
--- a/src/store.h
+++ b/src/store.h
@@ -28,3 +28,7 @@ char *mms_store_get_path(const char *service_id, const ch=
ar *uuid);
 GKeyFile *mms_store_meta_open(const char *service_id, const char *uuid);
 void mms_store_meta_close(const char *service_id, const char *uuid,
 					GKeyFile *keyfile, gboolean save);
+
+GKeyFile *mms_settings_open(const char *service_id, const char *store);
+void mms_settings_close(const char *service_id, const char *store,
+					GKeyFile *keyfile, gboolean save);
-- =

1.7.9.5


--===============2128695131175982565==--

