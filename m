Content-Type: multipart/mixed; boundary="===============6468362145804790201=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] unit: Avoid use of uninitialised data in test-simutil
Date: Fri, 25 Aug 2017 01:17:31 +0300
Message-ID: <1503613051-17235-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6468362145804790201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

GTest: run: /testsimutil/ber tlv encode EFpnn
=3D=3D16777=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D16777=3D=3D    at 0x4068CB: ber_tlv_iter_next (simutil.c:369)
=3D=3D16777=3D=3D    by 0x406C39: ber_tlv_find_by_tag (simutil.c:483)
=3D=3D16777=3D=3D    by 0x407E1D: sim_eons_add_pnn_record (simutil.c:1027)
=3D=3D16777=3D=3D    by 0x402C39: test_ber_tlv_builder_efpnn (test-simutil.=
c:181)
=3D=3D16777=3D=3D    by 0x4EA3A80: g_test_run_suite_internal
=3D=3D16777=3D=3D    by 0x4EA3F9A: g_test_run_suite
=3D=3D16777=3D=3D    by 0x4EA3FD0: g_test_run
=3D=3D16777=3D=3D    by 0x4042FA: main (test-simutil.c:518)
---
 unit/test-simutil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 69dd81e..490e288 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -178,12 +178,12 @@ static void test_ber_tlv_builder_efpnn(void)
 	ber_tlv_builder_optimize(&builder, NULL, NULL);
 =

 	eons_info =3D sim_eons_new(1);
-	sim_eons_add_pnn_record(eons_info, 1, efpnn0, sizeof(efpnn0));
+	sim_eons_add_pnn_record(eons_info, 1, efpnn0, 8 + 10);
 	g_assert(!sim_eons_pnn_is_empty(eons_info));
 	sim_eons_free(eons_info);
 =

 	eons_info =3D sim_eons_new(1);
-	sim_eons_add_pnn_record(eons_info, 1, efpnn1, sizeof(efpnn1));
+	sim_eons_add_pnn_record(eons_info, 1, efpnn1, 8 + 6);
 	g_assert(!sim_eons_pnn_is_empty(eons_info));
 	sim_eons_free(eons_info);
 }
-- =

1.9.1


--===============6468362145804790201==--

