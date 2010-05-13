Content-Type: multipart/mixed; boundary="===============1021531113415036405=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 27/27] test-stk: Add test for timer management parser
Date: Thu, 13 May 2010 18:48:44 +0800
Message-ID: <1273747724-28019-27-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1021531113415036405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  609 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 609 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 5a6d2a4..8642680 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -266,6 +266,22 @@ static void check_c_apdu(const struct stk_c_apdu *comm=
and,
 		g_assert(command->le =3D=3D test->le);
 }
 =

+/* Defined in TS 102.223 Section 8.37 */
+static inline void check_timer_id(const unsigned char command,
+					const unsigned char test)
+{
+	check_common_byte(command, test);
+}
+
+/* Defined in TS 102.223 Section 8.38 */
+static inline void check_timer_value(const struct stk_timer_value *command,
+					const struct stk_timer_value *test)
+{
+	g_assert(command->hour =3D=3D test->hour);
+	g_assert(command->minute =3D=3D test->minute);
+	g_assert(command->second =3D=3D test->second);
+}
+
 /* Defined in TS 102.223 Section 8.43 */
 static inline void check_imm_resp(const unsigned char command,
 					const unsigned char test)
@@ -9463,6 +9479,522 @@ static void test_get_reader_status(gconstpointer da=
ta)
 	stk_command_free(command);
 }
 =

+struct timer_mgmt_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	unsigned char timer_id;
+	struct stk_timer_value timer_value;
+};
+
+static unsigned char timer_mgmt_111[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x01, 0xA5, 0x03,
+						0x00, 0x50, 0x00 };
+
+static unsigned char timer_mgmt_112[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x01 };
+
+static unsigned char timer_mgmt_113[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x01, 0xA5, 0x03,
+						0x00, 0x10, 0x03 };
+
+static unsigned char timer_mgmt_114[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x01 };
+
+static unsigned char timer_mgmt_121[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x02, 0xA5, 0x03,
+						0x32, 0x95, 0x95 };
+
+static unsigned char timer_mgmt_122[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x02 };
+
+static unsigned char timer_mgmt_123[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x02, 0xA5, 0x03,
+						0x00, 0x10, 0x01 };
+
+static unsigned char timer_mgmt_124[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x02 };
+
+static unsigned char timer_mgmt_131[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x08, 0xA5, 0x03,
+						0x00, 0x02, 0x00 };
+
+static unsigned char timer_mgmt_132[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x08 };
+
+static unsigned char timer_mgmt_133[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x08, 0xA5, 0x03,
+						0x10, 0x00, 0x00 };
+
+static unsigned char timer_mgmt_134[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x08 };
+
+static unsigned char timer_mgmt_141[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x01 };
+
+static unsigned char timer_mgmt_142[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x02 };
+
+static unsigned char timer_mgmt_143[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x03 };
+
+static unsigned char timer_mgmt_144[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x04 };
+
+static unsigned char timer_mgmt_145[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x05 };
+
+static unsigned char timer_mgmt_146[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x06 };
+
+static unsigned char timer_mgmt_147[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x07 };
+
+static unsigned char timer_mgmt_148[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x02, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x08 };
+
+static unsigned char timer_mgmt_151[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x01 };
+
+static unsigned char timer_mgmt_152[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x02 };
+
+static unsigned char timer_mgmt_153[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x03 };
+
+static unsigned char timer_mgmt_154[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x04 };
+
+static unsigned char timer_mgmt_155[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x05 };
+
+static unsigned char timer_mgmt_156[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x06 };
+
+static unsigned char timer_mgmt_157[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x07 };
+
+static unsigned char timer_mgmt_158[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01, =
0x27,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x08 };
+
+static unsigned char timer_mgmt_161[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x01, 0xA5, 0x03,
+						0x00, 0x00, 0x50 };
+
+static unsigned char timer_mgmt_162[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x02, 0xA5, 0x03,
+						0x00, 0x00, 0x50 };
+
+static unsigned char timer_mgmt_163[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x03, 0xA5, 0x03,
+						0x00, 0x00, 0x50 };
+
+static unsigned char timer_mgmt_164[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x04, 0xA5, 0x03,
+						0x00, 0x00, 0x50 };
+
+static unsigned char timer_mgmt_165[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x05, 0xA5, 0x03,
+						0x00, 0x00, 0x50 };
+
+static unsigned char timer_mgmt_166[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x06, 0xA5, 0x03,
+						0x00, 0x00, 0x50 };
+
+static unsigned char timer_mgmt_167[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x07, 0xA5, 0x03,
+						0x00, 0x00, 0x50 };
+
+static unsigned char timer_mgmt_168[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x08, 0xA5, 0x03,
+						0x00, 0x00, 0x50 };
+
+static unsigned char timer_mgmt_211[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x01, 0xA5, 0x03,
+						0x00, 0x00, 0x01 };
+
+static unsigned char timer_mgmt_221[] =3D { 0xD0, 0x11, 0x81, 0x03, 0x01, =
0x27,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0xA4, 0x01, 0x01, 0xA5, 0x03,
+						0x00, 0x00, 0x03 };
+
+static struct timer_mgmt_test timer_mgmt_data_111 =3D {
+	.pdu =3D timer_mgmt_111,
+	.pdu_len =3D sizeof(timer_mgmt_111),
+	.qualifier =3D 0x00,
+	.timer_id =3D 1,
+	.timer_value =3D {
+		.minute =3D 5
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_112 =3D {
+	.pdu =3D timer_mgmt_112,
+	.pdu_len =3D sizeof(timer_mgmt_112),
+	.qualifier =3D 0x02,
+	.timer_id =3D 1
+};
+
+static struct timer_mgmt_test timer_mgmt_data_113 =3D {
+	.pdu =3D timer_mgmt_113,
+	.pdu_len =3D sizeof(timer_mgmt_113),
+	.qualifier =3D 0x00,
+	.timer_id =3D 1,
+	.timer_value =3D {
+		.minute =3D 1,
+		.second =3D 30
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_114 =3D {
+	.pdu =3D timer_mgmt_114,
+	.pdu_len =3D sizeof(timer_mgmt_114),
+	.qualifier =3D 0x01,
+	.timer_id =3D 1
+};
+
+static struct timer_mgmt_test timer_mgmt_data_121 =3D {
+	.pdu =3D timer_mgmt_121,
+	.pdu_len =3D sizeof(timer_mgmt_121),
+	.qualifier =3D 0x00,
+	.timer_id =3D 2,
+	.timer_value =3D {
+		.hour =3D 23,
+		.minute =3D 59,
+		.second =3D 59
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_122 =3D {
+	.pdu =3D timer_mgmt_122,
+	.pdu_len =3D sizeof(timer_mgmt_122),
+	.qualifier =3D 0x02,
+	.timer_id =3D 2
+};
+
+static struct timer_mgmt_test timer_mgmt_data_123 =3D {
+	.pdu =3D timer_mgmt_123,
+	.pdu_len =3D sizeof(timer_mgmt_123),
+	.qualifier =3D 0x00,
+	.timer_id =3D 2,
+	.timer_value =3D {
+		.minute =3D 1,
+		.second =3D 10
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_124 =3D {
+	.pdu =3D timer_mgmt_124,
+	.pdu_len =3D sizeof(timer_mgmt_124),
+	.qualifier =3D 0x01,
+	.timer_id =3D 2
+};
+
+static struct timer_mgmt_test timer_mgmt_data_131 =3D {
+	.pdu =3D timer_mgmt_131,
+	.pdu_len =3D sizeof(timer_mgmt_131),
+	.qualifier =3D 0x00,
+	.timer_id =3D 8,
+	.timer_value =3D {
+		.minute =3D 20
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_132 =3D {
+	.pdu =3D timer_mgmt_132,
+	.pdu_len =3D sizeof(timer_mgmt_132),
+	.qualifier =3D 0x02,
+	.timer_id =3D 8
+};
+
+static struct timer_mgmt_test timer_mgmt_data_133 =3D {
+	.pdu =3D timer_mgmt_133,
+	.pdu_len =3D sizeof(timer_mgmt_133),
+	.qualifier =3D 0x00,
+	.timer_id =3D 8,
+	.timer_value =3D {
+		.hour =3D 1
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_134 =3D {
+	.pdu =3D timer_mgmt_134,
+	.pdu_len =3D sizeof(timer_mgmt_134),
+	.qualifier =3D 0x01,
+	.timer_id =3D 8
+};
+
+static struct timer_mgmt_test timer_mgmt_data_141 =3D {
+	.pdu =3D timer_mgmt_141,
+	.pdu_len =3D sizeof(timer_mgmt_141),
+	.qualifier =3D 0x02,
+	.timer_id =3D 1
+};
+
+static struct timer_mgmt_test timer_mgmt_data_142 =3D {
+	.pdu =3D timer_mgmt_142,
+	.pdu_len =3D sizeof(timer_mgmt_142),
+	.qualifier =3D 0x02,
+	.timer_id =3D 2
+};
+
+static struct timer_mgmt_test timer_mgmt_data_143 =3D {
+	.pdu =3D timer_mgmt_143,
+	.pdu_len =3D sizeof(timer_mgmt_143),
+	.qualifier =3D 0x02,
+	.timer_id =3D 3
+};
+
+static struct timer_mgmt_test timer_mgmt_data_144 =3D {
+	.pdu =3D timer_mgmt_144,
+	.pdu_len =3D sizeof(timer_mgmt_144),
+	.qualifier =3D 0x02,
+	.timer_id =3D 4
+};
+
+static struct timer_mgmt_test timer_mgmt_data_145 =3D {
+	.pdu =3D timer_mgmt_145,
+	.pdu_len =3D sizeof(timer_mgmt_145),
+	.qualifier =3D 0x02,
+	.timer_id =3D 5
+};
+
+static struct timer_mgmt_test timer_mgmt_data_146 =3D {
+	.pdu =3D timer_mgmt_146,
+	.pdu_len =3D sizeof(timer_mgmt_146),
+	.qualifier =3D 0x02,
+	.timer_id =3D 6
+};
+
+static struct timer_mgmt_test timer_mgmt_data_147 =3D {
+	.pdu =3D timer_mgmt_147,
+	.pdu_len =3D sizeof(timer_mgmt_147),
+	.qualifier =3D 0x02,
+	.timer_id =3D 7
+};
+
+static struct timer_mgmt_test timer_mgmt_data_148 =3D {
+	.pdu =3D timer_mgmt_148,
+	.pdu_len =3D sizeof(timer_mgmt_148),
+	.qualifier =3D 0x02,
+	.timer_id =3D 8
+};
+
+static struct timer_mgmt_test timer_mgmt_data_151 =3D {
+	.pdu =3D timer_mgmt_151,
+	.pdu_len =3D sizeof(timer_mgmt_151),
+	.qualifier =3D 0x01,
+	.timer_id =3D 1
+};
+
+static struct timer_mgmt_test timer_mgmt_data_152 =3D {
+	.pdu =3D timer_mgmt_152,
+	.pdu_len =3D sizeof(timer_mgmt_152),
+	.qualifier =3D 0x01,
+	.timer_id =3D 2
+};
+
+static struct timer_mgmt_test timer_mgmt_data_153 =3D {
+	.pdu =3D timer_mgmt_153,
+	.pdu_len =3D sizeof(timer_mgmt_153),
+	.qualifier =3D 0x01,
+	.timer_id =3D 3
+};
+
+static struct timer_mgmt_test timer_mgmt_data_154 =3D {
+	.pdu =3D timer_mgmt_154,
+	.pdu_len =3D sizeof(timer_mgmt_154),
+	.qualifier =3D 0x01,
+	.timer_id =3D 4
+};
+
+static struct timer_mgmt_test timer_mgmt_data_155 =3D {
+	.pdu =3D timer_mgmt_155,
+	.pdu_len =3D sizeof(timer_mgmt_155),
+	.qualifier =3D 0x01,
+	.timer_id =3D 5
+};
+
+static struct timer_mgmt_test timer_mgmt_data_156 =3D {
+	.pdu =3D timer_mgmt_156,
+	.pdu_len =3D sizeof(timer_mgmt_156),
+	.qualifier =3D 0x01,
+	.timer_id =3D 6
+};
+
+static struct timer_mgmt_test timer_mgmt_data_157 =3D {
+	.pdu =3D timer_mgmt_157,
+	.pdu_len =3D sizeof(timer_mgmt_157),
+	.qualifier =3D 0x01,
+	.timer_id =3D 7
+};
+
+static struct timer_mgmt_test timer_mgmt_data_158 =3D {
+	.pdu =3D timer_mgmt_158,
+	.pdu_len =3D sizeof(timer_mgmt_158),
+	.qualifier =3D 0x01,
+	.timer_id =3D 8
+};
+
+static struct timer_mgmt_test timer_mgmt_data_161 =3D {
+	.pdu =3D timer_mgmt_161,
+	.pdu_len =3D sizeof(timer_mgmt_161),
+	.qualifier =3D 0x00,
+	.timer_id =3D 1,
+	.timer_value =3D {
+		.second =3D 5
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_162 =3D {
+	.pdu =3D timer_mgmt_162,
+	.pdu_len =3D sizeof(timer_mgmt_162),
+	.qualifier =3D 0x00,
+	.timer_id =3D 2,
+	.timer_value =3D {
+		.second =3D 5
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_163 =3D {
+	.pdu =3D timer_mgmt_163,
+	.pdu_len =3D sizeof(timer_mgmt_163),
+	.qualifier =3D 0x00,
+	.timer_id =3D 3,
+	.timer_value =3D {
+		.second =3D 5
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_164 =3D {
+	.pdu =3D timer_mgmt_164,
+	.pdu_len =3D sizeof(timer_mgmt_164),
+	.qualifier =3D 0x00,
+	.timer_id =3D 4,
+	.timer_value =3D {
+		.second =3D 5
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_165 =3D {
+	.pdu =3D timer_mgmt_165,
+	.pdu_len =3D sizeof(timer_mgmt_165),
+	.qualifier =3D 0x00,
+	.timer_id =3D 5,
+	.timer_value =3D {
+		.second =3D 5
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_166 =3D {
+	.pdu =3D timer_mgmt_166,
+	.pdu_len =3D sizeof(timer_mgmt_166),
+	.qualifier =3D 0x00,
+	.timer_id =3D 6,
+	.timer_value =3D {
+		.second =3D 5
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_167 =3D {
+	.pdu =3D timer_mgmt_167,
+	.pdu_len =3D sizeof(timer_mgmt_167),
+	.qualifier =3D 0x00,
+	.timer_id =3D 7,
+	.timer_value =3D {
+		.second =3D 5
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_168 =3D {
+	.pdu =3D timer_mgmt_168,
+	.pdu_len =3D sizeof(timer_mgmt_168),
+	.qualifier =3D 0x00,
+	.timer_id =3D 8,
+	.timer_value =3D {
+		.second =3D 5
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_211 =3D {
+	.pdu =3D timer_mgmt_211,
+	.pdu_len =3D sizeof(timer_mgmt_211),
+	.qualifier =3D 0x00,
+	.timer_id =3D 1,
+	.timer_value =3D {
+		.second =3D 10
+	}
+};
+
+static struct timer_mgmt_test timer_mgmt_data_221 =3D {
+	.pdu =3D timer_mgmt_221,
+	.pdu_len =3D sizeof(timer_mgmt_221),
+	.qualifier =3D 0x00,
+	.timer_id =3D 1,
+	.timer_value =3D {
+		.second =3D 30
+	}
+};
+
+static void test_timer_mgmt(gconstpointer data)
+{
+	const struct timer_mgmt_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_TIMER_MANAGEMENT);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	check_timer_id(command->timer_mgmt.timer_id, test->timer_id);
+	check_timer_value(&command->timer_mgmt.timer_value, &test->timer_value);
+
+	stk_command_free(command);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -10145,5 +10677,82 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Get Reader Status 1.1.1",
 			&get_reader_status_data_111, test_get_reader_status);
 =

+	g_test_add_data_func("/teststk/Timer Management 1.1.1",
+			&timer_mgmt_data_111, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.1.2",
+			&timer_mgmt_data_112, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.1.3",
+			&timer_mgmt_data_113, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.1.4",
+			&timer_mgmt_data_114, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.2.1",
+			&timer_mgmt_data_121, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.2.2",
+			&timer_mgmt_data_122, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.2.3",
+			&timer_mgmt_data_123, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.2.4",
+			&timer_mgmt_data_124, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.3.1",
+			&timer_mgmt_data_131, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.3.2",
+			&timer_mgmt_data_132, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.3.3",
+			&timer_mgmt_data_133, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.3.4",
+			&timer_mgmt_data_134, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.4.1",
+			&timer_mgmt_data_141, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.4.2",
+			&timer_mgmt_data_142, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.4.3",
+			&timer_mgmt_data_143, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.4.4",
+			&timer_mgmt_data_144, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.4.5",
+			&timer_mgmt_data_145, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.4.6",
+			&timer_mgmt_data_146, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.4.7",
+			&timer_mgmt_data_147, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.4.8",
+			&timer_mgmt_data_148, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.5.1",
+			&timer_mgmt_data_151, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.5.2",
+			&timer_mgmt_data_152, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.5.3",
+			&timer_mgmt_data_153, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.5.4",
+			&timer_mgmt_data_154, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.5.5",
+			&timer_mgmt_data_155, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.5.6",
+			&timer_mgmt_data_156, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.5.7",
+			&timer_mgmt_data_157, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.5.8",
+			&timer_mgmt_data_158, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.6.1",
+			&timer_mgmt_data_161, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.6.2",
+			&timer_mgmt_data_162, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.6.3",
+			&timer_mgmt_data_163, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.6.4",
+			&timer_mgmt_data_164, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.6.5",
+			&timer_mgmt_data_165, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.6.6",
+			&timer_mgmt_data_166, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.6.7",
+			&timer_mgmt_data_167, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 1.6.8",
+			&timer_mgmt_data_168, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 2.1.1",
+			&timer_mgmt_data_211, test_timer_mgmt);
+	g_test_add_data_func("/teststk/Timer Management 2.2.1",
+			&timer_mgmt_data_221, test_timer_mgmt);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============1021531113415036405==--

