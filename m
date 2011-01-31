Content-Type: multipart/mixed; boundary="===============4845016056851964998=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/8] bluetooth: add support to register Bluetooth Service
Date: Mon, 31 Jan 2011 18:51:56 -0200
Message-ID: <1296507122-10936-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296507122-10936-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4845016056851964998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index dcf75e6..0b5a021 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -44,6 +44,43 @@ static GHashTable *adapter_address_hash =3D NULL;
 static GSList *server_list =3D NULL;
 static gint bluetooth_refcount;
 =

+static const gchar *dun_record =3D "<?xml version=3D\"1.0\" encoding=3D\"U=
TF-8\" ?>	\
+<record>									\
+  <attribute id=3D\"0x0001\">							\
+    <sequence>									\
+      <uuid value=3D\"0x1103\"/>							\
+    </sequence>									\
+  </attribute>									\
+										\
+  <attribute id=3D\"0x0004\">							\
+    <sequence>									\
+      <sequence>								\
+        <uuid value=3D\"0x0100\"/>						\
+      </sequence>								\
+      <sequence>								\
+        <uuid value=3D\"0x0003\"/>						\
+        <uint8 value=3D\"%u\" name=3D\"channel\"/>					\
+      </sequence>								\
+      <sequence>								\
+        <uuid value=3D\"0x0008\"/>						\
+      </sequence>								\
+    </sequence>									\
+  </attribute>									\
+										\
+  <attribute id=3D\"0x0009\">							\
+    <sequence>									\
+      <sequence>								\
+        <uuid value=3D\"0x1103\"/>						\
+        <uint16 value=3D\"0x0100\" name=3D\"version\"/>				\
+      </sequence>								\
+    </sequence>									\
+  </attribute>									\
+										\
+  <attribute id=3D\"0x0100\">							\
+    <text value=3D\"%s\" name=3D\"name\"/>						\
+  </attribute>									\
+</record>";
+
 struct server {
 	guint16		service;
 	gchar		*name;
@@ -451,12 +488,40 @@ static void new_connection(GIOChannel *io, gpointer u=
ser_data)
 	DBG("%p", server);
 }
 =

+static void add_record_cb(DBusPendingCall *call, gpointer user_data)
+{
+	struct server *server =3D user_data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError derr;
+	guint32 handle;
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("Replied with an error: %s, %s",
+					derr.name, derr.message);
+		dbus_error_free(&derr);
+		server_stop(server);
+		goto done;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_UINT32, &handle,
+					DBUS_TYPE_INVALID);
+	server->handle =3D handle;
+
+	ofono_info("Registered: %s, handle: 0x%x", server->name, handle);
+
+done:
+	dbus_message_unref(reply);
+}
+
 static void server_start(gpointer data, gpointer user_data)
 {
 	struct server *server =3D data;
 	char *addr, *path =3D user_data;
 	bdaddr_t baddr;
 	GError *err =3D NULL;
+	gchar *xml;
 =

 	if (server->handle !=3D 0)
 		return;
@@ -478,6 +543,16 @@ static void server_start(gpointer data, gpointer user_=
data)
 	}
 =

 	server->adapter =3D g_strdup(path);
+
+	xml =3D g_markup_printf_escaped(dun_record, server->channel,
+					server->name);
+
+	bluetooth_send_with_reply(path, BLUEZ_SERVICE_INTERFACE, "AddRecord",
+					add_record_cb, server, NULL, -1,
+					DBUS_TYPE_STRING, &xml,
+					DBUS_TYPE_INVALID);
+
+	g_free(xml);
 }
 =

 static void adapter_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
-- =

1.7.4.rc3


--===============4845016056851964998==--

