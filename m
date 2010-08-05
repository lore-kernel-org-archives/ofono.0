Content-Type: multipart/mixed; boundary="===============5998239737482877566=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] atutil: Parse CMS and CME error codes.
Date: Thu, 05 Aug 2010 19:31:57 +0200
Message-ID: <1281029518-9152-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5998239737482877566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: root <root@neo.(none)>

---
 drivers/atmodem/atutil.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 5dad679..e668602 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -40,6 +40,12 @@ void decode_at_error(struct ofono_error *error, const ch=
ar *final)
 	if (!strcmp(final, "OK")) {
 		error->type =3D OFONO_ERROR_TYPE_NO_ERROR;
 		error->error =3D 0;
+	} else if (g_str_has_prefix(final, "+CMS ERROR:")) {
+		error->type =3D OFONO_ERROR_TYPE_CMS;
+		error->error =3D strtol(&final[11], NULL, 0);
+	} else if (g_str_has_prefix(final, "+CME ERROR:")) {
+		error->type =3D OFONO_ERROR_TYPE_CME;
+		error->error =3D strtol(&final[11], NULL, 0);
 	} else {
 		error->type =3D OFONO_ERROR_TYPE_FAILURE;
 		error->error =3D 0;
-- =

1.7.1.86.g0e460.dirty


--===============5998239737482877566==--

