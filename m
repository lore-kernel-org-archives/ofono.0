Content-Type: multipart/mixed; boundary="===============4245510961562146085=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 1/2] ifxmodem: add handling of XCOLP notification
Date: Mon, 07 Feb 2011 20:21:19 +0200
Message-ID: <1297102880-32714-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1297102880-32714-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4245510961562146085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |   51 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index f66815a..d31fa70 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -688,6 +688,55 @@ static void ccwa_notify(GAtResult *result, gpointer us=
er_data)
 		ofono_voicecall_notify(vc, call);
 }
 =

+static void xcolp_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	const char *num;
+	int type, call_id;
+	GSList *l;
+	struct ofono_call *call;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XCOLP:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &call_id))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &num))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &type))
+		return;
+
+	if (strlen(num) =3D=3D 0) {
+		ofono_error("XCOLP received with invalid number!!!");
+		return;
+	}
+
+	DBG("xcolp_notify: %d %s %d", call_id, num, type);
+
+	l =3D g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(call_id),
+				at_util_call_compare_by_id);
+	if (l =3D=3D NULL) {
+		ofono_error("XCOLP for unknown call");
+		return;
+	}
+
+	call =3D l->data;
+
+	strncpy(call->phone_number.number, num,	OFONO_MAX_PHONE_NUMBER_LENGTH);
+	call->phone_number.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+	call->phone_number.type =3D type;
+	call->clip_validity =3D CLIP_VALIDITY_VALID;
+
+	ofono_voicecall_notify(vc, call);
+}
+
 static void ifx_voicecall_initialized(gboolean ok, GAtResult *result,
 					gpointer user_data)
 {
@@ -702,6 +751,7 @@ static void ifx_voicecall_initialized(gboolean ok, GAtR=
esult *result,
 	g_at_chat_register(vd->chat, "+XEM:", xem_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+XCALLSTAT:", xcallstat_notify,
 							FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+XCOLP:", xcolp_notify, FALSE, vc, NULL);
 =

 	ofono_voicecall_register(vc);
 }
@@ -722,6 +772,7 @@ static int ifx_voicecall_probe(struct ofono_voicecall *=
vc, unsigned int vendor,
 =

 	g_at_chat_send(chat, "AT+XCALLSTAT=3D1", none_prefix, NULL, NULL, NULL);
 	g_at_chat_send(chat, "AT+XEMC=3D1", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+XCOLP=3D1", none_prefix, NULL, NULL, NULL);
 =

 	g_at_chat_send(vd->chat, "AT+CRC=3D1", none_prefix, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CLIP=3D1", none_prefix, NULL, NULL, NULL);
-- =

1.7.0.4


--===============4245510961562146085==--

