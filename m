Content-Type: multipart/mixed; boundary="===============4508915612731440635=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/14] stk: Handle the Set Up Idle Text proactive command.
Date: Wed, 07 Jul 2010 00:39:05 +0200
Message-ID: <1278455949-2823-11-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4508915612731440635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a SimToolkit dbus interface with just one property
(IdleModeText).
---
 src/stk.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index a57342a..940c65d 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -50,6 +50,7 @@ struct ofono_stk {
 	GQueue *envelope_q;
 =

 	struct sms_submit_req *sms_submit_req;
+	char *idle_mode_text;
 };
 =

 struct envelope_op {
@@ -219,6 +220,45 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	/* TODO */
 }
 =

+static DBusMessage *stk_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_stk *stk =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *idle_mode_text =3D stk->idle_mode_text ?: "";
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	ofono_dbus_dict_append(&dict, "IdleModeText",
+				DBUS_TYPE_STRING, &idle_mode_text);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static GDBusMethodTable stk_methods[] =3D {
+	{ "GetProperties",		"",	"a{sv}",stk_get_properties },
+
+	{ }
+};
+
+static GDBusSignalTable stk_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+
+	{ }
+};
+
 static gboolean handle_command_more_time(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -310,6 +350,34 @@ static gboolean handle_command_send_sms(const struct s=
tk_command *cmd,
 	return FALSE;
 }
 =

+static gboolean handle_command_set_idle_text(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const char *idle_mode_text;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(stk->atom);
+
+	if (stk->idle_mode_text) {
+		g_free(stk->idle_mode_text);
+		stk->idle_mode_text =3D NULL;
+	}
+
+	if (!cmd->setup_idle_mode_text.text)
+		goto out;
+
+	stk->idle_mode_text =3D g_strdup(cmd->setup_idle_mode_text.text);
+
+out:
+	idle_mode_text =3D stk->idle_mode_text ?: "";
+	ofono_dbus_signal_property_changed(conn, path, OFONO_STK_INTERFACE,
+						"IdleModeText",
+						DBUS_TYPE_STRING,
+						&idle_mode_text);
+
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -388,6 +456,10 @@ void ofono_stk_proactive_command_notify(struct ofono_s=
tk *stk,
 			respond =3D handle_command_send_sms(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
+			respond =3D handle_command_set_idle_text(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
@@ -438,14 +510,25 @@ void ofono_stk_driver_unregister(const struct ofono_s=
tk_driver *d)
 static void stk_unregister(struct ofono_atom *atom)
 {
 	struct ofono_stk *stk =3D __ofono_atom_get_data(atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
 =

 	if (stk->pending_cmd) {
 		stk_command_free(stk->pending_cmd);
 		stk->pending_cmd =3D NULL;
 	}
 =

+	if (stk->idle_mode_text) {
+		g_free(stk->idle_mode_text);
+		stk->idle_mode_text =3D NULL;
+	}
+
 	g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
 	g_queue_free(stk->envelope_q);
+
+	ofono_modem_remove_interface(modem, OFONO_STK_INTERFACE);
+	g_dbus_unregister_interface(conn, path, OFONO_STK_INTERFACE);
 }
 =

 static void stk_remove(struct ofono_atom *atom)
@@ -500,6 +583,21 @@ struct ofono_stk *ofono_stk_create(struct ofono_modem =
*modem,
 =

 void ofono_stk_register(struct ofono_stk *stk)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	const char *path =3D __ofono_atom_get_path(stk->atom);
+
+	if (!g_dbus_register_interface(conn, path, OFONO_STK_INTERFACE,
+					stk_methods, stk_signals, NULL,
+					stk, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_STK_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_STK_INTERFACE);
+
 	__ofono_atom_register(stk->atom, stk_unregister);
 =

 	stk->envelope_q =3D g_queue_new();
-- =

1.7.1.86.g0e460.dirty


--===============4508915612731440635==--

