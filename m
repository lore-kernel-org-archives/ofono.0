Content-Type: multipart/mixed; boundary="===============7109743603611947112=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] dbus: Use dbus_validate_path
Date: Thu, 18 Jan 2018 18:47:57 +0200
Message-ID: <1516294077-16319-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7109743603611947112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of __ofono_dbus_valid_object_path
---
 plugins/push-notification.c |  2 +-
 plugins/smart-messaging.c   |  2 +-
 src/dbus.c                  | 44 -----------------------------------------=
---
 src/gnss.c                  |  2 +-
 src/modem.c                 |  2 +-
 src/netmon.c                |  2 +-
 src/ofono.h                 |  2 --
 src/stk.c                   |  4 ++--
 8 files changed, 7 insertions(+), 53 deletions(-)

diff --git a/plugins/push-notification.c b/plugins/push-notification.c
index ff388d9..f469f9e 100644
--- a/plugins/push-notification.c
+++ b/plugins/push-notification.c
@@ -96,7 +96,7 @@ static DBusMessage *push_notification_register_agent(DBus=
Connection *conn,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!__ofono_dbus_valid_object_path(agent_path))
+	if (!dbus_validate_path(agent_path, NULL))
 		return __ofono_error_invalid_format(msg);
 =

 	pn->agent =3D sms_agent_new(AGENT_INTERFACE,
diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index bbbdaa9..0c9700d 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -119,7 +119,7 @@ static DBusMessage *smart_messaging_register_agent(DBus=
Connection *conn,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!__ofono_dbus_valid_object_path(agent_path))
+	if (!dbus_validate_path(agent_path, NULL))
 		return __ofono_error_invalid_format(msg);
 =

 	sm->agent =3D sms_agent_new(AGENT_INTERFACE,
diff --git a/src/dbus.c b/src/dbus.c
index 45becc1..3e1e162 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -456,50 +456,6 @@ void __ofono_dbus_pending_reply(DBusMessage **msg, DBu=
sMessage *reply)
 	*msg =3D NULL;
 }
 =

-gboolean __ofono_dbus_valid_object_path(const char *path)
-{
-	unsigned int i;
-	char c =3D '\0';
-
-	if (path =3D=3D NULL)
-		return FALSE;
-
-	if (path[0] =3D=3D '\0')
-		return FALSE;
-
-	if (path[0] && !path[1] && path[0] =3D=3D '/')
-		return TRUE;
-
-	if (path[0] !=3D '/')
-		return FALSE;
-
-	for (i =3D 0; path[i]; i++) {
-		if (path[i] =3D=3D '/' && c =3D=3D '/')
-			return FALSE;
-
-		c =3D path[i];
-
-		if (path[i] >=3D 'a' && path[i] <=3D 'z')
-			continue;
-
-		if (path[i] >=3D 'A' && path[i] <=3D 'Z')
-			continue;
-
-		if (path[i] >=3D '0' && path[i] <=3D '9')
-			continue;
-
-		if (path[i] =3D=3D '_' || path[i] =3D=3D '/')
-			continue;
-
-		return FALSE;
-	}
-
-	if (path[i-1] =3D=3D '/')
-		return FALSE;
-
-	return TRUE;
-}
-
 DBusConnection *ofono_dbus_get_connection(void)
 {
 	return g_connection;
diff --git a/src/gnss.c b/src/gnss.c
index 97d1152..ba2a97b 100644
--- a/src/gnss.c
+++ b/src/gnss.c
@@ -135,7 +135,7 @@ static DBusMessage *gnss_register_agent(DBusConnection =
*conn,
 				&agent_path, DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!__ofono_dbus_valid_object_path(agent_path))
+	if (!dbus_validate_path(agent_path, NULL))
 		return __ofono_error_invalid_format(msg);
 =

 	gnss->posr_agent =3D gnss_agent_new(agent_path,
diff --git a/src/modem.c b/src/modem.c
index 0c63d2c..d5fda7c 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1876,7 +1876,7 @@ struct ofono_modem *ofono_modem_create(const char *na=
me, const char *type)
 	else
 		snprintf(path, sizeof(path), "/%s", name);
 =

-	if (__ofono_dbus_valid_object_path(path) =3D=3D FALSE)
+	if (!dbus_validate_path(path, NULL))
 		return NULL;
 =

 	modem =3D g_try_new0(struct ofono_modem, 1);
diff --git a/src/netmon.c b/src/netmon.c
index 3a49587..62e0ec0 100644
--- a/src/netmon.c
+++ b/src/netmon.c
@@ -353,7 +353,7 @@ static DBusMessage *netmon_register_agent(DBusConnectio=
n *conn,
 				DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!__ofono_dbus_valid_object_path(agent_path))
+	if (!dbus_validate_path(agent_path, NULL))
 		return __ofono_error_invalid_format(msg);
 =

 	if (!period)
diff --git a/src/ofono.h b/src/ofono.h
index deb1b7c..ac3726d 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -76,8 +76,6 @@ DBusMessage *__ofono_error_from_error(const struct ofono_=
error *error,
 =

 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
 =

-gboolean __ofono_dbus_valid_object_path(const char *path);
-
 struct ofono_watchlist_item {
 	unsigned int id;
 	void *notify;
diff --git a/src/stk.c b/src/stk.c
index 49d6365..9cdf2b1 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -722,7 +722,7 @@ static DBusMessage *stk_register_agent(DBusConnection *=
conn,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!__ofono_dbus_valid_object_path(agent_path))
+	if (!dbus_validate_path(agent_path, NULL))
 		return __ofono_error_invalid_format(msg);
 =

 	stk->default_agent =3D stk_agent_new(agent_path,
@@ -834,7 +834,7 @@ static DBusMessage *stk_select_item(DBusConnection *con=
n,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!__ofono_dbus_valid_object_path(agent_path))
+	if (!dbus_validate_path(agent_path, NULL))
 		return __ofono_error_invalid_format(msg);
 =

 	for (i =3D 0; i < selection && menu->items[i].text; i++);
-- =

1.9.1


--===============7109743603611947112==--

