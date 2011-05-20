Content-Type: multipart/mixed; boundary="===============4285667631689205458=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/7] gprs: remove set but not used var
Date: Fri, 20 May 2011 16:03:40 -0300
Message-ID: <1305918225-8438-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305918225-8438-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4285667631689205458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 9d6e829..559a43d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -276,14 +276,11 @@ static void gprs_cid_release(struct ofono_gprs *gprs,=
 unsigned int id)
 static gboolean assign_context(struct pri_context *ctx)
 {
 	struct idmap *cidmap =3D ctx->gprs->cid_map;
-	unsigned int cid_min;
 	GSList *l;
 =

 	if (cidmap =3D=3D NULL)
 		return FALSE;
 =

-	cid_min =3D idmap_get_min(cidmap);
-
 	ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);
 	if (ctx->context.cid =3D=3D 0)
 		return FALSE;
-- =

1.7.5.1


--===============4285667631689205458==--

