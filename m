Content-Type: multipart/mixed; boundary="===============1638845231016838578=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: [RFC PATCH V1] gprs: add function to handle activated context
Date: Mon, 17 Jan 2011 13:46:54 +0000
Message-ID: <8281606748F03E4390BB98A3F47F2E948A9C19E2BB@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1638845231016838578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

gprs: add function to handle activated context


ofono_gprs_context_activated : this function is symetric to ofono_gprs_cont=
ext_deactivated.
This function must be call by any gprs-context driver when a context has be=
en activated without explicit request.

Behavior of the function :

List all the context and try to find correct APN
If such context is not found then create a new one with "Internet" type onl=
y if we are in LTE with no Active context.

Otherwise deactivate the connection.

For the context (found or created):
	Update the settings
	Set to active
---
 src/gprs.c |  122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0e86bdf..6506936 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -692,6 +692,10 @@ static void pri_activate_callback(const struct ofono_e=
rror *error,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
 }
 =

+static void __ofono_gprs_context_activated_callback(const struct ofono_err=
or *error, void *data)
+{
+}
+
 static void pri_deactivate_callback(const struct ofono_error *error, void =
*data)
 {
 	struct pri_context *ctx =3D data;
@@ -1979,6 +1983,124 @@ void ofono_gprs_add_context(struct ofono_gprs *gprs,
 	__ofono_atom_register(gc->atom, gprs_context_unregister);
 }
 =

+void ofono_gprs_context_activated(struct ofono_gprs_context *gc,
+		const int cid, const char *apn,
+		const char *interface, ofono_bool_t static_ip,
+		const char *address, const char *netmask,
+		const char *gw, const char **dns)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	GSList *l;
+	dbus_bool_t value;
+	struct pri_context *context;
+	const char *path;
+	DBusMessage *signal;
+	GKeyFile *settings;
+	int active_context =3D 0;
+	int technology =3D 0;
+
+	if (gc->gprs =3D=3D NULL)
+		return;
+
+	for (l =3D gc->gprs->contexts; l; l =3D l->next) {
+		context =3D l->data;
+
+		if (strcmp(context->context.apn, apn) =3D=3D 0)
+			break;
+
+		if (context->active)
+			active_context =3D 1;
+	}
+
+
+	if (gc->gprs->netreg)
+		technology =3D ofono_netreg_get_technology(gc->gprs->netreg);
+
+	if (!l && !(active_context =3D=3D 1 && technology =3D=3D 7)) {
+
+		for (l =3D context->gprs->context_drivers; l; l =3D l->next) {
+			struct ofono_gprs_context *gc =3D l->data;
+
+			if (gc->inuse !=3D TRUE) {
+				gc->driver->deactivate_primary(gc, cid,
+				__ofono_gprs_context_activated_callback, 0);
+
+				return ;
+			}
+		}
+		return ;
+	}
+
+	if (!l) {
+		context =3D add_context(gc->gprs, "Internet", OFONO_GPRS_CONTEXT_TYPE_IN=
TERNET);
+		path =3D __ofono_atom_get_path(gc->gprs->atom);
+		signal =3D dbus_message_new_signal(path,
+				OFONO_CONNECTION_MANAGER_INTERFACE,
+				"ContextAdded");
+
+		if (signal) {
+			DBusMessageIter iter;
+			DBusMessageIter dict;
+
+			dbus_message_iter_init_append(signal, &iter);
+
+			path =3D context->path;
+			dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+							&path);
+
+			dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+			append_context_properties(context, &dict);
+			dbus_message_iter_close_container(&iter, &dict);
+
+			g_dbus_send_message(conn, signal);
+		}
+
+		strcpy(context->context.apn, apn);
+		settings =3D context->gprs->settings;
+
+		if (settings) {
+			g_key_file_set_string(settings, context->key,
+					"AccessPointName", apn);
+			storage_sync(context->gprs->imsi,
+					SETTINGS_STORE, settings);
+		}
+
+		ofono_dbus_signal_property_changed(conn, context->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"AccessPointName",
+					DBUS_TYPE_STRING, &apn);
+	}
+
+	context->context.cid =3D cid;
+	value =3D context->active =3D TRUE;
+
+	if (interface !=3D NULL)
+		pri_update_context_settings(context, interface, static_ip,
+					address, netmask, gw, dns);
+
+	for (l =3D context->gprs->context_drivers; l; l =3D l->next) {
+		struct ofono_gprs_context *gc =3D l->data;
+
+		if (gc->inuse =3D=3D TRUE)
+			continue;
+
+		if (gc->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_ANY ||
+						gc->type =3D=3D context->type) {
+			context->context_driver =3D gc;
+			context->context_driver->inuse =3D TRUE;
+		}
+	}
+
+	ofono_dbus_signal_property_changed(conn, context->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+
+}
+
+
+
 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
 					unsigned int cid)
 {
-- =

1.7.0.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============1638845231016838578==--

