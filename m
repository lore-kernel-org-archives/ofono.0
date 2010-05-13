Content-Type: multipart/mixed; boundary="===============1210581020157393755=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 26/27] stkutil: Add timer management command parser
Date: Thu, 13 May 2010 18:48:43 +0800
Message-ID: <1273747724-28019-26-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1210581020157393755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   28 ++++++++++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 608a679..9cfc6e2 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2718,6 +2718,31 @@ static gboolean parse_get_reader_status(struct stk_c=
ommand *command,
 	return TRUE;
 }
 =

+static gboolean parse_timer_mgmt(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_timer_mgmt *obj =3D &command->timer_mgmt;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TIMER_ID,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->timer_id,
+				STK_DATA_OBJECT_TYPE_TIMER_VALUE, 0,
+				&obj->timer_value,
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
@@ -2830,6 +2855,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_GET_READER_STATUS:
 		ok =3D parse_get_reader_status(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_TIMER_MANAGEMENT:
+		ok =3D parse_timer_mgmt(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 5da7cc6..80af488 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -960,6 +960,11 @@ struct stk_command_perform_card_apdu {
 	struct stk_c_apdu c_apdu;
 };
 =

+struct stk_command_timer_mgmt {
+	unsigned char timer_id;
+	struct stk_timer_value timer_value;
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -980,6 +985,7 @@ struct stk_command {
 		struct stk_command_refresh refresh;
 		struct stk_command_setup_event_list setup_event_list;
 		struct stk_command_perform_card_apdu perform_card_apdu;
+		struct stk_command_timer_mgmt timer_mgmt;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============1210581020157393755==--

