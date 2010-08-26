Content-Type: multipart/mixed; boundary="===============6484217513391097305=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] simutil: Fix compilation with gcc 4.3.2
Date: Thu, 26 Aug 2010 14:36:31 +0200
Message-ID: <1282826191-17988-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6484217513391097305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This gcc version gives two signed / unsigned comparison warnings.
---
 src/simutil.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 2d0764c..ac054ae 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1420,7 +1420,7 @@ gboolean sim_parse_2g_get_response(const unsigned cha=
r *response, int len,
 gboolean sim_ust_is_available(unsigned char *efust, unsigned char len,
 						enum sim_ust_service index)
 {
-	if (index >=3D len * 8)
+	if (index >=3D len * 8u)
 		return FALSE;
 =

 	return (efust[index / 8] >> (index % 8)) & 1;
@@ -1429,7 +1429,7 @@ gboolean sim_ust_is_available(unsigned char *efust, u=
nsigned char len,
 gboolean sim_est_is_active(unsigned char *efest, unsigned char len,
 						enum sim_est_service index)
 {
-	if (index >=3D len * 8)
+	if (index >=3D len * 8u)
 		return FALSE;
 =

 	return (efest[index / 8] >> (index % 8)) & 1;
-- =

1.7.1.86.g0e460.dirty


--===============6484217513391097305==--

