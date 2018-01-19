Content-Type: multipart/mixed; boundary="===============5449576083336346771=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] unit: fix test-simutil failure
Date: Fri, 19 Jan 2018 10:29:56 -0800
Message-ID: <1516386596-14530-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5449576083336346771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A fixup was made in simauth to fix the AUTS length
and the simutil unit test was never updated to reflect
the length change.
---
 unit/test-simutil.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index ddf9d28..1b27a95 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -539,15 +539,15 @@ static void test_auth_build_parse(void)
 			0x89, 0xab, 0xcd, 0xef, 0xfe, 0xdc, 0xba, 0x98, 0x76,
 			0x54, 0x32, 0x10, 0x08, 0xab, 0xcd, 0xef, 0x12, 0x34,
 			0x56, 0x78, 0x9a };
-	const unsigned char umts_sync_failure[] =3D { 0xdc, 0x10, 0xde, 0xea,
+	const unsigned char umts_sync_failure[] =3D { 0xdc, 0x0e, 0xde, 0xea,
 			0xbe, 0xef, 0xde, 0xea, 0xbe, 0xef, 0xde, 0xea, 0xbe,
-			0xef, 0xde, 0xea, 0xbe, 0xef };
+			0xef, 0xde, 0xea };
 	int len =3D 0;
 =

 	/* test GSM auth command */
 	len =3D sim_build_gsm_authenticate(auth_cmd, 40, rand);
 =

-	g_assert(len =3D=3D 22);
+	g_assert(len =3D=3D 23);
 	g_assert(auth_cmd[0] =3D=3D 0x00);
 	g_assert(auth_cmd[1] =3D=3D 0x88);
 	g_assert(auth_cmd[2] =3D=3D 0x00);
@@ -589,7 +589,7 @@ static void test_auth_build_parse(void)
 						sizeof(umts_sync_failure),
 						&res_p, &ck_p, &ik_p, &auts_p,
 						&kc_p));
-	g_assert(!memcmp(auts_p, auts, 16));
+	g_assert(!memcmp(auts_p, auts, 14));
 =

 	/* test UMTS success parse, with kc */
 	g_assert(sim_parse_umts_authenticate(umts_success_kc,
-- =

2.7.4


--===============5449576083336346771==--

