Content-Type: multipart/mixed; boundary="===============0306269365278508448=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv2 03/11] unit: add gsm and umts parse/build unit tests
Date: Tue, 10 Oct 2017 14:36:12 -0700
Message-ID: <1507671380-7625-3-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507671380-7625-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0306269365278508448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-simutil.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 105 insertions(+)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 490e288..b45ae41 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -496,6 +496,110 @@ static void test_get_2g_path(void)
 	g_assert(!memcmp(path, path1, len));
 }
 =

+static void test_auth_build_parse(void)
+{
+	unsigned char auth_cmd[40];
+	const unsigned char rand[16] =3D { 0x00, 0x01, 0x02, 0x03, 0x04,0x05,
+			0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
+			0x0e, 0x0f };
+	const unsigned char sres[4] =3D { 0x00, 0x11, 0x22, 0x33 };
+	const unsigned char *sres_p;
+	const unsigned char kc[8] =3D { 0xab, 0xcd, 0xef, 0x12, 0x34, 0x56,
+			0x78, 0x9a };
+	const unsigned char *kc_p;
+	const unsigned char gsm_success[] =3D { 0x04, 0x00, 0x11, 0x22, 0x33,
+			0x08,0xab, 0xcd, 0xef, 0x12, 0x34, 0x56, 0x78, 0x9a };
+	const unsigned char autn[16] =3D { 0x0f, 0x0e, 0x0d, 0x0c, 0x0b, 0x0a,
+			0x09, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02,
+			0x01, 0x00 };
+	const unsigned char res[8] =3D { 0xff, 0xee, 0xdd, 0xcc, 0xbb, 0xaa,
+			0x11, 0x22 };
+	const unsigned char *res_p;
+	const unsigned char ck[16] =3D { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+			0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
+	const unsigned char *ck_p;
+	const unsigned char ik[16] =3D { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd,
+			0xef, 0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10 };
+	const unsigned char *ik_p;
+	const unsigned char auts[16] =3D { 0xde, 0xea, 0xbe, 0xef, 0xde, 0xea,
+			0xbe, 0xef, 0xde, 0xea, 0xbe, 0xef, 0xde, 0xea,
+			0xbe, 0xef };
+	const unsigned char *auts_p;
+
+	const unsigned char umts_success[] =3D { 0xdb, 0x08, 0xff, 0xee, 0xdd,
+			0xcc, 0xbb, 0xaa, 0x11, 0x22, 0x10, 0x00, 0x11, 0x22,
+			0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb,
+			0xcc, 0xdd, 0xee, 0xff, 0x10, 0x01, 0x23, 0x45, 0x67,
+			0x89, 0xab, 0xcd, 0xef, 0xfe, 0xdc, 0xba, 0x98, 0x76,
+			0x54, 0x32, 0x10 };
+	const unsigned char umts_success_kc[] =3D { 0xdb, 0x08, 0xff, 0xee, 0xdd,
+			0xcc, 0xbb, 0xaa, 0x11, 0x22, 0x10, 0x00, 0x11, 0x22,
+			0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb,
+			0xcc, 0xdd, 0xee, 0xff, 0x10, 0x01, 0x23, 0x45, 0x67,
+			0x89, 0xab, 0xcd, 0xef, 0xfe, 0xdc, 0xba, 0x98, 0x76,
+			0x54, 0x32, 0x10, 0x08, 0xab, 0xcd, 0xef, 0x12, 0x34,
+			0x56, 0x78, 0x9a };
+	const unsigned char umts_sync_failure[] =3D { 0xdc, 0x10, 0xde, 0xea,
+			0xbe, 0xef, 0xde, 0xea, 0xbe, 0xef, 0xde, 0xea, 0xbe,
+			0xef, 0xde, 0xea, 0xbe, 0xef };
+	int len =3D 0;
+
+	/* test GSM auth command */
+	len =3D sim_build_gsm_authenticate(auth_cmd, 40, rand);
+
+	g_assert(len =3D=3D 22);
+	g_assert(auth_cmd[0] =3D=3D 0x00);
+	g_assert(auth_cmd[1] =3D=3D 0x88);
+	g_assert(auth_cmd[2] =3D=3D 0x00);
+	g_assert(auth_cmd[3] =3D=3D 0x80);
+	g_assert(auth_cmd[4] =3D=3D 0x11);
+	g_assert(auth_cmd[5] =3D=3D 0x10);
+	g_assert(!memcmp(auth_cmd + 6, rand, 16));
+
+	/* test UMTS auth command */
+	len =3D sim_build_umts_authenticate(auth_cmd, 40, rand, autn);
+
+	g_assert(len =3D=3D 40);
+	g_assert(auth_cmd[0] =3D=3D 0x00);
+	g_assert(auth_cmd[1] =3D=3D 0x88);
+	g_assert(auth_cmd[2] =3D=3D 0x00);
+	g_assert(auth_cmd[3] =3D=3D 0x81);
+	g_assert(auth_cmd[4] =3D=3D 0x22);
+	g_assert(auth_cmd[5] =3D=3D 0x10);
+	g_assert(!memcmp(auth_cmd + 6, rand, 16));
+	g_assert(auth_cmd[22] =3D=3D 0x10);
+	g_assert(!memcmp(auth_cmd + 23, autn, 16));
+
+	/* test GSM parse */
+	g_assert(sim_parse_gsm_authenticate(gsm_success, sizeof(gsm_success),
+			&sres_p, &kc_p));
+	g_assert(!memcmp(sres_p, sres, 4));
+	g_assert(!memcmp(kc_p, kc, 8));
+
+	/* test UMTS success parse, no kc */
+	g_assert(sim_parse_umts_authenticate(umts_success, sizeof(umts_success),
+			&res_p, &ck_p, &ik_p, &auts_p, &kc_p));
+	g_assert(!memcmp(res_p, res, 8));
+	g_assert(!memcmp(ck_p, ck, 16));
+	g_assert(!memcmp(ik_p, ik, 16));
+	g_assert(!auts_p && !kc_p);
+
+	/* test UMTS sync failure */
+	g_assert(sim_parse_umts_authenticate(umts_sync_failure, sizeof(umts_sync_=
failure),
+			&res_p, &ck_p, &ik_p, &auts_p, &kc_p));
+	g_assert(!memcmp(auts_p, auts, 16));
+
+	/* test UMTS success parse, with kc */
+	g_assert(sim_parse_umts_authenticate(umts_success_kc, sizeof(umts_success=
_kc),
+			&res_p, &ck_p, &ik_p, &auts_p, &kc_p));
+	g_assert(!memcmp(res_p, res, 8));
+	g_assert(!memcmp(ck_p, ck, 16));
+	g_assert(!memcmp(ik_p, ik, 16));
+	g_assert(!memcmp(kc_p, kc, 8));
+	g_assert(!auts_p);
+
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -514,6 +618,7 @@ int main(int argc, char **argv)
 			test_application_entry_decode);
 	g_test_add_func("/testsimutil/3G path", test_get_3g_path);
 	g_test_add_func("/testsimutil/2G path", test_get_2g_path);
+	g_test_add_func("/testsimutil/auth build parse", test_auth_build_parse);
 =

 	return g_test_run();
 }
-- =

2.7.4


--===============0306269365278508448==--

