Content-Type: multipart/mixed; boundary="===============2098949317682661658=="
MIME-Version: 1.0
From: Philip Withnall <philip@tecnocode.co.uk>
Subject: [PATCH] gdbus: Drop message replies if the sender requested no reply
Date: Wed, 02 Dec 2015 15:44:07 +0000
Message-ID: <1449071047.4523.18.camel@tecnocode.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2098949317682661658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the sender flags a D-Bus message as not expecting a reply, it is
against system bus policy to send a reply =E2=80=94 sending one will result=
 in
errors being sent to us by dbus-daemon.

Magically drop all replies to messages which request no reply.

This is not a complete fix. In an ideal world, the existing check for
G_DBUS_METHOD_FLAG_NOREPLY would be dropped, as the server should be
prepared to return a reply to every method, if the client requests and
expects one =E2=80=94 otherwise the client will time out. However, that=E2=
=80=99s a
much
bigger change with a much bigger risk of breaking things, so I=E2=80=99ll s=
tick
with this for now.

Signed-off-by: Philip Withnall <philip.withnall@collabora.co.uk>
Reviewed-by: Simon McVittie <simon.mcvittie@collabora.co.uk>
---
=C2=A0gdbus/object.c | 3 ++-
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 96db516..146a255 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -258,7 +258,8 @@ static DBusHandlerResult
process_message(DBusConnection *connection,
=C2=A0
=C2=A0	reply =3D method->function(connection, message,
iface_user_data);
=C2=A0
-	if (method->flags & G_DBUS_METHOD_FLAG_NOREPLY) {
+	if (method->flags & G_DBUS_METHOD_FLAG_NOREPLY ||
+	=C2=A0=C2=A0=C2=A0=C2=A0dbus_message_get_no_reply(message)) {
=C2=A0		if (reply !=3D NULL)
=C2=A0			dbus_message_unref(reply);
=C2=A0		return DBUS_HANDLER_RESULT_HANDLED;
-- =

2.5.0

--===============2098949317682661658==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlGNEVBQkVL
QUFZRkFsWmZFY2NBQ2drUThKUXVpVXN1cjZCQ1FnRCtKamw4YXBTWlRIUnl0UGdKUWlxdWRnNEoK
RDRWdlpwOFBoRHdVN0gvejlsc0JBSXJTYzBnMjZzVHJWYnhnRXd6Ym0xYUJmOXVRcmtzeTF4b01P
ak1KQ1lERgo9ZmxaVgotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============2098949317682661658==--

