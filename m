Content-Type: multipart/mixed; boundary="===============2147247372086691267=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 4/4] simutil: add file type for EFimg
Date: Mon, 04 Oct 2010 15:33:22 -0700
Message-ID: <1286231602-18692-5-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1286231602-18692-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2147247372086691267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 65ce1ac..ed0970c 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -69,6 +69,7 @@ static struct sim_ef_info ef_db[] =3D {
 {	0x2F05, ROOTMF, BINARY, 0,	ALW,	PIN	},
 {	0x2F06, ROOTMF, RECORD, 0,	ALW,	PIN	},
 {	0x2FE2, ROOTMF, BINARY, 10,	ALW,	NEV 	},
+{	0x4F20, 0x5F50, BINARY, 0,	PIN,	ADM	},
 {	0x6F05, 0x7F20, BINARY, 0,	ALW,	PIN	},
 {	0x6F06, 0x0000, RECORD, 0,	ALW,	ADM	},
 {	0x6F2C, 0x7F20, BINARY, 16,	PIN,	PIN	},
-- =

1.7.2.1


--===============2147247372086691267==--

