Content-Type: multipart/mixed; boundary="===============2228856645822147942=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 20/27] stkutil: Add perform card apdu command parser
Date: Thu, 13 May 2010 18:48:37 +0800
Message-ID: <1273747724-28019-20-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2228856645822147942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   27 ++++++++++++++++++++++
 src/stkutil.h |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 01cdeef..8ba4b2d 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2644,6 +2644,30 @@ static gboolean parse_setup_event_list(struct stk_co=
mmand *command,
 	return TRUE;
 }
 =

+static gboolean parse_perform_card_apdu(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_perform_card_apdu *obj =3D &command->perform_card_apdu;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CARD_READER_0) ||
+			(command->dst > STK_DEVICE_IDENTITY_TYPE_CARD_READER_7))
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_C_APDU,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->c_apdu,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2744,6 +2768,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_SETUP_EVENT_LIST:
 		ok =3D parse_setup_event_list(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_PERFORM_CARD_APDU:
+		ok =3D parse_perform_card_apdu(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index dde62e6..809cb8c 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -183,6 +183,16 @@ enum stk_device_identity_type {
 	STK_DEVICE_IDENTITY_TYPE_KEYPAD =3D	0x01,
 	STK_DEVICE_IDENTITY_TYPE_DISPLAY =3D	0x02,
 	STK_DEVICE_IDENTITY_TYPE_EARPIECE =3D	0x03,
+	STK_DEVICE_IDENTITY_TYPE_CARD_READER_0 =3D 0x10,
+	STK_DEVICE_IDENTITY_TYPE_CARD_READER_1 =3D 0x11,
+	STK_DEVICE_IDENTITY_TYPE_CARD_READER_2 =3D 0x12,
+	STK_DEVICE_IDENTITY_TYPE_CARD_READER_3 =3D 0x13,
+	STK_DEVICE_IDENTITY_TYPE_CARD_READER_4 =3D 0x14,
+	STK_DEVICE_IDENTITY_TYPE_CARD_READER_5 =3D 0x15,
+	STK_DEVICE_IDENTITY_TYPE_CARD_READER_6 =3D 0x16,
+	STK_DEVICE_IDENTITY_TYPE_CARD_READER_7 =3D 0x17,
+	STK_DEVICE_IDENTITY_TYPE_CHANNEL_1 =3D 0x21,
+	STK_DEVICE_IDENTITY_TYPE_CHANNEL_7 =3D 0x27,
 	STK_DEVICE_IDENTITY_TYPE_UICC =3D		0x81,
 	STK_DEVICE_IDENTITY_TYPE_TERMINAL =3D	0x82,
 	STK_DEVICE_IDENTITY_TYPE_NETWORK =3D	0x83,
@@ -301,6 +311,60 @@ enum stk_icon_qualifier {
 	STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY =3D	0x01
 };
 =

+enum stk_ins {
+	STK_INS_DEACTIVATE_FILE =3D 			0X04,
+	STK_INS_ERASE_RECORDS =3D 			0X0C,
+	STK_INS_ERASE_BINARY_0E =3D 			0X0E,
+	STK_INS_ERASE_BINARY_0F =3D 			0X0F,
+	STK_INS_PERFORM_SCQL_OPERATION =3D 		0X10,
+	STK_INS_PERFORM_TRANSACTION_OPERATION =3D 	0X12,
+	STK_INS_PERFORM_USER_OPEPRATION =3D 		0X14,
+	STK_INS_VERIFY_20 =3D 				0X20,
+	STK_INS_VERIFY_21 =3D 				0X21,
+	STK_INS_MANAGE_SECURITY_ENVIRONMENT =3D 		0X22,
+	STK_INS_CHANGE_REFERENCE_DATA =3D 		0X24,
+	STK_INS_DISABLE_VERIFICATION_REQUIREMENT =3D 	0X26,
+	STK_INS_ENABLE_VERIFICATION_REQUIREMENT =3D 	0X28,
+	STK_INS_PERFORM_SECURITY_OPERATION =3D 		0X2A,
+	STK_INS_RESET_RETRY_COUNTER =3D 			0X2C,
+	STK_INS_ACTIVATE_FILE =3D 			0X44,
+	STK_INS_GENERATE_ASYMMETRIC_KEY_PAIR =3D 		0X46,
+	STK_INS_MANAGE_CHANNEL =3D 			0X70,
+	STK_INS_EXTERNAL_AUTHENTICATE =3D 		0X82,
+	STK_INS_GET_CHALLENGE =3D 			0X84,
+	STK_INS_GENERAL_AUTHENTICATE_86 =3D 		0X86,
+	STK_INS_GENERAL_AUTHENTICATE_87 =3D 		0X87,
+	STK_INS_INTERNAL_AUTHENTICATE =3D 		0X88,
+	STK_INS_SEARCH_BINARY_A0 =3D 			0XA0,
+	STK_INS_SEARCH_BINARY_A1 =3D 			0XA1,
+	STK_INS_SEARCH_RECORD =3D 			0XA2,
+	STK_INS_SELECT =3D 				0XA4,
+	STK_INS_READ_BINARY_B0 =3D 			0XB0,
+	STK_INS_READ_BINARY_B1 =3D 			0XB1,
+	STK_INS_READ_RECORDS_B2 =3D 			0XB2,
+	STK_INS_READ_RECORDS_B3 =3D 			0XB3,
+	STK_INS_GET_RESPONSE =3D 				0XC0,
+	STK_INS_ENVELOPE_C2 =3D 				0XC2,
+	STK_INS_ENVELOPE_C3 =3D				0XC3,
+	STK_INS_GET_DATA_CA =3D				0XCA,
+	STK_INS_GET_DATA_CB =3D				0XCB,
+	STK_INS_WRITE_BINARY_D0 =3D			0XD0,
+	STK_INS_WRITE_BINARY_D1 =3D 			0XD1,
+	STK_INS_WRITE_RECORD =3D 				0XD2,
+	STK_INS_UPDATE_BINARY_D6 =3D 			0XD6,
+	STK_INS_UPDATE_BINARY_D7 =3D 			0XD7,
+	STK_INS_PUT_DATA_DA =3D 				0XDA,
+	STK_INS_PUT_DATA_DB =3D 				0XDB,
+	STK_INS_UPDATE_RECORD_DC =3D 			0XDC,
+	STK_INS_UPDATE_RECORD_DD =3D 			0XDD,
+	STK_INS_CREATE_FILE =3D 				0XE0,
+	STK_INS_APPEND_RECORD =3D 			0XE2,
+	STK_INS_DELETE_FILE =3D 				0XE4,
+	STK_INS_TERMINATE_DF =3D 				0XE6,
+	STK_INS_TERMINATE_EF =3D 				0XE8,
+	STK_INS_TERMINATE_CARD_USAGE =3D 			0XFE
+};
+
 enum stk_browser_id {
 	STK_BROWSER_ID_DEFAULT =3D	0x00,
 	STK_BROWSER_ID_WML =3D		0x01,
@@ -887,6 +951,10 @@ struct stk_command_setup_event_list {
 	struct stk_event_list event_list;
 };
 =

+struct stk_command_perform_card_apdu {
+	struct stk_c_apdu c_apdu;
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -906,6 +974,7 @@ struct stk_command {
 		struct stk_command_setup_call setup_call;
 		struct stk_command_refresh refresh;
 		struct stk_command_setup_event_list setup_event_list;
+		struct stk_command_perform_card_apdu perform_card_apdu;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============2228856645822147942==--

