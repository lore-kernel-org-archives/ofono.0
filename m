Content-Type: multipart/mixed; boundary="===============2716151927384629357=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 04/10] Add server at command data structure
Date: Fri, 19 Mar 2010 17:44:42 +0800
Message-ID: <1268991888-17279-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268991888-17279-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2716151927384629357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   27 +++++++++++++++++++++++++++
 gatchat/gatserver.h |   22 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 0658553..6173765 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -88,6 +88,13 @@ struct v250_settings {
 	unsigned int c108;		/* set by &D<val> */
 };
 =

+/* AT command set that server supported */
+struct at_command {
+	GAtServerNotifyFunc notify;
+	gpointer user_data;
+	GDestroyNotify destroy_notify;
+};
+
 struct _GAtServer {
 	gint ref_count;				/* Ref count */
 	struct v250_settings v250;		/* V.250 command setting */
@@ -99,6 +106,7 @@ struct _GAtServer {
 	gpointer user_disconnect_data;		/* User disconnect data */
 	GAtDebugFunc debugf;			/* Debugging output function */
 	gpointer debug_data;			/* Data to pass to debug func */
+	GHashTable *command_list;		/* List of AT commands */
 	struct ring_buffer *read_buf;		/* Current read buffer */
 	GQueue *write_queue;			/* Write buffer queue */
 	guint max_read_attempts;		/* Max reads per select */
@@ -740,6 +748,9 @@ static void g_at_server_cleanup(GAtServer *server)
 	/* Cleanup pending data to write */
 	write_queue_free(server->write_queue);
 =

+	g_hash_table_destroy(server->command_list);
+	server->command_list =3D NULL;
+
 	server->channel =3D NULL;
 }
 =

@@ -785,6 +796,16 @@ static void v250_settings_create(struct v250_settings =
*v250)
 	v250->c108 =3D 0;
 }
 =

+static void at_notify_node_destroy(gpointer data)
+{
+	struct at_command *node =3D data;
+
+	if (node->destroy_notify)
+		node->destroy_notify(node->user_data);
+
+	g_free(node);
+}
+
 GAtServer *g_at_server_new(GIOChannel *io)
 {
 	GAtServer *server;
@@ -799,6 +820,9 @@ GAtServer *g_at_server_new(GIOChannel *io)
 	server->ref_count =3D 1;
 	v250_settings_create(&server->v250);
 	server->channel =3D io;
+	server->command_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+							g_free,
+							at_notify_node_destroy);
 	server->read_buf =3D ring_buffer_new(BUF_SIZE);
 	if (!server->read_buf)
 		goto error;
@@ -823,6 +847,9 @@ GAtServer *g_at_server_new(GIOChannel *io)
 	return server;
 =

 error:
+	if (server->command_list)
+		g_hash_table_destroy(server->command_list);
+
 	if (server->read_buf)
 		ring_buffer_free(server->read_buf);
 =

diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index 698f7e0..1c12a0d 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -26,6 +26,7 @@
 extern "C" {
 #endif
 =

+#include "gatresult.h"
 #include "gatutil.h"
 =

 struct _GAtServer;
@@ -46,6 +47,27 @@ enum _GAtServerResult {
 =

 typedef enum _GAtServerResult GAtServerResult;
 =

+/* Types of AT command:
+ * COMMAND_ONLY: command without any sub-parameters, e.g. ATA, AT+CLCC
+ * QUERY: command followed by '?', e.g. AT+CPIN?
+ * SUPPORT: command followed by '=3D?', e.g. AT+CSMS=3D?
+ * SET: command followed by '=3D', e.g. AT+CLIP=3D1
+ * 	or, basic command followed with sub-parameters, e.g. ATD12345;
+ */
+enum _GAtServerRequestType {
+	G_AT_SERVER_REQUEST_TYPE_ERROR,
+	G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY,
+	G_AT_SERVER_REQUEST_TYPE_QUERY,
+	G_AT_SERVER_REQUEST_TYPE_SUPPORT,
+	G_AT_SERVER_REQUEST_TYPE_SET,
+};
+
+typedef enum _GAtServerRequestType GAtServerRequestType;
+
+typedef GAtServerResult (*GAtServerNotifyFunc)(GAtServerRequestType type,
+						GAtResult *result,
+						gpointer user_data);
+
 GAtServer *g_at_server_new(GIOChannel *io);
 =

 GAtServer *g_at_server_ref(GAtServer *server);
-- =

1.6.6.1


--===============2716151927384629357==--

