Content-Type: multipart/mixed; boundary="===============0697696535862920813=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 02/11] stk: Add support for the proactive command 'Open
 channel'
Date: Mon, 04 Jul 2011 18:06:33 +0200
Message-ID: <1309795602-26046-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309795602-26046-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0697696535862920813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  231 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 231 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 9575f0e..cbbab4a 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -41,6 +41,7 @@
 #include "smsutil.h"
 #include "stkutil.h"
 #include "stkagent.h"
+#include "gprs.h"
 #include "util.h"
 =

 static GSList *g_drivers =3D NULL;
@@ -79,6 +80,15 @@ struct ofono_stk {
 =

 	__ofono_sms_sim_download_cb_t sms_pp_cb;
 	void *sms_pp_userdata;
+	struct {
+		struct stk_channel channel;
+		struct ofono_gprs_primary_context context;
+		gsize tx_avail;
+		gboolean link_on_demand;
+		struct ofono_gprs *gprs;
+		struct stk_bearer_description bearer_desc;
+		enum stk_transport_protocol_type protocol;
+	} bip;
 };
 =

 struct envelope_op {
@@ -104,6 +114,12 @@ static void timers_update(struct ofono_stk *stk);
 		result.additional_len =3D sizeof(addn_info);	\
 		result.additional =3D addn_info;			\
 =

+/*
+ * Channel identifier is attributed by default to 1 since only one channel
+ * is open per time
+ */
+#define DEFAULT_CHANNEL_ID 1
+
 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			ofono_stk_generic_cb_t cb)
 {
@@ -532,6 +548,122 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	stk_agent_request_cancel(stk->current_agent);
 }
 =

+static void ofono_stk_activate_context_cb(int error, const char *interface,
+						const char *ip,
+						void *data)
+{
+}
+
+static void stk_open_channel(struct ofono_stk *stk)
+{
+	const struct stk_command_open_channel *oc;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	struct ofono_atom *gprs_atom;
+	struct stk_response rsp;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	int err;
+
+	oc =3D &stk->pending_cmd->open_channel;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+
+	if (oc->data_dest_addr.type =3D=3D STK_ADDRESS_IPV6) {
+		/*
+		 * For now, only the bearer type "GPRS / UTRAN packet service /
+		 * E-UTRAN" is supported.
+		 * For such bearer, according 3GPP TS 31.111, the packet data
+		 * protocol type is IP, so only IPv4 addresses are considered.
+		 */
+		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		goto out;
+	}
+
+	stk->bip.channel.id =3D DEFAULT_CHANNEL_ID;
+	stk->bip.tx_avail =3D oc->buf_size;
+
+	memset(&stk->bip.context, 0, sizeof(stk->bip.context));
+	stk->bip.context.proto =3D OFONO_GPRS_PROTO_IP;
+
+	if (oc->apn) {
+		if (strlen(oc->apn) > OFONO_GPRS_MAX_APN_LENGTH) {
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+
+		strcpy(stk->bip.context.apn, oc->apn);
+	}
+
+	if (oc->text_usr) {
+		if (strlen(oc->text_usr) > OFONO_GPRS_MAX_APN_LENGTH) {
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+
+		strcpy(stk->bip.context.username, oc->text_usr);
+	}
+
+	if (oc->text_passwd) {
+		if (strlen(oc->text_passwd) > OFONO_GPRS_MAX_APN_LENGTH) {
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+
+		strcpy(stk->bip.context.password, oc->text_passwd);
+	}
+
+	memcpy(&stk->bip.bearer_desc, &oc->bearer_desc,
+					sizeof(struct stk_bearer_description));
+	stk->bip.protocol =3D oc->uti.protocol;
+	stk->bip.link_on_demand =3D (stk->pending_cmd->qualifier &
+				STK_OPEN_CHANNEL_FLAG_IMMEDIATE) ? FALSE : TRUE;
+
+	if (stk->bip.link_on_demand) {
+		rsp.open_channel.channel.id =3D stk->bip.channel.id;
+		rsp.open_channel.channel.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
+		rsp.open_channel.buf_size =3D oc->buf_size;
+		goto out;
+	}
+
+	gprs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
+	if (gprs_atom =3D=3D NULL || !__ofono_atom_get_registered(gprs_atom)) {
+		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		goto out;
+	}
+
+	err =3D __ofono_gprs_private_context_activate(
+					__ofono_atom_get_data(gprs_atom),
+					&stk->bip.context,
+					ofono_stk_activate_context_cb,
+					stk);
+
+	if (err =3D=3D -EBUSY) {
+		rsp.result.type =3D STK_RESULT_TYPE_BIP_ERROR;
+		goto out;
+	} else if (err < 0) {
+		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		goto out;
+	}
+
+	/* In background mode, send the terminal response now */
+	if (stk->pending_cmd->qualifier & STK_OPEN_CHANNEL_FLAG_BACKGROUND) {
+		rsp.open_channel.channel.id =3D stk->bip.channel.id;
+		rsp.open_channel.channel.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
+		rsp.open_channel.buf_size =3D oc->buf_size;
+		goto out;
+	}
+
+	/* wait for the PDP context activation to send the Terminal Response */
+	return;
+
+out:
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+
+}
+
 static int duration_to_msecs(const struct stk_duration *duration)
 {
 	int msecs =3D duration->interval;
@@ -2601,6 +2733,100 @@ static gboolean handle_command_launch_browser(const=
 struct stk_command *cmd,
 	return FALSE;
 }
 =

+static void confirm_open_channel_cb(enum stk_agent_result result,
+					gboolean confirm,
+					void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	switch (result) {
+	case STK_AGENT_RESULT_TIMEOUT:
+		confirm =3D FALSE;
+		/* Fall through */
+
+	case STK_AGENT_RESULT_OK:
+		if (confirm)
+			break;
+
+		send_simple_response(stk, STK_RESULT_TYPE_USER_REJECT);
+		return;
+
+	case STK_AGENT_RESULT_TERMINATE:
+	default:
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+		return;
+	}
+
+	stk_open_channel(stk);
+}
+
+static gboolean handle_command_open_channel(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	const struct stk_command_open_channel *oc =3D &cmd->open_channel;
+	struct ofono_atom *gprs_atom;
+	int err;
+
+	/* Check first if channel is available */
+	if (stk->bip.channel.id) {
+		unsigned char addnl_info[1];
+
+		addnl_info[0] =3D STK_RESULT_ADDNL_BIP_PB_NO_CHANNEL_AVAIL;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
+				addnl_info);
+		return TRUE;
+	}
+
+	gprs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
+	if (gprs_atom =3D=3D NULL || !__ofono_atom_get_registered(gprs_atom)) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	/*
+	 * Don't ask for user confirmation if AID is a null data object
+	 * or is not provided
+	 */
+	if (oc->alpha_id && oc->alpha_id[0] !=3D '\0') {
+		char *alpha_id;
+
+		alpha_id =3D dbus_apply_text_attributes(oc->alpha_id,
+								&oc->text_attr);
+		if (alpha_id =3D=3D NULL) {
+			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+			return TRUE;
+		}
+
+		err =3D stk_agent_confirm_open_channel(stk->current_agent,
+							alpha_id,
+							&oc->icon_id,
+							confirm_open_channel_cb,
+							stk, NULL,
+							stk->timeout * 1000);
+		g_free(alpha_id);
+
+		if (err < 0) {
+			unsigned char no_cause_result[] =3D { 0x00 };
+
+			ADD_ERROR_RESULT(rsp->result,
+						STK_RESULT_TYPE_TERMINAL_BUSY,
+						no_cause_result);
+			return TRUE;
+		}
+
+		return FALSE;
+	}
+
+	stk_open_channel(stk);
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -2794,6 +3020,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_OPEN_CHANNEL:
+		respond =3D handle_command_open_channel(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.1


--===============0697696535862920813==--

