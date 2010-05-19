Content-Type: multipart/mixed; boundary="===============7534861290542189570=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 6/8] test-stk: Add test for send dtmf parser
Date: Wed, 19 May 2010 18:24:44 +0800
Message-ID: <1274264686-9706-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274264686-9706-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7534861290542189570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  742 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 742 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 1195d6d..b236e59 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -299,6 +299,12 @@ static inline void check_imm_resp(const unsigned char =
command,
 	check_common_byte(command, test);
 }
 =

+/* Defined in TS 102.223 Section 8.44 */
+static inline void check_dtmf_string(const char *command, const char *test)
+{
+	check_common_text(command, test);
+}
+
 /* Defined in TS 102.223 Section 8.60 */
 static inline void check_aid(const struct stk_aid *command,
 					const struct stk_aid *test)
@@ -11476,6 +11482,671 @@ static void test_run_at_command(gconstpointer dat=
a)
 	stk_command_free(command);
 }
 =

+struct send_dtmf_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	char *alpha_id;
+	char *dtmf;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+static unsigned char send_dtmf_111[] =3D { 0xD0, 0x0D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0xAC, 0x02, 0xC1, 0xF2 };
+
+static unsigned char send_dtmf_121[] =3D { 0xD0, 0x1B, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x09, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0xAC, 0x05, 0x21, 0x43,
+						0x65, 0x87, 0x09 };
+
+static unsigned char send_dtmf_131[] =3D { 0xD0, 0x13, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x00, 0xAC, 0x06, 0xC1,
+						0xCC, 0xCC, 0xCC, 0xCC, 0x2C };
+
+static unsigned char send_dtmf_211[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0A, 0x42, 0x61, 0x73,
+						0x69, 0x63, 0x20, 0x49, 0x63,
+						0x6F, 0x6E, 0xAC, 0x02, 0xC1,
+						0xF2, 0x9E, 0x02, 0x00, 0x01 };
+
+static unsigned char send_dtmf_221[] =3D { 0xD0, 0x1E, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x43, 0x6F, 0x6C,
+						0x6F, 0x75, 0x72, 0x20, 0x49,
+						0x63, 0x6F, 0x6E, 0xAC, 0x02,
+						0xC1, 0xF2, 0x9E, 0x02, 0x00,
+						0x02 };
+
+static unsigned char send_dtmf_231[] =3D { 0xD0, 0x1C, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x09, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0xAC, 0x02, 0xC1, 0xF2,
+						0x9E, 0x02, 0x01, 0x01 };
+
+static unsigned char send_dtmf_311[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x19, 0x80, 0x04, 0x17,
+						0x04, 0x14, 0x04, 0x20, 0x04,
+						0x10, 0x04, 0x12, 0x04, 0x21,
+						0x04, 0x22, 0x04, 0x12, 0x04,
+						0x23, 0x04, 0x19, 0x04, 0x22,
+						0x04, 0x15, 0xAC, 0x02, 0xC1,
+						0xF2 };
+
+static unsigned char send_dtmf_411[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x31, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x00,
+						0xB4 };
+
+static unsigned char send_dtmf_412[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x32, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09 };
+
+static unsigned char send_dtmf_421[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x31, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x01,
+						0xB4 };
+
+static unsigned char send_dtmf_422[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x32, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09 };
+
+static unsigned char send_dtmf_431[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x31, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0xB0, 0x02,
+						0xB4 };
+
+static unsigned char send_dtmf_432[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x32, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09 };
+
+static unsigned char send_dtmf_441[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x31, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x04,
+						0xB4 };
+
+static unsigned char send_dtmf_442[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x32, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x00,
+						0xB4 };
+
+static unsigned char send_dtmf_443[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x33, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09 };
+
+static unsigned char send_dtmf_451[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x31, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x08,
+						0xB4 };
+
+static unsigned char send_dtmf_452[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x32, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x00,
+						0xB4 };
+
+static unsigned char send_dtmf_453[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x33, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09 };
+
+/* The last 0x00 in spec should be removed. */
+static unsigned char send_dtmf_461[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x31, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x10,
+						0xB4 };
+
+static unsigned char send_dtmf_462[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x32, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x00,
+						0xB4 };
+
+static unsigned char send_dtmf_463[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x33, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09 };
+
+static unsigned char send_dtmf_471[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x31, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x20,
+						0xB4 };
+
+static unsigned char send_dtmf_472[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x32, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x00,
+						0xB4 };
+
+static unsigned char send_dtmf_473[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x33, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09 };
+
+static unsigned char send_dtmf_481[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x31, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x40,
+						0xB4 };
+
+static unsigned char send_dtmf_482[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x32, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x00,
+						0xB4 };
+
+static unsigned char send_dtmf_483[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x33, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09 };
+
+/* The second to the last should be 0x80 */
+static unsigned char send_dtmf_491[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x31, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x80,
+						0xB4 };
+
+static unsigned char send_dtmf_492[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x32, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x00,
+						0xB4 };
+
+static unsigned char send_dtmf_493[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x33, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09 };
+
+static unsigned char send_dtmf_4101[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, =
0x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x31, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09,
+						0xD0, 0x04, 0x00, 0x0B, 0x00,
+						0xB4 };
+
+static unsigned char send_dtmf_4102[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x01, =
0x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x0B, 0x53, 0x65, 0x6E,
+						0x64, 0x20, 0x44, 0x54, 0x4D,
+						0x46, 0x20, 0x32, 0xAC, 0x05,
+						0x21, 0x43, 0x65, 0x87, 0x09 };
+
+static unsigned char send_dtmf_511[] =3D { 0xD0, 0x14, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x05, 0x80, 0x4F, 0x60,
+						0x59, 0x7D, 0xAC, 0x02, 0xC1,
+						0xF2 };
+
+static unsigned char send_dtmf_611[] =3D { 0xD0, 0x12, 0x81, 0x03, 0x01, 0=
x14,
+						0x00, 0x82, 0x02, 0x81, 0x83,
+						0x85, 0x03, 0x80, 0x30, 0xEB,
+						0xAC, 0x02, 0xC1, 0xF2 };
+
+static struct send_dtmf_test send_dtmf_data_111 =3D {
+	.pdu =3D send_dtmf_111,
+	.pdu_len =3D sizeof(send_dtmf_111),
+	.qualifier =3D 0x00,
+	.dtmf =3D "1a2"
+};
+
+static struct send_dtmf_test send_dtmf_data_121 =3D {
+	.pdu =3D send_dtmf_121,
+	.pdu_len =3D sizeof(send_dtmf_121),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_131 =3D {
+	.pdu =3D send_dtmf_131,
+	.pdu_len =3D sizeof(send_dtmf_131),
+	.qualifier =3D 0x00,
+	.dtmf =3D "1aaaaaaaaaa2"
+};
+
+static struct send_dtmf_test send_dtmf_data_211 =3D {
+	.pdu =3D send_dtmf_211,
+	.pdu_len =3D sizeof(send_dtmf_211),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Basic Icon",
+	.dtmf =3D "1a2",
+	.icon_id =3D {
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
+		.id =3D 0x01
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_221 =3D {
+	.pdu =3D send_dtmf_221,
+	.pdu_len =3D sizeof(send_dtmf_221),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Colour Icon",
+	.dtmf =3D "1a2",
+	.icon_id =3D {
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
+		.id =3D 0x02
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_231 =3D {
+	.pdu =3D send_dtmf_231,
+	.pdu_len =3D sizeof(send_dtmf_231),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF",
+	.dtmf =3D "1a2",
+	.icon_id =3D {
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
+		.id =3D 0x01
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_311 =3D {
+	.pdu =3D send_dtmf_311,
+	.pdu_len =3D sizeof(send_dtmf_311),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
+	.dtmf =3D "1a2"
+};
+
+static struct send_dtmf_test send_dtmf_data_411 =3D {
+	.pdu =3D send_dtmf_411,
+	.pdu_len =3D sizeof(send_dtmf_411),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 1",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_412 =3D {
+	.pdu =3D send_dtmf_412,
+	.pdu_len =3D sizeof(send_dtmf_412),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 2",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_421 =3D {
+	.pdu =3D send_dtmf_421,
+	.pdu_len =3D sizeof(send_dtmf_421),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 1",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x01, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_422 =3D {
+	.pdu =3D send_dtmf_422,
+	.pdu_len =3D sizeof(send_dtmf_422),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 2",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_431 =3D {
+	.pdu =3D send_dtmf_431,
+	.pdu_len =3D sizeof(send_dtmf_431),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 1",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0xB0, 0x02, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_432 =3D {
+	.pdu =3D send_dtmf_432,
+	.pdu_len =3D sizeof(send_dtmf_432),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 2",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_441 =3D {
+	.pdu =3D send_dtmf_441,
+	.pdu_len =3D sizeof(send_dtmf_441),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 1",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x04, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_442 =3D {
+	.pdu =3D send_dtmf_442,
+	.pdu_len =3D sizeof(send_dtmf_442),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 2",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_443 =3D {
+	.pdu =3D send_dtmf_443,
+	.pdu_len =3D sizeof(send_dtmf_443),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 3",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_451 =3D {
+	.pdu =3D send_dtmf_451,
+	.pdu_len =3D sizeof(send_dtmf_451),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 1",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x08, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_452 =3D {
+	.pdu =3D send_dtmf_452,
+	.pdu_len =3D sizeof(send_dtmf_452),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 2",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_453 =3D {
+	.pdu =3D send_dtmf_453,
+	.pdu_len =3D sizeof(send_dtmf_453),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 3",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_461 =3D {
+	.pdu =3D send_dtmf_461,
+	.pdu_len =3D sizeof(send_dtmf_461),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 1",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x10, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_462 =3D {
+	.pdu =3D send_dtmf_462,
+	.pdu_len =3D sizeof(send_dtmf_462),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 2",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_463 =3D {
+	.pdu =3D send_dtmf_463,
+	.pdu_len =3D sizeof(send_dtmf_463),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 3",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_471 =3D {
+	.pdu =3D send_dtmf_471,
+	.pdu_len =3D sizeof(send_dtmf_471),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 1",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x20, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_472 =3D {
+	.pdu =3D send_dtmf_472,
+	.pdu_len =3D sizeof(send_dtmf_472),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 2",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_473 =3D {
+	.pdu =3D send_dtmf_473,
+	.pdu_len =3D sizeof(send_dtmf_473),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 3",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_481 =3D {
+	.pdu =3D send_dtmf_481,
+	.pdu_len =3D sizeof(send_dtmf_481),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 1",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x40, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_482 =3D {
+	.pdu =3D send_dtmf_482,
+	.pdu_len =3D sizeof(send_dtmf_482),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 2",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_483 =3D {
+	.pdu =3D send_dtmf_483,
+	.pdu_len =3D sizeof(send_dtmf_483),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 3",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_491 =3D {
+	.pdu =3D send_dtmf_491,
+	.pdu_len =3D sizeof(send_dtmf_491),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 1",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x80, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_492 =3D {
+	.pdu =3D send_dtmf_492,
+	.pdu_len =3D sizeof(send_dtmf_492),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 2",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_493 =3D {
+	.pdu =3D send_dtmf_493,
+	.pdu_len =3D sizeof(send_dtmf_493),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 3",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_4101 =3D {
+	.pdu =3D send_dtmf_4101,
+	.pdu_len =3D sizeof(send_dtmf_4101),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 1",
+	.dtmf =3D "1234567890",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
+	}
+};
+
+static struct send_dtmf_test send_dtmf_data_4102 =3D {
+	.pdu =3D send_dtmf_4102,
+	.pdu_len =3D sizeof(send_dtmf_4102),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Send DTMF 2",
+	.dtmf =3D "1234567890"
+};
+
+static struct send_dtmf_test send_dtmf_data_511 =3D {
+	.pdu =3D send_dtmf_511,
+	.pdu_len =3D sizeof(send_dtmf_511),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "=E4=BD=A0=E5=A5=BD",
+	.dtmf =3D "1a2"
+};
+
+static struct send_dtmf_test send_dtmf_data_611 =3D {
+	.pdu =3D send_dtmf_611,
+	.pdu_len =3D sizeof(send_dtmf_611),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "=E3=83=AB",
+	.dtmf =3D "1a2"
+};
+
+static void test_send_dtmf(gconstpointer data)
+{
+	const struct send_dtmf_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SEND_DTMF);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_NETWORK);
+
+	check_alpha_id(command->send_dtmf.alpha_id, test->alpha_id);
+	check_dtmf_string(command->send_dtmf.dtmf, test->dtmf);
+	check_icon_id(&command->send_dtmf.icon_id, &test->icon_id);
+	check_text_attr(&command->send_dtmf.text_attr, &test->text_attr);
+	check_frame_id(&command->send_dtmf.frame_id, &test->frame_id);
+
+	stk_command_free(command);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -12385,5 +13056,76 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Run At Command 6.1.1",
 			&run_at_command_data_611, test_run_at_command);
 =

+	g_test_add_data_func("/teststk/Send DTMF 1.1.1",
+			&send_dtmf_data_111, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 1.2.1",
+			&send_dtmf_data_121, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 1.3.1",
+			&send_dtmf_data_131, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 2.1.1",
+			&send_dtmf_data_211, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 2.2.1",
+			&send_dtmf_data_221, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 2.3.1",
+			&send_dtmf_data_231, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 3.1.1",
+			&send_dtmf_data_311, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.1.1",
+			&send_dtmf_data_411, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.1.2",
+			&send_dtmf_data_412, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.2.1",
+			&send_dtmf_data_421, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.2.2",
+			&send_dtmf_data_422, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.3.1",
+			&send_dtmf_data_431, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.3.2",
+			&send_dtmf_data_432, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.4.1",
+			&send_dtmf_data_441, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.4.2",
+			&send_dtmf_data_442, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.4.3",
+			&send_dtmf_data_443, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.5.1",
+			&send_dtmf_data_451, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.5.2",
+			&send_dtmf_data_452, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.5.3",
+			&send_dtmf_data_453, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.6.1",
+			&send_dtmf_data_461, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.6.2",
+			&send_dtmf_data_462, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.6.3",
+			&send_dtmf_data_463, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.7.1",
+			&send_dtmf_data_471, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.7.2",
+			&send_dtmf_data_472, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.7.3",
+			&send_dtmf_data_473, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.8.1",
+			&send_dtmf_data_481, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.8.2",
+			&send_dtmf_data_482, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.8.3",
+			&send_dtmf_data_483, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.9.1",
+			&send_dtmf_data_491, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.9.2",
+			&send_dtmf_data_492, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.9.3",
+			&send_dtmf_data_493, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.10.1",
+			&send_dtmf_data_4101, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 4.10.2",
+			&send_dtmf_data_4102, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 5.1.1",
+			&send_dtmf_data_511, test_send_dtmf);
+	g_test_add_data_func("/teststk/Send DTMF 6.1.1",
+			&send_dtmf_data_611, test_send_dtmf);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============7534861290542189570==--

