Content-Type: multipart/mixed; boundary="===============6973494818998269918=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: [PATCH] voicecall.c: use swap_without_accept method, if present
Date: Thu, 08 Oct 2009 19:59:52 +0300
Message-ID: <1255021194-31138-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6973494818998269918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/voicecall.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index eff6321..1be907a 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -835,11 +835,31 @@ static DBusMessage *manager_transfer(DBusConnection *=
conn,
 	return NULL;
 }
 =

+static DBusMessage *manager_swap_without_accept(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+
+	if (vc->flags & VOICECALLS_FLAG_PENDING)
+		return __ofono_error_busy(msg);
+
+	vc->flags |=3D VOICECALLS_FLAG_PENDING;
+	vc->pending =3D dbus_message_ref(msg);
+
+	vc->driver->swap_without_accept(vc, generic_callback, vc);
+
+	return NULL;
+}
+
+
 static DBusMessage *manager_swap_calls(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
 =

+	if (vc->driver->swap_without_accept)
+		return manager_swap_without_accept(conn, msg, data);
+
 	if (vc->flags & VOICECALLS_FLAG_PENDING)
 		return __ofono_error_busy(msg);
 =

-- =

1.6.0.4


--===============6973494818998269918==--

