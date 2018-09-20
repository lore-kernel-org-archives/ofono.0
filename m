Content-Type: multipart/mixed; boundary="===============8595834023651774411=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] bugfix: src/gprs.c used the right binary NOT operator in
 bitwise operation instead of the boolean NOT operator
Date: Thu, 20 Sep 2018 06:26:13 +0200
Message-ID: <1537417573-10973-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8595834023651774411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index f17f31b..8f5d195 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1015,7 +1015,7 @@ static void pri_read_settings_callback(const struct o=
fono_error *error,
 =

 	value =3D pri_ctx->active;
 =

-	gprs->flags &=3D !GPRS_FLAG_ATTACHING;
+	gprs->flags &=3D ~GPRS_FLAG_ATTACHING;
 =

 	gprs->driver_attached =3D TRUE;
 	gprs_set_attached_property(gprs, TRUE);
-- =

1.9.1


--===============8595834023651774411==--

