Content-Type: multipart/mixed; boundary="===============7017619977203797218=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] watch: Free service data in service_reply
Date: Fri, 23 Jul 2010 14:01:11 +0800
Message-ID: <1279864871-799-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7017619977203797218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Avoid the memory leak of server_data.
---
 gdbus/watch.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 1d479fa..ccdbb64 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -468,8 +468,10 @@ static void service_reply(DBusPendingCall *call, void =
*user_data)
 	dbus_bool_t has_owner;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
-	if (reply =3D=3D NULL)
+	if (reply =3D=3D NULL) {
+		g_free(data);
 		return;
+	}
 =

 	dbus_error_init(&error);
 =

@@ -490,6 +492,7 @@ static void service_reply(DBusPendingCall *call, void *=
user_data)
 =

 done:
 	dbus_message_unref(reply);
+	g_free(data);
 }
 =

 static void check_service(DBusConnection *connection, const char *name,
-- =

1.7.0.4


--===============7017619977203797218==--

