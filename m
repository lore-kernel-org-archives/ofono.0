Content-Type: multipart/mixed; boundary="===============3553370592668041015=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH] ubloxmodem: fix maybe-unitialized error
Date: Fri, 21 Jun 2019 11:56:08 +0200
Message-ID: <20190621095608.39463-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3553370592668041015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes:

../git/drivers/ubloxmodem/gprs-context.c: In function =E2=80=98ublox_gprs_a=
ctivate_primary=E2=80=99:
../git/drivers/ubloxmodem/gprs-context.c:339:2: error: =E2=80=98auth=E2=80=
=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitializ=
ed]
  snprintf(buf, sizeof(buf), "AT+UAUTHREQ=3D%u,%u,\"%s\",\"%s\"",
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    gcd->active_context, auth, username, password);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../git/drivers/ubloxmodem/gprs-context.c:324:11: note: =E2=80=98auth=E2=80=
=99 was declared here
  unsigned auth;
           ^~~~
---
 drivers/ubloxmodem/gprs-context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 489f31e8..c5b789b6 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -321,7 +321,7 @@ static void ublox_send_uauthreq(struct ofono_gprs_conte=
xt *gc,
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	char buf[UBLOX_MAX_USER_LEN + UBLOX_MAX_PASS_LEN + 32];
-	unsigned auth;
+	unsigned auth =3D 0;
 =

 	switch (auth_method) {
 	case OFONO_GPRS_AUTH_METHOD_PAP:
-- =

2.22.0


--===============3553370592668041015==--

