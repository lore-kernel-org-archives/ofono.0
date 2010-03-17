Content-Type: multipart/mixed; boundary="===============5148800823234227667=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 6/6] Add voice call test case for GAtServer
Date: Wed, 17 Mar 2010 22:44:11 +0800
Message-ID: <1268837051-5032-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268837051-5032-6-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5148800823234227667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It simulates a simple voice call with client. Client could use ATD
to dial out a call and Server could use a pseudo command 'AT+INCM'
to notify an incoming call.
---
 gatchat/test-server.c |  419 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 419 insertions(+), 0 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index fdb7475..0485f39 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -46,9 +46,16 @@
 #include "gatserver.h"
 #include "ringbuffer.h"
 =

+#include "ofono/types.h"
+
 #define DEFAULT_TCP_PORT 12346
 #define DEFAULT_SOCK_PATH "./server_sock"
 =

+#define INCOMING_CALL "1234567890"
+#define TIMEOUT_INTERVAL 2000
+#define TIMEOUT_DIAL 10000
+#define TIMEOUT_INCOMING 10000
+
 struct sock_server{
 	int server_sock;
 };
@@ -57,8 +64,45 @@ static GMainLoop *mainloop;
 static GAtServer *server;
 unsigned int server_watch;
 =

+unsigned int outgoing_source;
+unsigned int outgoing_timeout;
+unsigned int incoming_source;
+unsigned int incoming_timeout;
+unsigned int call_ids;
+static GSList *call_list;
+
+static void release_id(int id)
+{
+	call_ids &=3D ~(0x1 << id);
+}
+
+static void voicecall_destroy(gpointer data, gpointer user_data)
+{
+	struct ofono_call *call =3D data;
+
+	if (call) {
+		if (call->direction =3D=3D 0 && outgoing_source) {
+			g_source_remove(outgoing_source);
+			outgoing_source =3D 0;
+		} else if (call->direction =3D=3D 1 && incoming_source) {
+			g_source_remove(incoming_source);
+			incoming_source =3D 0;
+		}
+
+		release_id(call->id);
+	}
+
+	g_free(call);
+}
+
 static gboolean server_cleanup()
 {
+	if (call_list) {
+		g_slist_foreach(call_list, voicecall_destroy, NULL);
+		g_slist_free(call_list);
+		call_list =3D NULL;
+	}
+
 	if (server_watch)
 		g_source_remove(server_watch);
 =

@@ -77,9 +121,384 @@ static void server_debug(const char *str, void *data)
 	g_print("%s: %s\n", (char *) data, str);
 }
 =

+static unsigned int alloc_next_id()
+{
+	unsigned int i;
+
+	for (i =3D 1; i < sizeof(call_ids) * 8; i++) {
+		if (call_ids & (0x1 << i))
+			continue;
+
+		return i;
+	}
+
+	return 0;
+}
+
+static struct ofono_call *create_call(int type, int direction, int status,
+					const char *num, int num_type, int clip)
+{
+	struct ofono_call *call;
+
+	call =3D g_try_new0(struct ofono_call, 1);
+	if (!call)
+		return NULL;
+
+	call->id =3D alloc_next_id();
+	call->type =3D type;
+	call->direction =3D direction;
+	call->status =3D status;
+
+	if (clip !=3D 2) {
+		strncpy(call->phone_number.number, num,
+			OFONO_MAX_PHONE_NUMBER_LENGTH);
+		call->phone_number.type =3D num_type;
+	}
+
+	call->clip_validity =3D clip;
+
+	call_list =3D g_slist_prepend(call_list, call);
+
+	return call;
+}
+
+static void list_calls(GAtServer *server)
+{
+	GSList *text =3D NULL;
+	GSList *l;
+	char buf[512];
+	gboolean is_mpty =3D FALSE;
+
+	/* No calls */
+	if (!call_list)
+		return;
+
+	if (g_slist_length(call_list) > 1)
+		is_mpty =3D TRUE;
+
+	for (l =3D call_list; l; l =3D l->next) {
+		struct ofono_call *call =3D l->data;
+
+		/* +CLCC: <id>,<dir>,<stat>,<mode>,<mpty>[<number>,<type>] */
+		sprintf(buf, "+CLCC: %d,%d,%d,%d,%d,%s,%d",
+						call->id, call->direction,
+						call->status, call->type,
+						call->mpty,
+						call->phone_number.number,
+						call->phone_number.type);
+
+		text =3D g_slist_append(text, g_strdup(buf));
+	}
+
+	g_at_server_send_info_text(server, text);
+
+	g_slist_foreach(text, (GFunc) g_free, NULL);
+	g_slist_free(text);
+}
+
+static GAtServerResult at_clcc_cb(GAtServerRequestType type, GAtResult *re=
sult,
+					gpointer user_data)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtResultIter iter;
+	GAtServer *server =3D user_data;
+
+	if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_SUPPORT) {
+		res =3D G_AT_SERVER_RESULT_OK;
+		goto done;
+	}
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CLCC"))
+		goto done;
+
+	list_calls(server);
+
+	res =3D G_AT_SERVER_RESULT_OK;
+
+done:
+	return res;
+}
+
+static gboolean hangup_current()
+{
+	struct ofono_call *call;
+
+	if (!call_list)
+		return FALSE;
+
+	call =3D call_list->data;
+	call_list =3D g_slist_remove(call_list, call);
+	voicecall_destroy(call, NULL);
+
+	return TRUE;
+}
+
+static gboolean hangup_specific(struct ofono_call *call)
+{
+	if (!call_list)
+		return FALSE;
+
+	call_list =3D g_slist_remove(call_list, call);
+	voicecall_destroy(call, NULL);
+
+	return TRUE;
+}
+
+static gboolean dial_timeout(gpointer user_data)
+{
+	struct ofono_call *call =3D user_data;
+
+	hangup_specific(call);
+
+	if (outgoing_source) {
+		g_source_remove(outgoing_source);
+		outgoing_source =3D 0;
+	}
+
+	outgoing_timeout =3D 0;
+
+	return FALSE;
+}
+
+static GAtServerResult dial_voicecall(const char *dial_str)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	char c;
+	char *number;
+	int len =3D strlen(dial_str);
+	struct ofono_call *call;
+
+	/* Skip last comma */
+	len--;
+
+	c =3D dial_str[len-1];
+	/* Skip closed user group flag */
+	if (c =3D=3D 'G' || c =3D=3D 'g')
+		len--;
+
+	c =3D dial_str[len-1];
+	/* Skip caller id suppress flag */
+	if (c =3D=3D 'I' || c =3D=3D 'i')
+		len--;
+
+	number =3D g_strndup(dial_str, len);
+
+	call =3D create_call(0, 0, 2, number, 129, 0);
+	if (!call)
+		goto done;
+
+	outgoing_timeout =3D g_timeout_add(TIMEOUT_DIAL,
+					(GSourceFunc) dial_timeout,
+					call);
+
+	res =3D G_AT_SERVER_RESULT_OK;
+
+done:
+	if (number)
+		g_free(number);
+
+	return res;
+}
+
+static GAtServerResult dial_call(GAtServer *server, const char *dial_str)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	int len =3D strlen(dial_str);
+
+	if (dial_str[0] =3D=3D '*' || dial_str[0] =3D=3D '#') {
+		/* Supplementary service request */
+		sleep(2);
+		g_at_server_send_intermediate(server, "CONNECT");
+		sleep(2);
+		res =3D G_AT_SERVER_RESULT_OK;
+		goto done;
+	}
+
+	if (dial_str[len-1] =3D=3D ';') {
+		/* Voice call */
+		res =3D dial_voicecall(dial_str);
+
+	}
+
+done:
+	return res;
+}
+
+static GAtServerResult dial_cb(GAtServerRequestType type, GAtResult *resul=
t,
+					gpointer user_data)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtResultIter iter;
+	const char *dial_str;
+	GAtServer *server =3D user_data;
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "D"))
+		goto done;
+
+	dial_str =3D g_at_result_iter_raw_line(&iter);
+	if (!dial_str)
+		goto done;
+
+	if (outgoing_source) {
+		g_source_remove(outgoing_source);
+		outgoing_source =3D 0;
+	}
+
+	res =3D dial_call(server, dial_str);
+
+done:
+	return res;
+}
+
+static GAtServerResult at_chup_cb(GAtServerRequestType type, GAtResult *re=
sult,
+					gpointer user_data)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtResultIter iter;
+
+	if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_SUPPORT) {
+		res =3D G_AT_SERVER_RESULT_OK;
+		goto done;
+	}
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CHUP"))
+		goto done;
+
+	if (!hangup_current())
+		goto done;
+
+	res =3D G_AT_SERVER_RESULT_OK;
+
+done:
+	return res;
+}
+
+static GAtServerResult answer_cb(GAtServerRequestType type, GAtResult *res=
ult,
+					gpointer user_data)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtResultIter iter;
+	struct ofono_call *call;
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "A"))
+		goto done;
+
+	if (incoming_source) {
+		g_source_remove(incoming_source);
+		incoming_source =3D 0;
+	}
+
+	if (!call_list)
+		goto done;
+
+	call =3D call_list->data;
+	call->status =3D 0;
+
+	res =3D G_AT_SERVER_RESULT_OK;
+
+done:
+	return res;
+}
+
+static gboolean ring_timeout(gpointer user_data)
+{
+	struct ofono_call *call =3D user_data;
+
+	hangup_specific(call);
+
+	if (incoming_source) {
+		g_source_remove(incoming_source);
+		incoming_source =3D 0;
+	}
+
+	incoming_timeout =3D 0;
+
+	return FALSE;
+}
+
+static gboolean ring_notify(gpointer user_data)
+{
+	GAtServer *server =3D user_data;
+	char buf[100];
+
+	/* Notify a new incoming call to client */
+	g_at_server_send_unsolicited(server, "RING");
+
+	sprintf(buf, "+CLIP: \"%s\",129", INCOMING_CALL);
+	g_at_server_send_unsolicited(server, buf);
+
+	return TRUE;
+}
+
+static GAtServerResult at_incm_cb(GAtServerRequestType type, GAtResult *re=
sult,
+					gpointer user_data)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtResultIter iter;
+	GAtServer *server =3D user_data;
+	struct ofono_call *call;
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+INCM"))
+		goto done;
+
+	/* Remove existing incoming call if exists */
+	if (incoming_source) {
+		g_source_remove(incoming_source);
+		incoming_source =3D 0;
+	}
+
+	call =3D create_call(0, 1, 4, INCOMING_CALL, 129, 0);
+	if (!call)
+		goto done;
+
+	incoming_source =3D g_timeout_add(TIMEOUT_INTERVAL,
+					(GSourceFunc) ring_notify, server);
+
+	incoming_timeout =3D g_timeout_add(TIMEOUT_INCOMING,
+					(GSourceFunc) ring_timeout, call);
+
+	res =3D G_AT_SERVER_RESULT_OK;
+
+done:
+	return res;
+}
+
 static void add_handler(GAtServer *server)
 {
 	g_at_server_set_debug(server, server_debug, "Server");
+
+	g_at_server_register(server, "D", dial_cb, server, NULL);
+	g_at_server_register(server, "A", answer_cb, server, NULL);
+	g_at_server_register(server, "+CLCC", at_clcc_cb, server, NULL);
+	g_at_server_register(server, "+CHUP", at_chup_cb, server, NULL);
+
+	/* Psuedo command to notify an incoming call to the client */
+	g_at_server_register(server, "+INCM", at_incm_cb, server, NULL);
 }
 =

 static void server_destroy(gpointer user)
-- =

1.6.6.1


--===============5148800823234227667==--

