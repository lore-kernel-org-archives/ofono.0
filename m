Content-Type: multipart/mixed; boundary="===============2556567364430869336=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 08/12] Do not set signature and reply in GDBus tables
Date: Fri, 18 May 2012 16:44:08 -0300
Message-ID: <1337370252-29346-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337370252-29346-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2556567364430869336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use GDBUS_* macros, so signature and reply fields are not set in each
method/signal.
---
 plugins/ofono.c |    4 ++--
 src/service.c   |   25 +++++++++++--------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index fcdb228..45fac91 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -115,11 +115,11 @@ static DBusMessage *agent_release(DBusConnection *con=
n,
 }
 =

 static const GDBusMethodTable agent_methods[] =3D {
-	{ _GDBUS_METHOD("ReceiveNotification", "aya{sv}", "",
+	{ GDBUS_METHOD("ReceiveNotification",
 			GDBUS_ARGS({ "notification", "ay" },
 						{ "info", "a{sv}" }),
 			NULL, agent_receive) },
-	{ _GDBUS_NOREPLY_METHOD("Release", "", "", NULL, NULL, agent_release) },
+	{ GDBUS_NOREPLY_METHOD("Release", NULL, NULL, agent_release) },
 	{ }
 };
 =

diff --git a/src/service.c b/src/service.c
index 669d10e..83e1fe1 100644
--- a/src/service.c
+++ b/src/service.c
@@ -223,13 +223,13 @@ static DBusMessage *msg_mark_read(DBusConnection *con=
n,
 }
 =

 static const GDBusMethodTable message_methods[] =3D {
-	{ _GDBUS_METHOD("MarkRead", "", "", NULL, NULL, msg_mark_read) },
-	{ _GDBUS_METHOD("Delete", "", "", NULL, NULL, msg_delete) },
+	{ GDBUS_METHOD("MarkRead", NULL, NULL, msg_mark_read) },
+	{ GDBUS_METHOD("Delete", NULL, NULL, msg_delete) },
 	{ }
 };
 =

 static const GDBusSignalTable message_signals[] =3D {
-	{ _GDBUS_SIGNAL("PropertyChanged", "sv",
+	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
@@ -981,16 +981,16 @@ release_msg:
 }
 =

 static const GDBusMethodTable service_methods[] =3D {
-	{ _GDBUS_METHOD("SendMessage", "assa(sss)", "o",
+	{ GDBUS_METHOD("SendMessage",
 			GDBUS_ARGS({ "recipients", "as" }, { "smil", "s" },
 						{ "attachments", "a(sss)" }),
 			GDBUS_ARGS({ "path", "o" }),
 			send_message) },
-	{ _GDBUS_METHOD("GetMessages", "", "a(oa{sv})",
+	{ GDBUS_METHOD("GetMessages",
 			NULL,
 			GDBUS_ARGS({ "messages_with_properties", "a(oa{sv})" }),
 			get_messages) },
-	{ _GDBUS_METHOD("GetConversation", "su", "a(oa{sv})",
+	{ GDBUS_METHOD("GetConversation",
 			GDBUS_ARGS({ "number", "s" }, { "count", "s" }),
 			GDBUS_ARGS({ "messages_with_properties", "a(oa{sv}" }),
 			get_conversation) },
@@ -998,10 +998,9 @@ static const GDBusMethodTable service_methods[] =3D {
 };
 =

 static const GDBusSignalTable service_signals[] =3D {
-	{ _GDBUS_SIGNAL("MessageAdded", "oa{sv}",
-				GDBUS_ARGS({ "path", "o" },
+	{ GDBUS_SIGNAL("MessageAdded", GDBUS_ARGS({ "path", "o" },
 						{ "properties", "a{sv}" })) },
-	{ _GDBUS_SIGNAL("MessageRemoved", "o", GDBUS_ARGS({ "path", "o" })) },
+	{ GDBUS_SIGNAL("MessageRemoved", GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
 =

@@ -2356,18 +2355,16 @@ static DBusMessage *get_services(DBusConnection *co=
nn,
 }
 =

 static const GDBusMethodTable manager_methods[] =3D {
-	{ _GDBUS_METHOD("GetServices", "", "a(oa{sv})",
-			NULL,
+	{ GDBUS_METHOD("GetServices", NULL,
 			GDBUS_ARGS({ "services_with_properties", "a(oa{sv})" }),
 			get_services) },
 	{ }
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ _GDBUS_SIGNAL("ServiceAdded", "oa{sv}",
-				GDBUS_ARGS({ "path", "o" },
+	{ GDBUS_SIGNAL("ServiceAdded", GDBUS_ARGS({ "path", "o" },
 						{ "properties", "a{sv}" })) },
-	{ _GDBUS_SIGNAL("ServiceRemoved", "o", GDBUS_ARGS({ "path", "o" })) },
+	{ GDBUS_SIGNAL("ServiceRemoved", GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
 =

-- =

1.7.10.2


--===============2556567364430869336==--

