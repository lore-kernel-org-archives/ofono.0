Content-Type: multipart/mixed; boundary="===============6895076124839800224=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 3/6] service: Retrieve delivery-report parameter
Date: Tue, 12 Jun 2012 16:04:12 +0200
Message-ID: <1339509855-7467-4-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1339509855-7467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6895076124839800224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index 83e1fe1..8150c29 100644
--- a/src/service.c
+++ b/src/service.c
@@ -456,6 +456,14 @@ static gboolean send_message_get_args(DBusMessage *dbu=
s_msg,
 	if (!dbus_message_iter_next(&top_iter))
 		return FALSE;
 =

+	if (dbus_message_iter_get_arg_type(&top_iter) !=3D DBUS_TYPE_BOOLEAN)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&top_iter, &msg->sr.dr);
+
+	if (!dbus_message_iter_next(&top_iter))
+		return FALSE;
+
 	if (dbus_message_iter_get_arg_type(&top_iter) !=3D DBUS_TYPE_STRING)
 		return FALSE;
 =

@@ -982,7 +990,9 @@ release_msg:
 =

 static const GDBusMethodTable service_methods[] =3D {
 	{ GDBUS_METHOD("SendMessage",
-			GDBUS_ARGS({ "recipients", "as" }, { "smil", "s" },
+			GDBUS_ARGS({ "recipients", "as" },
+						{ "delivery_report", "b" },
+						{ "smil", "s" },
 						{ "attachments", "a(sss)" }),
 			GDBUS_ARGS({ "path", "o" }),
 			send_message) },
-- =

1.7.4.1


--===============6895076124839800224==--

