Content-Type: multipart/mixed; boundary="===============1426026204698077253=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 01/12] Constify GDBus tables
Date: Fri, 18 May 2012 16:59:48 -0300
Message-ID: <1337371199-29496-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1426026204698077253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Constify method tables with the following commands:

find . -name '*.[ch]' -exec sed -i \
	     's/\(c\)\(GDBusSignalTable .* =3D\)/\1 const \2/g' {} \;

find . -name '*.[ch]' -exec sed -i \
	     's/\(c\)\(GDBusMethodTable .* =3D\)/\1 const \2/g' {} \;
---
 plugins/ofono.c |    2 +-
 src/service.c   |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index f598c5e..29e8f06 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -114,7 +114,7 @@ static DBusMessage *agent_release(DBusConnection *conn,
 	return NULL;
 }
 =

-static GDBusMethodTable agent_methods[] =3D {
+static const GDBusMethodTable agent_methods[] =3D {
 	{ "ReceiveNotification", "aya{sv}", "", agent_receive },
 	{ "Release",             "",        "", agent_release,
 						G_DBUS_METHOD_FLAG_NOREPLY },
diff --git a/src/service.c b/src/service.c
index 6bcdede..a269556 100644
--- a/src/service.c
+++ b/src/service.c
@@ -222,13 +222,13 @@ static DBusMessage *msg_mark_read(DBusConnection *con=
n,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 =

-static GDBusMethodTable message_methods[] =3D {
+static const GDBusMethodTable message_methods[] =3D {
 	{ "MarkRead", "", "", msg_mark_read },
 	{ "Delete",   "", "", msg_delete },
 	{ }
 };
 =

-static GDBusSignalTable message_signals[] =3D {
+static const GDBusSignalTable message_signals[] =3D {
 	{ "PropertyChanged", "sv" },
 	{ }
 };
@@ -979,14 +979,14 @@ release_msg:
 	return __mms_error_trans_failure(dbus_msg);
 }
 =

-static GDBusMethodTable service_methods[] =3D {
+static const GDBusMethodTable service_methods[] =3D {
 	{ "SendMessage", "assa(sss)", "o", send_message },
 	{ "GetMessages", "", "a(oa{sv})", get_messages },
 	{ "GetConversation", "su", "a(oa{sv})", get_conversation },
 	{ }
 };
 =

-static GDBusSignalTable service_signals[] =3D {
+static const GDBusSignalTable service_signals[] =3D {
 	{ "MessageAdded",   "oa{sv}" },
 	{ "MessageRemoved", "o" },
 	{ }
@@ -2342,12 +2342,12 @@ static DBusMessage *get_services(DBusConnection *co=
nn,
 	return reply;
 }
 =

-static GDBusMethodTable manager_methods[] =3D {
+static const GDBusMethodTable manager_methods[] =3D {
 	{ "GetServices", "", "a(oa{sv})", get_services },
 	{ }
 };
 =

-static GDBusSignalTable manager_signals[] =3D {
+static const GDBusSignalTable manager_signals[] =3D {
 	{ "ServiceAdded",   "oa{sv}" },
 	{ "ServiceRemoved", "o"      },
 	{ }
-- =

1.7.10.2


--===============1426026204698077253==--

