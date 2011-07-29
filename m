Content-Type: multipart/mixed; boundary="===============5350370514339625356=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2] connman: Fix crash while requesting and releasing private
 network
Date: Fri, 29 Jul 2011 14:49:56 +0200
Message-ID: <1311943796-15267-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1311943498-14865-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5350370514339625356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This v2 fixes indentation issue.

---
 plugins/connman.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/plugins/connman.c b/plugins/connman.c
index 3a3429f..bb29cd5 100644
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
@@ -186,8 +186,7 @@ static void request_reply(DBusPendingCall *call, void *=
user_data)
 	if (reply =3D=3D NULL)
 		goto badreply;
 =

-	if (parse_reply(dbus_pending_call_steal_reply(call),
-			&path, &pns) =3D=3D FALSE)
+	if (parse_reply(reply, &path, &pns) =3D=3D FALSE)
 		goto error;
 =

 	DBG("fd: %d, path: %s", pns.fd, path);
-- =

1.7.1


--===============5350370514339625356==--

