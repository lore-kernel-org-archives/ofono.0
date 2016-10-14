Content-Type: multipart/mixed; boundary="===============8542682312185395950=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] netmon: Make sure we don't pass NULL message to
 g_dbus_send_message
Date: Fri, 14 Oct 2016 19:32:05 +0300
Message-ID: <1476462725-24137-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8542682312185395950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also that we don't lose the reply message.
---
 src/netmon.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/netmon.c b/src/netmon.c
index 9d6de07..eb18b9c 100644
--- a/src/netmon.c
+++ b/src/netmon.c
@@ -199,9 +199,24 @@ static void serving_cell_info_callback(const struct of=
ono_error *error,
 	struct ofono_netmon *netmon =3D data;
 	DBusMessage *reply =3D netmon->reply;
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		if (reply)
+			dbus_message_unref(reply);
+
 		reply =3D __ofono_error_failed(netmon->pending);
+        } else if (!reply) {
+		DBusMessageIter iter;
+		DBusMessageIter dict;
+
+		reply =3D dbus_message_new_method_return(netmon->pending);
+		dbus_message_iter_init_append(reply, &iter);
+		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+		dbus_message_iter_close_container(&iter, &dict);
+	}
 =

+	netmon->reply =3D NULL;
 	__ofono_dbus_pending_reply(&netmon->pending, reply);
 }
 =

-- =

1.9.1


--===============8542682312185395950==--

