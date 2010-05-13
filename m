Content-Type: multipart/mixed; boundary="===============6314632336511554069=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 18/27] stkutil: Add event list command parser
Date: Thu, 13 May 2010 18:48:35 +0800
Message-ID: <1273747724-28019-18-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6314632336511554069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   31 ++++++++++++++++++++++++++++++-
 src/stkutil.h |    5 +++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 0484687..01cdeef 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -703,7 +703,10 @@ static gboolean parse_dataobj_event_list(struct compre=
hension_tlv_iter *iter,
 	const unsigned char *data;
 	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
 =

-	if ((len < 1) || (len > sizeof(el->list)))
+	if (len =3D=3D 0)
+		return TRUE;
+
+	if (len > sizeof(el->list))
 		return FALSE;
 =

 	data =3D comprehension_tlv_iter_get_data(iter);
@@ -2618,6 +2621,29 @@ static gboolean parse_provide_local_info(struct stk_=
command *command,
 	return TRUE;
 }
 =

+static gboolean parse_setup_event_list(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_setup_event_list *obj =3D &command->setup_event_list;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_EVENT_LIST,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->event_list,
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
@@ -2715,6 +2741,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO:
 		ok =3D parse_provide_local_info(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_SETUP_EVENT_LIST:
+		ok =3D parse_setup_event_list(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index d974ea1..dde62e6 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -883,6 +883,10 @@ struct stk_command_refresh {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_setup_event_list {
+	struct stk_event_list event_list;
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -901,6 +905,7 @@ struct stk_command {
 		struct stk_command_send_sms send_sms;
 		struct stk_command_setup_call setup_call;
 		struct stk_command_refresh refresh;
+		struct stk_command_setup_event_list setup_event_list;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============6314632336511554069==--

