Content-Type: multipart/mixed; boundary="===============5974453247390812196=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 7/7] Add g_at_server_register to register callback
Date: Wed, 03 Mar 2010 22:56:52 +0800
Message-ID: <1267628212-14079-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267628212-14079-6-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5974453247390812196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 gatchat/gatserver.h |    6 ++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index bea51f5..c49e5f8 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -987,3 +987,50 @@ gboolean g_at_server_set_debug(GAtServer *server, GAtD=
ebugFunc func,
 =

 	return TRUE;
 }
+
+guint g_at_server_register(GAtServer *server, const char *prefix,
+					GAtServerCommandType type,
+					GAtServerNotifyFunc notify,
+					gpointer user_data,
+					GDestroyNotify destroy_notify)
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
+	node->type =3D type;
+	node->notify =3D notify;
+	node->user_data =3D user_data;
+	node->destroy_notify =3D destroy_notify;
+
+	g_hash_table_insert(server->command_list, node->prefix, node);
+
+	return node->id;
+}
diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index 5db9321..59cdf25 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -80,6 +80,12 @@ gboolean g_at_server_set_debug(GAtServer *server,
 					GAtDebugFunc func,
 					gpointer user);
 =

+guint g_at_server_register(GAtServer *server, const char *prefix,
+					GAtServerCommandType type,
+					GAtServerNotifyFunc notify,
+					gpointer user_data,
+					GDestroyNotify destroy_notify);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.6.6.1


--===============5974453247390812196==--

