Content-Type: multipart/mixed; boundary="===============8831055205254202908=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 01/10] gprs: avoid useless loop iteration
Date: Mon, 10 Jan 2011 15:15:16 +0200
Message-ID: <1294665325-11937-1-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201101101515.04596.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8831055205254202908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 58166f8..8afaffb 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1991,12 +1991,12 @@ void ofono_gprs_context_deactivated(struct ofono_gp=
rs_context *gc,
 	for (l =3D gc->gprs->contexts; l; l =3D l->next) {
 		ctx =3D l->data;
 =

-		if (ctx->active =3D=3D FALSE)
-			continue;
-
 		if (ctx->context.cid !=3D cid)
 			continue;
 =

+		if (ctx->active =3D=3D FALSE)
+			break;
+
 		gprs_cid_release(ctx->gprs, ctx->context.cid);
 		ctx->context.cid =3D 0;
 		ctx->active =3D FALSE;
-- =

1.7.1


--===============8831055205254202908==--

