Content-Type: multipart/mixed; boundary="===============8617643797352833993=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/14] atmodem: Make sim operations return sim error codes.
Date: Wed, 07 Jul 2010 00:39:00 +0200
Message-ID: <1278455949-2823-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8617643797352833993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |   32 +++++++++++++++++++++++++-------
 drivers/atmodem/stk.c |   20 ++++++++++++--------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 2b4a8c6..d5d5ff9 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -82,8 +82,15 @@ static void at_crsm_info_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	if (!g_at_result_iter_next_hexstring(&iter, &response, &len) ||
 			(sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92) ||
-			(sw1 =3D=3D 0x90 && sw2 !=3D 0x00))
-		goto error;
+			(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
+		memset(&error, 0, sizeof(error));
+
+		error.type =3D OFONO_ERROR_TYPE_SIM;
+		error.error =3D (sw1 << 8) | sw2;
+
+		cb(&error, -1, -1, -1, NULL, cbd->data);
+		return;
+	}
 =

 	DBG("crsm_info_cb: %02x, %02x, %i", sw1, sw2, len);
 =

@@ -165,9 +172,18 @@ static void at_crsm_read_cb(gboolean ok, GAtResult *re=
sult,
 	g_at_result_iter_next_number(&iter, &sw1);
 	g_at_result_iter_next_number(&iter, &sw2);
 =

-	if (!g_at_result_iter_next_hexstring(&iter, &response, &len) ||
-		(sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92 && sw1 !=3D 0x9f) ||
-		(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
+	if ((sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92 && sw1 !=3D 0x9f) ||
+			(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
+		memset(&error, 0, sizeof(error));
+
+		error.type =3D OFONO_ERROR_TYPE_SIM;
+		error.error =3D (sw1 << 8) | sw2;
+
+		cb(&error, NULL, 0, cbd->data);
+		return;
+	}
+
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len)) {
 		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
 		return;
 	}
@@ -255,8 +271,10 @@ static void at_crsm_update_cb(gboolean ok, GAtResult *=
result,
 =

 	if ((sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92 && sw1 !=3D 0x9f) ||
 			(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
-		return;
+		memset(&error, 0, sizeof(error));
+
+		error.type =3D OFONO_ERROR_TYPE_SIM;
+		error.error =3D (sw1 << 8) | sw2;
 	}
 =

 	DBG("crsm_update_cb: %02x, %02x", sw1, sw2);
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

-- =

1.7.1.86.g0e460.dirty


--===============8617643797352833993==--

