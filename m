Content-Type: multipart/mixed; boundary="===============7931874802095236179=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 9/9] call-settings: apply rule M11 of coding style
Date: Wed, 12 Jan 2011 09:27:47 -0200
Message-ID: <1294831667-7447-10-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294831667-7447-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7931874802095236179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-settings.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index 0214abf..109f130 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -41,32 +41,32 @@ static GSList *g_drivers =3D NULL;
 =

 /* 27.007 Section 7.7 */
 enum clir_status {
-	CLIR_STATUS_NOT_PROVISIONED =3D 0,
-	CLIR_STATUS_PROVISIONED_PERMANENT,
-	CLIR_STATUS_UNKNOWN,
-	CLIR_STATUS_TEMPORARY_RESTRICTED,
-	CLIR_STATUS_TEMPORARY_ALLOWED
+	CLIR_STATUS_NOT_PROVISIONED =3D		0,
+	CLIR_STATUS_PROVISIONED_PERMANENT =3D	1,
+	CLIR_STATUS_UNKNOWN =3D			2,
+	CLIR_STATUS_TEMPORARY_RESTRICTED =3D	3,
+	CLIR_STATUS_TEMPORARY_ALLOWED =3D		4
 };
 =

 /* 27.007 Section 7.6 */
 enum clip_status {
-	CLIP_STATUS_NOT_PROVISIONED =3D 0,
-	CLIP_STATUS_PROVISIONED,
-	CLIP_STATUS_UNKNOWN
+	CLIP_STATUS_NOT_PROVISIONED =3D		0,
+	CLIP_STATUS_PROVISIONED =3D		1,
+	CLIP_STATUS_UNKNOWN =3D			2
 };
 =

 /* 27.007 Section 7.30 */
 enum cnap_status {
-	CNAP_STATUS_NOT_PROVISIONED =3D 0,
-	CNAP_STATUS_PROVISIONED,
-	CNAP_STATUS_UNKNOWN
+	CNAP_STATUS_NOT_PROVISIONED =3D		0,
+	CNAP_STATUS_PROVISIONED =3D		1,
+	CNAP_STATUS_UNKNOWN =3D			2
 };
 =

 /* 27.007 Section 7.8 */
 enum colp_status {
-	COLP_STATUS_NOT_PROVISIONED =3D 0,
-	COLP_STATUS_PROVISIONED =3D 1,
-	COLP_STATUS_UNKNOWN =3D 2
+	COLP_STATUS_NOT_PROVISIONED =3D		0,
+	COLP_STATUS_PROVISIONED =3D		1,
+	COLP_STATUS_UNKNOWN =3D			2
 };
 =

 /* 27.007 Section 7.9 */
@@ -78,9 +78,9 @@ enum cdip_status {
 =

 /* This is not defined in 27.007, but presumably the same as CLIP/COLP */
 enum colr_status {
-	COLR_STATUS_NOT_PROVISIONED =3D 0,
-	COLR_STATUS_PROVISIONED =3D 1,
-	COLR_STATUS_UNKNOWN =3D 2
+	COLR_STATUS_NOT_PROVISIONED =3D		0,
+	COLR_STATUS_PROVISIONED =3D		1,
+	COLR_STATUS_UNKNOWN =3D			2
 };
 =

 enum call_setting_type {
-- =

1.7.3.5


--===============7931874802095236179==--

