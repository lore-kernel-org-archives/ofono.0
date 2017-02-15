Content-Type: multipart/mixed; boundary="===============4231032832315018878=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] gprs: fix error check of gprs_cid_alloc function
Date: Wed, 15 Feb 2017 17:54:21 +0100
Message-ID: <20170215165421.30121-2-c.ronco@kerlink.fr>
In-Reply-To: <20170215165421.30121-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4231032832315018878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When there is no context id available, idmap_alloc and
gprs_cid_alloc return max + 1.
---
 src/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index 5015a2fc..6ed1c89d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -313,7 +313,7 @@ static gboolean assign_context(struct pri_context *ctx,=
 int use_cid)
 	} else
 		ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);
 =

-	if (ctx->context.cid =3D=3D 0)
+	if (ctx->context.cid > idmap_get_max(cidmap))
 		return FALSE;
 =

 	for (l =3D ctx->gprs->context_drivers; l; l =3D l->next) {
-- =

2.11.0


--===============4231032832315018878==--

