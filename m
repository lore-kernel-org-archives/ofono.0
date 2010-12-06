Content-Type: multipart/mixed; boundary="===============6859106175275855045=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 08/14] atmodem: Add CNAP parsing to voicecall
Date: Mon, 06 Dec 2010 18:12:36 -0200
Message-ID: <1291666362-19128-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-7-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6859106175275855045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c |   47 +++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index a2ee49d..41fd901 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -746,6 +746,51 @@ static void clip_notify(GAtResult *result, gpointer us=
er_data)
 	}
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
+	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
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
+	strncpy(call->name, name,
+		OFONO_MAX_CALLER_NAME_LENGTH);
+	call->name[OFONO_MAX_CALLER_NAME_LENGTH] =3D '\0';
+	call->cnap_validity =3D validity;
+
+	ofono_voicecall_notify(vc, call);
+}
+
 static void ccwa_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -864,6 +909,7 @@ static void at_voicecall_initialized(gboolean ok, GAtRe=
sult *result,
 	g_at_chat_register(vd->chat, "RING", ring_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CRING:", cring_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CLIP:", clip_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+CNAP:", cnap_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CCWA:", ccwa_notify, FALSE, vc, NULL);
 =

 	/* Modems with 'better' call progress indicators should
@@ -899,6 +945,7 @@ static int at_voicecall_probe(struct ofono_voicecall *v=
c, unsigned int vendor,
 =

 	g_at_chat_send(vd->chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+COLP=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+VTD?", NULL,
 				vtd_query_cb, vc, NULL);
-- =

1.7.3.2


--===============6859106175275855045==--

