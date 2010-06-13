Content-Type: multipart/mixed; boundary="===============5275319681390136775=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 07/12] Add several proactive command parsers
Date: Sun, 13 Jun 2010 17:43:17 +0800
Message-ID: <1276422202-16240-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1276422202-16240-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5275319681390136775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  473 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   93 +++++++++++
 2 files changed, 566 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index d2c8522..268d686 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3107,6 +3107,440 @@ static gboolean parse_launch_browser(struct stk_com=
mand *command,
 	return TRUE;
 }
 =

+/* TODO: parse_open_channel */
+
+static void destroy_close_channel(struct stk_command *command)
+{
+	g_free(command->close_channel.alpha_id);
+}
+
+static gboolean parse_close_channel(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_close_channel *obj =3D &command->close_channel;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_close_channel;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void destroy_receive_data(struct stk_command *command)
+{
+	g_free(command->receive_data.alpha_id);
+}
+
+static gboolean parse_receive_data(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_receive_data *obj =3D &command->receive_data;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CHANNEL_1) ||
+			(command->dst > STK_DEVICE_IDENTITY_TYPE_CHANNEL_7))
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_CHANNEL_DATA_LENGTH,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->data_len,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_receive_data;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void destroy_send_data(struct stk_command *command)
+{
+	g_free(command->send_data.alpha_id);
+	g_free(command->send_data.data.array);
+}
+
+static gboolean parse_send_data(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_send_data *obj =3D &command->send_data;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CHANNEL_1) ||
+			(command->dst > STK_DEVICE_IDENTITY_TYPE_CHANNEL_7))
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_CHANNEL_DATA,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->data,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_send_data;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean parse_get_channel_status(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void destroy_service_search(struct stk_command *command)
+{
+	g_free(command->service_search.alpha_id);
+	g_free(command->service_search.serv_search.ser_search);
+	g_free(command->service_search.dev_filter.dev_filter);
+}
+
+static gboolean parse_service_search(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_service_search *obj =3D &command->service_search;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_SERVICE_SEARCH,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->serv_search,
+				STK_DATA_OBJECT_TYPE_DEVICE_FILTER, 0,
+				&obj->dev_filter,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_service_search;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void destroy_get_service_info(struct stk_command *command)
+{
+	g_free(command->get_service_info.alpha_id);
+	g_free(command->get_service_info.attr_info.attr_info);
+}
+
+static gboolean parse_get_service_info(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_get_service_info *obj =3D &command->get_service_info;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_ATTRIBUTE_INFO,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->attr_info,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_get_service_info;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void destroy_declare_service(struct stk_command *command)
+{
+	g_free(command->declare_service.serv_rec.serv_rec);
+}
+
+static gboolean parse_declare_service(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_declare_service *obj =3D &command->declare_service;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_SERVICE_RECORD,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->serv_rec,
+				STK_DATA_OBJECT_TYPE_UICC_TE_INTERFACE, 0,
+				&obj->intf,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_declare_service;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean parse_set_frames(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_set_frames *obj =3D &command->set_frames;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FRAME_ID,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_FRAME_LAYOUT, 0,
+				&obj->frame_layout,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id_default,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean parse_get_frames_status(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void destroy_retrieve_mms(struct stk_command *command)
+{
+	g_free(command->retrieve_mms.alpha_id);
+	g_slist_foreach(command->retrieve_mms.mms_rec_files,
+						(GFunc)g_free, NULL);
+	g_slist_free(command->retrieve_mms.mms_rec_files);
+}
+
+static gboolean parse_retrieve_mms(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_retrieve_mms *obj =3D &command->retrieve_mms;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_MMS_REFERENCE,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->mms_ref,
+				STK_DATA_OBJECT_TYPE_FILE_LIST,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->mms_rec_files,
+				STK_DATA_OBJECT_TYPE_MMS_CONTENT_ID,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->mms_content_id,
+				STK_DATA_OBJECT_TYPE_MMS_ID, 0,
+				&obj->mms_id,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_retrieve_mms;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void destroy_submit_mms(struct stk_command *command)
+{
+	g_free(command->submit_mms.alpha_id);
+	g_slist_foreach(command->submit_mms.mms_subm_files,
+						(GFunc)g_free, NULL);
+	g_slist_free(command->submit_mms.mms_subm_files);
+}
+
+static gboolean parse_submit_mms(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_submit_mms *obj =3D &command->submit_mms;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_FILE_LIST,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->mms_subm_files,
+				STK_DATA_OBJECT_TYPE_MMS_ID, 0,
+				&obj->mms_id,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_submit_mms;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void destroy_display_mms(struct stk_command *command)
+{
+	g_slist_foreach(command->display_mms.mms_subm_files,
+						(GFunc)g_free, NULL);
+	g_slist_free(command->display_mms.mms_subm_files);
+}
+
+static gboolean parse_display_mms(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_display_mms *obj =3D &command->display_mms;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FILE_LIST,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->mms_subm_files,
+				STK_DATA_OBJECT_TYPE_MMS_ID,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->mms_id,
+				STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE, 0,
+				&obj->imd_resp,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_display_mms;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean parse_activate(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_activate *obj =3D &command->activate;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ACTIVATE_DESCRIPTOR,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->actv_desc,
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
@@ -3243,6 +3677,45 @@ struct stk_command *stk_command_new_from_pdu(const u=
nsigned char *pdu,
 	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
 		ok =3D parse_launch_browser(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_CLOSE_CHANNEL:
+		ok =3D parse_close_channel(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_RECEIVE_DATA:
+		ok =3D parse_receive_data(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_SEND_DATA:
+		ok =3D parse_send_data(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
+		ok =3D parse_get_channel_status(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_SERVICE_SEARCH:
+		ok =3D parse_service_search(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_GET_SERVICE_INFO:
+		ok =3D parse_get_service_info(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_DECLARE_SERVICE:
+		ok =3D parse_declare_service(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_SET_FRAMES:
+		ok =3D parse_set_frames(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_GET_FRAMES_STATUS:
+		ok =3D parse_get_frames_status(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_RETRIEVE_MMS:
+		ok =3D parse_retrieve_mms(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_SUBMIT_MMS:
+		ok =3D parse_submit_mms(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_DISPLAY_MMS:
+		ok =3D parse_display_mms(command, &iter);
+		break;
+	case STK_COMMAND_TYPE_ACTIVATE:
+		ok =3D parse_activate(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index b6fb85b..6ab5ed1 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1033,6 +1033,88 @@ struct stk_command_launch_browser {
 	char *text_passwd;
 };
 =

+struct stk_command_close_channel {
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+struct stk_command_receive_data {
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	unsigned char data_len;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+struct stk_command_send_data {
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_common_byte_array data;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+struct stk_command_service_search {
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_service_search serv_search;
+	struct stk_device_filter dev_filter;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+struct stk_command_get_service_info {
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_attribute_info attr_info;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+struct stk_command_declare_service {
+	struct stk_service_record serv_rec;
+	struct stk_uicc_te_interface intf;
+};
+
+struct stk_command_set_frames {
+	struct stk_frame_id frame_id;
+	struct stk_frame_layout frame_layout;
+	struct stk_frame_id frame_id_default;
+};
+
+struct stk_command_retrieve_mms {
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_mms_reference mms_ref;
+	GSList *mms_rec_files;
+	struct stk_mms_content_id mms_content_id;
+	struct stk_mms_id mms_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+struct stk_command_submit_mms {
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	GSList *mms_subm_files;
+	struct stk_mms_id mms_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+struct stk_command_display_mms {
+	GSList *mms_subm_files;
+	struct stk_mms_id mms_id;
+	ofono_bool_t imd_resp;
+	struct stk_frame_id frame_id;
+};
+
+struct stk_command_activate {
+	unsigned char actv_desc;
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -1061,6 +1143,17 @@ struct stk_command {
 		struct stk_command_send_dtmf send_dtmf;
 		struct stk_command_language_notification language_notification;
 		struct stk_command_launch_browser launch_browser;
+		struct stk_command_close_channel close_channel;
+		struct stk_command_receive_data receive_data;
+		struct stk_command_send_data send_data;
+		struct stk_command_service_search service_search;
+		struct stk_command_get_service_info get_service_info;
+		struct stk_command_declare_service declare_service;
+		struct stk_command_set_frames set_frames;
+		struct stk_command_retrieve_mms retrieve_mms;
+		struct stk_command_submit_mms submit_mms;
+		struct stk_command_display_mms display_mms;
+		struct stk_command_activate activate;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============5275319681390136775==--

