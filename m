Content-Type: multipart/mixed; boundary="===============3749890212563485338=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/6] simutil: add fileid for EFimg
Date: Wed, 18 Aug 2010 04:25:18 -0700
Message-ID: <1282130723-10488-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1282130723-10488-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3749890212563485338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index 29194ca..1cfc4af 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -22,6 +22,7 @@
 enum sim_fileid {
 	SIM_EFPL_FILEID =3D 0x2f05,
 	SIM_EF_ICCID_FILEID =3D 0x2fe2,
+	SIM_EFIMG_FILEID =3D 0x4F20,
 	SIM_EFLI_FILEID =3D 0x6f05,
 	SIM_EF_CPHS_MWIS_FILEID =3D 0x6f11,
 	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
-- =

1.7.2.1


--===============3749890212563485338==--

