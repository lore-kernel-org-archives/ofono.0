Content-Type: multipart/mixed; boundary="===============5094528118706877466=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 7/8] teststk: Add test for launch browser parser
Date: Wed, 26 May 2010 22:39:13 +0800
Message-ID: <1274884754-12977-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274884754-12977-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5094528118706877466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  790 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 790 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 77e05c4..2637ec0 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -397,6 +397,49 @@ static inline void check_language(const char *command,=
 const char *test)
 	check_common_text(command, test);
 }
 =

+/* Defined in TS 102.223 Section 8.47 */
+static inline void check_browser_id(const unsigned char command,
+					const unsigned char test)
+{
+	check_common_byte(command, test);
+}
+
+/* Defined in TS 102.223 Section 8.48 */
+static inline void check_url(const char *command, const char *test)
+{
+	check_common_text(command, test);
+}
+
+/* Defined in TS 102.223 Section 8.49 */
+static inline void check_bearer(const struct stk_common_byte_array *comman=
d,
+				const struct stk_common_byte_array *test)
+{
+	check_common_byte_array(command, test);
+}
+
+/* Defined in TS 102.223 Section 8.50 */
+static void check_provisioning_file_reference(const struct stk_file *comma=
nd,
+					const struct stk_file *test)
+{
+	g_assert(command->len =3D=3D test->len);
+	g_assert(g_mem_equal(command->file, test->file, test->len));
+}
+
+static void check_provisioning_file_references(GSList *command,
+						const struct stk_file *test)
+{
+	struct stk_file *sf;
+	GSList *l;
+	unsigned int i =3D 0;
+
+	for (l =3D command; l; l =3D l->next) {
+		sf =3D l->data;
+		check_provisioning_file_reference(sf, &test[i++]);
+	}
+
+	g_assert(test[i].len =3D=3D 0);
+}
+
 /* Defined in TS 102.223 Section 8.60 */
 static inline void check_aid(const struct stk_aid *command,
 					const struct stk_aid *test)
@@ -13835,6 +13878,676 @@ static void test_language_notification(gconstpoin=
ter data)
 	stk_command_free(command);
 }
 =

+struct launch_browser_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	unsigned char browser_id;
+	char *url;
+	struct stk_common_byte_array bearer;
+	struct stk_file prov_file_refs[MAX_ITEM];
+	char *text_gateway_proxy_id;
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+	struct stk_common_byte_array network_name;
+	char *text_usr;
+	char *text_passwd;
+};
+
+static unsigned char launch_browser_111[] =3D { 0xD0, 0x18, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0B,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C };
+
+static unsigned char launch_browser_121[] =3D { 0xD0, 0x1F, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x12, 0x68, 0x74,
+						0x74, 0x70, 0x3A, 0x2F, 0x2F,
+						0x78, 0x78, 0x78, 0x2E, 0x79,
+						0x79, 0x79, 0x2E, 0x7A, 0x7A,
+						0x7A, 0x05, 0x00 };
+
+static unsigned char launch_browser_131[] =3D { 0xD0, 0x0E, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x30, 0x01, 0x00, 0x31,
+						0x00 };
+
+static unsigned char launch_browser_141[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x32, 0x01,
+						0x03, 0x0D, 0x10, 0x04, 0x61,
+						0x62, 0x63, 0x2E, 0x64, 0x65,
+						0x66, 0x2E, 0x67, 0x68, 0x69,
+						0x2E, 0x6A, 0x6B, 0x6C };
+
+static unsigned char launch_browser_211[] =3D { 0xD0, 0x18, 0x81, 0x03, 0x=
01,
+						0x15, 0x02, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0B,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C };
+
+static unsigned char launch_browser_221[] =3D { 0xD0, 0x18, 0x81, 0x03, 0x=
01,
+						0x15, 0x03, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0B,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C };
+
+static unsigned char launch_browser_231[] =3D { 0xD0, 0x0B, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00 };
+
+static unsigned char launch_browser_311[] =3D { 0xD0, 0x26, 0x81, 0x03, 0x=
01,
+						0x15, 0x02, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x19,
+						0x80, 0x04, 0x17, 0x04, 0x14,
+						0x04, 0x20, 0x04, 0x10, 0x04,
+						0x12, 0x04, 0x21, 0x04, 0x22,
+						0x04, 0x12, 0x04, 0x23, 0x04,
+						0x19, 0x04, 0x22, 0x04, 0x15 };
+
+static unsigned char launch_browser_411[] =3D { 0xD0, 0x21, 0x81, 0x03, 0x=
01,
+						0x15, 0x02, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x10,
+						0x4E, 0x6F, 0x74, 0x20, 0x73,
+						0x65, 0x6C, 0x66, 0x20, 0x65,
+						0x78, 0x70, 0x6C, 0x61, 0x6E,
+						0x2E, 0x1E, 0x02, 0x01, 0x01 };
+
+static unsigned char launch_browser_421[] =3D { 0xD0, 0x1D, 0x81, 0x03, 0x=
01,
+						0x15, 0x02, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0C,
+						0x53, 0x65, 0x6C, 0x66, 0x20,
+						0x65, 0x78, 0x70, 0x6C, 0x61,
+						0x6E, 0x2E, 0x1E, 0x02, 0x00,
+						0x01 };
+
+static unsigned char launch_browser_511[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x31, 0xD0, 0x04,
+						0x00, 0x0D, 0x00, 0xB4 };
+
+static unsigned char launch_browser_512[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x32 };
+
+static unsigned char launch_browser_521[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x31, 0xD0, 0x04,
+						0x00, 0x0D, 0x01, 0xB4 };
+
+static unsigned char launch_browser_522[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x32 };
+
+static unsigned char launch_browser_531[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x31, 0xD0, 0x04,
+						0x00, 0x0D, 0x02, 0xB4 };
+
+static unsigned char launch_browser_532[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x32 };
+
+static unsigned char launch_browser_541[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x31, 0xD0, 0x04,
+						0x00, 0x0D, 0x04, 0xB4 };
+
+static unsigned char launch_browser_542[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x32, 0xD0, 0x04,
+						0x00, 0x0D, 0x00, 0xB4 };
+
+static unsigned char launch_browser_543[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x33 };
+
+static unsigned char launch_browser_551[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x31, 0xD0, 0x04,
+						0x00, 0x0D, 0x08, 0xB4 };
+
+static unsigned char launch_browser_552[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x32, 0xD0, 0x04,
+						0x00, 0x0D, 0x00, 0xB4 };
+
+static unsigned char launch_browser_553[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x33 };
+
+static unsigned char launch_browser_561[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x31, 0xD0, 0x04,
+						0x00, 0x0D, 0x10, 0xB4 };
+
+static unsigned char launch_browser_562[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x32, 0xD0, 0x04,
+						0x00, 0x0D, 0x00, 0xB4 };
+
+static unsigned char launch_browser_563[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x33 };
+
+static unsigned char launch_browser_571[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x31, 0xD0, 0x04,
+						0x00, 0x0D, 0x20, 0xB4 };
+
+static unsigned char launch_browser_572[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x32, 0xD0, 0x04,
+						0x00, 0x0D, 0x00, 0xB4 };
+
+static unsigned char launch_browser_573[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x33 };
+
+static unsigned char launch_browser_581[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x31, 0xD0, 0x04,
+						0x00, 0x0D, 0x40, 0xB4 };
+
+static unsigned char launch_browser_582[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x32, 0xD0, 0x04,
+						0x00, 0x0D, 0x00, 0xB4 };
+
+static unsigned char launch_browser_583[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x33 };
+
+static unsigned char launch_browser_591[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x31, 0xD0, 0x04,
+						0x00, 0x0D, 0x80, 0xB4 };
+
+static unsigned char launch_browser_592[] =3D { 0xD0, 0x20, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x32, 0xD0, 0x04,
+						0x00, 0x0D, 0x00, 0xB4 };
+
+static unsigned char launch_browser_593[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x=
01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x33 };
+
+static unsigned char launch_browser_5101[] =3D { 0xD0, 0x20, 0x81, 0x03, 0=
x01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x31, 0xD0, 0x04,
+						0x00, 0x0D, 0x00, 0xB4 };
+
+static unsigned char launch_browser_5102[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0=
x01,
+						0x15, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x0D,
+						0x44, 0x65, 0x66, 0x61, 0x75,
+						0x6C, 0x74, 0x20, 0x55, 0x52,
+						0x4C, 0x20, 0x32 };
+
+static unsigned char launch_browser_611[] =3D { 0xD0, 0x12, 0x81, 0x03, 0x=
01,
+						0x15, 0x02, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x05,
+						0x80, 0x4F, 0x60, 0x59, 0x7D };
+
+static unsigned char launch_browser_711[] =3D { 0xD0, 0x10, 0x81, 0x03, 0x=
01,
+						0x15, 0x02, 0x82, 0x02, 0x81,
+						0x82, 0x31, 0x00, 0x05, 0x03,
+						0x80, 0x30, 0xEB };
+
+static struct launch_browser_test launch_browser_data_111 =3D {
+	.pdu =3D launch_browser_111,
+	.pdu_len =3D sizeof(launch_browser_111),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL"
+};
+
+static struct launch_browser_test launch_browser_data_121 =3D {
+	.pdu =3D launch_browser_121,
+	.pdu_len =3D sizeof(launch_browser_121),
+	.qualifier =3D 0x00,
+	.url =3D "http://xxx.yyy.zzz"
+};
+
+static struct launch_browser_test launch_browser_data_131 =3D {
+	.pdu =3D launch_browser_131,
+	.pdu_len =3D sizeof(launch_browser_131),
+	.qualifier =3D 0x00
+};
+
+static struct launch_browser_test launch_browser_data_141 =3D {
+	.pdu =3D launch_browser_141,
+	.pdu_len =3D sizeof(launch_browser_141),
+	.qualifier =3D 0x00,
+	.bearer =3D {
+		.len =3D 1,
+		.array =3D (unsigned char *) "\x03"
+	},
+	.text_gateway_proxy_id =3D "abc.def.ghi.jkl"
+};
+
+static struct launch_browser_test launch_browser_data_211 =3D {
+	.pdu =3D launch_browser_211,
+	.pdu_len =3D sizeof(launch_browser_211),
+	.qualifier =3D 0x02,
+	.alpha_id =3D "Default URL"
+};
+
+static struct launch_browser_test launch_browser_data_221 =3D {
+	.pdu =3D launch_browser_221,
+	.pdu_len =3D sizeof(launch_browser_221),
+	.qualifier =3D 0x03,
+	.alpha_id =3D "Default URL"
+};
+
+static struct launch_browser_test launch_browser_data_231 =3D {
+	.pdu =3D launch_browser_231,
+	.pdu_len =3D sizeof(launch_browser_231),
+	.qualifier =3D 0x00
+};
+
+static struct launch_browser_test launch_browser_data_311 =3D {
+	.pdu =3D launch_browser_311,
+	.pdu_len =3D sizeof(launch_browser_311),
+	.qualifier =3D 0x02,
+	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95"
+};
+
+static struct launch_browser_test launch_browser_data_411 =3D {
+	.pdu =3D launch_browser_411,
+	.pdu_len =3D sizeof(launch_browser_411),
+	.qualifier =3D 0x02,
+	.alpha_id =3D "Not self explan.",
+	.icon_id =3D {
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
+		.id =3D 0x01
+	}
+};
+
+static struct launch_browser_test launch_browser_data_421 =3D {
+	.pdu =3D launch_browser_421,
+	.pdu_len =3D sizeof(launch_browser_421),
+	.qualifier =3D 0x02,
+	.alpha_id =3D "Self explan.",
+	.icon_id =3D {
+		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
+		.id =3D 0x01
+	}
+};
+
+static struct launch_browser_test launch_browser_data_511 =3D {
+	.pdu =3D launch_browser_511,
+	.pdu_len =3D sizeof(launch_browser_511),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x00, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_512 =3D {
+	.pdu =3D launch_browser_512,
+	.pdu_len =3D sizeof(launch_browser_512),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 2"
+};
+
+static struct launch_browser_test launch_browser_data_521 =3D {
+	.pdu =3D launch_browser_521,
+	.pdu_len =3D sizeof(launch_browser_521),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x01, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_522 =3D {
+	.pdu =3D launch_browser_522,
+	.pdu_len =3D sizeof(launch_browser_522),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 2"
+};
+
+static struct launch_browser_test launch_browser_data_531 =3D {
+	.pdu =3D launch_browser_531,
+	.pdu_len =3D sizeof(launch_browser_531),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x02, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_532 =3D {
+	.pdu =3D launch_browser_532,
+	.pdu_len =3D sizeof(launch_browser_532),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 2"
+};
+
+static struct launch_browser_test launch_browser_data_541 =3D {
+	.pdu =3D launch_browser_541,
+	.pdu_len =3D sizeof(launch_browser_541),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x04, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_542 =3D {
+	.pdu =3D launch_browser_542,
+	.pdu_len =3D sizeof(launch_browser_542),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x00, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_543 =3D {
+	.pdu =3D launch_browser_543,
+	.pdu_len =3D sizeof(launch_browser_543),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 3"
+};
+
+static struct launch_browser_test launch_browser_data_551 =3D {
+	.pdu =3D launch_browser_551,
+	.pdu_len =3D sizeof(launch_browser_551),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x08, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_552 =3D {
+	.pdu =3D launch_browser_552,
+	.pdu_len =3D sizeof(launch_browser_552),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x00, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_553 =3D {
+	.pdu =3D launch_browser_553,
+	.pdu_len =3D sizeof(launch_browser_553),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 3"
+};
+
+static struct launch_browser_test launch_browser_data_561 =3D {
+	.pdu =3D launch_browser_561,
+	.pdu_len =3D sizeof(launch_browser_561),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x10, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_562 =3D {
+	.pdu =3D launch_browser_562,
+	.pdu_len =3D sizeof(launch_browser_562),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x00, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_563 =3D {
+	.pdu =3D launch_browser_563,
+	.pdu_len =3D sizeof(launch_browser_563),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 3"
+};
+
+static struct launch_browser_test launch_browser_data_571 =3D {
+	.pdu =3D launch_browser_571,
+	.pdu_len =3D sizeof(launch_browser_571),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x20, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_572 =3D {
+	.pdu =3D launch_browser_572,
+	.pdu_len =3D sizeof(launch_browser_572),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x00, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_573 =3D {
+	.pdu =3D launch_browser_573,
+	.pdu_len =3D sizeof(launch_browser_573),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 3"
+};
+
+static struct launch_browser_test launch_browser_data_581 =3D {
+	.pdu =3D launch_browser_581,
+	.pdu_len =3D sizeof(launch_browser_581),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x40, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_582 =3D {
+	.pdu =3D launch_browser_582,
+	.pdu_len =3D sizeof(launch_browser_582),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x00, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_583 =3D {
+	.pdu =3D launch_browser_583,
+	.pdu_len =3D sizeof(launch_browser_583),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 3"
+};
+
+static struct launch_browser_test launch_browser_data_591 =3D {
+	.pdu =3D launch_browser_591,
+	.pdu_len =3D sizeof(launch_browser_591),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x80, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_592 =3D {
+	.pdu =3D launch_browser_592,
+	.pdu_len =3D sizeof(launch_browser_592),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 2",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x00, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_593 =3D {
+	.pdu =3D launch_browser_593,
+	.pdu_len =3D sizeof(launch_browser_593),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 3"
+};
+
+static struct launch_browser_test launch_browser_data_5101 =3D {
+	.pdu =3D launch_browser_5101,
+	.pdu_len =3D sizeof(launch_browser_5101),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0D, 0x00, 0xB4 }
+	}
+};
+
+static struct launch_browser_test launch_browser_data_5102 =3D {
+	.pdu =3D launch_browser_5102,
+	.pdu_len =3D sizeof(launch_browser_5102),
+	.qualifier =3D 0x00,
+	.alpha_id =3D "Default URL 2"
+};
+
+static struct launch_browser_test launch_browser_data_611 =3D {
+	.pdu =3D launch_browser_611,
+	.pdu_len =3D sizeof(launch_browser_611),
+	.qualifier =3D 0x02,
+	.alpha_id =3D "=E4=BD=A0=E5=A5=BD"
+};
+
+static struct launch_browser_test launch_browser_data_711 =3D {
+	.pdu =3D launch_browser_711,
+	.pdu_len =3D sizeof(launch_browser_711),
+	.qualifier =3D 0x02,
+	.alpha_id =3D "=E3=83=AB"
+};
+
+static void test_launch_browser(gconstpointer data)
+{
+	const struct launch_browser_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_LAUNCH_BROWSER);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	check_browser_id(command->launch_browser.browser_id, test->browser_id);
+	check_url(command->launch_browser.url, test->url);
+	check_bearer(&command->launch_browser.bearer, &test->bearer);
+	check_provisioning_file_references(
+		command->launch_browser.prov_file_refs,	test->prov_file_refs);
+	check_text(command->launch_browser.text_gateway_proxy_id,
+						test->text_gateway_proxy_id);
+	check_alpha_id(command->launch_browser.alpha_id, test->alpha_id);
+	check_icon_id(&command->launch_browser.icon_id, &test->icon_id);
+	check_text_attr(&command->launch_browser.text_attr, &test->text_attr);
+	check_frame_id(&command->launch_browser.frame_id, &test->frame_id);
+	check_text(command->launch_browser.text_usr, test->text_usr);
+	check_text(command->launch_browser.text_passwd, test->text_passwd);
+
+	stk_command_free(command);
+}
+
 struct terminal_response_test {
 	const unsigned char *pdu;
 	unsigned int pdu_len;
@@ -17246,5 +17959,82 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Language Notification 1.2.1",
 		&language_notification_data_121, test_language_notification);
 =

+	g_test_add_data_func("/teststk/Launch Browser 1.1.1",
+			     &launch_browser_data_111, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 1.2.1",
+			     &launch_browser_data_121, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 1.3.1",
+			     &launch_browser_data_131, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 1.4.1",
+			     &launch_browser_data_141, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 2.1.1",
+			     &launch_browser_data_211, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 2.2.1",
+			     &launch_browser_data_221, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 2.3.1",
+			     &launch_browser_data_231, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 3.1.1",
+			     &launch_browser_data_311, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 4.1.1",
+			     &launch_browser_data_411, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 4.2.1",
+			     &launch_browser_data_421, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.1.1",
+			     &launch_browser_data_511, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.1.2",
+			     &launch_browser_data_512, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.2.1",
+			     &launch_browser_data_521, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.2.2",
+			     &launch_browser_data_522, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.3.1",
+			     &launch_browser_data_531, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.3.2",
+			     &launch_browser_data_532, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.4.1",
+			     &launch_browser_data_541, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.4.2",
+			     &launch_browser_data_542, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.4.3",
+			     &launch_browser_data_543, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.5.1",
+			     &launch_browser_data_551, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.5.2",
+			     &launch_browser_data_552, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.5.3",
+			     &launch_browser_data_553, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.6.1",
+			     &launch_browser_data_561, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.6.2",
+			     &launch_browser_data_562, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.6.3",
+			     &launch_browser_data_563, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.7.1",
+			     &launch_browser_data_571, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.7.2",
+			     &launch_browser_data_572, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.7.3",
+			     &launch_browser_data_573, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.8.1",
+			     &launch_browser_data_581, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.8.2",
+			     &launch_browser_data_582, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.8.3",
+			     &launch_browser_data_583, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.9.1",
+			     &launch_browser_data_591, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.9.2",
+			     &launch_browser_data_592, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.9.3",
+			     &launch_browser_data_593, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.10.1",
+			     &launch_browser_data_5101, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 5.10.2",
+			     &launch_browser_data_5102, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 6.1.1",
+			     &launch_browser_data_611, test_launch_browser);
+	g_test_add_data_func("/teststk/Launch Browser 7.1.1",
+			     &launch_browser_data_711, test_launch_browser);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============5094528118706877466==--

