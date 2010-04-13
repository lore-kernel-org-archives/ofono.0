Content-Type: multipart/mixed; boundary="===============1403969359124022986=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 5/8] Add emulator dialing call support
Date: Tue, 13 Apr 2010 22:18:16 +0800
Message-ID: <1271168299-4862-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1271168299-4862-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1403969359124022986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    4 +-
 src/emulator.c     |  110 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 3d07e36..0412f5a 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -63,11 +63,11 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 					unsigned int vendor,
 					const char *driver, void *data);
 =

-void ofono_emulator_watch_voicecall(struct ofono_emulator *emulator);
-
 void ofono_emulator_set_data(struct ofono_emulator *emulator, void *data);
 void *ofono_emulator_get_data(struct ofono_emulator *emulator);
 =

+gboolean ofono_emulator_dial(struct ofono_emulator *emulator,
+				const char *number);
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/emulator.c b/src/emulator.c
index 33e0a85..e21d826 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -41,8 +41,116 @@ struct ofono_emulator {
 	const struct ofono_emulator_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct ofono_atom *voicecall;		/* emulated voicecall atom */
 };
 =

+/* steal from plugins/hfp.c */
+static int send_method_call_with_reply(const char *dest, const char *path,
+				const char *interface, const char *method,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, DBusFreeFunction free_func,
+				int timeout, int type, ...)
+{
+	DBusConnection *connection =3D ofono_dbus_get_connection();
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	va_list args;
+	int err;
+
+	msg =3D dbus_message_new_method_call(dest, path, interface, method);
+	if (!msg) {
+		ofono_error("Unable to allocate new D-Bus %s message", method);
+		err =3D -ENOMEM;
+		goto fail;
+	}
+
+	va_start(args, type);
+
+	if (!dbus_message_append_args_valist(msg, type, args)) {
+		va_end(args);
+		err =3D -EIO;
+		goto fail;
+	}
+
+	va_end(args);
+
+	if (timeout > 0)
+		timeout *=3D 1000;
+
+	if (!dbus_connection_send_with_reply(connection, msg, &call, timeout)) {
+		ofono_error("Sending %s failed", method);
+		err =3D -EIO;
+		goto fail;
+	}
+
+	dbus_pending_call_set_notify(call, cb, user_data, free_func);
+	dbus_pending_call_unref(call);
+	dbus_message_unref(msg);
+
+	return 0;
+
+fail:
+	if (free_func && user_data)
+		free_func(user_data);
+
+	if (msg)
+		dbus_message_unref(msg);
+
+	return err;
+}
+
+static void emulator_dial_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusMessage *reply;
+	DBusError derr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Call reply: %s", derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+done:
+	dbus_message_unref(reply);
+}
+
+gboolean ofono_emulator_dial(struct ofono_emulator *emulator,
+				const char *number)
+{
+	struct ofono_atom *voicecall =3D emulator->voicecall;
+	struct ofono_voicecall *vc;
+	const char *path;
+	const char *clir =3D "default";
+
+	if (number =3D=3D NULL)
+		return FALSE;
+
+	vc =3D __ofono_atom_get_data(voicecall);
+	path =3D __ofono_atom_get_path(voicecall);
+
+	send_method_call_with_reply(OFONO_SERVICE, path,
+					OFONO_VOICECALL_MANAGER_INTERFACE,
+					"Dial", emulator_dial_cb, vc, NULL, 15,
+					DBUS_TYPE_STRING, &number,
+					DBUS_TYPE_STRING, &clir,
+					DBUS_TYPE_INVALID);
+
+	return TRUE;
+}
+
+static void ofono_emulator_watch_voicecall(struct ofono_emulator *emulator)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(emulator->atom);
+	struct ofono_atom *voicecall;
+
+	voicecall =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_VOICECALL);
+
+	emulator->voicecall =3D voicecall;
+}
+
 static DBusMessage *emulator_get_properties(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -60,6 +168,8 @@ static DBusMessage *emulator_enable(DBusConnection *conn,
 {
 	struct ofono_emulator *emulator =3D data;
 =

+	ofono_emulator_watch_voicecall(emulator);
+
 	if (emulator->driver->enable)
 		emulator->driver->enable(emulator);
 =

-- =

1.6.6.1


--===============1403969359124022986==--

