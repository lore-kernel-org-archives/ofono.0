Content-Type: multipart/mixed; boundary="===============6621359027831113298=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/13] stk: IdleModeIcon and MainMenuIcon properties.
Date: Wed, 13 Oct 2010 15:54:11 +0200
Message-ID: <1286978056-16600-8-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286978056-16600-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6621359027831113298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 3635579..863a6dd 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -72,6 +72,7 @@ struct ofono_stk {
 	guint remove_agent_source;
 	struct extern_req *extern_req;
 	char *idle_mode_text;
+	struct stk_icon_id idle_mode_icon;
 	struct timeval get_inkey_start_ts;
 };
 =

@@ -364,6 +365,11 @@ static void emit_menu_changed(struct ofono_stk *stk)
 						"MainMenuTitle",
 						DBUS_TYPE_STRING, &menu->title);
 =

+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_STK_INTERFACE,
+						"MainMenuIcon",
+						DBUS_TYPE_BYTE, &menu->icon.id);
+
 	signal =3D dbus_message_new_signal(path, OFONO_STK_INTERFACE,
 						"PropertyChanged");
 	if (!signal) {
@@ -390,6 +396,9 @@ static void dict_append_menu(DBusMessageIter *dict, str=
uct stk_menu *menu)
 	ofono_dbus_dict_append(dict, "MainMenuTitle",
 				DBUS_TYPE_STRING, &menu->title);
 =

+	ofono_dbus_dict_append(dict, "MainMenuIcon",
+				DBUS_TYPE_BYTE, &menu->icon.id);
+
 	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
 						NULL, &entry);
 =

@@ -433,6 +442,10 @@ static DBusMessage *stk_get_properties(DBusConnection =
*conn,
 	ofono_dbus_dict_append(&dict, "IdleModeText",
 				DBUS_TYPE_STRING, &idle_mode_text);
 =

+	if (stk->idle_mode_icon.id)
+		ofono_dbus_dict_append(&dict, "IdleModeIcon", DBUS_TYPE_BYTE,
+					&stk->idle_mode_icon.id);
+
 	if (stk->main_menu)
 		dict_append_menu(&dict, stk->main_menu);
 =

@@ -789,6 +802,16 @@ static gboolean handle_command_set_idle_text(const str=
uct stk_command *cmd,
 						DBUS_TYPE_STRING,
 						&idle_mode_text);
 =

+	if (stk->idle_mode_icon.id !=3D cmd->setup_idle_mode_text.icon_id.id) {
+		memcpy(&stk->idle_mode_icon, &cmd->setup_idle_mode_text.icon_id,
+				sizeof(stk->idle_mode_icon));
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_STK_INTERFACE,
+						"IdleModeIcon", DBUS_TYPE_BYTE,
+						&stk->idle_mode_icon.id);
+	}
+
 	return TRUE;
 }
 =

-- =

1.7.1.86.g0e460.dirty


--===============6621359027831113298==--

