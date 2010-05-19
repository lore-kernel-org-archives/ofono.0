Content-Type: multipart/mixed; boundary="===============1143099706187622865=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/8] test-stk: Add test for setup idle mode text parser
Date: Wed, 19 May 2010 18:24:40 +0800
Message-ID: <1274264686-9706-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274264686-9706-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1143099706187622865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  793 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 793 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 0daf7f9..7b75e1a 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -9999,6 +9999,724 @@ static void test_timer_mgmt(gconstpointer data)
 	stk_command_free(command);
 }
 =

+struct setup_idle_mode_text_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	char *text;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+static unsigned char setup_idle_mode_text_111[] =3D { 0xD0, 0x1A, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x0F, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74 };
+
+static unsigned char setup_idle_mode_text_121[] =3D { 0xD0, 0x18, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x0D, 0x04,
+						0x54, 0x6F, 0x6F, 0x6C, 0x6B,
+						0x69, 0x74, 0x20, 0x54, 0x65,
+						0x73, 0x74 };
+
+static unsigned char setup_idle_mode_text_131[] =3D { 0xD0, 0x0B, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x00 };
+
+static unsigned char setup_idle_mode_text_171[] =3D { 0xD0, 0x81, 0xFD, 0x=
81,
+						0x03, 0x01, 0x28, 0x00, 0x82,
+						0x02, 0x81, 0x82, 0x8D, 0x81,
+						0xF1, 0x00, 0x54, 0x74, 0x19,
+						0x34, 0x4D, 0x36, 0x41, 0x73,
+						0x74, 0x98, 0xCD, 0x06, 0xCD,
+						0xEB, 0x70, 0x38, 0x3B, 0x0F,
+						0x0A, 0x83, 0xE8, 0x65, 0x3C,
+						0x1D, 0x34, 0xA7, 0xCB, 0xD3,
+						0xEE, 0x33, 0x0B, 0x74, 0x47,
+						0xA7, 0xC7, 0x68, 0xD0, 0x1C,
+						0x1D, 0x66, 0xB3, 0x41, 0xE2,
+						0x32, 0x88, 0x9C, 0x9E, 0xC3,
+						0xD9, 0xE1, 0x7C, 0x99, 0x0C,
+						0x12, 0xE7, 0x41, 0x74, 0x74,
+						0x19, 0xD4, 0x2C, 0x82, 0xC2,
+						0x73, 0x50, 0xD8, 0x0D, 0x4A,
+						0x93, 0xD9, 0x65, 0x50, 0xFB,
+						0x4D, 0x2E, 0x83, 0xE8, 0x65,
+						0x3C, 0x1D, 0x94, 0x36, 0x83,
+						0xE8, 0xE8, 0x32, 0xA8, 0x59,
+						0x04, 0xA5, 0xE7, 0xA0, 0xB0,
+						0x98, 0x5D, 0x06, 0xD1, 0xDF,
+						0x20, 0xF2, 0x1B, 0x94, 0xA6,
+						0xBB, 0xA8, 0xE8, 0x32, 0x08,
+						0x2E, 0x2F, 0xCF, 0xCB, 0x6E,
+						0x7A, 0x98, 0x9E, 0x7E, 0xBB,
+						0x41, 0x73, 0x7A, 0x9E, 0x5D,
+						0x06, 0xA5, 0xE7, 0x20, 0x76,
+						0xD9, 0x4C, 0x07, 0x85, 0xE7,
+						0xA0, 0xB0, 0x1B, 0x94, 0x6E,
+						0xC3, 0xD9, 0xE5, 0x76, 0xD9,
+						0x4D, 0x0F, 0xD3, 0xD3, 0x6F,
+						0x37, 0x88, 0x5C, 0x1E, 0xA7,
+						0xE7, 0xE9, 0xB7, 0x1B, 0x44,
+						0x7F, 0x83, 0xE8, 0xE8, 0x32,
+						0xA8, 0x59, 0x04, 0xB5, 0xC3,
+						0xEE, 0xBA, 0x39, 0x3C, 0xA6,
+						0xD7, 0xE5, 0x65, 0xB9, 0x0B,
+						0x44, 0x45, 0x97, 0x41, 0x69,
+						0x32, 0xBB, 0x0C, 0x6A, 0xBF,
+						0xC9, 0x65, 0x10, 0xBD, 0x8C,
+						0xA7, 0x83, 0xE6, 0xE8, 0x30,
+						0x9B, 0x0D, 0x12, 0x97, 0x41,
+						0xE4, 0xF4, 0x1C, 0xCE, 0x0E,
+						0xE7, 0xCB, 0x64, 0x50, 0xDA,
+						0x0D, 0x0A, 0x83, 0xDA, 0x61,
+						0xB7, 0xBB, 0x2C, 0x07, 0xD1,
+						0xD1, 0x61, 0x3A, 0xA8, 0xEC,
+						0x9E, 0xD7, 0xE5, 0xE5, 0x39,
+						0x88, 0x8E, 0x0E, 0xD3, 0x41,
+						0xEE, 0x32 };
+
+static unsigned char setup_idle_mode_text_211[] =3D { 0xD0, 0x19, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x0A, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x74, 0x65, 0x78, 0x74, 0x9E,
+						0x02, 0x00, 0x01 };
+
+static unsigned char setup_idle_mode_text_221[] =3D { 0xD0, 0x19, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x0A, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x74, 0x65, 0x78, 0x74, 0x9E,
+						0x02, 0x01, 0x01 };
+
+static unsigned char setup_idle_mode_text_231[] =3D { 0xD0, 0x19, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x0A, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x74, 0x65, 0x78, 0x74, 0x9E,
+						0x02, 0x00, 0x02 };
+
+static unsigned char setup_idle_mode_text_241[] =3D { 0xD0, 0x0F, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x00, 0x9E,
+						0x02, 0x01, 0x01 };
+
+static unsigned char setup_idle_mode_text_311[] =3D { 0xD0, 0x24, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x19, 0x08,
+						0x04, 0x17, 0x04, 0x14, 0x04,
+						0x20, 0x04, 0x10, 0x04, 0x12,
+						0x04, 0x21, 0x04, 0x22, 0x04,
+						0x12, 0x04, 0x23, 0x04, 0x19,
+						0x04, 0x22, 0x04, 0x15 };
+
+static unsigned char setup_idle_mode_text_411[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x31, 0xD0, 0x04, 0x00, 0x10,
+						0x00, 0xB4 };
+
+static unsigned char setup_idle_mode_text_412[] =3D { 0xD0, 0x1C, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x32 };
+
+static unsigned char setup_idle_mode_text_421[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x31, 0xD0, 0x04, 0x00, 0x10,
+						0x01, 0xB4 };
+
+static unsigned char setup_idle_mode_text_422[] =3D { 0xD0, 0x1C, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x32 };
+
+static unsigned char setup_idle_mode_text_431[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x31, 0xD0, 0x04, 0x00, 0x10,
+						0x02, 0xB4 };
+
+static unsigned char setup_idle_mode_text_432[] =3D { 0xD0, 0x1C, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x32 };
+
+static unsigned char setup_idle_mode_text_441[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x31, 0xD0, 0x04, 0x00, 0x10,
+						0x04, 0xB4 };
+
+static unsigned char setup_idle_mode_text_442[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x32, 0xD0, 0x04, 0x00, 0x10,
+						0x00, 0xB4 };
+
+static unsigned char setup_idle_mode_text_443[] =3D { 0xD0, 0x1C, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x33 };
+
+static unsigned char setup_idle_mode_text_451[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x31, 0xD0, 0x04, 0x00, 0x10,
+						0x08, 0xB4 };
+
+static unsigned char setup_idle_mode_text_452[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x32, 0xD0, 0x04, 0x00, 0x10,
+						0x00, 0xB4 };
+
+static unsigned char setup_idle_mode_text_453[] =3D { 0xD0, 0x1C, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x33 };
+
+static unsigned char setup_idle_mode_text_461[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x31, 0xD0, 0x04, 0x00, 0x10,
+						0x10, 0xB4 };
+
+static unsigned char setup_idle_mode_text_462[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x32, 0xD0, 0x04, 0x00, 0x10,
+						0x00, 0xB4 };
+
+static unsigned char setup_idle_mode_text_463[] =3D { 0xD0, 0x1C, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x33 };
+
+static unsigned char setup_idle_mode_text_471[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x31, 0xD0, 0x04, 0x00, 0x10,
+						0x20, 0xB4 };
+
+static unsigned char setup_idle_mode_text_472[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x32, 0xD0, 0x04, 0x00, 0x10,
+						0x00, 0xB4 };
+
+static unsigned char setup_idle_mode_text_473[] =3D { 0xD0, 0x1C, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x33 };
+
+static unsigned char setup_idle_mode_text_481[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x31, 0xD0, 0x04, 0x00, 0x10,
+						0x40, 0xB4 };
+
+static unsigned char setup_idle_mode_text_482[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x32, 0xD0, 0x04, 0x00, 0x10,
+						0x00, 0xB4 };
+
+static unsigned char setup_idle_mode_text_483[] =3D { 0xD0, 0x1C, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x33 };
+
+static unsigned char setup_idle_mode_text_491[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x31, 0xD0, 0x04, 0x00, 0x10,
+						0x80, 0xB4 };
+
+static unsigned char setup_idle_mode_text_492[] =3D { 0xD0, 0x22, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x32, 0xD0, 0x04, 0x00, 0x10,
+						0x00, 0xB4 };
+
+static unsigned char setup_idle_mode_text_493[] =3D { 0xD0, 0x1C, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x33 };
+
+static unsigned char setup_idle_mode_text_4101[] =3D { 0xD0, 0x22, 0x81, 0=
x03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x31, 0xD0, 0x04, 0x00, 0x10,
+						0x00, 0xB4 };
+
+static unsigned char setup_idle_mode_text_4102[] =3D { 0xD0, 0x1C, 0x81, 0=
x03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x11, 0x04,
+						0x49, 0x64, 0x6C, 0x65, 0x20,
+						0x4D, 0x6F, 0x64, 0x65, 0x20,
+						0x54, 0x65, 0x78, 0x74, 0x20,
+						0x32 };
+
+static unsigned char setup_idle_mode_text_511[] =3D { 0xD0, 0x10, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x05, 0x08,
+						0x4F, 0x60, 0x59, 0x7D };
+
+static unsigned char setup_idle_mode_text_611[] =3D { 0xD0, 0x14, 0x81, 0x=
03,
+						0x01, 0x28, 0x00, 0x82, 0x02,
+						0x81, 0x82, 0x8D, 0x09, 0x08,
+						0x00, 0x38, 0x00, 0x30, 0x30,
+						0xEB, 0x00, 0x30 };
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_111 =3D {
+	.pdu =3D setup_idle_mode_text_111,
+	.pdu_len =3D sizeof(setup_idle_mode_text_111),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_121 =3D {
+	.pdu =3D setup_idle_mode_text_121,
+	.pdu_len =3D sizeof(setup_idle_mode_text_121),
+	.qualifier =3D 0x00,
+	.text =3D "Toolkit Test"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_131 =3D {
+	.pdu =3D setup_idle_mode_text_131,
+	.pdu_len =3D sizeof(setup_idle_mode_text_131),
+	.qualifier =3D 0x00
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_171 =3D {
+	.pdu =3D setup_idle_mode_text_171,
+	.pdu_len =3D sizeof(setup_idle_mode_text_171),
+	.qualifier =3D 0x00,
+	.text =3D "The SIM shall supply a text string, which shall be displayed "
+		"by the ME as an idle mode text if the ME is able to do it."
+		"The presentation style is left as an implementation decision "
+		"to the ME manufacturer. The idle mode text shall be displayed "
+		"in a manner that ensures that ne"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_211 =3D {
+	.pdu =3D setup_idle_mode_text_211,
+	.pdu_len =3D sizeof(setup_idle_mode_text_211),
+	.qualifier =3D 0x00,
+	.text =3D "Idle text",
+	.icon_id =3D {
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
+		.id =3D 0x01
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_221 =3D {
+	.pdu =3D setup_idle_mode_text_221,
+	.pdu_len =3D sizeof(setup_idle_mode_text_221),
+	.qualifier =3D 0x00,
+	.text =3D "Idle text",
+	.icon_id =3D {
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
+		.id =3D 0x01
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_231 =3D {
+	.pdu =3D setup_idle_mode_text_231,
+	.pdu_len =3D sizeof(setup_idle_mode_text_231),
+	.qualifier =3D 0x00,
+	.text =3D "Idle text",
+	.icon_id =3D {
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
+		.id =3D 0x02
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_241 =3D {
+	.pdu =3D setup_idle_mode_text_241,
+	.pdu_len =3D sizeof(setup_idle_mode_text_241),
+	.qualifier =3D 0x00,
+	.icon_id =3D {
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
+		.id =3D 0x01
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_311 =3D {
+	.pdu =3D setup_idle_mode_text_311,
+	.pdu_len =3D sizeof(setup_idle_mode_text_311),
+	.qualifier =3D 0x00,
+	.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=95"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_411 =3D {
+	.pdu =3D setup_idle_mode_text_411,
+	.pdu_len =3D sizeof(setup_idle_mode_text_411),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_412 =3D {
+	.pdu =3D setup_idle_mode_text_412,
+	.pdu_len =3D sizeof(setup_idle_mode_text_412),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 2"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_421 =3D {
+	.pdu =3D setup_idle_mode_text_421,
+	.pdu_len =3D sizeof(setup_idle_mode_text_421),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x01, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_422 =3D {
+	.pdu =3D setup_idle_mode_text_422,
+	.pdu_len =3D sizeof(setup_idle_mode_text_422),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 2"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_431 =3D {
+	.pdu =3D setup_idle_mode_text_431,
+	.pdu_len =3D sizeof(setup_idle_mode_text_431),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x02, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_432 =3D {
+	.pdu =3D setup_idle_mode_text_432,
+	.pdu_len =3D sizeof(setup_idle_mode_text_432),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 2"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_441 =3D {
+	.pdu =3D setup_idle_mode_text_441,
+	.pdu_len =3D sizeof(setup_idle_mode_text_441),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x04, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_442 =3D {
+	.pdu =3D setup_idle_mode_text_442,
+	.pdu_len =3D sizeof(setup_idle_mode_text_442),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_443 =3D {
+	.pdu =3D setup_idle_mode_text_443,
+	.pdu_len =3D sizeof(setup_idle_mode_text_443),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 3"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_451 =3D {
+	.pdu =3D setup_idle_mode_text_451,
+	.pdu_len =3D sizeof(setup_idle_mode_text_451),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x08, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_452 =3D {
+	.pdu =3D setup_idle_mode_text_452,
+	.pdu_len =3D sizeof(setup_idle_mode_text_452),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_453 =3D {
+	.pdu =3D setup_idle_mode_text_453,
+	.pdu_len =3D sizeof(setup_idle_mode_text_453),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 3"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_461 =3D {
+	.pdu =3D setup_idle_mode_text_461,
+	.pdu_len =3D sizeof(setup_idle_mode_text_461),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x10, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_462 =3D {
+	.pdu =3D setup_idle_mode_text_462,
+	.pdu_len =3D sizeof(setup_idle_mode_text_462),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_463 =3D {
+	.pdu =3D setup_idle_mode_text_463,
+	.pdu_len =3D sizeof(setup_idle_mode_text_463),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 3"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_471 =3D {
+	.pdu =3D setup_idle_mode_text_471,
+	.pdu_len =3D sizeof(setup_idle_mode_text_471),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x20, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_472 =3D {
+	.pdu =3D setup_idle_mode_text_472,
+	.pdu_len =3D sizeof(setup_idle_mode_text_472),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_473 =3D {
+	.pdu =3D setup_idle_mode_text_473,
+	.pdu_len =3D sizeof(setup_idle_mode_text_473),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 3"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_481 =3D {
+	.pdu =3D setup_idle_mode_text_481,
+	.pdu_len =3D sizeof(setup_idle_mode_text_481),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x40, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_482 =3D {
+	.pdu =3D setup_idle_mode_text_482,
+	.pdu_len =3D sizeof(setup_idle_mode_text_482),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_483 =3D {
+	.pdu =3D setup_idle_mode_text_483,
+	.pdu_len =3D sizeof(setup_idle_mode_text_483),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 3"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_491 =3D {
+	.pdu =3D setup_idle_mode_text_491,
+	.pdu_len =3D sizeof(setup_idle_mode_text_491),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x80, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_492 =3D {
+	.pdu =3D setup_idle_mode_text_492,
+	.pdu_len =3D sizeof(setup_idle_mode_text_492),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_493 =3D {
+	.pdu =3D setup_idle_mode_text_493,
+	.pdu_len =3D sizeof(setup_idle_mode_text_493),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 3"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_4101 =3D=
 {
+	.pdu =3D setup_idle_mode_text_4101,
+	.pdu_len =3D sizeof(setup_idle_mode_text_4101),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
+	}
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_4102 =3D=
 {
+	.pdu =3D setup_idle_mode_text_4102,
+	.pdu_len =3D sizeof(setup_idle_mode_text_4102),
+	.qualifier =3D 0x00,
+	.text =3D "Idle Mode Text 2"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_511 =3D {
+	.pdu =3D setup_idle_mode_text_511,
+	.pdu_len =3D sizeof(setup_idle_mode_text_511),
+	.qualifier =3D 0x00,
+	.text =3D "=E4=BD=A0=E5=A5=BD"
+};
+
+static struct setup_idle_mode_text_test setup_idle_mode_text_data_611 =3D {
+	.pdu =3D setup_idle_mode_text_611,
+	.pdu_len =3D sizeof(setup_idle_mode_text_611),
+	.qualifier =3D 0x00,
+	.text =3D "80=E3=83=AB0"
+};
+
+static void test_setup_idle_mode_text(gconstpointer data)
+{
+	const struct setup_idle_mode_text_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	check_text(command->setup_idle_mode_text.text, test->text);
+	check_icon_id(&command->setup_idle_mode_text.icon_id, &test->icon_id);
+	check_text_attr(&command->setup_idle_mode_text.text_attr,
+							&test->text_attr);
+	check_frame_id(&command->setup_idle_mode_text.frame_id,
+							&test->frame_id);
+
+	stk_command_free(command);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -10758,5 +11476,80 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Timer Management 2.2.1",
 			&timer_mgmt_data_221, test_timer_mgmt);
 =

+	g_test_add_data_func("/teststk/Setup Idle Mode Text 1.1.1",
+		&setup_idle_mode_text_data_111, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 1.2.1",
+		&setup_idle_mode_text_data_121, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 1.3.1",
+		&setup_idle_mode_text_data_131, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 1.7.1",
+		&setup_idle_mode_text_data_171, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 2.1.1",
+		&setup_idle_mode_text_data_211, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 2.2.1",
+		&setup_idle_mode_text_data_221, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 2.3.1",
+		&setup_idle_mode_text_data_231, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 2.4.1",
+		&setup_idle_mode_text_data_241, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 3.1.1",
+		&setup_idle_mode_text_data_311, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.1.1",
+		&setup_idle_mode_text_data_411, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.1.2",
+		&setup_idle_mode_text_data_412, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.2.1",
+		&setup_idle_mode_text_data_421, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.2.2",
+		&setup_idle_mode_text_data_422, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.3.1",
+		&setup_idle_mode_text_data_431, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.3.2",
+		&setup_idle_mode_text_data_432, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.4.1",
+		&setup_idle_mode_text_data_441, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.4.2",
+		&setup_idle_mode_text_data_442, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.4.3",
+		&setup_idle_mode_text_data_443, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.5.1",
+		&setup_idle_mode_text_data_451, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.5.2",
+		&setup_idle_mode_text_data_452, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.5.3",
+		&setup_idle_mode_text_data_453, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.6.1",
+		&setup_idle_mode_text_data_461, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.6.2",
+		&setup_idle_mode_text_data_462, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.6.3",
+		&setup_idle_mode_text_data_463, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.7.1",
+		&setup_idle_mode_text_data_471, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.7.2",
+		&setup_idle_mode_text_data_472, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.7.3",
+		&setup_idle_mode_text_data_473, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.8.1",
+		&setup_idle_mode_text_data_481, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.8.2",
+		&setup_idle_mode_text_data_482, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.8.3",
+		&setup_idle_mode_text_data_483, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.9.1",
+		&setup_idle_mode_text_data_491, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.9.2",
+		&setup_idle_mode_text_data_492, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.9.3",
+		&setup_idle_mode_text_data_493, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.10.1",
+		&setup_idle_mode_text_data_4101, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 4.10.2",
+		&setup_idle_mode_text_data_4102, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 5.1.1",
+		&setup_idle_mode_text_data_511, test_setup_idle_mode_text);
+	g_test_add_data_func("/teststk/Setup Idle Mode Text 6.1.1",
+		&setup_idle_mode_text_data_611, test_setup_idle_mode_text);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============1143099706187622865==--

