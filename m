Content-Type: multipart/mixed; boundary="===============0287852909434566282=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 6/9] gprs: custom cid for assign_context
Date: Thu, 17 Mar 2016 18:02:17 +0100
Message-ID: <1458234140-7936-7-git-send-email-dragos@endocode.com>
In-Reply-To: <1458234140-7936-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0287852909434566282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's optional though. If 0 a cid is picked up automatically from the
allowed range.
---
 src/gprs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 664c377..e5e7abc 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -283,12 +283,17 @@ static unsigned int gprs_cid_alloc(struct ofono_gprs =
*gprs)
 	return idmap_alloc(gprs->cid_map);
 }
 =

+static void gprs_cid_take(struct ofono_gprs *gprs, unsigned int id)
+{
+	idmap_take(gprs->cid_map, id);
+}
+
 static void gprs_cid_release(struct ofono_gprs *gprs, unsigned int id)
 {
 	idmap_put(gprs->cid_map, id);
 }
 =

-static gboolean assign_context(struct pri_context *ctx)
+static gboolean assign_context(struct pri_context *ctx, int use_cid)
 {
 	struct idmap *cidmap =3D ctx->gprs->cid_map;
 	GSList *l;
@@ -296,7 +301,12 @@ static gboolean assign_context(struct pri_context *ctx)
 	if (cidmap =3D=3D NULL)
 		return FALSE;
 =

-	ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);
+	if (use_cid > 0) {
+		gprs_cid_take(ctx->gprs, use_cid);
+		ctx->context.cid =3D use_cid;
+	} else
+		ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);
+
 	if (ctx->context.cid =3D=3D 0)
 		return FALSE;
 =

@@ -1248,7 +1258,7 @@ static DBusMessage *pri_set_property(DBusConnection *=
conn,
 		if (ctx->gprs->flags & GPRS_FLAG_ATTACHING)
 			return __ofono_error_attach_in_progress(msg);
 =

-		if (value && assign_context(ctx) =3D=3D FALSE)
+		if (value && assign_context(ctx, 0) =3D=3D FALSE)
 			return __ofono_error_not_implemented(msg);
 =

 		gc =3D ctx->context_driver;
-- =

2.5.0


--===============0287852909434566282==--

