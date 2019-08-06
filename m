Content-Type: multipart/mixed; boundary="===============1640060293259915186=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: Do not leak CID on failure to assign context
Date: Tue, 06 Aug 2019 23:11:09 +0000
Message-ID: <20190806231109.27727-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1640060293259915186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

---
 src/gprs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index bdb8c8a2..723013b7 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -271,6 +271,9 @@ static gboolean assign_context(struct pri_context *ctx,=
 unsigned int use_cid)
 		return TRUE;
 	}
 =

+	l_uintset_take(used_cids, ctx->context.cid);
+	ctx->context.cid =3D 0;
+
 	return FALSE;
 }
 =

-- =

2.20.1


--===============1640060293259915186==--

