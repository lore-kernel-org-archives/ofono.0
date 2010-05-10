Content-Type: multipart/mixed; boundary="===============2138896865990932455=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 08/19] test-stkutil: Add unit test for play tone parser
Date: Mon, 10 May 2010 18:38:51 +0800
Message-ID: <1273487942-27213-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2138896865990932455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c | 1356 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 1356 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 11b088b..65688ea 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -52,6 +52,12 @@ static inline void check_common_bool(const ofono_bool_t =
command,
 	g_assert(command =3D=3D test);
 }
 =

+static inline void check_common_byte(const unsigned char command,
+					const unsigned char test)
+{
+	g_assert(command =3D=3D test);
+}
+
 static inline void check_common_text(const char *command, const char *test)
 {
 	if (test =3D=3D NULL) {
@@ -2635,6 +2641,1247 @@ static void test_more_time(gconstpointer data)
 	stk_command_free(command);
 }
 =

+struct play_tone_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	char *alpha_id;
+	unsigned char tone;
+	struct stk_duration duration;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+static unsigned char play_tone_111[] =3D { 0xD0, 0x1B, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x09, 0x44, 0x69, 0x61,
+						0x6C, 0x20, 0x54, 0x6F, 0x6E,
+						0x65, 0x8E, 0x01, 0x01, 0x84,
+						0x02, 0x01, 0x05 };
+
+static unsigned char play_tone_112[] =3D { 0xD0, 0x1B, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x09, 0x53, 0x75, 0x62,
+						0x2E, 0x20, 0x42, 0x75, 0x73,
+						0x79, 0x8E, 0x01, 0x02, 0x84,
+						0x02, 0x01, 0x05 };
+
+static unsigned char play_tone_113[] =3D { 0xD0, 0x1C, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x0A, 0x43, 0x6F, 0x6E,
+						0x67, 0x65, 0x73, 0x74, 0x69,
+						0x6F, 0x6E, 0x8E, 0x01, 0x03,
+						0x84, 0x02, 0x01, 0x05 };
+
+static unsigned char play_tone_114[] =3D { 0xD0, 0x18, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x06, 0x52, 0x50, 0x20,
+						0x41, 0x63, 0x6B, 0x8E, 0x01,
+						0x04, 0x84, 0x02, 0x01, 0x05 };
+
+static unsigned char play_tone_115[] =3D { 0xD0, 0x17, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x05, 0x4E, 0x6F, 0x20,
+						0x52, 0x50, 0x8E, 0x01, 0x05,
+						0x84, 0x02, 0x01, 0x05 };
+
+static unsigned char play_tone_116[] =3D { 0xD0, 0x1B, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x09, 0x53, 0x70, 0x65,
+						0x63, 0x20, 0x49, 0x6E, 0x66,
+						0x6F, 0x8E, 0x01, 0x06, 0x84,
+						0x02, 0x01, 0x05 };
+
+static unsigned char play_tone_117[] =3D { 0xD0, 0x1B, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x09, 0x43, 0x61, 0x6C,
+						0x6C, 0x20, 0x57, 0x61, 0x69,
+						0x74, 0x8E, 0x01, 0x07, 0x84,
+						0x02, 0x01, 0x05 };
+
+static unsigned char play_tone_118[] =3D { 0xD0, 0x1B, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x09, 0x52, 0x69, 0x6E,
+						0x67, 0x20, 0x54, 0x6F, 0x6E,
+						0x65, 0x8E, 0x01, 0x08, 0x84,
+						0x02, 0x01, 0x05 };
+
+static unsigned char play_tone_119[] =3D { 0xD0, 0x81, 0xFD, 0x81, 0x03, 0=
x01,
+						0x20, 0x00, 0x82, 0x02, 0x81,
+						0x03, 0x85, 0x81, 0xF1, 0x54,
+						0x68, 0x69, 0x73, 0x20, 0x63,
+						0x6F, 0x6D, 0x6D, 0x61, 0x6E,
+						0x64, 0x20, 0x69, 0x6E, 0x73,
+						0x74, 0x72, 0x75, 0x63, 0x74,
+						0x73, 0x20, 0x74, 0x68, 0x65,
+						0x20, 0x4D, 0x45, 0x20, 0x74,
+						0x6F, 0x20, 0x70, 0x6C, 0x61,
+						0x79, 0x20, 0x61, 0x6E, 0x20,
+						0x61, 0x75, 0x64, 0x69, 0x6F,
+						0x20, 0x74, 0x6F, 0x6E, 0x65,
+						0x2E, 0x20, 0x55, 0x70, 0x6F,
+						0x6E, 0x20, 0x72, 0x65, 0x63,
+						0x65, 0x69, 0x76, 0x69, 0x6E,
+						0x67, 0x20, 0x74, 0x68, 0x69,
+						0x73, 0x20, 0x63, 0x6F, 0x6D,
+						0x6D, 0x61, 0x6E, 0x64, 0x2C,
+						0x20, 0x74, 0x68, 0x65, 0x20,
+						0x4D, 0x45, 0x20, 0x73, 0x68,
+						0x61, 0x6C, 0x6C, 0x20, 0x63,
+						0x68, 0x65, 0x63, 0x6B, 0x20,
+						0x69, 0x66, 0x20, 0x69, 0x74,
+						0x20, 0x69, 0x73, 0x20, 0x63,
+						0x75, 0x72, 0x72, 0x65, 0x6E,
+						0x74, 0x6C, 0x79, 0x20, 0x69,
+						0x6E, 0x2C, 0x20, 0x6F, 0x72,
+						0x20, 0x69, 0x6E, 0x20, 0x74,
+						0x68, 0x65, 0x20, 0x70, 0x72,
+						0x6F, 0x63, 0x65, 0x73, 0x73,
+						0x20, 0x6F, 0x66, 0x20, 0x73,
+						0x65, 0x74, 0x74, 0x69, 0x6E,
+						0x67, 0x20, 0x75, 0x70, 0x20,
+						0x28, 0x53, 0x45, 0x54, 0x2D,
+						0x55, 0x50, 0x20, 0x6D, 0x65,
+						0x73, 0x73, 0x61, 0x67, 0x65,
+						0x20, 0x73, 0x65, 0x6E, 0x74,
+						0x20, 0x74, 0x6F, 0x20, 0x74,
+						0x68, 0x65, 0x20, 0x6E, 0x65,
+						0x74, 0x77, 0x6F, 0x72, 0x6B,
+						0x2C, 0x20, 0x73, 0x65, 0x65,
+						0x20, 0x47, 0x53, 0x4D, 0x22,
+						0x30, 0x34, 0x2E, 0x30, 0x38,
+						0x22, 0x28, 0x38, 0x29, 0x29,
+						0x2C, 0x20, 0x61, 0x20, 0x73,
+						0x70, 0x65, 0x65, 0x63, 0x68,
+						0x20, 0x63, 0x61, 0x6C, 0x6C,
+						0x2E, 0x20, 0x2D, 0x20, 0x49,
+						0x66, 0x20, 0x74, 0x68, 0x65,
+						0x20, 0x4D, 0x45, 0x20, 0x49 };
+
+static unsigned char play_tone_1110[] =3D { 0xD0, 0x16, 0x81, 0x03, 0x01, =
0x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x04, 0x42, 0x65, 0x65,
+						0x70, 0x8E, 0x01, 0x10, 0x84,
+						0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_1111[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x01, =
0x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x08, 0x50, 0x6F, 0x73,
+						0x69, 0x74, 0x69, 0x76, 0x65,
+						0x8E, 0x01, 0x11, 0x84, 0x02,
+						0x01, 0x01 };
+
+static unsigned char play_tone_1112[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x01, =
0x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x08, 0x4E, 0x65, 0x67,
+						0x61, 0x74, 0x69, 0x76, 0x65,
+						0x8E, 0x01, 0x12, 0x84, 0x02,
+						0x01, 0x01 };
+
+static unsigned char play_tone_1113[] =3D { 0xD0, 0x17, 0x81, 0x03, 0x01, =
0x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x05, 0x51, 0x75, 0x69,
+						0x63, 0x6B, 0x8E, 0x01, 0x10,
+						0x84, 0x02, 0x02, 0x02 };
+
+static unsigned char play_tone_1114[] =3D { 0xD0, 0x19, 0x81, 0x03, 0x01, =
0x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x07, 0x3C, 0x41, 0x42,
+						0x4F, 0x52, 0x54, 0x3E, 0x8E,
+						0x01, 0x06, 0x84, 0x02, 0x00,
+						0x01 };
+
+static unsigned char play_tone_1115[] =3D { 0xD0, 0x09, 0x81, 0x03, 0x01, =
0x20,
+						0x00, 0x82, 0x02, 0x81, 0x03 };
+
+static unsigned char play_tone_211[] =3D { 0xD0, 0x2B, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x19, 0x80, 0x04, 0x17,
+						0x04, 0x14, 0x04, 0x20, 0x04,
+						0x10, 0x04, 0x12, 0x04, 0x21,
+						0x04, 0x22, 0x04, 0x12, 0x04,
+						0x23, 0x04, 0x19, 0x04, 0x22,
+						0x04, 0x15, 0x8E, 0x01, 0x11,
+						0x84, 0x02, 0x01, 0x01 };
+
+
+static unsigned char play_tone_212[] =3D { 0xD0, 0x21, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x0F, 0x81, 0x0C, 0x08,
+						0x97, 0x94, 0xA0, 0x90, 0x92,
+						0xA1, 0xA2, 0x92, 0xA3, 0x99,
+						0xA2, 0x95, 0x8E, 0x01, 0x11,
+						0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_213[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x82, 0x0C, 0x04,
+						0x10, 0x87, 0x84, 0x90, 0x80,
+						0x82, 0x91, 0x92, 0x82, 0x93,
+						0x89, 0x92, 0x85, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_311[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x0C, 0x3C, 0x42, 0x41,
+						0x53, 0x49, 0x43, 0x2D, 0x49,
+						0x43, 0x4F, 0x4E, 0x3E, 0x8E,
+						0x01, 0x11, 0x84, 0x02, 0x01,
+						0x01, 0x1E, 0x02, 0x00, 0x01 };
+
+static unsigned char play_tone_321[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x0C, 0x3C, 0x42, 0x41,
+						0x53, 0x49, 0x43, 0x2D, 0x49,
+						0x43, 0x4F, 0x4E, 0x3E, 0x8E,
+						0x01, 0x11, 0x84, 0x02, 0x01,
+						0x01, 0x1E, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_331[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x0D, 0x3C, 0x43, 0x4F,
+						0x4C, 0x4F, 0x55, 0x52, 0x2D,
+						0x49, 0x43, 0x4F, 0x4E, 0x3E,
+						0x8E, 0x01, 0x11, 0x84, 0x02,
+						0x01, 0x01, 0x1E, 0x02, 0x00,
+						0x02 };
+
+static unsigned char play_tone_341[] =3D { 0xD0, 0x23, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x0D, 0x3C, 0x43, 0x4F,
+						0x4C, 0x4F, 0x55, 0x52, 0x2D,
+						0x49, 0x43, 0x4F, 0x4E, 0x3E,
+						0x8E, 0x01, 0x11, 0x84, 0x02,
+						0x01, 0x01, 0x1E, 0x02, 0x01,
+						0x02 };
+
+static unsigned char play_tone_411[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x31, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x00,
+						0xB4 };
+
+static unsigned char play_tone_412[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x32, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_421[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x31, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x01,
+						0xB4 };
+
+static unsigned char play_tone_422[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x32, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_431[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x31, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x02,
+						0xB4 };
+
+static unsigned char play_tone_432[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x32, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_441[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x31, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x04,
+						0xB4 };
+
+static unsigned char play_tone_442[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x32, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x00,
+						0xB4 };
+
+static unsigned char play_tone_443[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x33, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_451[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x31, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x08,
+						0xB4 };
+
+static unsigned char play_tone_452[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x32, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x00,
+						0xB4 };
+
+static unsigned char play_tone_453[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x33, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_461[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x31, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x0E, 0x10,
+						0xB4 };
+
+static unsigned char play_tone_462[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x32, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x00,
+						0xB4 };
+
+static unsigned char play_tone_463[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x33, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_471[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x31, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x0E, 0x20,
+						0xB4 };
+
+static unsigned char play_tone_472[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x32, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x00,
+						0xB4 };
+
+static unsigned char play_tone_473[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x33, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_481[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x31, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x40,
+						0xB4 };
+
+static unsigned char play_tone_482[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x32, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x00,
+						0xB4 };
+
+static unsigned char play_tone_483[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x33, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_491[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x31, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x80,
+						0xB4 };
+
+static unsigned char play_tone_492[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x32, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x00,
+						0xB4 };
+
+static unsigned char play_tone_493[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x33, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_4101[] =3D { 0xD0, 0x28, 0x81, 0x03, 0x01, =
0x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x31, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01,
+						0xD0, 0x04, 0x00, 0x10, 0x00,
+						0xB4 };
+
+static unsigned char play_tone_4102[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, =
0x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x10, 0x54, 0x65, 0x78,
+						0x74, 0x20, 0x41, 0x74, 0x74,
+						0x72, 0x69, 0x62, 0x75, 0x74,
+						0x65, 0x20, 0x32, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_511[] =3D { 0xD0, 0x17, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x05, 0x80, 0x4E, 0x2D,
+						0x4E, 0x00, 0x8E, 0x01, 0x11,
+						0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_512[] =3D { 0xD0, 0x17, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x05, 0x81, 0x02, 0x9C,
+						0xAD, 0x80, 0x8E, 0x01, 0x11,
+						0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_513[] =3D { 0xD0, 0x18, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x06, 0x82, 0x02, 0x4E,
+						0x00, 0xAD, 0x80, 0x8E, 0x01,
+						0x11, 0x84, 0x02, 0x01, 0x01 };
+
+static unsigned char play_tone_611[] =3D { 0xD0, 0x1B, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x09, 0x80, 0x00, 0x38,
+						0x00, 0x30, 0x30, 0xEB, 0x00,
+						0x30, 0x8E, 0x01, 0x01, 0x84,
+						0x02, 0x01, 0x05 };
+
+static unsigned char play_tone_612[] =3D { 0xD0, 0x19, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x07, 0x81, 0x04, 0x61,
+						0x38, 0x31, 0xEB, 0x31, 0x8E,
+						0x01, 0x01, 0x84, 0x02, 0x01,
+						0x05 };
+
+static unsigned char play_tone_613[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x01, 0=
x20,
+						0x00, 0x82, 0x02, 0x81, 0x03,
+						0x85, 0x08, 0x82, 0x04, 0x30,
+						0xA0, 0x38, 0x32, 0xCB, 0x32,
+						0x8E, 0x01, 0x01, 0x84, 0x02,
+						0x01, 0x05 };
+
+static struct play_tone_test play_tone_data_111 =3D {
+	.pdu =3D play_tone_111,
+	.pdu_len =3D sizeof(play_tone_111),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Dial Tone",
+	.tone =3D STK_TONE_TYPE_DIAL_TONE,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+static struct play_tone_test play_tone_data_112 =3D {
+	.pdu =3D play_tone_112,
+	.pdu_len =3D sizeof(play_tone_112),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Sub. Busy",
+	.tone =3D STK_TONE_TYPE_BUSY_TONE,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+static struct play_tone_test play_tone_data_113 =3D {
+	.pdu =3D play_tone_113,
+	.pdu_len =3D sizeof(play_tone_113),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Congestion",
+	.tone =3D STK_TONE_TYPE_CONGESTION,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+static struct play_tone_test play_tone_data_114 =3D {
+	.pdu =3D play_tone_114,
+	.pdu_len =3D sizeof(play_tone_114),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "RP Ack",
+	.tone =3D STK_TONE_TYPE_RP_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+static struct play_tone_test play_tone_data_115 =3D {
+	.pdu =3D play_tone_115,
+	.pdu_len =3D sizeof(play_tone_115),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "No RP",
+	.tone =3D STK_TONE_TYPE_CALL_DROPPED,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+static struct play_tone_test play_tone_data_116 =3D {
+	.pdu =3D play_tone_116,
+	.pdu_len =3D sizeof(play_tone_116),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Spec Info",
+	.tone =3D STK_TONE_TYPE_ERROR,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+static struct play_tone_test play_tone_data_117 =3D {
+	.pdu =3D play_tone_117,
+	.pdu_len =3D sizeof(play_tone_117),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Call Wait",
+	.tone =3D STK_TONE_TYPE_CALL_WAITING,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+static struct play_tone_test play_tone_data_118 =3D {
+	.pdu =3D play_tone_118,
+	.pdu_len =3D sizeof(play_tone_118),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Ring Tone",
+	.tone =3D STK_TONE_TYPE_RINGING,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+static struct play_tone_test play_tone_data_119 =3D {
+	.pdu =3D play_tone_119,
+	.pdu_len =3D sizeof(play_tone_119),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "This command instructs the ME to play an audio tone. \
+Upon receiving this command, the ME shall check if it is currently in, or \
+in the process of setting up (SET-UP message sent to the network, \
+see GSM\"04.08\"(8)), a speech call. - If the ME I"
+};
+
+static struct play_tone_test play_tone_data_1110 =3D {
+	.pdu =3D play_tone_1110,
+	.pdu_len =3D sizeof(play_tone_1110),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Beep",
+	.tone =3D STK_TONE_TYPE_GENERAL_BEEP,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_1111 =3D {
+	.pdu =3D play_tone_1111,
+	.pdu_len =3D sizeof(play_tone_1111),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Positive",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_1112 =3D {
+	.pdu =3D play_tone_1112,
+	.pdu_len =3D sizeof(play_tone_1112),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Negative",
+	.tone =3D STK_TONE_TYPE_NEGATIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_1113 =3D {
+	.pdu =3D play_tone_1113,
+	.pdu_len =3D sizeof(play_tone_1113),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Quick",
+	.tone =3D STK_TONE_TYPE_GENERAL_BEEP,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECOND_TENTHS,
+		.interval =3D 2
+	}
+};
+
+static struct play_tone_test play_tone_data_1114 =3D {
+	.pdu =3D play_tone_1114,
+	.pdu_len =3D sizeof(play_tone_1114),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "<ABORT>",
+	.tone =3D STK_TONE_TYPE_ERROR,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_MINUTES,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_1115 =3D {
+	.pdu =3D play_tone_1115,
+	.pdu_len =3D sizeof(play_tone_1115),
+	.qualifier =3D 0x00
+};
+
+static struct play_tone_test play_tone_data_211 =3D {
+	.pdu =3D play_tone_211,
+	.pdu_len =3D sizeof(play_tone_211),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_212 =3D {
+	.pdu =3D play_tone_212,
+	.pdu_len =3D sizeof(play_tone_212),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_213 =3D {
+	.pdu =3D play_tone_213,
+	.pdu_len =3D sizeof(play_tone_213),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_311 =3D {
+	.pdu =3D play_tone_311,
+	.pdu_len =3D sizeof(play_tone_311),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "<BASIC-ICON>",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.icon_id =3D {
+	    .qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
+	    .id =3D 0x01
+	}
+};
+
+static struct play_tone_test play_tone_data_321 =3D {
+	.pdu =3D play_tone_321,
+	.pdu_len =3D sizeof(play_tone_321),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "<BASIC-ICON>",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.icon_id =3D {
+	    .qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
+	    .id =3D 0x01
+	}
+};
+
+static struct play_tone_test play_tone_data_331 =3D {
+	.pdu =3D play_tone_331,
+	.pdu_len =3D sizeof(play_tone_331),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "<COLOUR-ICON>",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.icon_id =3D {
+	    .qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
+	    .id =3D 0x02
+	}
+};
+
+static struct play_tone_test play_tone_data_341 =3D {
+	.pdu =3D play_tone_341,
+	.pdu_len =3D sizeof(play_tone_341),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "<COLOUR-ICON>",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.icon_id =3D {
+	    .qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
+	    .id =3D 0x02
+	}
+};
+
+static struct play_tone_test play_tone_data_411 =3D {
+	.pdu =3D play_tone_411,
+	.pdu_len =3D sizeof(play_tone_411),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 1",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_412 =3D {
+	.pdu =3D play_tone_412,
+	.pdu_len =3D sizeof(play_tone_412),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 2",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_421 =3D {
+	.pdu =3D play_tone_421,
+	.pdu_len =3D sizeof(play_tone_421),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 1",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x01, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_422 =3D {
+	.pdu =3D play_tone_422,
+	.pdu_len =3D sizeof(play_tone_422),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 2",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_431 =3D {
+	.pdu =3D play_tone_431,
+	.pdu_len =3D sizeof(play_tone_431),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 1",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x02, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_432 =3D {
+	.pdu =3D play_tone_432,
+	.pdu_len =3D sizeof(play_tone_432),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 2",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_441 =3D {
+	.pdu =3D play_tone_441,
+	.pdu_len =3D sizeof(play_tone_441),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 1",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x04, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_442 =3D {
+	.pdu =3D play_tone_442,
+	.pdu_len =3D sizeof(play_tone_442),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 2",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_443 =3D {
+	.pdu =3D play_tone_443,
+	.pdu_len =3D sizeof(play_tone_443),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 3",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_451 =3D {
+	.pdu =3D play_tone_451,
+	.pdu_len =3D sizeof(play_tone_451),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 1",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x08, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_452 =3D {
+	.pdu =3D play_tone_452,
+	.pdu_len =3D sizeof(play_tone_452),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 2",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_453 =3D {
+	.pdu =3D play_tone_453,
+	.pdu_len =3D sizeof(play_tone_453),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 3",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_461 =3D {
+	.pdu =3D play_tone_461,
+	.pdu_len =3D sizeof(play_tone_461),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 1",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0E, 0x10, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_462 =3D {
+	.pdu =3D play_tone_462,
+	.pdu_len =3D sizeof(play_tone_462),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 2",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_463 =3D {
+	.pdu =3D play_tone_463,
+	.pdu_len =3D sizeof(play_tone_463),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 3",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_471 =3D {
+	.pdu =3D play_tone_471,
+	.pdu_len =3D sizeof(play_tone_471),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 1",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0E, 0x20, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_472 =3D {
+	.pdu =3D play_tone_472,
+	.pdu_len =3D sizeof(play_tone_472),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 2",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_473 =3D {
+	.pdu =3D play_tone_473,
+	.pdu_len =3D sizeof(play_tone_473),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 3",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_481 =3D {
+	.pdu =3D play_tone_481,
+	.pdu_len =3D sizeof(play_tone_481),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 1",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x40, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_482 =3D {
+	.pdu =3D play_tone_482,
+	.pdu_len =3D sizeof(play_tone_482),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 2",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_483 =3D {
+	.pdu =3D play_tone_483,
+	.pdu_len =3D sizeof(play_tone_483),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 3",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_491 =3D {
+	.pdu =3D play_tone_491,
+	.pdu_len =3D sizeof(play_tone_491),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 1",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x80, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_492 =3D {
+	.pdu =3D play_tone_492,
+	.pdu_len =3D sizeof(play_tone_492),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 2",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_493 =3D {
+	.pdu =3D play_tone_493,
+	.pdu_len =3D sizeof(play_tone_493),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 3",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_4101 =3D {
+	.pdu =3D play_tone_4101,
+	.pdu_len =3D sizeof(play_tone_4101),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 1",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct play_tone_test play_tone_data_4102 =3D {
+	.pdu =3D play_tone_4102,
+	.pdu_len =3D sizeof(play_tone_4102),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Text Attribute 2",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_511 =3D {
+	.pdu =3D play_tone_511,
+	.pdu_len =3D sizeof(play_tone_511),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "=E4=B8=AD=E4=B8=80",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_512 =3D {
+	.pdu =3D play_tone_512,
+	.pdu_len =3D sizeof(play_tone_512),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "=E4=B8=AD=E4=B8=80",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_513 =3D {
+	.pdu =3D play_tone_513,
+	.pdu_len =3D sizeof(play_tone_513),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "=E4=B8=AD=E4=B8=80",
+	.tone =3D STK_TONE_TYPE_POSITIVE_ACK,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 1
+	}
+};
+
+static struct play_tone_test play_tone_data_611 =3D {
+	.pdu =3D play_tone_611,
+	.pdu_len =3D sizeof(play_tone_611),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "80=E3=83=AB0",
+	.tone =3D STK_TONE_TYPE_DIAL_TONE,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+static struct play_tone_test play_tone_data_612 =3D {
+	.pdu =3D play_tone_612,
+	.pdu_len =3D sizeof(play_tone_612),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "81=E3=83=AB1",
+	.tone =3D STK_TONE_TYPE_DIAL_TONE,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+static struct play_tone_test play_tone_data_613 =3D {
+	.pdu =3D play_tone_613,
+	.pdu_len =3D sizeof(play_tone_613),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "82=E3=83=AB2",
+	.tone =3D STK_TONE_TYPE_DIAL_TONE,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 5
+	}
+};
+
+/* Defined in TS 102.384 Section 27.22.4.5 */
+static void test_play_tone(gconstpointer data)
+{
+	const struct play_tone_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_PLAY_TONE);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_EARPIECE);
+
+	check_common_text(command->play_tone.alpha_id, test->alpha_id);
+	check_common_byte(command->play_tone.tone, test->tone);
+	check_duration(&command->play_tone.duration, &test->duration);
+	check_icon_id(&command->play_tone.icon_id, &test->icon_id);
+	check_text_attr(&command->play_tone.text_attr, &test->text_attr);
+	check_frame_id(&command->play_tone.frame_id, &test->frame_id);
+
+	stk_command_free(command);
+}
+
 struct send_sms_test {
 	const unsigned char *pdu;
 	unsigned int pdu_len;
@@ -2964,6 +4211,115 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/More Time 1.1.1",
 				&more_time_data_111, test_more_time);
 =

+	g_test_add_data_func("/teststk/Play Tone 1.1.1",
+				&play_tone_data_111, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.2",
+				&play_tone_data_112, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.3",
+				&play_tone_data_113, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.4",
+				&play_tone_data_114, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.5",
+				&play_tone_data_115, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.6",
+				&play_tone_data_116, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.7",
+				&play_tone_data_117, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.8",
+				&play_tone_data_118, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.9",
+				&play_tone_data_119, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.10",
+				&play_tone_data_1110, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.11",
+				&play_tone_data_1111, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.12",
+				&play_tone_data_1112, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.13",
+				&play_tone_data_1113, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.14",
+				&play_tone_data_1114, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 1.1.15",
+				&play_tone_data_1115, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 2.1.1",
+				&play_tone_data_211, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 2.1.2",
+				&play_tone_data_212, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 2.1.3",
+				&play_tone_data_213, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 3.1.1",
+				&play_tone_data_311, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 3.2.1",
+				&play_tone_data_321, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 3.3.1",
+				&play_tone_data_331, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 3.4.1",
+				&play_tone_data_341, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.1.1",
+				&play_tone_data_411, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.1.2",
+				&play_tone_data_412, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.2.1",
+				&play_tone_data_421, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.2.2",
+				&play_tone_data_422, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.3.1",
+				&play_tone_data_431, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.3.2",
+				&play_tone_data_432, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.4.1",
+				&play_tone_data_441, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.4.2",
+				&play_tone_data_442, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.4.3",
+				&play_tone_data_443, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.5.1",
+				&play_tone_data_451, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.5.2",
+				&play_tone_data_452, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.5.3",
+				&play_tone_data_453, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.6.1",
+				&play_tone_data_461, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.6.2",
+				&play_tone_data_462, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.6.3",
+				&play_tone_data_463, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.7.1",
+				&play_tone_data_471, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.7.2",
+				&play_tone_data_472, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.7.3",
+				&play_tone_data_473, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.8.1",
+				&play_tone_data_481, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.8.2",
+				&play_tone_data_482, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.8.3",
+				&play_tone_data_483, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.9.1",
+				&play_tone_data_491, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.9.2",
+				&play_tone_data_492, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.9.3",
+				&play_tone_data_493, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.10.1",
+				&play_tone_data_4101, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 4.10.2",
+				&play_tone_data_4102, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 5.1.1",
+				&play_tone_data_511, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 5.1.2",
+				&play_tone_data_512, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 5.1.3",
+				&play_tone_data_513, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 6.1.1",
+				&play_tone_data_611, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 6.1.2",
+				&play_tone_data_612, test_play_tone);
+	g_test_add_data_func("/teststk/Play Tone 6.1.3",
+				&play_tone_data_613, test_play_tone);
+
 	g_test_add_data_func("/teststk/Send SMS 1.1",
 				&send_sms_data_11, test_send_sms);
 =

-- =

1.7.0.4


--===============2138896865990932455==--

