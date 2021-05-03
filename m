Content-Type: multipart/mixed; boundary="===============7215289440650166252=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] sim-auth: Parse auth response according to TS 31.102
Date: Mon, 03 May 2021 17:04:35 +0300
Message-ID: <20210503140435.3559338-1-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7215289440650166252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim-auth.c      |  34 ++++++-----
 src/simutil.c       | 146 +++++++++++++++++++++++++++++++++-----------
 src/simutil.h       |  13 ++--
 unit/test-simutil.c | 125 ++++++++++++++++++++++++++++---------
 4 files changed, 234 insertions(+), 84 deletions(-)

diff --git a/src/sim-auth.c b/src/sim-auth.c
index 3c3f35e7..6dab52ee 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -207,14 +207,10 @@ static void handle_umts(struct ofono_sim_auth *sa, co=
nst uint8_t *resp,
 	DBusMessage *reply =3D NULL;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
-	const uint8_t *res =3D NULL;
-	const uint8_t *ck =3D NULL;
-	const uint8_t *ik =3D NULL;
-	const uint8_t *auts =3D NULL;
-	const uint8_t *kc =3D NULL;
+	struct data_block res, ck, ik, auts, sres, kc;
 =

 	if (!sim_parse_umts_authenticate(resp, len, &res, &ck, &ik,
-			&auts, &kc))
+			&auts, &sres, &kc))
 		goto umts_end;
 =

 	reply =3D dbus_message_new_method_return(sa->pending->msg);
@@ -224,15 +220,23 @@ static void handle_umts(struct ofono_sim_auth *sa, co=
nst uint8_t *resp,
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
 			"{say}", &dict);
 =

-	if (auts) {
-		append_dict_byte_array(&dict, "AUTS", auts, 14);
-	} else {
-		append_dict_byte_array(&dict, "RES", res, 8);
-		append_dict_byte_array(&dict, "CK", ck, 16);
-		append_dict_byte_array(&dict, "IK", ik, 16);
-		if (kc)
-			append_dict_byte_array(&dict, "Kc", kc, 8);
-	}
+	if (auts.data)
+		append_dict_byte_array(&dict, "AUTS", auts.data, auts.len);
+
+	if (sres.data)
+		append_dict_byte_array(&dict, "SRES", sres.data, sres.len);
+
+	if (res.data)
+		append_dict_byte_array(&dict, "RES", res.data, res.len);
+
+	if (ck.data)
+		append_dict_byte_array(&dict, "CK", ck.data, ck.len);
+
+	if (ik.data)
+		append_dict_byte_array(&dict, "IK", ik.data, ik.len);
+
+	if (kc.data)
+		append_dict_byte_array(&dict, "Kc", kc.data, kc.len);
 =

 	dbus_message_iter_close_container(&iter, &dict);
 =

diff --git a/src/simutil.c b/src/simutil.c
index 5d2aa6a2..30b76f05 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1672,63 +1672,135 @@ int sim_build_gsm_authenticate(unsigned char *buff=
er, int len,
 	return build_authenticate(buffer, rand, NULL);
 }
 =

-gboolean sim_parse_umts_authenticate(const unsigned char *buffer,
-		int len, const unsigned char **res, const unsigned char **ck,
-		const unsigned char **ik, const unsigned char **auts,
-		const unsigned char **kc)
+gboolean sim_parse_umts_authenticate(const unsigned char *buffer, int len,
+		struct data_block *res, struct data_block *ck,
+		struct data_block *ik, struct data_block *auts,
+		struct data_block *sres, struct data_block *kc)
 {
-	if (len < 16 || !buffer)
+	const unsigned char *ptr =3D buffer;
+	const unsigned char *end =3D ptr + len;
+	unsigned int l;
+
+	if (!buffer || len < 2)
 		return FALSE;
 =

-	switch (buffer[0]) {
+	memset(res, 0, sizeof(*res));
+	memset(ck, 0, sizeof(*ck));
+	memset(ik, 0, sizeof(*ik));
+	memset(kc, 0, sizeof(*kc));
+	memset(auts, 0, sizeof(*auts));
+	memset(sres, 0, sizeof(*sres));
+
+	/*
+	 * TS 31.102
+	 * 7.1.2.1 GSM/3G security context
+	 */
+	switch (*ptr++) {
 	case 0xdb:
-		/* 'DB' + '08' + RES(16) + '10' + CK(32) + '10' + IK(32) =3D 43 */
-		if (len < 43)
-			goto umts_end;
+		/*
+		 * Response parameters/data, case 1, 3G security context,
+		 * command successful:
+		 *
+		 * "Successful 3G authentication" tag =3D 'DB'
+		 * 'DB' + L3 + RES(L3) + L4 + CK(L4) + L5 + IK(L5) + 8 + Kc(8)
+		 */
+		l =3D *ptr++; /* L3 */
+		if ((ptr + l) > end)
+			return FALSE;
 =

-		/* success */
-		if (buffer[1] !=3D 0x08)
-			goto umts_end;
+		res->data =3D ptr;
+		res->len =3D l;
+		ptr +=3D l;
 =

-		*res =3D buffer + 2;
+		if (ptr =3D=3D end)
+			return FALSE;
 =

-		if (buffer[10] !=3D 0x10)
-			goto umts_end;
+		l =3D *ptr++; /* L4 */
+		if ((ptr + l) > end)
+			return FALSE;
 =

-		*ck =3D buffer + 11;
+		ck->data =3D ptr;
+		ck->len =3D l;
+		ptr +=3D l;
 =

-		if (buffer[27] !=3D 0x10)
-			goto umts_end;
+		if (ptr =3D=3D end)
+			return FALSE;
 =

-		*ik =3D buffer + 28;
+		l =3D *ptr++; /* L5 */
+		if ((ptr + l) > end)
+			return FALSE;
 =

-		if (len >=3D 53 && kc) {
-			if (buffer[44] !=3D 0x08)
-				goto umts_end;
+		ik->data =3D ptr;
+		ik->len =3D l;
+		ptr +=3D l;
 =

-			*kc =3D buffer + 45;
-		} else {
-			*kc =3D NULL;
+		if (ptr < end) {
+			l =3D *ptr++;
+			if (l !=3D 8 || (ptr + l) !=3D end)
+				return FALSE;
+
+			kc->data =3D ptr;
+			kc->len =3D l;
+			ptr +=3D l;
 		}
 =

-		*auts =3D NULL;
+		return TRUE;
 =

-		break;
 	case 0xdc:
-		/* sync error */
-		if (buffer[1] !=3D 0x0e)
-			goto umts_end;
+		/*
+		 * Response parameters/data, case 2, 3G security context,
+		 * synchronisation failure:
+		 *
+		 * "Synchronisation failure" tag =3D 'DC'
+		 * 'DC' + L1 + AUTS(L1)
+		 */
+		l =3D *ptr++; /* L1 */
+		if ((ptr + l) > end)
+			return FALSE;
 =

-		*auts =3D buffer + 2;
+		auts->data =3D ptr;
+		auts->len =3D l;
+		ptr +=3D l;
 =

-		break;
-	default:
-		goto umts_end;
-	}
+		if (ptr !=3D end)
+			return FALSE;
 =

-	return TRUE;
+		return TRUE;
+
+	case 0x04:
+		/*
+		 * Response parameters/data, case 3, GSM security context,
+		 * command successful:
+		 *
+		 * 4 + SRES(4) + 8 + Kc(8)
+		 */
+		l =3D 4; /* Already skipped this one */
+		if ((ptr + l) > end)
+			return FALSE;
+
+		sres->data =3D ptr;
+		sres->len =3D l;
+		ptr +=3D l;
+
+		if (ptr =3D=3D end)
+			return FALSE;
+
+		l =3D *ptr++; /* 8 */
+		if (l !=3D 8 || (ptr + l) > end)
+			return FALSE;
 =

-umts_end:
+		kc->data =3D ptr;
+		kc->len =3D l;
+		ptr +=3D l;
+
+		if (ptr !=3D end)
+			return FALSE;
+
+		return TRUE;
+
+	default:
+		break;
+	}
 	return FALSE;
 }
 =

diff --git a/src/simutil.h b/src/simutil.h
index 33b775a7..f908bbb4 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -371,6 +371,11 @@ struct comprehension_tlv_builder {
 	struct ber_tlv_builder *parent;
 };
 =

+struct data_block {
+	const unsigned char *data;
+	unsigned int len;
+};
+
 void simple_tlv_iter_init(struct simple_tlv_iter *iter,
 				const unsigned char *pdu, unsigned int len);
 gboolean simple_tlv_iter_next(struct simple_tlv_iter *iter);
@@ -527,10 +532,10 @@ int sim_build_umts_authenticate(unsigned char *buffer=
, int len,
 int sim_build_gsm_authenticate(unsigned char *buffer, int len,
 		const unsigned char *rand);
 =

-gboolean sim_parse_umts_authenticate(const unsigned char *buffer,
-		int len, const unsigned char **res, const unsigned char **ck,
-		const unsigned char **ik, const unsigned char **auts,
-		const unsigned char **kc);
+gboolean sim_parse_umts_authenticate(const unsigned char *buffer, int len,
+		struct data_block *res, struct data_block *ck,
+		struct data_block *ik, struct data_block *auts,
+		struct data_block *sres, struct data_block *kc);
 =

 gboolean sim_parse_gsm_authenticate(const unsigned char *buffer, int len,
 		const unsigned char **sres, const unsigned char **kc);
diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 6f8419b4..530f624e 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -522,32 +522,34 @@ static void test_get_2g_path(void)
 static void test_auth_build_parse(void)
 {
 	unsigned char auth_cmd[40];
-	const unsigned char rand[16] =3D { 0x00, 0x01, 0x02, 0x03, 0x04,0x05,
+	const unsigned char rand[] =3D { 0x00, 0x01, 0x02, 0x03, 0x04,0x05,
 			0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
 			0x0e, 0x0f };
-	const unsigned char sres[4] =3D { 0x00, 0x11, 0x22, 0x33 };
+	const unsigned char sres[] =3D { 0x00, 0x11, 0x22, 0x33 };
 	const unsigned char *sres_p;
+	struct data_block sres_b;
 	const unsigned char kc[8] =3D { 0xab, 0xcd, 0xef, 0x12, 0x34, 0x56,
 			0x78, 0x9a };
 	const unsigned char *kc_p;
+	struct data_block kc_b;
 	const unsigned char gsm_success[] =3D { 0x04, 0x00, 0x11, 0x22, 0x33,
 			0x08,0xab, 0xcd, 0xef, 0x12, 0x34, 0x56, 0x78, 0x9a };
-	const unsigned char autn[16] =3D { 0x0f, 0x0e, 0x0d, 0x0c, 0x0b, 0x0a,
+	const unsigned char autn[] =3D { 0x0f, 0x0e, 0x0d, 0x0c, 0x0b, 0x0a,
 			0x09, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02,
 			0x01, 0x00 };
-	const unsigned char res[8] =3D { 0xff, 0xee, 0xdd, 0xcc, 0xbb, 0xaa,
+	const unsigned char res[] =3D { 0xff, 0xee, 0xdd, 0xcc, 0xbb, 0xaa,
 			0x11, 0x22 };
-	const unsigned char *res_p;
-	const unsigned char ck[16] =3D { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+	struct data_block res_b;
+	const unsigned char ck[] =3D { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
 			0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
-	const unsigned char *ck_p;
-	const unsigned char ik[16] =3D { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd,
+	struct data_block ck_b;
+	const unsigned char ik[] =3D { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd,
 			0xef, 0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10 };
-	const unsigned char *ik_p;
-	const unsigned char auts[16] =3D { 0xde, 0xea, 0xbe, 0xef, 0xde, 0xea,
-			0xbe, 0xef, 0xde, 0xea, 0xbe, 0xef, 0xde, 0xea,
-			0xbe, 0xef };
-	const unsigned char *auts_p;
+	struct data_block ik_b;
+	const unsigned char auts[] =3D { 0xde, 0xea,
+			0xbe, 0xef, 0xde, 0xea, 0xbe, 0xef, 0xde, 0xea, 0xbe,
+			0xef, 0xde, 0xea };
+	struct data_block auts_b;
 =

 	const unsigned char umts_success[] =3D { 0xdb, 0x08, 0xff, 0xee, 0xdd,
 			0xcc, 0xbb, 0xaa, 0x11, 0x22, 0x10, 0x00, 0x11, 0x22,
@@ -565,6 +567,8 @@ static void test_auth_build_parse(void)
 	const unsigned char umts_sync_failure[] =3D { 0xdc, 0x0e, 0xde, 0xea,
 			0xbe, 0xef, 0xde, 0xea, 0xbe, 0xef, 0xde, 0xea, 0xbe,
 			0xef, 0xde, 0xea };
+	const unsigned char case3[] =3D { 0x04, 0x01, 0x02, 0x03, 0x04,
+			0x08, 0xab, 0xcd, 0xef, 0x12, 0x34, 0x56, 0x78, 0x9a };
 	int len =3D 0;
 =

 	/* test GSM auth command */
@@ -599,31 +603,96 @@ static void test_auth_build_parse(void)
 	g_assert(!memcmp(sres_p, sres, 4));
 	g_assert(!memcmp(kc_p, kc, 8));
 =

+	/* test truncated messages */
+	g_assert(!sim_parse_umts_authenticate(umts_success, 1,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(umts_success, 2,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(umts_success, 10,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(umts_success, 11,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(umts_success, 27,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(umts_success, 28,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(umts_sync_failure, 2,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(case3, 2,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(case3, 5,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(case3, 6,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+
+	/* the extra byte won't actually be accessed */
+	g_assert(!sim_parse_umts_authenticate(umts_success,
+			sizeof(umts_success) + 1,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(umts_sync_failure,
+			sizeof(umts_sync_failure) + 1,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert(!sim_parse_umts_authenticate(case3, sizeof(case3) + 1,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+
+	/* unrecognized data */
+	g_assert(!sim_parse_umts_authenticate(case3 + 1, sizeof(case3) - 1,
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+
 	/* test UMTS success parse, no kc */
 	g_assert(sim_parse_umts_authenticate(umts_success, sizeof(umts_success),
-			&res_p, &ck_p, &ik_p, &auts_p, &kc_p));
-	g_assert(!memcmp(res_p, res, 8));
-	g_assert(!memcmp(ck_p, ck, 16));
-	g_assert(!memcmp(ik_p, ik, 16));
-	g_assert(!auts_p && !kc_p);
+			&res_b, &ck_b, &ik_b, &auts_b, &sres_b, &kc_b));
+	g_assert_cmpuint(res_b.len, =3D=3D , sizeof(res));
+	g_assert(!memcmp(res_b.data, res, sizeof(res)));
+	g_assert_cmpuint(ck_b.len, =3D=3D , sizeof(ck));
+	g_assert(!memcmp(ck_b.data, ck, sizeof(ck)));
+	g_assert_cmpuint(ik_b.len, =3D=3D , sizeof(ik));
+	g_assert(!memcmp(ik_b.data, ik, sizeof(ik)));
+	g_assert(!sres_b.len && !sres_b.data);
+	g_assert(!auts_b.len && !auts_b.data);
+	g_assert(!kc_b.len && !kc_b.data);
 =

 	/* test UMTS sync failure */
 	g_assert(sim_parse_umts_authenticate(umts_sync_failure,
 						sizeof(umts_sync_failure),
-						&res_p, &ck_p, &ik_p, &auts_p,
-						&kc_p));
-	g_assert(!memcmp(auts_p, auts, 14));
+						&res_b, &ck_b, &ik_b, &auts_b,
+						&sres_b, &kc_b));
+	g_assert_cmpuint(auts_b.len, =3D=3D , sizeof(auts));
+	g_assert(!memcmp(auts_b.data, auts, sizeof(auts)));
+	g_assert(!res_b.len && !res_b.data);
+	g_assert(!ck_b.len && !ck_b.data);
+	g_assert(!ik_b.len && !ik_b.data);
+	g_assert(!sres_b.len && !sres_b.data);
+	g_assert(!kc_b.len && !kc_b.data);
 =

 	/* test UMTS success parse, with kc */
 	g_assert(sim_parse_umts_authenticate(umts_success_kc,
 						sizeof(umts_success_kc),
-						&res_p, &ck_p, &ik_p, &auts_p,
-						&kc_p));
-	g_assert(!memcmp(res_p, res, 8));
-	g_assert(!memcmp(ck_p, ck, 16));
-	g_assert(!memcmp(ik_p, ik, 16));
-	g_assert(!memcmp(kc_p, kc, 8));
-	g_assert(!auts_p);
+						&res_b, &ck_b, &ik_b, &auts_b,
+						&sres_b, &kc_b));
+	g_assert_cmpuint(res_b.len, =3D=3D , sizeof(res));
+	g_assert(!memcmp(res_b.data, res, sizeof(res)));
+	g_assert_cmpuint(ck_b.len, =3D=3D , sizeof(ck));
+	g_assert(!memcmp(ck_b.data, ck, sizeof(ck)));
+	g_assert_cmpuint(ik_b.len, =3D=3D , sizeof(ik));
+	g_assert(!memcmp(ik_b.data, ik, sizeof(ik)));
+	g_assert_cmpuint(kc_b.len, =3D=3D , sizeof(kc));
+	g_assert(!memcmp(kc_b.data, kc, sizeof(kc)));
+	g_assert(!sres_b.len && !sres_b.data);
+	g_assert(!auts_b.len && !auts_b.data);
+
+	/* test case3 */
+	g_assert(sim_parse_umts_authenticate(case3, sizeof(case3),
+						&res_b, &ck_b, &ik_b, &auts_b,
+						&sres_b, &kc_b));
+	g_assert(!res_b.len && !res_b.data);
+	g_assert(!ck_b.len && !ck_b.data);
+	g_assert(!ik_b.len && !ik_b.data);
+	g_assert(!auts_b.len && !auts_b.data);
+	g_assert_cmpuint(sres_b.len, =3D=3D , 4);
+	g_assert(!memcmp(sres_b.data, case3 + 1, sres_b.len));
+	g_assert_cmpuint(kc_b.len, =3D=3D , sizeof(kc));
+	g_assert(!memcmp(kc_b.data, kc, sizeof(kc)));
 }
 =

 int main(int argc, char **argv)
-- =

2.25.1

--===============7215289440650166252==--

