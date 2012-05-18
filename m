Content-Type: multipart/mixed; boundary="===============0985982811275552305=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 05/12] Convert GDBus methods to use macro helpers
Date: Fri, 18 May 2012 16:59:52 -0300
Message-ID: <1337371199-29496-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337371199-29496-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0985982811275552305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With these macro helpers we can separate in/out arguments and use their
own vector.
---
 plugins/ofono.c |    8 +++++---
 src/service.c   |   40 +++++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 29e8f06..fcdb228 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -115,9 +115,11 @@ static DBusMessage *agent_release(DBusConnection *conn,
 }
 =

 static const GDBusMethodTable agent_methods[] =3D {
-	{ "ReceiveNotification", "aya{sv}", "", agent_receive },
-	{ "Release",             "",        "", agent_release,
-						G_DBUS_METHOD_FLAG_NOREPLY },
+	{ _GDBUS_METHOD("ReceiveNotification", "aya{sv}", "",
+			GDBUS_ARGS({ "notification", "ay" },
+						{ "info", "a{sv}" }),
+			NULL, agent_receive) },
+	{ _GDBUS_NOREPLY_METHOD("Release", "", "", NULL, NULL, agent_release) },
 	{ }
 };
 =

diff --git a/src/service.c b/src/service.c
index a269556..669d10e 100644
--- a/src/service.c
+++ b/src/service.c
@@ -223,13 +223,14 @@ static DBusMessage *msg_mark_read(DBusConnection *con=
n,
 }
 =

 static const GDBusMethodTable message_methods[] =3D {
-	{ "MarkRead", "", "", msg_mark_read },
-	{ "Delete",   "", "", msg_delete },
+	{ _GDBUS_METHOD("MarkRead", "", "", NULL, NULL, msg_mark_read) },
+	{ _GDBUS_METHOD("Delete", "", "", NULL, NULL, msg_delete) },
 	{ }
 };
 =

 static const GDBusSignalTable message_signals[] =3D {
-	{ "PropertyChanged", "sv" },
+	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

@@ -980,15 +981,27 @@ release_msg:
 }
 =

 static const GDBusMethodTable service_methods[] =3D {
-	{ "SendMessage", "assa(sss)", "o", send_message },
-	{ "GetMessages", "", "a(oa{sv})", get_messages },
-	{ "GetConversation", "su", "a(oa{sv})", get_conversation },
+	{ _GDBUS_METHOD("SendMessage", "assa(sss)", "o",
+			GDBUS_ARGS({ "recipients", "as" }, { "smil", "s" },
+						{ "attachments", "a(sss)" }),
+			GDBUS_ARGS({ "path", "o" }),
+			send_message) },
+	{ _GDBUS_METHOD("GetMessages", "", "a(oa{sv})",
+			NULL,
+			GDBUS_ARGS({ "messages_with_properties", "a(oa{sv})" }),
+			get_messages) },
+	{ _GDBUS_METHOD("GetConversation", "su", "a(oa{sv})",
+			GDBUS_ARGS({ "number", "s" }, { "count", "s" }),
+			GDBUS_ARGS({ "messages_with_properties", "a(oa{sv}" }),
+			get_conversation) },
 	{ }
 };
 =

 static const GDBusSignalTable service_signals[] =3D {
-	{ "MessageAdded",   "oa{sv}" },
-	{ "MessageRemoved", "o" },
+	{ _GDBUS_SIGNAL("MessageAdded", "oa{sv}",
+				GDBUS_ARGS({ "path", "o" },
+						{ "properties", "a{sv}" })) },
+	{ _GDBUS_SIGNAL("MessageRemoved", "o", GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
 =

@@ -2343,13 +2356,18 @@ static DBusMessage *get_services(DBusConnection *co=
nn,
 }
 =

 static const GDBusMethodTable manager_methods[] =3D {
-	{ "GetServices", "", "a(oa{sv})", get_services },
+	{ _GDBUS_METHOD("GetServices", "", "a(oa{sv})",
+			NULL,
+			GDBUS_ARGS({ "services_with_properties", "a(oa{sv})" }),
+			get_services) },
 	{ }
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ "ServiceAdded",   "oa{sv}" },
-	{ "ServiceRemoved", "o"      },
+	{ _GDBUS_SIGNAL("ServiceAdded", "oa{sv}",
+				GDBUS_ARGS({ "path", "o" },
+						{ "properties", "a{sv}" })) },
+	{ _GDBUS_SIGNAL("ServiceRemoved", "o", GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
 =

-- =

1.7.10.2


--===============0985982811275552305==--

