Content-Type: multipart/mixed; boundary="===============8383819313766175959=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] connman: Fix crash while requesting and releasing private
 network
Date: Fri, 29 Jul 2011 14:44:58 +0200
Message-ID: <1311943498-14865-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8383819313766175959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/connman.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/connman.c b/plugins/connman.c
index 3a3429f..8ad6815 100644
--- a/plugins/connman.c
+++ b/plugins/connman.c
@@ -119,7 +119,7 @@ static gboolean parse_reply(DBusMessage *reply, const c=
har **path,
 	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_OBJECT_PATH)
 		return FALSE;
 =

-	dbus_message_iter_get_basic(&array, &path);
+	dbus_message_iter_get_basic(&array, path);
 =

 	dbus_message_iter_next(&array);
 	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
@@ -186,7 +186,7 @@ static void request_reply(DBusPendingCall *call, void *=
user_data)
 	if (reply =3D=3D NULL)
 		goto badreply;
 =

-	if (parse_reply(dbus_pending_call_steal_reply(call),
+	if (parse_reply(reply,
 			&path, &pns) =3D=3D FALSE)
 		goto error;
 =

-- =

1.7.1


--===============8383819313766175959==--

