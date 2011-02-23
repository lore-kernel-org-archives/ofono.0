Content-Type: multipart/mixed; boundary="===============1926282367327106145=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 06/18] src: add missing SIM enum to simutil.h
Date: Wed, 23 Feb 2011 12:43:17 +0100
Message-ID: <2e1ac6ec28ae6bab1ddfcad4e50208928a574a3c.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1926282367327106145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 src/simutil.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index a5a683b..16b210b 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -34,6 +34,7 @@ enum sim_fileid {
    SIM_DFPHONEBOOK_FILEID =3D		0x5F3A,
    SIM_DFMULTIMEDIA_FILEID =3D		0x5F3B,
    SIM_EFLI_FILEID =3D			0x6F05,
+	SIM_EFARR_FILEID =3D			0x6F06,
    SIM_EFIMSI_FILEID =3D			0x6F07,
    SIM_EF_CPHS_MWIS_FILEID =3D		0x6F11,
    SIM_EF_CPHS_CFF_FILEID =3D		0x6F13,
--
1.7.3.5


--===============1926282367327106145==--

