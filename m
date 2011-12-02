Content-Type: multipart/mixed; boundary="===============7286618430182706952=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 5/9] simutil: Add CPHS SPN and short-SPN IDs
Date: Fri, 02 Dec 2011 13:10:33 +0200
Message-ID: <1322824237-10039-6-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322824237-10039-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7286618430182706952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index fde3126..42251d4 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -38,9 +38,11 @@ enum sim_fileid {
 	SIM_EFIMSI_FILEID =3D			0x6F07,
 	SIM_EF_CPHS_MWIS_FILEID =3D		0x6F11,
 	SIM_EF_CPHS_CFF_FILEID =3D		0x6F13,
+	SIM_EF_CPHS_SPN_FILEID =3D		0x6F14,
 	SIM_EF_CPHS_CSP_FILEID =3D		0x6F15,
 	SIM_EF_CPHS_INFORMATION_FILEID =3D	0x6F16,
 	SIM_EF_CPHS_MBDN_FILEID =3D		0x6F17,
+	SIM_EF_CPHS_SPN_SHORT_FILEID =3D		0x6F18,
 	SIM_EFUST_FILEID =3D			0x6F38,
 	SIM_EFSST_FILEID =3D			0x6F38, /* same as EFust */
 	SIM_EFADN_FILEID =3D			0x6F3A,
-- =

1.7.5.4


--===============7286618430182706952==--

