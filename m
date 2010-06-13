Content-Type: multipart/mixed; boundary="===============7481121797378959763=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 03/12] stk: Add parser for send ussd commands
Date: Sun, 13 Jun 2010 17:43:13 +0800
Message-ID: <1276422202-16240-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1276422202-16240-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7481121797378959763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |    5 ++-
 src/stkutil.c  |   66 ++++++++++++++++++++++++++++++++++++++++++++
 src/stkutil.h  |    9 ++++++
 src/ussdutil.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ussdutil.h |   22 +++++++++++++++
 5 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100644 src/ussdutil.c
 create mode 100644 src/ussdutil.h

diff --git a/Makefile.am b/Makefile.am
index 2ca0703..1cf91fa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -269,7 +269,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
 			src/gprs.c src/idmap.h src/idmap.c \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
-			src/nettime.c
+			src/nettime.c src/ussdutil.h src/ussdutil.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

@@ -384,7 +384,8 @@ unit_objects +=3D $(unit_test_simutil_OBJECTS)
 =

 unit_test_stkutil_SOURCES =3D unit/test-stkutil.c src/util.c \
 				src/storage.c src/smsutil.c \
-				src/simutil.c src/stkutil.c
+				src/simutil.c src/stkutil.c \
+				src/ussdutil.c
 unit_test_stkutil_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_stkutil_OBJECTS)
 =

diff --git a/src/stkutil.c b/src/stkutil.c
index 642e141..d2c8522 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -29,6 +29,7 @@
 #include <glib.h>
 =

 #include <ofono/types.h>
+#include "ussdutil.h"
 #include "smsutil.h"
 #include "stkutil.h"
 #include "simutil.h"
@@ -560,6 +561,27 @@ static gboolean parse_dataobj_tone(struct comprehensio=
n_tlv_iter *iter,
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.17 */
+static gboolean parse_dataobj_ussd(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	char **ussd =3D user;
+	char *utf8;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+	const unsigned char *data =3D comprehension_tlv_iter_get_data(iter);
+
+	if (len <=3D 1)
+		return FALSE;
+
+	utf8 =3D ussd_decode(data[0], len - 1, data + 1);
+
+	if (utf8 =3D=3D NULL)
+		return FALSE;
+
+	*ussd =3D utf8;
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.18 */
 static gboolean parse_dataobj_file_list(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1896,6 +1918,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_text;
 	case STK_DATA_OBJECT_TYPE_TONE:
 		return parse_dataobj_tone;
+	case STK_DATA_OBJECT_TYPE_USSD_STRING:
+		return parse_dataobj_ussd;
 	case STK_DATA_OBJECT_TYPE_FILE_LIST:
 		return parse_dataobj_file_list;
 	case STK_DATA_OBJECT_TYPE_LOCATION_INFO:
@@ -2604,6 +2628,45 @@ static gboolean parse_send_ss(struct stk_command *co=
mmand,
 	return TRUE;
 }
 =

+static void destroy_send_ussd(struct stk_command *command)
+{
+	g_free(command->send_ussd.alpha_id);
+	g_free(command->send_ussd.ussd);
+}
+
+static gboolean parse_send_ussd(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_send_ussd *obj =3D &command->send_ussd;
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
+				STK_DATA_OBJECT_TYPE_USSD_STRING,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->ussd,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_send_ussd;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
 static void destroy_setup_call(struct stk_command *command)
 {
 	g_free(command->setup_call.alpha_id_usr_cfm);
@@ -3132,6 +3195,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_SEND_SS:
 		ok =3D parse_send_ss(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_SEND_USSD:
+		ok =3D parse_send_ussd(command, &iter);
+		break;
 	case STK_COMMAND_TYPE_SETUP_CALL:
 		ok =3D parse_setup_call(command, &iter);
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index d73d5e1..b6fb85b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -947,6 +947,14 @@ struct stk_command_send_ss {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_send_ussd {
+	char *alpha_id;
+	char *ussd;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command_setup_call {
 	char *alpha_id_usr_cfm;
 	struct stk_address addr;
@@ -1043,6 +1051,7 @@ struct stk_command {
 		struct stk_command_select_item select_item;
 		struct stk_command_send_sms send_sms;
 		struct stk_command_send_ss send_ss;
+		struct stk_command_send_ussd send_ussd;
 		struct stk_command_setup_call setup_call;
 		struct stk_command_setup_event_list setup_event_list;
 		struct stk_command_perform_card_apdu perform_card_apdu;
diff --git a/src/ussdutil.c b/src/ussdutil.c
new file mode 100644
index 0000000..b2f3d49
--- /dev/null
+++ b/src/ussdutil.c
@@ -0,0 +1,83 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <dirent.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include "smsutil.h"
+#include "ussdutil.h"
+#include "util.h"
+
+char *ussd_decode(int dcs, int len, const unsigned char *data)
+{
+	gboolean udhi;
+	enum sms_charset charset;
+	gboolean compressed;
+	gboolean iso639;
+	char *utf8;
+
+	if (!cbs_dcs_decode(dcs, &udhi, NULL, &charset,
+				&compressed, NULL, &iso639))
+		return NULL;
+
+	if (udhi || compressed || iso639)
+		return NULL;
+
+	switch (charset) {
+	case SMS_CHARSET_7BIT:
+	{
+		long written;
+		unsigned char *unpacked =3D unpack_7bit(data, len, 0, TRUE, 0,
+							&written, 0);
+		if (unpacked =3D=3D NULL)
+			return NULL;
+
+		utf8 =3D convert_gsm_to_utf8(unpacked, written, NULL, NULL, 0);
+		g_free(unpacked);
+
+		break;
+	}
+	case SMS_CHARSET_8BIT:
+		utf8 =3D convert_gsm_to_utf8(data, len, NULL, NULL, 0);
+		break;
+	case SMS_CHARSET_UCS2:
+		utf8 =3D g_convert((const gchar *) data, len,
+					"UTF-8//TRANSLIT", "UCS-2BE",
+					NULL, NULL, NULL);
+		break;
+	default:
+		utf8 =3D NULL;
+	}
+
+	return utf8;
+}
diff --git a/src/ussdutil.h b/src/ussdutil.h
new file mode 100644
index 0000000..17bb79c
--- /dev/null
+++ b/src/ussdutil.h
@@ -0,0 +1,22 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+char *ussd_decode(int dcs, int len, const unsigned char *data);
-- =

1.7.0.4


--===============7481121797378959763==--

