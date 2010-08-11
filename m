Content-Type: multipart/mixed; boundary="===============6771314461210954837=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 10/16] gprs: Add ofono_gprs_create_context method
Date: Wed, 11 Aug 2010 10:26:35 +0800
Message-ID: <1281493601-14351-11-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6771314461210954837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN server may create one primary context if none of contexts existing
on the GPRS atom.
---
 src/gprs.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 5d850df..7e85d39 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1162,6 +1162,82 @@ static DBusMessage *gprs_set_property(DBusConnection=
 *conn,
 	return dbus_message_new_method_return(msg);
 }
 =

+static struct pri_context *ofono_gprs_create_context(
+					struct ofono_gprs *gprs,
+					const char *name, const char *typestr)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct pri_context *context;
+	const char *path;
+	enum gprs_context_type type;
+	char **objpath_list;
+	unsigned int id;
+
+	if (strlen(name) =3D=3D 0 || strlen(name) > MAX_CONTEXT_NAME_LENGTH)
+		return NULL;
+
+	type =3D gprs_context_string_to_type(typestr);
+
+	if (type =3D=3D GPRS_CONTEXT_TYPE_INVALID)
+		return NULL;
+
+	if (gprs->last_context_id)
+		id =3D idmap_alloc_next(gprs->pid_map, gprs->last_context_id);
+	else
+		id =3D idmap_alloc(gprs->pid_map);
+
+	if (id > idmap_get_max(gprs->pid_map))
+		return NULL;
+
+	context =3D pri_context_create(gprs, name, type);
+	context->id =3D id;
+
+	if (!context) {
+		ofono_error("Unable to allocate context struct");
+		return NULL;
+	}
+
+	DBG("Registering new context");
+
+	if (!context_dbus_register(context)) {
+		ofono_error("Unable to register primary context");
+		return NULL;
+	}
+
+	gprs->last_context_id =3D id;
+
+	if (gprs->settings) {
+		g_key_file_set_string(gprs->settings, context->key,
+					"Name", context->name);
+		g_key_file_set_string(gprs->settings, context->key,
+					"AccessPointName",
+					context->context.apn);
+		g_key_file_set_string(gprs->settings, context->key,
+					"Username", context->context.username);
+		g_key_file_set_string(gprs->settings, context->key,
+					"Password", context->context.password);
+		g_key_file_set_string(gprs->settings, context->key, "Type",
+				gprs_context_type_to_string(context->type));
+		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
+	}
+
+	gprs->contexts =3D g_slist_append(gprs->contexts, context);
+
+	objpath_list =3D gprs_contexts_path_list(gprs->contexts);
+
+	if (objpath_list) {
+		path =3D __ofono_atom_get_path(gprs->atom);
+		ofono_dbus_signal_array_property_changed(conn, path,
+					OFONO_DATA_CONNECTION_MANAGER_INTERFACE,
+					"PrimaryContexts",
+					DBUS_TYPE_OBJECT_PATH, &objpath_list);
+
+		g_strfreev(objpath_list);
+	}
+
+	return context;
+}
+
 static DBusMessage *gprs_create_context(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-- =

1.7.0.4


--===============6771314461210954837==--

