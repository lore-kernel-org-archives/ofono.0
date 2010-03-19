Content-Type: multipart/mixed; boundary="===============2594568419056275873=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 06/10] Add g_at_server_register and unregister callback
Date: Fri, 19 Mar 2010 17:44:44 +0800
Message-ID: <1268991888-17279-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268991888-17279-6-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2594568419056275873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 gatchat/gatserver.h |    6 ++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 3f60f1c..1ffc2c3 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -987,3 +987,51 @@ gboolean g_at_server_set_debug(GAtServer *server, GAtD=
ebugFunc func,
 =

 	return TRUE;
 }
+
+gboolean g_at_server_register(GAtServer *server, char *prefix,
+					GAtServerNotifyFunc notify,
+					gpointer user_data,
+					GDestroyNotify destroy_notify)
+{
+	struct at_command *node;
+
+	if (server =3D=3D NULL || server->command_list =3D=3D NULL)
+		return FALSE;
+
+	if (notify =3D=3D NULL)
+		return FALSE;
+
+	if (prefix =3D=3D NULL || strlen(prefix) =3D=3D 0)
+		return FALSE;
+
+	node =3D g_try_new0(struct at_command, 1);
+	if (!node)
+		return FALSE;
+
+	node->notify =3D notify;
+	node->user_data =3D user_data;
+	node->destroy_notify =3D destroy_notify;
+
+	g_hash_table_replace(server->command_list, g_strdup(prefix), node);
+
+	return TRUE;
+}
+
+gboolean g_at_server_unregister(GAtServer *server, const char *prefix)
+{
+	struct at_command *node;
+
+	if (server =3D=3D NULL || server->command_list =3D=3D NULL)
+		return FALSE;
+
+	if (prefix =3D=3D NULL || strlen(prefix) =3D=3D 0)
+		return FALSE;
+
+	node =3D g_hash_table_lookup(server->command_list, prefix);
+	if (!node)
+		return FALSE;
+
+	g_hash_table_remove(server->command_list, prefix);
+
+	return TRUE;
+}
diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index 1c12a0d..5e9eb62 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -81,6 +81,12 @@ gboolean g_at_server_set_debug(GAtServer *server,
 					GAtDebugFunc func,
 					gpointer user);
 =

+gboolean g_at_server_register(GAtServer *server, char *prefix,
+					GAtServerNotifyFunc notify,
+					gpointer user_data,
+					GDestroyNotify destroy_notify);
+gboolean g_at_server_unregister(GAtServer *server, const char *prefix);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.6.6.1


--===============2594568419056275873==--

