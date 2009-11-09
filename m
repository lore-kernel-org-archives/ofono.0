Content-Type: multipart/mixed; boundary="===============0387982635210510143=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 2/4] add create/destroy_interface to ofono_gprs_context_driver
Date: Mon, 09 Nov 2009 15:37:59 +0800
Message-ID: <1257752281-22251-2-git-send-email-martin.xu@intel.com>
In-Reply-To: <1257752281-22251-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0387982635210510143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |    4 ++++
 src/gprs.c             |   20 ++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index adb0820..b8c770d 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -57,6 +57,10 @@ struct ofono_gprs_context_driver {
 	void (*deactivate_primary)(struct ofono_gprs_context *gc,
 					unsigned int id,
 					ofono_gprs_context_cb_t cb, void *data);
+	void (*create_interface)(struct ofono_gprs_context *gc,
+				struct ofono_gprs_primary_context *ctx);
+	void (*destroy_interface)(struct ofono_gprs_context *gc,
+				struct ofono_gprs_primary_context *ctx);
 };
 =

 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc, unsigne=
d id);
diff --git a/src/gprs.c b/src/gprs.c
index 18ae82a..60d26ec 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -498,21 +498,29 @@ static struct pri_context *pri_context_create(struct =
ofono_gprs *gprs,
 						const char *name,
 						enum gprs_context_type type)
 {
-	struct pri_context *context =3D g_try_new0(struct pri_context, 1);
+	struct ofono_gprs_context *gc =3D gprs->context_driver;
+	struct pri_context *ctx =3D g_try_new0(struct pri_context, 1);
 =

-	if (!context)
+	if (!ctx)
 		return NULL;
 =

-	context->gprs =3D gprs;
-	strcpy(context->name, name);
-	context->type =3D type;
+	ctx->gprs =3D gprs;
+	strcpy(ctx->name, name);
+	ctx->type =3D type;
+
+	if (gc->driver->create_interface)
+		gc->driver->create_interface(gc, &ctx->context);
 =

-	return context;
+	return ctx;
 }
 =

 static void pri_context_destroy(gpointer userdata)
 {
 	struct pri_context *ctx =3D userdata;
+	struct ofono_gprs_context *gc =3D ctx->gprs->context_driver;
+
+	if (gc->driver->destroy_interface)
+		gc->driver->destroy_interface(gc, &ctx->context);
 =

 	if (ctx->path)
 		g_free(ctx->path);
-- =

1.6.1.3


--===============0387982635210510143==--

