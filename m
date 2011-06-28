Content-Type: multipart/mixed; boundary="===============7919479338047933990=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 07/11] stk: Add support for the proactive command 'Receive
 data'
Date: Tue, 28 Jun 2011 19:16:19 +0200
Message-ID: <1309281383-6605-8-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309281383-6605-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7919479338047933990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 133 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 9739e4b..5abc27c 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -31,6 +31,7 @@
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <unistd.h>
+#include <sys/ioctl.h>
 =

 #include <glib.h>
 #include <gdbus.h>
@@ -85,6 +86,7 @@ struct ofono_stk {
 	void *sms_pp_userdata;
 	struct stk_channel channel;
 	struct ofono_gprs_primary_context context;
+	gsize rx_remaining;
 	gsize tx_avail;
 	gboolean link_on_demand;
 	struct ofono_gprs *gprs;
@@ -124,6 +126,14 @@ static void timers_update(struct ofono_stk *stk);
  */
 #define DEFAULT_CHANNEL_ID 1
 =

+/*
+ * According the structure and coding of the Terminal response defined in
+ * TS 102 223 section 6.8, the maximum number of bytes possible for the ch=
annel
+ * data object is 243
+ */
+#define CHANNEL_DATA_OBJECT_MAX_LENGTH 243
+
+
 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			ofono_stk_generic_cb_t cb)
 {
@@ -534,6 +544,11 @@ static void stk_close_channel(struct ofono_stk *stk)
 {
 	int err;
 =

+	if (stk->read_watch > 0)
+		g_source_remove(stk->read_watch);
+	else if (stk->io)
+		g_io_channel_unref(stk->io);
+
 	err =3D __ofono_gprs_deactivate_context(stk->context.cid,
 			ofono_stk_deactivate_context_cb, stk);
 =

@@ -598,6 +613,31 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 static gboolean receive_callback(GIOChannel *channel, GIOCondition cond,
 				gpointer userdata)
 {
+	struct ofono_stk *stk =3D (struct ofono_stk *) userdata;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
+	if (cond & G_IO_IN) {
+		int fd =3D g_io_channel_unix_get_fd(channel);
+		int len =3D 0;
+
+		ioctl(fd, FIONREAD, &len);
+		DBG("%zd bytes to read", len);
+
+		/*
+		 * TODO
+		 * send data available event if the buffer is empty
+		 * when new data arrives in it
+		 */
+
+		stk->rx_remaining =3D len;
+
+		/* Disable the read watch until the SIM requests all bytes */
+		g_io_channel_ref(channel);
+		g_source_remove(stk->read_watch);
+		stk->read_watch =3D 0;
+	}
 	return TRUE;
 }
 =

@@ -775,6 +815,7 @@ static void stk_open_channel(struct ofono_stk *stk)
 =

 	stk->channel.id =3D DEFAULT_CHANNEL_ID;
 	stk->tx_avail =3D oc->buf_size;
+	stk->io =3D NULL;
 =

 	memset(&stk->context, 0, sizeof(stk->context));
 	stk->context.proto =3D OFONO_GPRS_PROTO_IP;
@@ -848,6 +889,61 @@ out:
 		stk_close_channel(stk);
 }
 =

+static void stk_receive_data(struct ofono_stk *stk, unsigned char toread)
+{
+	struct stk_response rsp;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	gsize bytes_read;
+	unsigned char buf[CHANNEL_DATA_OBJECT_MAX_LENGTH];
+	GIOStatus status;
+	int fd;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+
+	/* update bytes_to_read */
+	fd =3D g_io_channel_unix_get_fd(stk->io);
+	ioctl(fd, FIONREAD, &stk->rx_remaining);
+	DBG("%zd bytes to read", stk->rx_remaining);
+
+	if (stk->rx_remaining =3D=3D 0) {
+		rsp.result.type =3D STK_RESULT_TYPE_MISSING_INFO;
+		goto out;
+	}
+
+	if (toread > stk->rx_remaining) {
+		rsp.result.type =3D STK_RESULT_TYPE_MISSING_INFO;
+		toread =3D stk->rx_remaining;
+	}
+
+	if (toread > CHANNEL_DATA_OBJECT_MAX_LENGTH)
+		toread =3D CHANNEL_DATA_OBJECT_MAX_LENGTH;
+
+	status =3D g_io_channel_read_chars(stk->io, (gchar *)buf, toread,
+						&bytes_read, NULL);
+
+	if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN) {
+		rsp.result.type =3D STK_RESULT_TYPE_MISSING_INFO;
+		goto out;
+	}
+
+	rsp.receive_data.rx_data.len =3D bytes_read;
+	rsp.receive_data.rx_data.array =3D buf;
+	stk->rx_remaining -=3D bytes_read;
+	rsp.receive_data.rx_remaining =3D stk->rx_remaining;
+
+	if (stk->rx_remaining =3D=3D 0) {
+		stk->read_watch =3D g_io_add_watch_full(stk->io,
+					G_PRIORITY_DEFAULT,
+					G_IO_IN | G_IO_HUP | G_IO_ERR |
+					G_IO_NVAL, receive_callback, stk, NULL);
+		g_io_channel_unref(stk->io);
+	}
+
+out:
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+}
 =

 static int duration_to_msecs(const struct stk_duration *duration)
 {
@@ -3045,6 +3141,38 @@ static gboolean handle_command_close_channel(const s=
truct stk_command *cmd,
 	return FALSE;
 }
 =

+static gboolean handle_command_receive_data(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_receive_data *rd =3D &cmd->receive_data;
+
+	/* Check if channel identifier is valid or already closed */
+	if (cmd->dst !=3D (stk->channel.id | 0x20)) {
+		unsigned char addnl_info[1];
+
+		addnl_info[1] =3D STK_RESULT_ADDNL_BIP_PB_CHANNEL_ID_NOT_VALID;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
+					addnl_info);
+		return TRUE;
+	}
+
+	/*
+	 * Don't inform the user during data transfer if AID is
+	 * a null data object or is not provided
+	 */
+	if (rd->alpha_id && rd->alpha_id[0] !=3D '\0')
+		stk_alpha_id_set(stk, rd->alpha_id, &rd->text_attr,
+					&rd->icon_id);
+
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	stk_receive_data(stk, rd->data_len);
+
+	return FALSE;
+}
+
 static gboolean handle_command_get_channel_status(const struct stk_command=
 *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -3258,6 +3386,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_RECEIVE_DATA:
+		respond =3D handle_command_receive_data(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
 		respond =3D handle_command_get_channel_status(stk->pending_cmd,
 							&rsp, stk);
-- =

1.7.1


--===============7919479338047933990==--

