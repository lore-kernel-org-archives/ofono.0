Content-Type: multipart/mixed; boundary="===============6644328673885401545=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 2/2] unit: add fuzzy address check to test-sms
Date: Tue, 21 Sep 2010 20:12:05 +0300
Message-ID: <1285089125-23921-2-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1285089125-23921-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6644328673885401545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-sms.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index d7a1b4d..f0089e0 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -1273,8 +1273,11 @@ static void test_sr_assembly()
 				"940A00";
 	const char *sr_pdu2 =3D "06050D91945152991136F00160124130640A0160124130"
 				"450A00";
+	const char *sr_pdu3 =3D "0606098121436587F9019012413064A0019012413045A0"
+				"00";
         struct sms sr1;
 	struct sms sr2;
+	struct sms sr3;
 	unsigned char pdu[176];
 	long pdu_len;
 	struct status_report_assembly *sra;
@@ -1285,7 +1288,7 @@ static void test_sr_assembly()
 						16, 17, 18, 19 };
 	unsigned char id[SMS_MSGID_LEN];
 =

-	/* mr 4 & mr 5 */
+	/* international address, mr 4 & mr 5 */
 =

         decode_hex_own_buf(sr_pdu1, -1, &pdu_len, 0, pdu);
 	g_assert(sms_decode(pdu, pdu_len, FALSE, 26, &sr1) =3D=3D TRUE);
@@ -1293,6 +1296,11 @@ static void test_sr_assembly()
 	decode_hex_own_buf(sr_pdu2, -1, &pdu_len, 0, pdu);
 	g_assert(sms_decode(pdu, pdu_len, FALSE, 26, &sr2) =3D=3D TRUE);
 =

+	/* national address, mr 6 */
+
+	decode_hex_own_buf(sr_pdu3, -1, &pdu_len, 0, pdu);
+	g_assert(sms_decode(pdu, pdu_len, FALSE, 24, &sr3) =3D=3D TRUE);
+
 	g_print("sr1 address: %s, mr: %d\n",
 			sms_address_to_string(&sr1.status_report.raddr),
 			sr1.status_report.mr);
@@ -1301,6 +1309,10 @@ static void test_sr_assembly()
 			sms_address_to_string(&sr2.status_report.raddr),
 			sr2.status_report.mr);
 =

+	g_print("sr3 address: %s, mr: %d\n",
+			sms_address_to_string(&sr3.status_report.raddr),
+			sr3.status_report.mr);
+
 	sms_address_from_string(&addr, "+4915259911630");
 =

 	sra =3D status_report_assembly_new(NULL);
@@ -1319,6 +1331,35 @@ static void test_sr_assembly()
 =

 	g_assert(memcmp(id, sha1, SMS_MSGID_LEN) =3D=3D 0);
 	g_assert(delivered =3D=3D TRUE);
+
+	/*
+	 * Send sms-message in the national address-format,
+	 * but receive in the international address-format.
+	 */
+	sms_address_from_string(&addr, "9911630");
+	status_report_assembly_add_fragment(sra, sha1, &addr, 4, time(NULL), 2);
+	status_report_assembly_add_fragment(sra, sha1, &addr, 5, time(NULL), 2);
+
+	g_assert(!status_report_assembly_report(sra, &sr1, id, &delivered));
+	g_assert(status_report_assembly_report(sra, &sr2, id, &delivered));
+
+	g_assert(memcmp(id, sha1, SMS_MSGID_LEN) =3D=3D 0);
+	g_assert(delivered =3D=3D TRUE);
+	g_assert(g_hash_table_size(sra->assembly_table) =3D=3D 0);
+
+	/*
+	 * Send sms-message in the international address-format,
+	 * but receive in the national address-format.
+	 */
+	sms_address_from_string(&addr, "+358123456789");
+	status_report_assembly_add_fragment(sra, sha1, &addr, 6, time(NULL), 1);
+
+	g_assert(status_report_assembly_report(sra, &sr3, id, &delivered));
+
+	g_assert(memcmp(id, sha1, SMS_MSGID_LEN) =3D=3D 0);
+	g_assert(delivered =3D=3D TRUE);
+	g_assert(g_hash_table_size(sra->assembly_table) =3D=3D 0);
+
 	status_report_assembly_free(sra);
 }
 =

-- =

1.6.3.3



--===============6644328673885401545==--

