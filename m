Content-Type: multipart/mixed; boundary="===============6255462031015016327=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 09/11] stk: Add support of the Setup event list proactive
 command
Date: Mon, 04 Jul 2011 18:06:40 +0200
Message-ID: <1309795602-26046-10-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309795602-26046-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6255462031015016327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
---
 1 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 1e5869a..4c81bf8 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -90,6 +90,8 @@ struct ofono_stk {
 		gsize rx_remaining;
 		gsize tx_avail;
 		gboolean link_on_demand;
+		gboolean report_data_available;
+		gboolean report_channel_status;
 		struct ofono_gprs *gprs;
 		struct stk_bearer_description bearer_desc;
 		enum stk_transport_protocol_type protocol;
@@ -519,6 +521,61 @@ static void cancel_pending_dtmf(struct ofono_stk *stk)
 		__ofono_voicecall_tone_cancel(vc, stk->dtmf_id);
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
+	e.event_download.type =3D STK_EVENT_TYPE_CHANNEL_STATUS;
+	e.event_download.channel_status.channel.id =3D stk->bip.channel.id;
+	e.event_download.channel_status.channel.status =3D
+						stk->bip.channel.status;
+
+	if (stk->bip.channel.status =3D=3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED)
+		memcpy(&e.event_download.channel_status.bearer_desc,
+				&stk->bip.bearer_desc,
+				sizeof(struct stk_bearer_description));
+
+	if (stk_send_envelope(stk, &e, event_download_envelope_cb, 0))
+		event_download_envelope_cb(stk, FALSE, NULL, -1);
+}
+
+static void stk_send_data_available_event(struct ofono_stk *stk,
+						unsigned short data_available)
+{
+	struct stk_envelope e;
+
+	memset(&e, 0, sizeof(e));
+	e.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD;
+	e.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL;
+	e.event_download.type =3D STK_EVENT_TYPE_DATA_AVAILABLE;
+	e.event_download.data_available.channel.id =3D stk->bip.channel.id;
+	e.event_download.data_available.channel.status =3D
+						stk->bip.channel.status;
+	e.event_download.data_available.channel_data_len =3D data_available;
+
+	if (stk_send_envelope(stk, &e, event_download_envelope_cb, 0))
+		event_download_envelope_cb(stk, FALSE, NULL, -1);
+}
+
 static void ofono_stk_deactivate_context_cb(int error, void *data)
 {
 	struct ofono_stk *stk =3D data;
@@ -534,8 +591,10 @@ static void ofono_stk_deactivate_context_cb(int error,=
 void *data)
 			send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
 		else
 			send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
-	} else {
-		/* TODO send channel status event */
+	} else if (stk->bip.report_channel_status) {
+		/* user cancellation */
+		stk->bip.channel.status =3D STK_CHANNEL_LINK_DROPPED;
+		stk_send_channel_status_event(stk);
 	}
 =

 	stk->bip.channel.id =3D 0;
@@ -672,11 +731,10 @@ static gboolean receive_callback(GIOChannel *channel,=
 GIOCondition cond,
 		ioctl(fd, FIONREAD, &len);
 		DBG("%zd bytes to read", len);
 =

-		/*
-		 * TODO
-		 * send data available event if the buffer is empty
-		 * when new data arrives in it
-		 */
+		if (len > 0 && stk->bip.rx_remaining =3D=3D 0 &&
+				stk->bip.report_data_available) {
+			stk_send_data_available_event(stk, len);
+		}
 =

 		stk->bip.rx_remaining =3D len;
 =

@@ -711,7 +769,8 @@ static void ofono_stk_activate_context_cb(int error, co=
nst char *interface,
 				STK_COMMAND_TYPE_OPEN_CHANNEL &&
 				stk->pending_cmd->type !=3D
 				STK_COMMAND_TYPE_SEND_DATA)) {
-			/* TODO send channel status event */
+			if (stk->bip.report_channel_status)
+				stk_send_channel_status_event(stk);
 			return;
 		} else {
 			rsp.result.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE;
@@ -805,7 +864,8 @@ static void ofono_stk_activate_context_cb(int error, co=
nst char *interface,
 	g_io_channel_unref(io);
 =

 	if (stk->pending_cmd =3D=3D NULL) {
-		/* TODO send channel status event */
+		if (stk->bip.report_channel_status)
+			stk_send_channel_status_event(stk);
 		return;
 	} else if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_OPEN_CHANNEL) {
 		rsp.open_channel.channel.id =3D stk->bip.channel.id;
@@ -828,7 +888,8 @@ static void ofono_stk_activate_context_cb(int error, co=
nst char *interface,
 		}
 		rsp.send_data.tx_avail =3D stk->bip.tx_avail;
 	} else {
-		/* TODO send channel status event */
+		if (stk->bip.report_channel_status)
+			stk_send_channel_status_event(stk);
 		return;
 	}
 =

@@ -2747,6 +2808,8 @@ static gboolean handle_command_refresh(const struct s=
tk_command *cmd,
 		case 5:
 		case 6:
 			free_idle_mode_text(stk);
+			stk->bip.report_data_available =3D FALSE;
+			stk->bip.report_channel_status =3D FALSE;
 			__ofono_sim_refresh(sim, file_list, FALSE, TRUE);
 			break;
 		}
@@ -3355,6 +3418,38 @@ static gboolean handle_command_get_channel_status(co=
nst struct stk_command *cmd,
 	return TRUE;
 }
 =

+static gboolean handle_command_setup_event_list(const struct stk_command *=
cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_setup_event_list *sel =3D &cmd->setup_event_list;
+	unsigned int i;
+
+	stk->bip.report_data_available =3D FALSE;
+	stk->bip.report_channel_status =3D FALSE;
+
+	for (i =3D 0; i < sel->event_list.len; i++) {
+		switch (sel->event_list.list[i]) {
+		case STK_EVENT_TYPE_DATA_AVAILABLE:
+			DBG("Enable data available event");
+			stk->bip.report_data_available =3D TRUE;
+			break;
+		case STK_EVENT_TYPE_CHANNEL_STATUS:
+			DBG("Enable channel status event");
+			stk->bip.report_channel_status =3D TRUE;
+			break;
+		default:
+			DBG("Event type (%d) not supported",
+						sel->event_list.list[i]);
+			rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			return TRUE;
+		}
+	}
+
+	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -3573,6 +3668,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
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


--===============6255462031015016327==--

