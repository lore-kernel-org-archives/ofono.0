Content-Type: multipart/mixed; boundary="===============8203320127986350597=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: [PATCH] gprs: mark context driver as not used when removing active
 context
Date: Thu, 20 Jan 2011 13:16:59 +0100
Message-ID: <1295525819-14905-1-git-send-email-tomasz.gregorek@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8203320127986350597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tomasz Gregorek <tomasz.gregorek@stericsson.com>

---
 src/gprs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 7ef81d5..0661f74 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1679,6 +1679,8 @@ static void gprs_deactivate_for_remove(const struct o=
fono_error *error,
 =

 	gprs_cid_release(gprs, ctx->context.cid);
 	ctx->context.cid =3D 0;
+	ctx->context_driver->inuse =3D FALSE;
+	ctx->context_driver =3D NULL;
 =

 	if (gprs->settings) {
 		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
-- =

1.7.1


--===============8203320127986350597==--

