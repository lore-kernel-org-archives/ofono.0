Content-Type: multipart/mixed; boundary="===============6949014065244975775=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 2/2] test-stkutil: Add unit tests for BIP commands
Date: Wed, 30 Mar 2011 23:41:27 +0200
Message-ID: <1301521287-12212-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6949014065244975775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c | 1170 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 1153 insertions(+), 17 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index aa62aac..1706f1d 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -470,6 +470,59 @@ static void check_provisioning_file_references(GSList =
*command,
 	g_assert(test[i].len =3D=3D 0);
 }
 =

+/* Defined in TS 102.223 Section 8.52 */
+static void check_bearer_desc(const struct stk_bearer_description *command,
+				const struct stk_bearer_description *test)
+{
+	g_assert(command->type =3D=3D test->type);
+
+	if (test->type =3D=3D STK_BEARER_TYPE_GPRS_UTRAN) {
+
+		check_common_byte(command->gprs.precedence,
+				test->gprs.precedence);
+		check_common_byte(command->gprs.delay,
+				test->gprs.delay);
+		check_common_byte(command->gprs.reliability,
+				test->gprs.reliability);
+		check_common_byte(command->gprs.peak,
+				test->gprs.peak);
+		check_common_byte(command->gprs.mean,
+				test->gprs.mean);
+		check_common_byte(command->gprs.pdp_type,
+				test->gprs.pdp_type);
+		return;
+	}
+}
+
+/* Defined in TS 102.223 Section 8.53 */
+static inline void check_channel_data(
+				const struct stk_common_byte_array *command,
+				const struct stk_common_byte_array *test)
+{
+	check_common_byte_array(command, test);
+}
+
+/* Defined in TS 102.223 Section 8.58 */
+static inline void check_other_address(
+				const struct stk_other_address *command,
+				const struct stk_other_address *test)
+{
+	check_common_byte(command->type, test->type);
+
+	if (test->type =3D=3D STK_ADDRESS_IPV4)
+		g_assert(command->addr.ipv4 =3D=3D test->addr.ipv4);
+	else
+		g_assert(g_mem_equal(command->addr.ipv6, test->addr.ipv6, 16));
+}
+
+/* Defined in TS 102.223 Section 8.59 */
+static void check_uicc_te_interface(const struct stk_uicc_te_interface *co=
mmand,
+				const struct stk_uicc_te_interface *test)
+{
+	check_common_byte(command->protocol, test->protocol);
+	g_assert(command->port =3D=3D test->port);
+}
+
 /* Defined in TS 102.223 Section 8.60 */
 static inline void check_aid(const struct stk_aid *command,
 					const struct stk_aid *test)
@@ -477,6 +530,13 @@ static inline void check_aid(const struct stk_aid *com=
mand,
 	g_assert(g_mem_equal(command->aid, test->aid, test->len));
 }
 =

+/* Defined in TS 102.223 Section 8.70 */
+static inline void check_network_access_name(const char *command,
+						const char *test)
+{
+	check_common_text(command, test);
+}
+
 /* Defined in TS 102.223 Section 8.71 */
 static inline void check_cdma_sms_tpdu(
 				const struct stk_common_byte_array *command,
@@ -16913,6 +16973,639 @@ static void test_launch_browser(gconstpointer dat=
a)
 	stk_command_free(command);
 }
 =

+struct open_channel_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_bearer_description bearer_desc;
+	unsigned short buf_size;
+	char *apn;
+	struct stk_other_address local_addr;
+	char *text_usr;
+	char *text_passwd;
+	struct stk_uicc_te_interface uti;
+	struct stk_other_address data_dest_addr;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+static unsigned char open_channel_211[] =3D { 0xD0, 0x36, 0x81, 0x03, 0x01=
, 0x40,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0x35, 0x07, 0x02, 0x03, 0x04,
+						0x03, 0x04, 0x1F, 0x02, 0x39,
+						0x02, 0x05, 0x78, 0x0D, 0x08,
+						0xF4, 0x55, 0x73, 0x65, 0x72,
+						0x4C, 0x6F, 0x67, 0x0D, 0x08,
+						0xF4, 0x55, 0x73, 0x65, 0x72,
+						0x50, 0x77, 0x64, 0x3C, 0x03,
+						0x01, 0xAD, 0x9C, 0x3E, 0x05,
+						0x21, 0x01, 0x01, 0x01, 0x01 };
+
+static unsigned char open_channel_221[] =3D { 0xD0, 0x42, 0x81, 0x03, 0x01=
, 0x40,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0x35, 0x07, 0x02, 0x03, 0x04,
+						0x03, 0x04, 0x1F, 0x02, 0x39,
+						0x02, 0x05, 0x78, 0x47, 0x0A,
+						0x06, 0x54, 0x65, 0x73, 0x74,
+						0x47, 0x70, 0x02, 0x72, 0x73,
+						0x0D, 0x08, 0xF4, 0x55, 0x73,
+						0x65, 0x72, 0x4C, 0x6F, 0x67,
+						0x0D, 0x08, 0xF4, 0x55, 0x73,
+						0x65, 0x72, 0x50, 0x77, 0x64,
+						0x3C, 0x03, 0x01, 0xAD, 0x9C,
+						0x3E, 0x05, 0x21, 0x01, 0x01,
+						0x01, 0x01 };
+
+static unsigned char open_channel_231[] =3D { 0xD0, 0x4B, 0x81, 0x03, 0x01=
, 0x40,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0x05, 0x07, 0x4F, 0x70, 0x65,
+						0x6E, 0x20, 0x49, 0x44, 0x35,
+						0x07, 0x02, 0x03, 0x04, 0x03,
+						0x04, 0x1F, 0x02, 0x39, 0x02,
+						0x05, 0x78, 0x47, 0x0A, 0x06,
+						0x54, 0x65, 0x73, 0x74, 0x47,
+						0x70, 0x02, 0x72, 0x73, 0x0D,
+						0x08, 0xF4, 0x55, 0x73, 0x65,
+						0x72, 0x4C, 0x6F, 0x67, 0x0D,
+						0x08, 0xF4, 0x55, 0x73, 0x65,
+						0x72, 0x50, 0x77, 0x64, 0x3C,
+						0x03, 0x01, 0xAD, 0x9C, 0x3E,
+						0x05, 0x21, 0x01, 0x01, 0x01,
+						0x01 };
+
+static unsigned char open_channel_241[] =3D { 0xD0, 0x44, 0x81, 0x03, 0x01=
, 0x40,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0x05, 0x00, 0x35, 0x07, 0x02,
+						0x03, 0x04, 0x03, 0x04, 0x1F,
+						0x02, 0x39, 0x02, 0x05, 0x78,
+						0x47, 0x0A, 0x06, 0x54, 0x65,
+						0x73, 0x74, 0x47, 0x70, 0x02,
+						0x72, 0x73, 0x0D, 0x08, 0xF4,
+						0x55, 0x73, 0x65, 0x72, 0x4C,
+						0x6F, 0x67, 0x0D, 0x08, 0xF4,
+						0x55, 0x73, 0x65, 0x72, 0x50,
+						0x77, 0x64, 0x3C, 0x03, 0x01,
+						0xAD, 0x9C, 0x3E, 0x05, 0x21,
+						0x01, 0x01, 0x01, 0x01 };
+
+static unsigned char open_channel_511[] =3D { 0xD0, 0x53, 0x81, 0x03, 0x01=
, 0x40,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0x05, 0x09, 0x4F, 0x70, 0x65,
+						0x6E, 0x20, 0x49, 0x44, 0x20,
+						0x31, 0x35, 0x07, 0x02, 0x03,
+						0x04, 0x03, 0x04, 0x1F, 0x02,
+						0x39, 0x02, 0x05, 0x78, 0x47,
+						0x0A, 0x06, 0x54, 0x65, 0x73,
+						0x74, 0x47, 0x70, 0x02, 0x72,
+						0x73, 0x0D, 0x08, 0xF4, 0x55,
+						0x73, 0x65, 0x72, 0x4C, 0x6F,
+						0x67, 0x0D, 0x08, 0xF4, 0x55,
+						0x73, 0x65, 0x72, 0x50, 0x77,
+						0x64, 0x3C, 0x03, 0x01, 0xAD,
+						0x9C, 0x3E, 0x05, 0x21, 0x01,
+						0x01, 0x01, 0x01, 0xD0, 0x04,
+						0x00, 0x09, 0x00, 0xB4 };
+
+static struct open_channel_test open_channel_data_211 =3D {
+	/*
+	 * OPEN CHANNEL, immediate link establishment, GPRS, no local address
+	 * no alpha identifier, no network access name
+	 */
+	.pdu =3D open_channel_211,
+	.pdu_len =3D sizeof(open_channel_211),
+	.qualifier =3D STK_OPEN_CHANNEL_IMMEDIATE,
+	.bearer_desc =3D {
+			.type =3D STK_BEARER_TYPE_GPRS_UTRAN,
+			.gprs =3D {
+				.precedence =3D 3,
+				.delay =3D 4,
+				.reliability =3D 3,
+				.peak =3D 4,
+				.mean =3D 31,
+				.pdp_type =3D 2,
+			},
+	},
+	.buf_size =3D 1400,
+	.text_usr =3D "UserLog",
+	.text_passwd =3D "UserPwd",
+	.uti =3D {
+		.protocol =3D STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE,
+		.port =3D 44444,
+	},
+	.data_dest_addr =3D {
+			.type =3D STK_ADDRESS_IPV4,
+			.addr =3D {
+				.ipv4 =3D 0x01010101,
+			},
+	},
+};
+
+static struct open_channel_test open_channel_data_221 =3D {
+	/*
+	 * OPEN CHANNEL, immediate link establishment GPRS,
+	 * no alpha identifier, with network access name
+	 */
+	.pdu =3D open_channel_221,
+	.pdu_len =3D sizeof(open_channel_221),
+	.qualifier =3D STK_OPEN_CHANNEL_IMMEDIATE,
+	.bearer_desc =3D {
+			.type =3D STK_BEARER_TYPE_GPRS_UTRAN,
+			.gprs =3D {
+				.precedence =3D 3,
+				.delay =3D 4,
+				.reliability =3D 3,
+				.peak =3D 4,
+				.mean =3D 31,
+				.pdp_type =3D 2,
+			},
+	},
+	.buf_size =3D 1400,
+	.apn =3D "TestGp.rs",
+	.text_usr =3D "UserLog",
+	.text_passwd =3D "UserPwd",
+	.uti =3D {
+		.protocol =3D STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE,
+		.port =3D 44444,
+	},
+	.data_dest_addr =3D {
+			.type =3D STK_ADDRESS_IPV4,
+			.addr =3D {
+				.ipv4 =3D 0x01010101,
+			},
+	},
+};
+
+static struct open_channel_test open_channel_data_231 =3D {
+	/*
+	 * OPEN CHANNEL, immediate link establishment, GPRS
+	 * with alpha identifier
+	 */
+	.pdu =3D open_channel_231,
+	.pdu_len =3D sizeof(open_channel_231),
+	.qualifier =3D STK_OPEN_CHANNEL_IMMEDIATE,
+	.alpha_id =3D "Open ID",
+	.bearer_desc =3D {
+			.type =3D STK_BEARER_TYPE_GPRS_UTRAN,
+			.gprs =3D {
+				.precedence =3D 3,
+				.delay =3D 4,
+				.reliability =3D 3,
+				.peak =3D 4,
+				.mean =3D 31,
+				.pdp_type =3D 2,
+			},
+	},
+	.buf_size =3D 1400,
+	.apn =3D "TestGp.rs",
+	.text_usr =3D "UserLog",
+	.text_passwd =3D "UserPwd",
+	.uti =3D {
+		.protocol =3D STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE,
+		.port =3D 44444,
+	},
+	.data_dest_addr =3D {
+			.type =3D STK_ADDRESS_IPV4,
+			.addr =3D {
+				.ipv4 =3D 0x01010101,
+			},
+	},
+};
+
+static struct open_channel_test open_channel_data_241 =3D {
+	/*
+	 * OPEN CHANNEL, immediate link establishment, GPRS,
+	 * with null alpha identifier
+	 */
+	.pdu =3D open_channel_241,
+	.pdu_len =3D sizeof(open_channel_241),
+	.qualifier =3D STK_OPEN_CHANNEL_IMMEDIATE,
+	.alpha_id =3D "",
+	.bearer_desc =3D {
+			.type =3D STK_BEARER_TYPE_GPRS_UTRAN,
+			.gprs =3D {
+				.precedence =3D 3,
+				.delay =3D 4,
+				.reliability =3D 3,
+				.peak =3D 4,
+				.mean =3D 31,
+				.pdp_type =3D 2,
+			},
+	},
+	.buf_size =3D 1400,
+	.apn =3D "TestGp.rs",
+	.text_usr =3D "UserLog",
+	.text_passwd =3D "UserPwd",
+	.uti =3D {
+		.protocol =3D STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE,
+		.port =3D 44444,
+	},
+	.data_dest_addr =3D {
+			.type =3D STK_ADDRESS_IPV4,
+			.addr =3D {
+				.ipv4 =3D 0x01010101,
+			},
+	},
+};
+
+static struct open_channel_test open_channel_data_511 =3D {
+	/*
+	 * OPEN CHANNEL, immediate link establishment, GPRS
+	 * Text Attribute =E2=80=93 Left Alignment
+	 */
+	.pdu =3D open_channel_511,
+	.pdu_len =3D sizeof(open_channel_511),
+	.qualifier =3D STK_OPEN_CHANNEL_IMMEDIATE,
+	.alpha_id =3D "Open ID 1",
+	.bearer_desc =3D {
+			.type =3D STK_BEARER_TYPE_GPRS_UTRAN,
+			.gprs =3D {
+				.precedence =3D 3,
+				.delay =3D 4,
+				.reliability =3D 3,
+				.peak =3D 4,
+				.mean =3D 31,
+				.pdp_type =3D 2,
+			},
+	},
+	.buf_size =3D 1400,
+	.apn =3D "TestGp.rs",
+	.text_usr =3D "UserLog",
+	.text_passwd =3D "UserPwd",
+	.uti =3D {
+		.protocol =3D STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE,
+		.port =3D 44444,
+	},
+	.data_dest_addr =3D {
+			.type =3D STK_ADDRESS_IPV4,
+			.addr =3D {
+				.ipv4 =3D 0x01010101,
+			},
+	},
+	.text_attr =3D {
+			.len =3D 4,
+			.attributes =3D { 0x00, 0x09, 0x00, 0xB4 }
+	},
+};
+
+static void test_open_channel(gconstpointer data)
+{
+	const struct open_channel_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_OPEN_CHANNEL);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	check_alpha_id(command->open_channel.alpha_id, test->alpha_id);
+	check_icon_id(&command->open_channel.icon_id, &test->icon_id);
+	check_bearer_desc(&command->open_channel.bearer_desc,
+					&test->bearer_desc);
+	g_assert(command->open_channel.buf_size =3D=3D test->buf_size);
+	check_network_access_name(command->open_channel.apn, test->apn);
+	check_other_address(&command->open_channel.local_addr,
+					&test->local_addr);
+	check_text(command->open_channel.text_usr, test->text_usr);
+	check_text(command->open_channel.text_passwd, test->text_passwd);
+	check_uicc_te_interface(&command->open_channel.uti, &test->uti);
+	check_other_address(&command->open_channel.data_dest_addr,
+					&test->data_dest_addr);
+	check_text_attr(&command->open_channel.text_attr, &test->text_attr);
+	check_frame_id(&command->open_channel.frame_id, &test->frame_id);
+
+	stk_command_free(command);
+}
+
+struct close_channel_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	enum stk_device_identity_type dst;
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+static unsigned char close_channel_111[] =3D { 0xD0, 0x09, 0x81, 0x03, 0x0=
1, 0x41,
+						0x00, 0x82, 0x02, 0x81, 0x21 };
+
+static struct close_channel_test close_channel_data_111 =3D {
+	.pdu =3D close_channel_111,
+	.pdu_len =3D sizeof(close_channel_111),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CHANNEL_1,
+};
+
+static unsigned char close_channel_211[] =3D { 0xD0, 0x1B, 0x81, 0x03, 0x0=
1, 0x41,
+						0x00, 0x82, 0x02, 0x81, 0x21,
+						0x85, 0x0A, 0x43, 0x6C, 0x6F,
+						0x73, 0x65, 0x20, 0x49, 0x44,
+						0x20, 0x31, 0xD0, 0x04, 0x00,
+						0x0A, 0x00, 0xB4,
+ };
+
+static struct close_channel_test close_channel_data_211 =3D {
+	.pdu =3D close_channel_211,
+	.pdu_len =3D sizeof(close_channel_211),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CHANNEL_1,
+	.alpha_id =3D "Close ID 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0A, 0x00, 0xB4 }
+	},
+};
+
+static void test_close_channel(gconstpointer data)
+{
+	const struct close_channel_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_CLOSE_CHANNEL);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D test->dst);
+
+	check_alpha_id(command->close_channel.alpha_id, test->alpha_id);
+	check_icon_id(&command->close_channel.icon_id, &test->icon_id);
+	check_text_attr(&command->close_channel.text_attr, &test->text_attr);
+	check_frame_id(&command->close_channel.frame_id, &test->frame_id);
+
+	stk_command_free(command);
+}
+
+struct receive_data_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	enum stk_device_identity_type dst;
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	unsigned char data_len;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+static unsigned char receive_data_111[] =3D { 0xD0, 0x0C, 0x81, 0x03, 0x01=
, 0x42,
+						0x00, 0x82, 0x02, 0x81, 0x21,
+						0xB7, 0x01, 0xC8 };
+
+static struct receive_data_test receive_data_data_111 =3D {
+	.pdu =3D receive_data_111,
+	.pdu_len =3D sizeof(receive_data_111),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CHANNEL_1,
+	.data_len =3D 200,
+};
+
+static unsigned char receive_data_211[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01=
, 0x42,
+						0x00, 0x82, 0x02, 0x81, 0x21,
+						0x85, 0x0E, 0x52, 0x65, 0x63,
+						0x65, 0x69, 0x76, 0x65, 0x20,
+						0x44, 0x61, 0x74, 0x61, 0x20,
+						0x31, 0xB7, 0x01, 0xC8, 0xD0,
+						0x04, 0x00, 0x0E, 0x00, 0xB4 };
+
+static struct receive_data_test receive_data_data_211 =3D {
+	.pdu =3D receive_data_211,
+	.pdu_len =3D sizeof(receive_data_211),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CHANNEL_1,
+	.data_len =3D 200,
+	.alpha_id =3D "Receive Data 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0E, 0x00, 0xB4 }
+	},
+};
+
+
+static void test_receive_data(gconstpointer data)
+{
+	const struct receive_data_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_RECEIVE_DATA);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D test->dst);
+
+	check_alpha_id(command->receive_data.alpha_id, test->alpha_id);
+	check_icon_id(&command->receive_data.icon_id, &test->icon_id);
+	check_common_byte(command->receive_data.data_len, test->data_len);
+	check_text_attr(&command->receive_data.text_attr, &test->text_attr);
+	check_frame_id(&command->receive_data.frame_id, &test->frame_id);
+
+	stk_command_free(command);
+}
+
+struct send_data_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	enum stk_device_identity_type dst;
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_common_byte_array data;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+static unsigned char send_data_111[] =3D { 0xD0, 0x13, 0x81, 0x03, 0x01, 0=
x43,
+						0x01, 0x82, 0x02, 0x81, 0x21,
+						0xB6, 0x08, 0x00, 0x01, 0x02,
+						0x03, 0x04, 0x05, 0x06, 0x07 };
+
+static struct send_data_test send_data_data_111 =3D {
+	.pdu =3D send_data_111,
+	.pdu_len =3D sizeof(send_data_111),
+	.qualifier =3D STK_SEND_DATA_IMMEDIATELY,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CHANNEL_1,
+	.data =3D {
+		.array =3D (unsigned char[8]) {
+				0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
+		},
+		.len =3D 8,
+	},
+};
+
+static unsigned char send_data_121[] =3D {
+				0xD0, 0x81, 0xD4, 0x81, 0x03, 0x01, 0x43, 0x00,
+				0x82, 0x02, 0x81, 0x21, 0xB6, 0x81, 0xC8, 0x00,
+				0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+				0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+				0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+				0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20,
+				0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
+				0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,
+				0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+				0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40,
+				0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,
+				0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50,
+				0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
+				0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60,
+				0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
+				0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70,
+				0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
+				0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, 0x80,
+				0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88,
+				0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x90,
+				0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98,
+				0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f, 0xa0,
+				0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8,
+				0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0xb0,
+				0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8,
+				0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf, 0xc0,
+				0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7 };
+
+static struct send_data_test send_data_data_121 =3D {
+	.pdu =3D send_data_121,
+	.pdu_len =3D sizeof(send_data_121),
+	.qualifier =3D STK_SEND_DATA_STORE_DATA,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CHANNEL_1,
+	.data =3D {
+		.array =3D (unsigned char[200]) {
+				0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+				0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+				0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+				0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
+				0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+				0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
+				0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+				0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
+				0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
+				0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
+				0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
+				0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
+				0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
+				0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
+				0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77,
+				0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,
+				0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
+				0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
+				0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
+				0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
+				0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
+				0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
+				0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
+				0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
+				0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
+		},
+		.len =3D 200,
+	},
+};
+static unsigned char send_data_211[] =3D {
+				0xD0, 0x26, 0x81, 0x03, 0x01, 0x43, 0x01, 0x82,
+				0x02, 0x81, 0x21, 0x85, 0x0B, 0x53, 0x65, 0x6E,
+				0x64, 0x20, 0x44, 0x61, 0x74, 0x61, 0x20, 0x31,
+				0xB6, 0x08, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05,
+				0x06, 0x07, 0xD0, 0x04, 0x00, 0x0B, 0x00, 0xB4,
+ };
+
+static struct send_data_test send_data_data_211 =3D {
+	.pdu =3D send_data_211,
+	.pdu_len =3D sizeof(send_data_211),
+	.qualifier =3D STK_SEND_DATA_IMMEDIATELY,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CHANNEL_1,
+	.alpha_id =3D "Send Data 1",
+	.data =3D {
+		.array =3D (unsigned char[8]) {
+				0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
+		},
+		.len =3D 8,
+	},
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
+	},
+};
+
+static void test_send_data(gconstpointer data)
+{
+	const struct send_data_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SEND_DATA);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D test->dst);
+
+	check_alpha_id(command->send_data.alpha_id, test->alpha_id);
+	check_icon_id(&command->send_data.icon_id, &test->icon_id);
+	check_channel_data(&command->send_data.data, &test->data);
+	check_text_attr(&command->send_data.text_attr, &test->text_attr);
+	check_frame_id(&command->send_data.frame_id, &test->frame_id);
+
+	stk_command_free(command);
+}
+
+struct get_channel_status_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+};
+
+static unsigned char get_channel_status_111[] =3D { 0xD0, 0x09, 0x81, 0x03=
, 0x01,
+							0x44, 0x00, 0x82, 0x02,
+							0x81, 0x82 };
+
+static struct get_channel_status_test get_channel_status_data_111 =3D {
+	.pdu =3D get_channel_status_111,
+	.pdu_len =3D sizeof(get_channel_status_111),
+	.qualifier =3D 0x00,
+};
+
+static void test_get_channel_status(gconstpointer data)
+{
+	const struct get_channel_status_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_GET_CHANNEL_STATUS);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	stk_command_free(command);
+}
+
 struct terminal_response_test {
 	const unsigned char *pdu;
 	unsigned int pdu_len;
@@ -20884,6 +21577,366 @@ static const struct terminal_response_test launch=
_browser_response_data_411b =3D {
 	},
 };
 =

+static const unsigned char open_channel_response_211[] =3D {
+		0x81, 0x03, 0x01, 0x40, 0x01, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x01, 0x00, 0x38, 0x02, 0x81, 0x00, 0x35, 0x07, 0x02, 0x03,
+		0x04, 0x03, 0x04, 0x1F, 0x02, 0x39, 0x02, 0x05, 0x78,
+};
+
+static const struct terminal_response_test open_channel_response_data_211 =
=3D {
+	.pdu =3D open_channel_response_211,
+	.pdu_len =3D sizeof(open_channel_response_211),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_OPEN_CHANNEL,
+		.qualifier =3D STK_OPEN_CHANNEL_IMMEDIATE,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .open_channel =3D {
+			.channel =3D {
+			.id =3D 1,
+			.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED,
+			},
+			.bearer_desc =3D {
+					.type =3D STK_BEARER_TYPE_GPRS_UTRAN,
+					.gprs =3D {
+						.precedence =3D 3,
+						.delay =3D 4,
+						.reliability =3D 3,
+						.peak =3D 4,
+						.mean =3D 31,
+						.pdp_type =3D 2,
+					},
+			},
+			.buf_size =3D 1400,
+		} },
+	},
+};
+
+static const unsigned char open_channel_response_271[] =3D {
+		0x81, 0x03, 0x01, 0x40, 0x01, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x01, 0x22, 0x35, 0x07, 0x02, 0x03, 0x04, 0x03, 0x04, 0x1F,
+		0x02, 0x39, 0x02, 0x05, 0x78,
+};
+
+static const struct terminal_response_test open_channel_response_data_271 =
=3D {
+	.pdu =3D open_channel_response_271,
+	.pdu_len =3D sizeof(open_channel_response_271),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_OPEN_CHANNEL,
+		.qualifier =3D STK_OPEN_CHANNEL_IMMEDIATE,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_USER_REJECT,
+		},
+		{ .open_channel =3D {
+			.bearer_desc =3D {
+					.type =3D STK_BEARER_TYPE_GPRS_UTRAN,
+					.gprs =3D {
+						.precedence =3D 3,
+						.delay =3D 4,
+						.reliability =3D 3,
+						.peak =3D 4,
+						.mean =3D 31,
+						.pdp_type =3D 2,
+					},
+			},
+			.buf_size =3D 1400,
+		} },
+	},
+};
+
+static const unsigned char close_channel_response_121[] =3D {
+		0x81, 0x03, 0x01, 0x41, 0x00, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x02, 0x3A, 0x03,
+};
+
+static const struct terminal_response_test close_channel_response_data_121=
 =3D {
+	.pdu =3D close_channel_response_121,
+	.pdu_len =3D sizeof(close_channel_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_CLOSE_CHANNEL,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_BIP_ERROR,
+			.additional_len =3D 1, /* Channel identifier not valid */
+			.additional =3D (unsigned char[1]) { 0x03 },
+		},
+	},
+};
+
+static const unsigned char close_channel_response_131[] =3D {
+		0x81, 0x03, 0x01, 0x41, 0x00, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x02, 0x3A, 0x02,
+};
+
+static const struct terminal_response_test close_channel_response_data_131=
 =3D {
+	.pdu =3D close_channel_response_131,
+	.pdu_len =3D sizeof(close_channel_response_131),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_CLOSE_CHANNEL,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_BIP_ERROR,
+			.additional_len =3D 1, /* Channel already closed */
+			.additional =3D (unsigned char[1]) { 0x02 },
+		},
+	},
+};
+
+static const unsigned char receive_data_response_111[] =3D {
+		0x81, 0x03, 0x01, 0x42, 0x00, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x01, 0x00, 0xB6, 0x81, 0xC8, 0xc8, 0xc9, 0xca, 0xcb, 0xcc,
+		0xcd, 0xce, 0xcf, 0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6,
+		0xd7, 0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf, 0xe0,
+		0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xea,
+		0xeb, 0xec, 0xed, 0xee, 0xef, 0xf0, 0xf1, 0xf2, 0xf3, 0xf4,
+		0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe,
+		0xff, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+		0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12,
+		0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c,
+		0x1d, 0x1e, 0x1f, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26,
+		0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,
+		0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a,
+		0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40, 0x41, 0x42, 0x43, 0x44,
+		0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e,
+		0x4f, 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
+		0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x61, 0x62,
+		0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c,
+		0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76,
+		0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, 0x80,
+		0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a,
+		0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0xB7, 0x01, 0xFF,
+};
+
+static const struct terminal_response_test receive_data_response_data_111 =
=3D {
+	.pdu =3D receive_data_response_111,
+	.pdu_len =3D sizeof(receive_data_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_RECEIVE_DATA,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .receive_data =3D {
+				.rx_data =3D {
+					.array =3D (unsigned char[200]) {
+					0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd,
+					0xce, 0xcf, 0xd0, 0xd1, 0xd2, 0xd3,
+					0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9,
+					0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
+					0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5,
+					0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xeb,
+					0xec, 0xed, 0xee, 0xef, 0xf0, 0xf1,
+					0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
+					0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd,
+					0xfe, 0xff, 0x00, 0x01, 0x02, 0x03,
+					0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
+					0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+					0x10, 0x11, 0x12, 0x13, 0x14, 0x15,
+					0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b,
+					0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x21,
+					0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+					0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
+					0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33,
+					0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
+					0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
+					0x40, 0x41, 0x42, 0x43, 0x44, 0x45,
+					0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b,
+					0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51,
+					0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
+					0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d,
+					0x5e, 0x5f, 0x60, 0x61, 0x62, 0x63,
+					0x64, 0x65, 0x66, 0x67, 0x68, 0x69,
+					0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
+					0x70, 0x71, 0x72, 0x73, 0x74, 0x75,
+					0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b,
+					0x7c, 0x7d, 0x7e, 0x7f, 0x80, 0x81,
+					0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
+					0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d,
+					0x8e, 0x8f,
+					},
+					.len =3D 200,
+				},
+				.rx_remaining =3D 0xFF,
+		} },
+	},
+};
+
+static const unsigned char send_data_response_111[] =3D {
+		0x81, 0x03, 0x01, 0x43, 0x01, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x01, 0x00, 0xB7, 0x01, 0xFF,
+};
+
+static const struct terminal_response_test send_data_response_data_111 =3D=
 {
+	.pdu =3D send_data_response_111,
+	.pdu_len =3D sizeof(send_data_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SEND_DATA,
+		.qualifier =3D STK_SEND_DATA_IMMEDIATELY,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .send_data =3D {
+				/* More than 255 bytes of space available */
+				.tx_avail =3D 0xFF,
+		} },
+	},
+};
+
+static const unsigned char send_data_response_121[] =3D {
+		0x81, 0x03, 0x01, 0x43, 0x00, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x01, 0x00, 0xB7, 0x01, 0xFF,
+};
+
+static const struct terminal_response_test send_data_response_data_121 =3D=
 {
+	.pdu =3D send_data_response_121,
+	.pdu_len =3D sizeof(send_data_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SEND_DATA,
+		.qualifier =3D STK_SEND_DATA_STORE_DATA,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .send_data =3D {
+				/* More than 255 bytes of space available */
+				.tx_avail =3D 0xFF,
+		} },
+	},
+};
+
+static const unsigned char send_data_response_151[] =3D {
+		0x81, 0x03, 0x01, 0x43, 0x01, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x02, 0x3A, 0x03,
+};
+
+static const struct terminal_response_test send_data_response_data_151 =3D=
 {
+	.pdu =3D send_data_response_151,
+	.pdu_len =3D sizeof(send_data_response_151),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SEND_DATA,
+		.qualifier =3D STK_SEND_DATA_IMMEDIATELY,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_BIP_ERROR,
+			.additional_len =3D 1, /* Channel identifier not valid */
+			.additional =3D (unsigned char[1]) { 0x03 },
+		},
+	},
+};
+
+static const unsigned char get_channel_status_response_111[] =3D {
+		0x81, 0x03, 0x01, 0x44, 0x00, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x01, 0x00, 0xB8, 0x02, 0x00, 0x00,
+};
+
+static const struct terminal_response_test
+				get_channel_status_response_data_111 =3D {
+	.pdu =3D get_channel_status_response_111,
+	.pdu_len =3D sizeof(get_channel_status_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_CHANNEL_STATUS,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .channel_status =3D {
+			/*
+			 * No Channel available, link not established or
+			 * PDP context not activated
+			 */
+			.channel =3D {
+				.id =3D 0,
+				.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED,
+			}
+		} },
+	},
+};
+
+static const unsigned char get_channel_status_response_121[] =3D {
+		0x81, 0x03, 0x01, 0x44, 0x00, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x01, 0x00, 0xB8, 0x02, 0x81, 0x00,
+};
+
+static const struct terminal_response_test
+				get_channel_status_response_data_121 =3D {
+	.pdu =3D get_channel_status_response_121,
+	.pdu_len =3D sizeof(get_channel_status_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_CHANNEL_STATUS,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .channel_status =3D {
+		/* Channel 1 open, link established or PDP context activated */
+			.channel =3D {
+				.id =3D 1,
+				.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED,
+			},
+		} },
+	},
+};
+
+static const unsigned char get_channel_status_response_131[] =3D {
+		0x81, 0x03, 0x01, 0x44, 0x00, 0x82, 0x02, 0x82, 0x81, 0x83,
+		0x01, 0x00, 0xB8, 0x02, 0x01, 0x05,
+};
+
+static const struct terminal_response_test
+				get_channel_status_response_data_131 =3D {
+	.pdu =3D get_channel_status_response_131,
+	.pdu_len =3D sizeof(get_channel_status_response_131),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_CHANNEL_STATUS,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .channel_status =3D {
+				/* Channel 1, link dropped */
+				.channel =3D {
+					.id =3D 1,
+					.status =3D STK_CHANNEL_LINK_DROPPED,
+				},
+		} },
+
+	},
+};
+
 struct envelope_test {
 	const unsigned char *pdu;
 	unsigned int pdu_len;
@@ -22428,16 +23481,20 @@ static const struct envelope_test event_download_=
data_available_data_111 =3D {
 			.type =3D STK_EVENT_TYPE_DATA_AVAILABLE,
 			{ .data_available =3D {
 				/* Channel 1 open, Link established */
-				.channel_status =3D { 0x81, 0x00 },
+				.channel =3D {
+				.id =3D 1,
+				.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED,
+				},
 				.channel_data_len =3D 255,
-			}},
-		}},
+			} },
+		} },
 	},
 };
 =

 static const unsigned char event_download_data_available_211[] =3D {
 	0xd6, 0x0e, 0x99, 0x01, 0x09, 0x82, 0x02, 0x82,
-	0x81, 0xb8, 0x02, 0x81, 0x01, 0xb7, 0x01, 0xff,
+	0x81, 0xb8, 0x02, 0x81, 0x00, 0xb7, 0x01, 0xff,
 };
 =

 static const struct envelope_test event_download_data_available_data_211 =
=3D {
@@ -22451,10 +23508,14 @@ static const struct envelope_test event_download_=
data_available_data_211 =3D {
 			.type =3D STK_EVENT_TYPE_DATA_AVAILABLE,
 			{ .data_available =3D {
 				/* Channel 1 open, Link established */
-				.channel_status =3D { 0x81, 0x01 },
+				.channel =3D {
+				.id =3D 1,
+				.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED,
+				},
 				.channel_data_len =3D 255,
-			}},
-		}},
+			} },
+		} },
 	},
 };
 =

@@ -22474,9 +23535,12 @@ static const struct envelope_test event_download_c=
hannel_status_data_131 =3D {
 			.type =3D STK_EVENT_TYPE_CHANNEL_STATUS,
 			{ .channel_status =3D {
 				/* Channel 1, Link dropped */
-				.status =3D { 0x01, 0x05 },
-			}},
-		}},
+				.channel =3D {
+					.id =3D 1,
+					.status =3D STK_CHANNEL_LINK_DROPPED,
+				},
+			} },
+		} },
 	},
 };
 =

@@ -22500,15 +23564,18 @@ static const struct envelope_test event_download_=
channel_status_data_211 =3D {
 			.type =3D STK_EVENT_TYPE_CHANNEL_STATUS,
 			{ .channel_status =3D {
 				/* Channel 1, TCP in LISTEN state */
-				.status =3D { 0x41, 0x00 },
-			}},
-		}},
+				.channel =3D {
+				.id =3D 1,
+				.status =3D STK_CHANNEL_TCP_IN_LISTEN_STATE,
+				},
+			} },
+		} },
 	},
 };
 =

 static const unsigned char event_download_channel_status_221[] =3D {
 	0xd6, 0x0b, 0x99, 0x01, 0x0a, 0x82, 0x02, 0x82,
-	0x81, 0xb8, 0x02, 0x81, 0x01,
+	0x81, 0xb8, 0x02, 0x81, 0x00,
 	/*
 	 * Byte 10 changed to 0xb8 (Comprehension Required should be
 	 * set according to TS 102 223 7.5.11.2)
@@ -22526,9 +23593,13 @@ static const struct envelope_test event_download_c=
hannel_status_data_221 =3D {
 			.type =3D STK_EVENT_TYPE_CHANNEL_STATUS,
 			{ .channel_status =3D {
 				/* Channel 1 open, TCP Link established */
-				.status =3D { 0x81, 0x01 },
-			}},
-		}},
+				.channel =3D {
+				.id =3D 1,
+				.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED,
+				},
+			} },
+		} },
 	},
 };
 =

@@ -24790,6 +25861,71 @@ int main(int argc, char **argv)
 			&launch_browser_response_data_411b,
 			test_terminal_response_encoding);
 =

+
+	g_test_add_data_func("/teststk/Open channel 2.1.1",
+				&open_channel_data_211, test_open_channel);
+	g_test_add_data_func("/teststk/Open channel 2.2.1",
+				&open_channel_data_221, test_open_channel);
+	g_test_add_data_func("/teststk/Open channel 2.3.1",
+				&open_channel_data_231, test_open_channel);
+	g_test_add_data_func("/teststk/Open channel 2.4.1",
+				&open_channel_data_241, test_open_channel);
+	g_test_add_data_func("/teststk/Open channel 5.1.1",
+				&open_channel_data_511, test_open_channel);
+	g_test_add_data_func("/teststk/Open channel response 2.1.1",
+				&open_channel_response_data_211,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Open channel response 2.7.1",
+				&open_channel_response_data_271,
+				test_terminal_response_encoding);
+
+	g_test_add_data_func("/teststk/Close channel 1.1.1",
+				&close_channel_data_111, test_close_channel);
+	g_test_add_data_func("/teststk/Close channel 2.1.1",
+				&close_channel_data_211, test_close_channel);
+	g_test_add_data_func("/teststk/Close channel response 1.2.1",
+				&close_channel_response_data_121,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Close channel response 1.3.1",
+				&close_channel_response_data_131,
+				test_terminal_response_encoding);
+
+	g_test_add_data_func("/teststk/Receive data 1.1.1",
+				&receive_data_data_111, test_receive_data);
+	g_test_add_data_func("/teststk/Receive data 2.1.1",
+				&receive_data_data_211, test_receive_data);
+	g_test_add_data_func("/teststk/Receive data response 1.1.1",
+				&receive_data_response_data_111,
+				test_terminal_response_encoding);
+
+	g_test_add_data_func("/teststk/Send data 1.1.1",
+					&send_data_data_111, test_send_data);
+	g_test_add_data_func("/teststk/Send data 1.2.1",
+					&send_data_data_121, test_send_data);
+	g_test_add_data_func("/teststk/Send data 2.1.1",
+					&send_data_data_211, test_send_data);
+	g_test_add_data_func("/teststk/Send data response 1.1.1",
+					&send_data_response_data_111,
+					test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Send data response 1.2.1",
+					&send_data_response_data_121,
+					test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Send data response 1.5.1",
+					&send_data_response_data_151,
+					test_terminal_response_encoding);
+
+	g_test_add_data_func("/teststk/Get Channel status 1.1.1",
+			&get_channel_status_data_111, test_get_channel_status);
+	g_test_add_data_func("/teststk/Get Channel status response 1.1.1",
+					&get_channel_status_response_data_111,
+					test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Channel status response 1.2.1",
+					&get_channel_status_response_data_121,
+					test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Channel status response 1.3.1",
+					&get_channel_status_response_data_131,
+					test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/SMS-PP data download 1.6.1",
 			&sms_pp_data_download_data_161,
 			test_envelope_encoding);
-- =

1.7.1


--===============6949014065244975775==--

