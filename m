Content-Type: multipart/mixed; boundary="===============1087931664455506759=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/9] Make sim operations return sim error codes to core.
Date: Tue, 29 Jun 2010 12:14:03 +0200
Message-ID: <1277806448-5322-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277806448-5322-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1087931664455506759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/stk.c |   20 ++++++++++++--------
 include/types.h       |    1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index 8cff4a2..aede668 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -74,11 +74,13 @@ static void at_csim_envelope_cb(gboolean ok, GAtResult =
*result,
 	if (rlen !=3D len * 2 || len < 2)
 		goto error;
 =

-	if (response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91)
-		goto error;
+	if ((response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91) ||
+			(response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)) {
+		memset(&error, 0, sizeof(error));
 =

-	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
-		goto error;
+		error.type =3D OFONO_ERROR_TYPE_SIM;
+		error.error =3D (response[len - 2] << 8) | response[len - 1];
+	}
 =

 	DBG("csim_envelope_cb: %i", len);
 =

@@ -157,11 +159,13 @@ static void at_csim_terminal_response_cb(gboolean ok,=
 GAtResult *result,
 	if (rlen !=3D len * 2 || len < 2)
 		goto error;
 =

-	if (response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91)
-		goto error;
+	if ((response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91) ||
+			(response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)) {
+		memset(&error, 0, sizeof(error));
 =

-	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
-		goto error;
+		error.type =3D OFONO_ERROR_TYPE_SIM;
+		error.error =3D (response[len - 2] << 8) | response[len - 1];
+	}
 =

 	DBG("csim_terminal_response_cb: %i", len);
 =

diff --git a/include/types.h b/include/types.h
index 2b154f0..6098cba 100644
--- a/include/types.h
+++ b/include/types.h
@@ -60,6 +60,7 @@ enum ofono_error_type {
 	OFONO_ERROR_TYPE_CME,
 	OFONO_ERROR_TYPE_CMS,
 	OFONO_ERROR_TYPE_CEER,
+	OFONO_ERROR_TYPE_SIM,
 	OFONO_ERROR_TYPE_FAILURE
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============1087931664455506759==--

