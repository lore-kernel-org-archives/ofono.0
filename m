Content-Type: multipart/mixed; boundary="===============2927051842273034836=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 2/8] stk: Add parser for launch browser commands
Date: Wed, 26 May 2010 22:39:08 +0800
Message-ID: <1274884754-12977-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274884754-12977-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2927051842273034836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   16 +++++++++
 2 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index fd5b7c6..12af7fc 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2865,6 +2865,106 @@ static gboolean parse_language_notification(struct =
stk_command *command,
 	return TRUE;
 }
 =

+static void destroy_launch_browser(struct stk_command *command)
+{
+	g_free(command->launch_browser.url);
+	g_free(command->launch_browser.bearer.array);
+	g_slist_foreach(command->launch_browser.prov_file_refs,
+				(GFunc)g_free, NULL);
+	g_slist_free(command->launch_browser.prov_file_refs);
+	g_free(command->launch_browser.text_gateway_proxy_id);
+	g_free(command->launch_browser.alpha_id);
+	g_free(command->launch_browser.network_name.array);
+	g_free(command->launch_browser.text_usr);
+	g_free(command->launch_browser.text_passwd);
+}
+
+static GSList *parse_provisioining_file_reference_list(
+					struct comprehension_tlv_iter *iter)
+{
+	unsigned short tag =3D STK_DATA_OBJECT_TYPE_PROVISIONING_FILE_REFERENCE;
+	struct comprehension_tlv_iter iter_old;
+	struct stk_file file;
+	GSList *list =3D NULL;
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D tag)
+		return NULL;
+
+	do {
+		comprehension_tlv_iter_copy(iter, &iter_old);
+		memset(&file, 0, sizeof(file));
+
+		if (parse_dataobj_provisioning_file_reference(iter, &file)
+									=3D=3D TRUE)
+			list =3D g_slist_prepend(list,
+						g_memdup(&file, sizeof(file)));
+	} while (comprehension_tlv_iter_next(iter) =3D=3D TRUE &&
+			comprehension_tlv_iter_get_tag(iter) =3D=3D tag);
+
+	comprehension_tlv_iter_copy(&iter_old, iter);
+	list =3D g_slist_reverse(list);
+
+	return list;
+}
+
+static gboolean parse_launch_browser(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_launch_browser *obj =3D &command->launch_browser;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter,
+				STK_DATA_OBJECT_TYPE_BROWSER_ID, 0,
+				&obj->browser_id,
+				STK_DATA_OBJECT_TYPE_URL,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->url,
+				STK_DATA_OBJECT_TYPE_BEARER, 0,
+				&obj->bearer,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		goto error;
+
+	obj->prov_file_refs =3D parse_provisioining_file_reference_list(iter);
+
+	ret =3D parse_dataobj(iter,
+			STK_DATA_OBJECT_TYPE_TEXT, 0,
+			&obj->text_gateway_proxy_id,
+			STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+			&obj->alpha_id,
+			STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+			&obj->icon_id,
+			STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+			&obj->text_attr,
+			STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+			&obj->frame_id,
+			STK_DATA_OBJECT_TYPE_NETWORK_ACCESS_NAME, 0,
+			&obj->network_name,
+			STK_DATA_OBJECT_TYPE_TEXT, 0,
+			&obj->text_usr,
+			STK_DATA_OBJECT_TYPE_TEXT, 0,
+			&obj->text_passwd,
+			STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	command->destructor =3D destroy_launch_browser;
+
+	return TRUE;
+
+error:
+	destroy_launch_browser(command);
+	return FALSE;
+}
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2992,6 +3092,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
 		ok =3D parse_language_notification(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
+		ok =3D parse_launch_browser(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 33a1325..1bc419b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -992,6 +992,21 @@ struct stk_command_language_notification {
 	char language[3];
 };
 =

+struct stk_command_launch_browser {
+	unsigned char browser_id;
+	char *url;
+	struct stk_common_byte_array bearer;
+	GSList *prov_file_refs;
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
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -1017,6 +1032,7 @@ struct stk_command {
 		struct stk_command_run_at_command run_at_command;
 		struct stk_command_send_dtmf send_dtmf;
 		struct stk_command_language_notification language_notification;
+		struct stk_command_launch_browser launch_browser;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============2927051842273034836==--

