Content-Type: multipart/mixed; boundary="===============4471395215034940972=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] ifxmodem: add CNAP support
Date: Thu, 10 Feb 2011 18:16:16 +0200
Message-ID: <1297354576-10011-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4471395215034940972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |   51 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 30e6991..87a48e6 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -630,6 +630,56 @@ static void clip_notify(GAtResult *result, gpointer us=
er_data)
 		ofono_voicecall_notify(vc, call);
 }
 =

+static void cnap_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	const char *name;
+	int validity;
+	GSList *l;
+	struct ofono_call *call;
+
+	/*
+	 * Currently, its not clear which URC will contain the
+	 * calling party name for the waiting call.
+	 */
+	l =3D g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				at_util_call_compare_by_status);
+	if (l =3D=3D NULL) {
+		ofono_error("CNAP for unknown call");
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CNAP:"))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &name))
+		return;
+
+	if (strlen(name) > 0)
+		validity =3D CNAP_VALIDITY_VALID;
+	else
+		validity =3D CNAP_VALIDITY_NOT_AVAILABLE;
+
+	/* If we have CNI validity field, override our guessed value */
+	g_at_result_iter_next_number(&iter, &validity);
+
+	DBG("%s %d", name, validity);
+
+	call =3D l->data;
+
+	strncpy(call->name, name, OFONO_MAX_CALLER_NAME_LENGTH);
+	call->name[OFONO_MAX_CALLER_NAME_LENGTH] =3D '\0';
+	call->cnap_validity =3D validity;
+
+	if (call->type =3D=3D 0)
+		ofono_voicecall_notify(vc, call);
+}
+
 static void ccwa_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -746,6 +796,7 @@ static void ifx_voicecall_initialized(gboolean ok, GAtR=
esult *result,
 =

 	g_at_chat_register(vd->chat, "+CRING:", cring_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CLIP:", clip_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+CNAP:", cnap_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CCWA:", ccwa_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+XEM:", xem_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+XCALLSTAT:", xcallstat_notify,
-- =

1.7.0.4


--===============4471395215034940972==--

