Content-Type: multipart/mixed; boundary="===============8095592160652029925=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 1/2] isimodem: gprs-context: properly null terminate
 cd->password
Date: Mon, 17 Jun 2019 14:38:04 -0400
Message-ID: <20190617183805.32599-1-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8095592160652029925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It looks like a previous line was copied and cd->username was re-terminated
instead of password. This also fixes a compiler error when using GCC 9:

In function =E2=80=98strncpy=E2=80=99,
    inlined from =E2=80=98isi_gprs_activate_primary=E2=80=99 at drivers/isi=
modem/gprs-context.c:546:3:
/usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_strn=
cpy=E2=80=99 output may be truncated copying 53 bytes from a string of leng=
th 255 [-Werror=3Dstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__de=
st));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
---
 drivers/isimodem/gprs-context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index 9ccc7f15..4076ed8b 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -544,7 +544,7 @@ static void isi_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 		strncpy(cd->username, ctx->username, GPDS_MAX_USERNAME_LENGTH);
 		cd->username[GPDS_MAX_USERNAME_LENGTH] =3D '\0';
 		strncpy(cd->password, ctx->password, GPDS_MAX_PASSWORD_LENGTH);
-		cd->username[GPDS_MAX_PASSWORD_LENGTH] =3D '\0';
+		cd->password[GPDS_MAX_PASSWORD_LENGTH] =3D '\0';
 	}
 =

 	cd->pep =3D g_isi_pep_create(cd->idx, NULL, NULL);
-- =

2.21.0


--===============8095592160652029925==--

