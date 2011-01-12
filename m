Content-Type: multipart/mixed; boundary="===============8814238292504400437=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 15/16] unit: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:17 +0200
Message-ID: <1294829538-3893-16-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8814238292504400437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-common.c  |    6 +++---
 unit/test-idmap.c   |    4 ++--
 unit/test-mux.c     |    8 ++++----
 unit/test-simutil.c |   14 +++++++-------
 unit/test-sms.c     |   26 +++++++++++++-------------
 unit/test-util.c    |   20 ++++++++++----------
 6 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/unit/test-common.c b/unit/test-common.c
index baed178..0ade9a0 100644
--- a/unit/test-common.c
+++ b/unit/test-common.c
@@ -56,7 +56,7 @@ static const char *invalid_strings[] =3D {
 	NULL
 };
 =

-static void test_invalid()
+static void test_invalid(void)
 {
 	char *sc;
 	char *sia;
@@ -107,7 +107,7 @@ static const char *valid_strings[] =3D {
 	NULL
 };
 =

-static void test_valid()
+static void test_valid(void)
 {
 	char *sc;
 	char *sia;
@@ -158,7 +158,7 @@ static const char *invalid_apns[] =3D {
 	NULL
 };
 =

-static void test_apn()
+static void test_apn(void)
 {
 	int i;
 	gboolean res;
diff --git a/unit/test-idmap.c b/unit/test-idmap.c
index bf428f8..17e767c 100644
--- a/unit/test-idmap.c
+++ b/unit/test-idmap.c
@@ -27,7 +27,7 @@
 =

 #include "idmap.h"
 =

-static void test_alloc()
+static void test_alloc(void)
 {
 	struct idmap *idmap;
 	unsigned int bit;
@@ -65,7 +65,7 @@ static void test_alloc()
 	idmap_free(idmap);
 }
 =

-static void test_alloc_next()
+static void test_alloc_next(void)
 {
 	struct idmap *idmap;
 	unsigned int bit;
diff --git a/unit/test-mux.c b/unit/test-mux.c
index d0e2d32..2efa49d 100644
--- a/unit/test-mux.c
+++ b/unit/test-mux.c
@@ -280,7 +280,7 @@ static const guint8 basic_long_frame_result[] =3D
 	0x78, 0x9A, 0xBC, 0xDE, 0xF0, 0x88, 0xF9
 };
 =

-static void test_fill_basic()
+static void test_fill_basic(void)
 {
 	guint8 control_frame[6];
 	guint8 data_frame[128];
@@ -327,7 +327,7 @@ static const guint8 advanced_quoted_data_result[] =3D
 	{ 0x7E, 0x07, 0xEF, 0x12, 0x34, 0x56, 0x7D, 0x5E, 0x78,
 		0x7D, 0x5D, 0x05, 0x7E };
 =

-static void test_fill_advanced()
+static void test_fill_advanced(void)
 {
 	guint8 control_frame[8];
 	guint8 data_frame[128];
@@ -368,7 +368,7 @@ static int basic_frame_size =3D 7;
 =

 static const guint8 basic_output[] =3D { 0x12, 0x34, 0x56 };
 =

-static void test_extract_basic()
+static void test_extract_basic(void)
 {
 	int total =3D 0;
 	int nread;
@@ -467,7 +467,7 @@ static int advanced_frame_size =3D 6;
 =

 static const guint8 advanced_output[] =3D { 0x12, 0x34, 0x56 };
 =

-static void test_extract_advanced()
+static void test_extract_advanced(void)
 {
 	int total =3D 0;
 	int nread;
diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 155cddd..7cb5c10 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -80,12 +80,12 @@ static void test_buffer(const unsigned char *buf, size_=
t size)
 	g_assert(ber_tlv_iter_next(&iter) =3D=3D FALSE);
 }
 =

-static void test_ber_tlv_iter()
+static void test_ber_tlv_iter(void)
 {
 	test_buffer(valid_mms_params, sizeof(valid_mms_params));
 }
 =

-static void test_ber_tlv_builder_mms()
+static void test_ber_tlv_builder_mms(void)
 {
 	struct ber_tlv_iter top_iter, nested_iter;
 	struct ber_tlv_builder top_builder, nested_builder;
@@ -128,7 +128,7 @@ static void test_ber_tlv_builder_mms()
 	test_buffer(pdu, pdulen);
 }
 =

-static void test_ber_tlv_builder_efpnn()
+static void test_ber_tlv_builder_efpnn(void)
 {
 	struct sim_eons *eons_info;
 	unsigned char efpnn0[64], efpnn1[64];
@@ -188,7 +188,7 @@ static void test_ber_tlv_builder_efpnn()
 	sim_eons_free(eons_info);
 }
 =

-static void test_ber_tlv_builder_3g_status()
+static void test_ber_tlv_builder_3g_status(void)
 {
 	unsigned char buf[512];
 	struct ber_tlv_builder top_builder, nested_builder;
@@ -351,7 +351,7 @@ const unsigned char valid_efpnn[][28] =3D {
 	  0x53, 0x68, 0x6F, 0x72, 0x74, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, }
 };
 =

-static void test_eons()
+static void test_eons(void)
 {
 	const struct sim_eons_operator_info *op_info;
 	struct sim_eons *eons_info;
@@ -383,7 +383,7 @@ static void test_eons()
 	sim_eons_free(eons_info);
 }
 =

-static void test_ef_db()
+static void test_ef_db(void)
 {
 	struct sim_ef_info *info;
 =

@@ -405,7 +405,7 @@ static const char *binary_ef =3D "62178202412183022F058=
A01058B032F060F8002000A"
 static const char *record_ef =3D "62198205422100200483026F408A01058B036F06=
07"
 				"800200808800";
 =

-static void test_3g_status_data()
+static void test_3g_status_data(void)
 {
 	unsigned char *response;
 	long len;
diff --git a/unit/test-sms.c b/unit/test-sms.c
index 134a4b1..abaed35 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -143,7 +143,7 @@ static void dump_details(struct sms *sms)
 	}
 }
 =

-static void test_simple_deliver()
+static void test_simple_deliver(void)
 {
 	struct sms sms;
 	unsigned char *decoded_pdu;
@@ -214,7 +214,7 @@ static void test_simple_deliver()
 	g_free(utf8);
 }
 =

-static void test_alnum_sender()
+static void test_alnum_sender(void)
 {
 	struct sms sms;
 	unsigned char *decoded_pdu;
@@ -285,7 +285,7 @@ static void test_alnum_sender()
 	g_free(utf8);
 }
 =

-static void test_deliver_encode()
+static void test_deliver_encode(void)
 {
 	struct sms sms;
 	unsigned char *decoded_pdu;
@@ -361,7 +361,7 @@ static void test_deliver_encode()
 	g_free(encoded_pdu);
 }
 =

-static void test_simple_submit()
+static void test_simple_submit(void)
 {
 	struct sms sms;
 	unsigned char *decoded_pdu;
@@ -427,7 +427,7 @@ static void test_simple_submit()
 	g_free(utf8);
 }
 =

-static void test_submit_encode()
+static void test_submit_encode(void)
 {
 	struct sms sms;
 	unsigned char *decoded_pdu;
@@ -931,7 +931,7 @@ static const char *assembly_pdu3 =3D "038121F3400481555=
50119906041001222044A0500"
 					"00431044B043B0020043D04300433002E";
 static int assembly_pdu_len3 =3D 89;
 =

-static void test_assembly()
+static void test_assembly(void)
 {
 	unsigned char pdu[176];
 	long pdu_len;
@@ -1018,7 +1018,7 @@ static const char *expected_no_fragmentation_7bit =3D=
 "079153485002020911000C915"
 			"348870420140000A71154747A0E4ACF41F4F29C9E769F4121";
 static const char *sc_addr =3D "+358405202090";
 static const char *da_addr =3D "+358478400241";
-static void test_prepare_7bit()
+static void test_prepare_7bit(void)
 {
 	GSList *r;
 	struct sms *sms;
@@ -1205,7 +1205,7 @@ static void test_limit(gunichar uni, int target_size,=
 gboolean use_16bit)
 	g_free(utf8);
 }
 =

-static void test_prepare_limits()
+static void test_prepare_limits(void)
 {
 	gunichar ascii =3D 0x41;
 	gunichar ucs2 =3D 0x416;
@@ -1236,7 +1236,7 @@ static const char *cbs2 =3D "0110003201114679785E9637=
1A8D46A3D168341A8D46A3D1683"
 	"41A8D46A3D168341A8D46A3D168341A8D46A3D168341A8D46A3D168341A8D46A3D168"
 	"341A8D46A3D168341A8D46A3D168341A8D46A3D168341A8D46A3D100";
 =

-static void test_cbs_encode_decode()
+static void test_cbs_encode_decode(void)
 {
 	unsigned char *decoded_pdu;
 	long pdu_len;
@@ -1301,7 +1301,7 @@ static void test_cbs_encode_decode()
 	g_free(encoded_pdu);
 }
 =

-static void test_cbs_assembly()
+static void test_cbs_assembly(void)
 {
 	unsigned char *decoded_pdu;
 	long pdu_len;
@@ -1389,7 +1389,7 @@ static void test_cbs_assembly()
 	cbs_assembly_free(assembly);
 }
 =

-static void test_serialize_assembly()
+static void test_serialize_assembly(void)
 {
 	unsigned char pdu[176];
 	long pdu_len;
@@ -1447,7 +1447,7 @@ static const char *ranges[] =3D { "1-5, 2, 3, 600, 56=
9-900, 999",
 static const char *inv_ranges[] =3D { "1-5, 3333", "1-5, afbcd", "1-5, 3-5=
,,",
 					"1-5, 3-5, c", NULL };
 =

-static void test_range_minimizer()
+static void test_range_minimizer(void)
 {
 	int i =3D 0;
 =

@@ -1480,7 +1480,7 @@ static void test_range_minimizer()
 	}
 }
 =

-static void test_sr_assembly()
+static void test_sr_assembly(void)
 {
 	const char *sr_pdu1 =3D "06040D91945152991136F00160124130340A0160124130"
 				"940A00";
diff --git a/unit/test-util.c b/unit/test-util.c
index 057bb76..c0d0bf1 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -341,7 +341,7 @@ unsigned short gsm_turkish_to_unicode_map[] =3D
 	((c) < 0x80 ? 1 : \
 	 ((c) < 0x800 ? 2 : 3))
 =

-static void test_invalid()
+static void test_invalid(void)
 {
 	long nwritten;
 	long nread;
@@ -382,7 +382,7 @@ static void test_invalid()
 	g_assert(nread =3D=3D 0);
 }
 =

-static void test_valid()
+static void test_valid(void)
 {
 	long nwritten;
 	long nread;
@@ -444,7 +444,7 @@ static void test_valid()
 	}
 }
 =

-static void test_valid_turkish()
+static void test_valid_turkish(void)
 {
 	long nwritten;
 	long nread;
@@ -515,7 +515,7 @@ static const char expected[] =3D "It is easy to read te=
xt messages via AT "
 				"commands.";
 static int reported_text_size =3D 49;
 =

-static void test_decode_encode()
+static void test_decode_encode(void)
 {
 	const char *sms =3D hex_packed;
 	unsigned char *decoded, *packed;
@@ -614,7 +614,7 @@ static void test_decode_encode()
 	g_free(hex_packed);
 }
 =

-static void test_pack_size()
+static void test_pack_size(void)
 {
 	unsigned char c1[] =3D { 'a' };
 	unsigned char c2[] =3D { 'a', 'b' };
@@ -676,7 +676,7 @@ static void test_pack_size()
 	g_free(packed);
 }
 =

-static void test_cr_handling()
+static void test_cr_handling(void)
 {
 	unsigned char c7[] =3D { 'a', 'b', 'c', 'd', 'e', 'f', 'g' };
 	unsigned char c7_expected[] =3D { 'a', 'b', 'c', 'd', 'e', 'f', 'g',
@@ -739,7 +739,7 @@ static void test_cr_handling()
 	g_free(packed);
 }
 =

-static void test_sms_handling()
+static void test_sms_handling(void)
 {
 	unsigned char c7[] =3D { 'a', 'b', 'c', 'd', 'e', 'f', 'g' };
 =

@@ -780,7 +780,7 @@ static void test_sms_handling()
 	g_free(packed);
 }
 =

-static void test_offset_handling()
+static void test_offset_handling(void)
 {
 	unsigned char c7[] =3D { 'a', 'b', 'c', 'd', 'e', 'f', 'g' };
 	unsigned char c8[] =3D { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' };
@@ -880,7 +880,7 @@ static unsigned char sim_82_1[] =3D { 0x82, 0x05, 0x04,=
 0x00, 0x2D, 0xB3, 0xB4,
 static unsigned char sim_82_2[] =3D { 0x82, 0x05, 0xD8, 0x00, 0x2D, 0xB3, =
0xB4,
 					0x2D, 0x31 };
 =

-static void test_sim()
+static void test_sim(void)
 {
 	char *utf8;
 =

@@ -930,7 +930,7 @@ static void test_sim()
 	g_assert(utf8 =3D=3D NULL);
 }
 =

-static void test_unicode_to_gsm()
+static void test_unicode_to_gsm(void)
 {
 	long nwritten;
 	long nread;
-- =

1.7.0.4


--===============8814238292504400437==--

