Content-Type: multipart/mixed; boundary="===============7372325511608040705=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 1/8] simutil: Added ISIM elementary file ID's
Date: Wed, 01 Nov 2017 10:33:41 -0700
Message-ID: <1509557628-15121-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7372325511608040705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/simutil.h b/src/simutil.h
index ece5145..e0b9d72 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -65,6 +65,17 @@ enum sim_fileid {
 	SIM_DFGSM_FILEID =3D			0x7F20,
 };
 =

+enum sim_isim_fileid {
+	SIM_ISIM_EFIMPI_FILEID =3D		0x6F02,
+	SIM_ISIM_EFDOMAIN_FILEID =3D		0x6F03,
+	SIM_ISIM_EFIMPU_FILEID =3D		0x6F04,
+	SIM_ISIM_EFARR_FILEID =3D			0x6F06,
+	SIM_ISIM_EFIST_FILEID =3D			0x6F07,
+	SIM_ISIM_EFPCSCF_FILEID =3D		0x6F09,
+	SIM_ISIM_EFSMS_FILEID =3D			0x6F3C,
+	SIM_ISIM_EFSMSP_FILEID =3D		0x6F42
+};
+
 /* 51.011 Section 9.3 */
 enum sim_file_access {
 	SIM_FILE_ACCESS_ALWAYS =3D	0,
-- =

2.7.4


--===============7372325511608040705==--

