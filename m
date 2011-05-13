Content-Type: multipart/mixed; boundary="===============2843071011528420880=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 7/7] stk: Add support of the Setup event list proactive
 command
Date: Fri, 13 May 2011 19:22:04 +0200
Message-ID: <1305307324-19548-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1305307324-19548-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2843071011528420880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
----
 1 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 5ff9441..7122477 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -85,6 +85,8 @@ struct ofono_stk {
 	struct stk_channel_data rx_buffer;
 	struct stk_channel_data tx_buffer;
 	gboolean link_on_demand;
+	gboolean report_data_available;
+	gboolean report_channel_status;
 	struct ofono_gprs *gprs;
 	struct stk_bearer_description bearer_desc;
 };
@@ -489,6 +491,40 @@ static void emit_menu_changed(struct ofono_stk *stk)
 	g_dbus_send_message(conn, signal);
 }
 =

+static void event_download_envelope_cb(struct ofono_stk *stk, gboolean ok,
+				const unsigned char *data, int len)
+{
+	if (!ok) {
+		ofono_error("Event download to UICC failed");
+		return;
+	}
+
+	if (len)
+		ofono_error("Event download returned %i bytes of data",
+				len);
+
+	DBG("Event download  to UICC reported no error");
+}
+
+static void stk_send_channel_status_event(struct ofono_stk *stk)
+{
+	struct stk_envelope e;
+
+	memset(&e, 0, sizeof(e));
+	e.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD;
+	e.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL;
+	e.event_download.channel_status.channel.id =3D stk->channel.id;
+	e.event_download.channel_status.channel.status =3D stk->channel.status;
+
+	if (stk->channel.status =3D=3D STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED)
+		memcpy(&e.event_download.channel_status.bearer_desc,
+				&stk->bearer_desc,
+				sizeof(struct stk_bearer_description));
+
+	if (stk_send_envelope(stk, &e, event_download_envelope_cb, 0))
+		event_download_envelope_cb(stk, FALSE, NULL, -1);
+}
+
 static void ofono_stk_remove_pdp_context_cb(int error, void *data)
 {
 	struct ofono_stk *stk =3D data;
@@ -503,12 +539,8 @@ static void ofono_stk_remove_pdp_context_cb(int error,=
 void *data)
 			send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
 		else
 			send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
-	} else {
-		/*
-		 * TODO
-		 * Send Event channel status
-		 */
-	}
+	} else if (stk->report_channel_status)
+		stk_send_channel_status_event(stk);
 =

 	/* free the buffers even in case of error */
 	g_free(stk->rx_buffer.data.array);
@@ -608,10 +640,8 @@ static void ofono_stk_activate_pdp_context_cb(int erro=
r, const char *interface,
 	}
 =

 	if (stk->pending_cmd =3D=3D NULL) {
-		/*
-		 * TODO
-		 * Send Event channel status
-		 */
+		if (stk->report_channel_status)
+			stk_send_channel_status_event(stk);
 		return;
 	}
 =

@@ -3129,6 +3159,41 @@ static gboolean handle_command_get_channel_status(co=
nst struct stk_command *cmd,
 	return TRUE;
 }
 =

+
+static gboolean handle_command_setup_event_list(const struct stk_command *=
cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_setup_event_list *sel =3D &cmd->setup_event_list;
+	unsigned int i;
+
+	for (i =3D 0; i < sel->event_list.len; i++) {
+		switch (sel->event_list.list[i]) {
+		case STK_EVENT_TYPE_DATA_AVAILABLE:
+			DBG("Enable data available event");
+			stk->report_data_available =3D TRUE;
+			break;
+		case STK_EVENT_TYPE_CHANNEL_STATUS:
+			DBG("Enable channel status event");
+			stk->report_channel_status =3D TRUE;
+			break;
+		default:
+			DBG("Event type (%d) not supported",
+						sel->event_list.list[i]);
+			rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			return TRUE;
+		}
+	}
+
+	if (sel->event_list.len =3D=3D 0) {
+		stk->report_data_available =3D FALSE;
+		stk->report_channel_status =3D FALSE;
+	}
+
+	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -3347,6 +3412,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_SETUP_EVENT_LIST:
+		respond =3D handle_command_setup_event_list(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.1


--===============2843071011528420880==--

