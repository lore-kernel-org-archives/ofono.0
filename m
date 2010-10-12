Content-Type: multipart/mixed; boundary="===============4850768849842247351=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 3/8] simutil: response-handler returns now also file-status
Date: Tue, 12 Oct 2010 18:18:09 +0300
Message-ID: <1286896694-3054-4-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1286896694-3054-3-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4850768849842247351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |    5 ++++-
 src/simutil.h |   11 ++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 65ce1ac..04ba975 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1405,7 +1405,8 @@ gboolean sim_parse_3g_get_response(const unsigned cha=
r *data, int len,
 =

 gboolean sim_parse_2g_get_response(const unsigned char *response, int len,
 					int *file_len, int *record_len,
-					int *structure, unsigned char *access)
+					int *structure, unsigned char *access,
+					unsigned char *file_status)
 {
 	if (len < 14 || response[6] !=3D 0x04)
 		return FALSE;
@@ -1420,6 +1421,8 @@ gboolean sim_parse_2g_get_response(const unsigned cha=
r *response, int len,
 	access[1] =3D response[9];
 	access[2] =3D response[10];
 =

+	*file_status =3D response[11];
+
 	if (response[13] =3D=3D 0x01 || response[13] =3D=3D 0x03)
 		*record_len =3D response[14];
 	else
diff --git a/src/simutil.h b/src/simutil.h
index 54b99a0..bd8e4ac 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -57,6 +57,14 @@ enum sim_file_access {
 	SIM_FILE_ACCESS_NEVER =3D 15,
 };
 =

+/* 51.011 Section 9.3 */
+enum sim_file_status {
+	SIM_FILE_STATUS_INVALID			=3D 0x00,
+	SIM_FILE_STATUS_NOT_INVALID		=3D 0x01,
+	SIM_FILE_STATUS_INVALID_BUT_ACCESS	=3D 0x04,
+	SIM_FILE_STATUS_NOT_AVAILABLE		=3D 0xFF,
+};
+
 /* 131.102 Section 4.2.8 */
 enum sim_ust_service {
 	SIM_UST_SERVICE_LOCAL_PHONE_BOOK		=3D 0,
@@ -425,7 +433,8 @@ gboolean sim_parse_3g_get_response(const unsigned char =
*data, int len,
 =

 gboolean sim_parse_2g_get_response(const unsigned char *response, int len,
 					int *file_len, int *record_len,
-					int *structure, unsigned char *access);
+					int *structure, unsigned char *access,
+					unsigned char *file_status);
 =

 gboolean sim_ust_is_available(unsigned char *service_ust, unsigned char le=
n,
 						enum sim_ust_service index);
-- =

1.6.3.3



--===============4850768849842247351==--

