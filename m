Content-Type: multipart/mixed; boundary="===============4338208362358559731=="
MIME-Version: 1.0
From: Lasse.Kunnasluoto@tieto.com
Subject: [PATCH] gprs: Fixing mem leak
Date: Mon, 10 Jan 2011 09:08:54 +0200
Message-ID: <3A42A4F4F2ABA44EBD5853ED09926647124764804B@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4338208362358559731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 58166f8..aeb505f 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1152,8 +1152,10 @@ static struct pri_context *pri_context_create(struct=
 ofono_gprs *gprs,
 =

 	if (name =3D=3D NULL) {
 		name =3D gprs_context_default_name(type);
-		if (name =3D=3D NULL)
+		if (name =3D=3D NULL) {
+			g_free(context);
 			return NULL;
+		}
 	}
 =

 	context->gprs =3D gprs;
-- =

1.7.0.4


--===============4338208362358559731==--

