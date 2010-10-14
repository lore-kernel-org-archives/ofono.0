Content-Type: multipart/mixed; boundary="===============1362666343136630115=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 2/8] simutil: response-handler returns now also file-status
Date: Fri, 15 Oct 2010 00:02:49 +0300
Message-ID: <1287090175-3018-3-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1287090175-3018-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1362666343136630115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |    5 ++++-
 src/simutil.h |   10 +++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index ed0970c..0474d2a 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1406,7 +1406,8 @@ gboolean sim_parse_3g_get_response(const unsigned cha=
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
@@ -1421,6 +1422,8 @@ gboolean sim_parse_2g_get_response(const unsigned cha=
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
index 69ef528..dc4ff57 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -58,6 +58,13 @@ enum sim_file_access {
 	SIM_FILE_ACCESS_NEVER =3D 15,
 };
 =

+/* 51.011 Section 9.3 */
+enum sim_file_status {
+	SIM_FILE_STATUS_INVALID			=3D 0x00,
+	SIM_FILE_STATUS_VALID			=3D 0x01,
+	SIM_FILE_STATUS_RW_WHEN_INVALID		=3D 0x04,
+};
+
 /* 131.102 Section 4.2.8 */
 enum sim_ust_service {
 	SIM_UST_SERVICE_LOCAL_PHONE_BOOK		=3D 0,
@@ -426,7 +433,8 @@ gboolean sim_parse_3g_get_response(const unsigned char =
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



--===============1362666343136630115==--

