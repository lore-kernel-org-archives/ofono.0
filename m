Content-Type: multipart/mixed; boundary="===============6871218455738486506=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH 2/2] simutil: sim_fileid sorted in numerical order
Date: Tue, 21 Dec 2010 10:34:49 +0100
Message-ID: <1292924089-16706-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6871218455738486506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index fd703d1..ad317f3 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -33,14 +33,18 @@ enum sim_fileid {
 	SIM_EF_CPHS_MBDN_FILEID =3D		0x6f17,
 	SIM_EFUST_FILEID =3D			0x6f38,
 	SIM_EFSST_FILEID =3D			0x6f38, /* same as EFust */
+	SIM_EFADN_FILEID =3D			0x6f3a,
 	SIM_EFMSISDN_FILEID =3D			0x6f40,
+	SIM_EFCBMI_FILEID =3D			0x6f45,
 	SIM_EFSPN_FILEID =3D			0x6f46,
+	SIM_EFCBMID_FILEID =3D			0x6f48,
 	SIM_EFSDN_FILEID =3D			0x6f49,
 	SIM_EFBDN_FILEID =3D			0x6f4d,
-	SIM_EFADN_FILEID =3D			0x6f3a,
+	SIM_EFCBMIR_FILEID =3D			0x6f50,
 	SIM_EFEST_FILEID =3D			0x6f56,
 	SIM_EFAD_FILEID =3D			0x6fad,
 	SIM_EFPHASE_FILEID =3D			0x6fae,
+	SIM_EFECC_FILEID =3D			0x6fb7,
 	SIM_EFPNN_FILEID =3D			0x6fc5,
 	SIM_EFOPL_FILEID =3D			0x6fc6,
 	SIM_EFMBDN_FILEID =3D			0x6fc7,
@@ -48,10 +52,6 @@ enum sim_fileid {
 	SIM_EFMWIS_FILEID =3D			0x6fca,
 	SIM_EFCFIS_FILEID =3D			0x6fcb,
 	SIM_EFSPDI_FILEID =3D			0x6fcd,
-	SIM_EFECC_FILEID =3D			0x6fb7,
-	SIM_EFCBMIR_FILEID =3D			0x6f50,
-	SIM_EFCBMI_FILEID =3D			0x6f45,
-	SIM_EFCBMID_FILEID =3D			0x6f48,
 };
 =

 /* 51.011 Section 9.3 */
-- =

1.7.3.2


--===============6871218455738486506==--

