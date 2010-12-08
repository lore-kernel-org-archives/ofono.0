Content-Type: multipart/mixed; boundary="===============3414707199109614347=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH 2/4]simutil: Changes to prepare for isimodem2.5
Date: Wed, 08 Dec 2010 09:34:36 +0100
Message-ID: <1291797276-20511-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3414707199109614347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

updates in src/simutil.h
Adding some sim file id and sim dir id mostly related to phonebook usim/sim.

Regards,
Jessica Nilsson

---
 src/simutil.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index 92b2e0f..bc53255 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -19,6 +19,8 @@
  *
  */
 =

+#include "types.h"
+
 enum sim_fileid {
 	SIM_EFPL_FILEID =3D 0x2f05,
 	SIM_EF_ICCID_FILEID =3D 0x2fe2,
@@ -49,6 +51,25 @@ enum sim_fileid {
 	SIM_EFCBMIR_FILEID =3D 0x6f50,
 	SIM_EFCBMI_FILEID =3D 0x6f45,
 	SIM_EFCBMID_FILEID =3D 0x6f48,
+	SIM_EFSMSP_FILEID =3D 0x6f42,
+	SIM_EFIMSI_FILEID =3D 0x6F07,
+
+	/* Phonebook (USIM) */
+	SIM_EFPBR_FILEID =3D 0x4f30,
+	SIM_EFPSC_FILEID =3D 0x4F22,
+	SIM_EFCC_FILEID =3D 0x4F23,
+	SIM_EFPUID_FILEID =3D 0x4F24,
+	/* Phonebook (SIM) */
+	SIM_EFADN_SIM_FILEID =3D 0x6F3A,
+	SIM_EFEXT1_SIM_FILEID =3D 0x6F4A,
+};
+
+enum sim_dirid {
+	MF_FILEID =3D 0x3F00,
+	DFTELECOM_FILEID =3D 0x7F10,
+	DFGSM_FILEID =3D 0x7F20,
+	DFPHONEBOOK_FILEID =3D 0x5F3A,
+	DFMULTIMEDIA_FILEID =3D 0x5F3B
 };
 =

 /* 51.011 Section 9.3 */
-- =

1.7.3.2


--===============3414707199109614347==--

