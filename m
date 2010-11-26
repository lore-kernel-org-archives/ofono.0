Content-Type: multipart/mixed; boundary="===============1265712088764102394=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 1/7] simutil: Add EFcfis and EFcphs-cff file Ids
Date: Thu, 25 Nov 2010 22:23:31 -0800
Message-ID: <1290752617-19024-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1290752617-19024-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1265712088764102394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index 5b56099..92b2e0f 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -25,6 +25,7 @@ enum sim_fileid {
 	SIM_EFIMG_FILEID =3D 0x4F20,
 	SIM_EFLI_FILEID =3D 0x6f05,
 	SIM_EF_CPHS_MWIS_FILEID =3D 0x6f11,
+	SIM_EF_CPHS_CFF_FILEID =3D 0x6f13,
 	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
 	SIM_EF_CPHS_MBDN_FILEID =3D 0x6f17,
 	SIM_EFUST_FILEID =3D 0x6f38,
@@ -42,6 +43,7 @@ enum sim_fileid {
 	SIM_EFMBDN_FILEID =3D 0x6fc7,
 	SIM_EFMBI_FILEID =3D 0x6fc9,
 	SIM_EFMWIS_FILEID =3D 0x6fca,
+	SIM_EFCFIS_FILEID =3D 0x6fcb,
 	SIM_EFSPDI_FILEID =3D 0x6fcd,
 	SIM_EFECC_FILEID =3D 0x6fb7,
 	SIM_EFCBMIR_FILEID =3D 0x6f50,
-- =

1.7.0.4


--===============1265712088764102394==--

