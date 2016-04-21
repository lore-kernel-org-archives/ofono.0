Content-Type: multipart/mixed; boundary="===============0783196997494554564=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 2/4] simutil: Add EFACL in elementary file db
Date: Thu, 21 Apr 2016 09:20:16 +0530
Message-ID: <1461210616-11284-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0783196997494554564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/simutil.c b/src/simutil.c
index a7745ae..5f8c8b8 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -95,6 +95,7 @@ static struct sim_ef_info ef_db[] =3D {
 {	0x6F4D, 0x7F20, 0x7FFF, EF, RECORD, 0,		PIN,	PIN2	},
 {	0x6F50, 0x7F20, 0x7FFF, EF, BINARY, 0,		PIN,	PIN	},
 {	0x6F56, 0x0000, 0x7FFF, EF, BINARY, 0,		PIN,	PIN2	},
+{	0x6F57,	0x7F20,	0x7FFF,	EF, BINARY, 0,		PIN,	PIN2	},
 {	0x6FAD, 0x7F20, 0x7FFF, EF, BINARY, 0,		ALW,	ADM	},
 {	0x6FAE, 0x7F20, 0x0000, EF, BINARY, 1,		ALW,	ADM	},
 {	0x6FB7, 0x7F20, 0x7FFF, EF, BINARY, 0,		ALW,	ADM	},
-- =

1.9.1


--===============0783196997494554564==--

