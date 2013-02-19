Content-Type: multipart/mixed; boundary="===============1524927116811205071=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 10/11] hfp_audio: Add Agent "Unregister"
Date: Tue, 19 Feb 2013 17:44:51 -0300
Message-ID: <1361306692-959-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1524927116811205071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implements the "Unregister" method of the Handsfree Audio
Manager. The agent is unregistered if sender and path match.
---
 plugins/hfp_audio.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_audio.c b/plugins/hfp_audio.c
index a8e365c..f46d739 100644
--- a/plugins/hfp_audio.c
+++ b/plugins/hfp_audio.c
@@ -146,9 +146,33 @@ invalid_args:
 static DBusMessage *am_agent_unregister(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
-						".NotImplemented",
-						"Implementation not provided");
+	GSList *list;
+	const char *sender, *path;
+	struct agent match, *agent;
+	DBusMessageIter iter;
+
+	sender =3D dbus_message_get_sender(msg);
+
+	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
+		goto invalid_args;
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	match.owner =3D (char *) sender;
+	match.path =3D (char *) path;
+	list =3D g_slist_find_custom(agents, &match, agent_cmp);
+	if (list =3D=3D NULL)
+		goto invalid_args;
+
+	agent =3D list->data;
+	agents =3D g_slist_remove(agents, agent);
+	agent_free(agent);
+
+	return dbus_message_new_method_return(msg);
+
+invalid_args:
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
 }
 =

 static const GDBusMethodTable am_methods[] =3D {
-- =

1.7.11.7


--===============1524927116811205071==--

