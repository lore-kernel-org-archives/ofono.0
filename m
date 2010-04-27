Content-Type: multipart/mixed; boundary="===============3104338105486257550=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 3/7] test-stkutil: Refactor the implementation to test display
 text
Date: Tue, 27 Apr 2010 17:47:08 +0800
Message-ID: <1272361632-21352-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1272361632-21352-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3104338105486257550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  160 ++++++++++++++++++++++++++++++++++-------------=
---
 1 files changed, 109 insertions(+), 51 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 2bea19b..0961368 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -35,15 +35,72 @@
 #include "smsutil.h"
 #include "stkutil.h"
 =

+static gboolean g_mem_equal(const unsigned char *v1, const unsigned char *=
v2,
+				unsigned int len)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < len; i++)
+		if (v1[i] !=3D v2[i])
+			return FALSE;
+	return TRUE;
+}
+
+static inline void check_common_bool(const ofono_bool_t command,
+					const ofono_bool_t test)
+{
+	g_assert(command =3D=3D test);
+}
+
+/* Defined in TS 102.223 Section 8.8 */
+static void check_duration(const struct stk_duration *command,
+					const struct stk_duration *test)
+{
+	g_assert(command->unit =3D=3D test->unit);
+	g_assert(command->interval =3D=3D test->interval);
+}
+
+/* Defined in TS 102.223 Section 8.15 */
+static inline void check_text(const char *command, const char *test)
+{
+	g_assert(g_str_equal(command, test));
+}
+
+/* Defined in TS 102.223 Section 8.31 */
+static void check_icon_id(const struct stk_icon_id *command,
+					const struct stk_icon_id *test)
+{
+	g_assert(command->id =3D=3D test->id);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+}
+
+/* Defined in TS 102.223 Section 8.72 */
+static void check_text_attr(const struct stk_text_attribute *command,
+					const struct stk_text_attribute *test)
+{
+	g_assert(command->len =3D=3D test->len);
+	g_assert(g_mem_equal(command->attributes, test->attributes, test->len));
+}
+
+/* Defined in TS 102.223 Section 8.80 */
+static void check_frame_id(const struct stk_frame_id *command,
+					const struct stk_frame_id *test)
+{
+	g_assert(command->has_id =3D=3D test->has_id);
+	if (test->has_id)
+		g_assert(command->id =3D=3D test->id);
+}
+
 struct display_text_test {
 	const unsigned char *pdu;
 	unsigned int pdu_len;
-	const char *expected;
 	unsigned char qualifier;
-	unsigned char icon_qualifier;
-	unsigned char icon_id;
-	enum stk_duration_type duration_unit;
-	unsigned char duration_interval;
+	const char *text;
+	struct stk_icon_id icon_id;
+	ofono_bool_t immediate_response;
+	struct stk_duration duration;
+	struct stk_text_attribute text_attribute;
+	struct stk_frame_id frame_id;
 };
 =

 unsigned char display_text_111[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x01, 0x21,=
 0x80,
@@ -151,103 +208,111 @@ unsigned char display_text_1011[] =3D { 0xD0, 0x12,=
 0x81, 0x03, 0x01, 0x21, 0x80,
 static struct display_text_test display_text_data_111 =3D {
 	.pdu =3D display_text_111,
 	.pdu_len =3D sizeof(display_text_111),
-	.expected =3D "Toolkit Test 1",
-	.qualifier =3D 0x80
+	.qualifier =3D 0x80,
+	.text =3D "Toolkit Test 1"
 };
 =

 static struct display_text_test display_text_data_131 =3D {
 	.pdu =3D display_text_131,
 	.pdu_len =3D sizeof(display_text_131),
-	.expected =3D "Toolkit Test 2",
-	.qualifier =3D 0x81
+	.qualifier =3D 0x81,
+	.text =3D "Toolkit Test 2"
 };
 =

 static struct display_text_test display_text_data_141 =3D {
 	.pdu =3D display_text_141,
 	.pdu_len =3D sizeof(display_text_141),
-	.expected =3D "Toolkit Test 3",
-	.qualifier =3D 0x80
+	.qualifier =3D 0x80,
+	.text =3D "Toolkit Test 3"
 };
 =

 static struct display_text_test display_text_data_151 =3D {
 	.pdu =3D display_text_151,
 	.pdu_len =3D sizeof(display_text_151),
-	.expected =3D "Toolkit Test 4",
-	.qualifier =3D 0x00
+	.qualifier =3D 0x00,
+	.text =3D "Toolkit Test 4"
 };
 =

 static struct display_text_test display_text_data_161 =3D {
 	.pdu =3D display_text_161,
 	.pdu_len =3D sizeof(display_text_161),
-	.expected =3D "This command instructs the ME to display a text message. "
+	.qualifier =3D 0x80,
+	.text =3D "This command instructs the ME to display a text message. "
 			"It allows the SIM to define the priority of that "
 			"message, and the text string format. Two types of "
-			"prio",
-	.qualifier =3D 0x80
+			"prio"
 };
 =

 static struct display_text_test display_text_data_171 =3D {
 	.pdu =3D display_text_171,
 	.pdu_len =3D sizeof(display_text_171),
-	.expected =3D "<GO-BACKWARDS>",
-	.qualifier =3D 0x80
+	.qualifier =3D 0x80,
+	.text =3D "<GO-BACKWARDS>"
 };
 =

 static struct display_text_test display_text_data_511 =3D {
 	.pdu =3D display_text_511,
 	.pdu_len =3D sizeof(display_text_511),
-	.expected =3D "Basic Icon",
 	.qualifier =3D 0x80,
-	.icon_id =3D 0x01,
-	.icon_qualifier =3D 0x00,
+	.text =3D "Basic Icon",
+	.icon_id =3D {
+		.qualifier =3D 0x00,
+		.id =3D 0x01
+	}
 };
 =

 static struct display_text_test display_text_data_521 =3D {
 	.pdu =3D display_text_521,
 	.pdu_len =3D sizeof(display_text_521),
-	.expected =3D "Colour Icon",
 	.qualifier =3D 0x80,
-	.icon_id =3D 0x02,
-	.icon_qualifier =3D 0x00,
+	.text =3D "Colour Icon",
+	.icon_id =3D {
+		.qualifier =3D 0x00,
+		.id =3D 0x02
+	}
 };
 =

 static struct display_text_test display_text_data_531 =3D {
 	.pdu =3D display_text_531,
 	.pdu_len =3D sizeof(display_text_531),
-	.expected =3D "Basic Icon",
 	.qualifier =3D 0x80,
-	.icon_id =3D 0x01,
-	.icon_qualifier =3D 0x01,
+	.text =3D "Basic Icon",
+	.icon_id =3D {
+		.qualifier =3D 0x01,
+		.id =3D 0x01
+	}
 };
 =

 static struct display_text_test display_text_data_611 =3D {
 	.pdu =3D display_text_611,
 	.pdu_len =3D sizeof(display_text_611),
-	.expected =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
-	.qualifier =3D 0x80
+	.qualifier =3D 0x80,
+	.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=95"
 };
 =

 static struct display_text_test display_text_data_711 =3D {
 	.pdu =3D display_text_711,
 	.pdu_len =3D sizeof(display_text_711),
-	.expected =3D "10 Second",
 	.qualifier =3D 0x80,
-	.duration_unit =3D STK_DURATION_TYPE_SECONDS,
-	.duration_interval =3D 10,
+	.text =3D "10 Second",
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 10,
+	}
 };
 =

 static struct display_text_test display_text_data_911 =3D {
 	.pdu =3D display_text_911,
 	.pdu_len =3D sizeof(display_text_911),
-	.expected =3D "=E4=BD=A0=E5=A5=BD",
-	.qualifier =3D 0x80
+	.qualifier =3D 0x80,
+	.text =3D "=E4=BD=A0=E5=A5=BD"
 };
 =

 static struct display_text_test display_text_data_1011 =3D {
 	.pdu =3D display_text_1011,
 	.pdu_len =3D sizeof(display_text_1011),
-	.expected =3D "80=E3=83=AB",
-	.qualifier =3D 0x80
+	.qualifier =3D 0x80,
+	.text =3D "80=E3=83=AB"
 };
 =

 /* Defined in TS 102.384 Section 27.22.4.1 */
@@ -268,21 +333,14 @@ static void test_display_text(gconstpointer data)
 	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_DISPLAY);
 =

 	g_assert(command->display_text.text);
-
-	g_assert(g_str_equal(test->expected, command->display_text.text));
-
-	if (test->icon_id > 0) {
-		g_assert(command->display_text.icon_id.id =3D=3D test->icon_id);
-		g_assert(command->display_text.icon_id.qualifier =3D=3D
-				test->icon_qualifier);
-	}
-
-	if (test->duration_interval > 0) {
-		g_assert(command->display_text.duration.unit =3D=3D
-				test->duration_unit);
-		g_assert(command->display_text.duration.interval =3D=3D
-				test->duration_interval);
-	}
+	check_text(command->display_text.text, test->text);
+	check_icon_id(&command->display_text.icon_id, &test->icon_id);
+	check_common_bool(command->display_text.immediate_response,
+						test->immediate_response);
+	check_duration(&command->display_text.duration, &test->duration);
+	check_text_attr(&command->display_text.text_attribute,
+						&test->text_attribute);
+	check_frame_id(&command->display_text.frame_id, &test->frame_id);
 =

 	stk_command_free(command);
 }
-- =

1.7.0.4


--===============3104338105486257550==--

