Content-Type: multipart/mixed; boundary="===============2998938212732369254=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/4] Add AT command parsing support and interface
Date: Mon, 11 Jan 2010 18:53:49 +0800
Message-ID: <1263207230-22036-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1263207230-22036-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2998938212732369254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add parsing support for server supported AT commands. Also add
APIs to add/remove notification functions.
---
 gatchat/gatserver.c |  225 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 gatchat/gatserver.h |   23 +++++
 2 files changed, 247 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index e861e25..602e509 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -67,12 +67,24 @@ struct v250_settings {
 	unsigned int c108;		/* set by &D<val> */
 };
 =

+/* AT command that server supported */
+struct at_command {
+	int id;
+	char *prefix;
+	gboolean expect_pdu;
+	GAtServerNotifyFunc notify;
+	gpointer user_data;
+	GDestroyNotify destroy_notify;
+};
+
 struct _GAtServer {
 	gint ref_count;				/* Ref count */
 	struct v250_settings *v250;		/* V.250 command setting */
 	GIOChannel *server_io;			/* Server IO */
 	int server_watch;			/* Watch for server IO */
 	char *modem_path;			/* Emulated modem path */
+	GHashTable *command_list;		/* Server supported commands */
+	gint next_command_id;			/* Id for next command */
 	GAtDisconnectFunc user_disconnect;	/* User disconnect func */
 	gpointer user_disconnect_data;		/* User disconnect data */
 	GAtDebugFunc debugf;			/* Debugging output function */
@@ -128,6 +140,112 @@ static gsize skip_space(const char *buf, gsize pos)
 	return i;
 }
 =

+static inline gboolean is_at_command_prefix(const char c)
+{
+	if (c =3D=3D '&')
+		return FALSE;
+
+	return g_ascii_ispunct(c);
+}
+
+static gchar *get_at_command_prefix(gchar *command, GAtServerRequestType *=
type)
+{
+	char c =3D g_ascii_toupper(*command);
+	gchar *prefix;
+	gchar *equal;
+	gchar *question;
+
+	/* Try to match command in ATA, ATD or ATH */
+	if (c =3D=3D 'A' || c =3D=3D 'D' || c =3D=3D 'H') {
+		*type =3D G_AT_SERVER_REQUEST_TYPE_ACTION;
+
+		prefix =3D g_strdup(command);
+	} else if (is_at_command_prefix(c)) {
+		command++;
+
+		equal =3D strchr(command, '=3D');
+		question =3D strchr(command, '?');
+
+		/* Try to match AT+XXX=3D?, AT+XXX=3D, AT+XXX? or AT+XXX */
+		if (equal) {
+			if (question)
+				*type =3D G_AT_SERVER_REQUEST_TYPE_SUPPORT;
+			else
+				*type =3D G_AT_SERVER_REQUEST_TYPE_SET;
+
+			/* It shouldn't happen but we still check it */
+			if (question !=3D equal + 1)
+				return G_AT_SERVER_REQUEST_TYPE_NONE;
+
+			prefix =3D g_strndup(command, equal - command);
+		} else if (question) {
+			*type =3D G_AT_SERVER_REQUEST_TYPE_QUERY;
+
+			prefix =3D g_strndup(command, question - command);
+		} else {
+			*type =3D G_AT_SERVER_REQUEST_TYPE_ACTION;
+
+			prefix =3D g_strdup(command);
+		}
+	}
+
+	return prefix;
+}
+
+static int parse_at_command(GAtServer *server, char *buf)
+{
+	int res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtServerRequestType type =3D G_AT_SERVER_REQUEST_TYPE_NONE;
+	gchar t =3D server->v250->s3;
+	gsize i =3D 0;
+	gchar *command =3D NULL;
+	gchar *prefix =3D NULL;
+	struct at_command *node;
+
+	while (buf[i] !=3D t && buf[i] !=3D ';')
+		i++;
+
+	command =3D g_strndup(buf, i);
+
+	prefix =3D get_at_command_prefix(command, &type);
+
+	if (G_AT_SERVER_REQUEST_TYPE_NONE =3D=3D type)
+		goto out;
+
+	node =3D g_hash_table_lookup(server->command_list, prefix);
+
+	if (node && node->notify) {
+		if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_SUPPORT)
+			res =3D G_AT_SERVER_RESULT_OK;
+		else {
+			GAtResult *result =3D g_try_new0(GAtResult, 1);
+
+			if (!result)
+				goto out;
+
+			result->lines =3D g_slist_prepend(NULL, command);
+			result->final_or_pdu =3D NULL;
+
+			res =3D node->notify(type, result, node->user_data);
+
+			g_free(result);
+		}
+	}
+
+	/* Compound command */
+	if ((res =3D=3D G_AT_SERVER_RESULT_OK) && (buf[i] =3D=3D ';'))
+		res =3D at_server_parse(server, buf + i);
+
+out:
+	if (prefix)
+		g_free(prefix);
+
+	if (command)
+		g_free(command);
+
+	return res;
+}
+
 static int parse_v250_settings(GAtServer *server, char *buf)
 {
 	int res =3D G_AT_SERVER_RESULT_ERROR;
@@ -150,7 +268,9 @@ static int at_server_parse(GAtServer *server, char *buf)
 	if (c =3D=3D ';')
 		c =3D buf[++i];
 =

-	if (g_ascii_isalpha(c) || c =3D=3D '&')
+	if (is_at_command_prefix(c) || c =3D=3D 'A' || c =3D=3D 'D' || c =3D=3D '=
H')
+		res =3D parse_at_command(server, buf + i);
+	else if (g_ascii_isalpha(c) || c =3D=3D '&')
 		res =3D parse_v250_settings(server, buf + i);
 	else if (c =3D=3D v250->s3)
 		res =3D G_AT_SERVER_RESULT_OK;
@@ -305,6 +425,8 @@ GAtServer *g_at_server_new(GIOChannel *io, const char *=
modem_path)
 	server->v250 =3D v250_settings_create();
 	server->server_io =3D io;
 	server->modem_path =3D g_strdup(modem_path);
+	server->command_list =3D g_hash_table_new(g_str_hash, g_str_equal);
+	server->next_command_id =3D 1;
 	server->user_disconnect =3D NULL;
 	server->user_disconnect_data =3D NULL;
 	server->debugf =3D NULL;
@@ -331,6 +453,9 @@ error:
 	if (server->buf)
 		ring_buffer_free(server->buf);
 =

+	if (server->command_list)
+		g_hash_table_destroy(server->command_list);
+
 	if (server->modem_path)
 		g_free(server->modem_path);
 =

@@ -379,6 +504,10 @@ gboolean g_at_server_shutdown(GAtServer *server)
 	if (server->v250)
 		g_free(server->v250);
 =

+	g_at_server_remove_all(server);
+
+	g_hash_table_destroy(server->command_list);
+
 	ring_buffer_free(server->buf);
 	server->buf =3D NULL;
 =

@@ -426,3 +555,97 @@ gboolean g_at_server_set_debug(GAtServer *server, GAtD=
ebugFunc func,
 =

 	return TRUE;
 }
+
+guint g_at_server_add_command(GAtServer *server, const char *prefix,
+						gboolean expect_pdu,
+						GAtServerNotifyFunc notify,
+						gpointer user_data,
+						GDestroyNotify destroy_notify)
+{
+	struct at_command *node;
+
+	if (server =3D=3D NULL || server->command_list =3D=3D NULL)
+		return 0;
+
+	if (notify =3D=3D NULL)
+		return 0;
+
+	if (prefix =3D=3D NULL || strlen(prefix) =3D=3D 0)
+		return 0;
+
+	node =3D g_hash_table_lookup(server->command_list, prefix);
+
+	if (node) {
+		g_hash_table_remove(server->command_list, prefix);
+
+		if (node->destroy_notify)
+			node->destroy_notify(node->user_data);
+
+		g_free(node->prefix);
+
+		g_free(node);
+	}
+
+	node =3D g_try_new0(struct at_command, 1);
+
+	if (!node)
+		return 0;
+
+	node->id =3D server->next_command_id++;
+	node->prefix =3D g_strdup(prefix);
+	node->expect_pdu =3D expect_pdu;
+	node->notify =3D notify;
+	node->user_data =3D user_data;
+	node->destroy_notify =3D destroy_notify;
+
+	g_hash_table_insert(server->command_list, node->prefix, node);
+
+	return node->id;
+}
+
+static gboolean at_server_remove_command(gpointer key, gpointer value,
+						gpointer user)
+{
+	struct at_command *node =3D value;
+
+	if (node->destroy_notify)
+		node->destroy_notify(node->user_data);
+
+	g_free(node->prefix);
+
+	g_free(node);
+
+	return TRUE;
+}
+
+gboolean g_at_server_remove_command(GAtServer *server, char *prefix)
+{
+	struct at_command *node;
+	gpointer key =3D prefix;
+
+	if (!server || !server->command_list)
+		return FALSE;
+
+	node =3D g_hash_table_lookup(server->command_list, key);
+
+	if (!node)
+		return FALSE;
+
+	g_hash_table_remove(server->command_list, key);
+
+	at_server_remove_command(prefix, node, node);
+
+	return TRUE;
+}
+
+gboolean g_at_server_remove_all(GAtServer *server)
+{
+	if (!server || !server->command_list)
+		return FALSE;
+
+	g_hash_table_foreach_remove(server->command_list,
+					at_server_remove_command, server);
+
+	return TRUE;
+}
+
diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index 39916ec..7b68d8a 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -45,6 +45,21 @@ enum _GAtServerResultCodes {
 	G_AT_SERVER_RESULT_CONNECT_EXT,
 };
 =

+enum _GAtServerRequestType {
+	G_AT_SERVER_REQUEST_TYPE_NONE =3D 0,
+	G_AT_SERVER_REQUEST_TYPE_SET,
+	G_AT_SERVER_REQUEST_TYPE_SUPPORT,
+	G_AT_SERVER_REQUEST_TYPE_QUERY,
+	G_AT_SERVER_REQUEST_TYPE_ACTION,
+};
+
+typedef enum _GAtServerRequestType GAtServerRequestType;
+
+typedef int (*GAtServerNotifyFunc)(GAtServerRequestType type,
+					GAtResult *result,
+					gpointer user_data);
+
+
 GAtServer *g_at_server_new(GIOChannel *io, const char *modem_path);
 =

 GAtServer *g_at_server_ref(GAtServer *server);
@@ -58,6 +73,14 @@ gboolean g_at_server_set_debug(GAtServer *server,
 					GAtDebugFunc func,
 					gpointer user);
 =

+guint g_at_server_add_command(GAtServer *server, const char *prefix,
+					gboolean expect_pdu,
+					GAtServerNotifyFunc notify,
+					gpointer user_data,
+					GDestroyNotify destroy);
+gboolean g_at_server_remove_command(GAtServer *server, char *prefix);
+gboolean g_at_server_remove_all(GAtServer *server);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.6.3.3


--===============2998938212732369254==--

