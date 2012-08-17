Content-Type: multipart/mixed; boundary="===============5787662095502549535=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 08/12] store: Define MMS_META_UUID_XXX len and suffix
Date: Fri, 17 Aug 2012 16:35:09 +0200
Message-ID: <1345214113-25597-9-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345214113-25597-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5787662095502549535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/store.c |    8 +++-----
 src/store.h |    5 +++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/store.c b/src/store.c
index b09c17b..f1c5714 100644
--- a/src/store.c
+++ b/src/store.c
@@ -42,8 +42,6 @@
 #define TFR
 #endif
 =

-#define MMS_SHA1_UUID_LEN 20
-
 static const char *digest_to_str(const unsigned char *digest)
 {
 	static char buf[MMS_SHA1_UUID_LEN * 2 + 1];
@@ -293,7 +291,7 @@ void mms_store_remove(const char *service_id, const cha=
r *uuid)
 =

 	unlink(pdu_path);
 =

-	meta_path =3D g_strdup_printf("%s%s", pdu_path, ".status");
+	meta_path =3D g_strdup_printf("%s%s", pdu_path, MMS_META_UUID_SUFFIX);
 =

 	g_free(pdu_path);
 =

@@ -312,7 +310,7 @@ GKeyFile *mms_store_meta_open(const char *service_id, c=
onst char *uuid)
 	if (pdu_path =3D=3D NULL)
 		return NULL;
 =

-	meta_path =3D g_strdup_printf("%s%s", pdu_path, ".status");
+	meta_path =3D g_strdup_printf("%s%s", pdu_path, MMS_META_UUID_SUFFIX);
 =

 	g_free(pdu_path);
 =

@@ -337,7 +335,7 @@ static void meta_store_sync(const char *service_id, con=
st char *uuid,
 	if (pdu_path =3D=3D NULL)
 		return;
 =

-	meta_path =3D g_strdup_printf("%s%s", pdu_path, ".status");
+	meta_path =3D g_strdup_printf("%s%s", pdu_path, MMS_META_UUID_SUFFIX);
 =

 	g_free(pdu_path);
 =

diff --git a/src/store.h b/src/store.h
index ba2c080..fb2ca9f 100644
--- a/src/store.h
+++ b/src/store.h
@@ -19,6 +19,11 @@
  *
  */
 =

+#define MMS_SHA1_UUID_LEN 20
+#define MMS_META_UUID_SUFFIX ".status"
+#define MMS_META_UUID_SUFFIX_LEN 7
+#define MMS_META_UUID_LEN (MMS_SHA1_UUID_LEN * 2)
+
 const char *mms_store(const char *service_id, unsigned char *pdu,
 							unsigned int len);
 const char *mms_store_file(const char *service_id, const char *path);
-- =

1.7.9.5


--===============5787662095502549535==--

