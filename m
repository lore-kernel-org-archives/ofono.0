Content-Type: multipart/mixed; boundary="===============6690198772220865682=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/3] Add __ofono_error_access_denied()
Date: Fri, 19 Nov 2010 19:37:08 -0200
Message-ID: <1290202629-23235-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1290202629-23235-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6690198772220865682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c  |    6 ++++++
 src/ofono.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index 8a685aa..d7ad564 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -342,6 +342,12 @@ DBusMessage *__ofono_error_canceled(DBusMessage *msg)
 					"Operation has been canceled");
 }
 =

+DBusMessage *__ofono_error_access_denied(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".AccessDenied",
+					"Operation not permitted");
+}
+
 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
diff --git a/src/ofono.h b/src/ofono.h
index 4d76d20..a24dc34 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -57,6 +57,7 @@ DBusMessage *__ofono_error_in_use(DBusMessage *msg);
 DBusMessage *__ofono_error_not_attached(DBusMessage *msg);
 DBusMessage *__ofono_error_attach_in_progress(DBusMessage *msg);
 DBusMessage *__ofono_error_canceled(DBusMessage *msg);
+DBusMessage *__ofono_error_access_denied(DBusMessage *msg);
 =

 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
 =

-- =

1.7.3.1


--===============6690198772220865682==--

