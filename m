Content-Type: multipart/mixed; boundary="===============8846392054016993466=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: [RFC PATCH] gprs: add function to handle activated context
Date: Wed, 05 Jan 2011 17:25:39 +0000
Message-ID: <8281606748F03E4390BB98A3F47F2E948A9C123E86@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8846392054016993466==
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
If such context is not found create a new one with "Internet" type

For the context (found or created):
	Update the settings
	Set to active
---
 include/gprs-context.h |    6 +++
 src/gprs.c             |  105 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 111 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index c29c0dc..57cd60b 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -76,6 +76,12 @@ struct ofono_gprs_context_driver {
 					ofono_gprs_context_cb_t cb, void *data);
 };
 =

+void ofono_gprs_context_activated(struct ofono_gprs_context *gc,
+				const int cid, const char *apn,
+				const char *interface, ofono_bool_t static_ip,
+				const char *address, const char *netmask,
+				const char *gw, const char **dns);
+
 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
 					unsigned int id);
 =

diff --git a/src/gprs.c b/src/gprs.c
index 58166f8..b7a4768 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -212,6 +212,11 @@ static unsigned int gprs_cid_alloc(struct ofono_gprs *=
gprs)
 	return idmap_alloc(gprs->cid_map);
 }
 =

+static void gprs_cid_take(struct ofono_gprs *gprs, unsigned int id)
+{
+	idmap_take(gprs->cid_map, id);
+}
+
 static void gprs_cid_release(struct ofono_gprs *gprs, unsigned int id)
 {
 	idmap_put(gprs->cid_map, id);
@@ -1977,6 +1982,106 @@ void ofono_gprs_add_context(struct ofono_gprs *gprs,
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
+
+	if (gc->gprs =3D=3D NULL)
+		return;
+
+	for (l =3D gc->gprs->contexts; l; l =3D l->next) {
+		context =3D l->data;
+
+		if (strcmp(context->context.apn, apn) =3D=3D 0)
+			break;
+	}
+
+	if (!l) {
+		context =3D add_context(gc->gprs, "Internet",
+				OFONO_GPRS_CONTEXT_TYPE_INTERNET);
+
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
+			dbus_message_iter_append_basic(&iter,
+					DBUS_TYPE_OBJECT_PATH,
+					&path);
+
+			dbus_message_iter_open_container(&iter,
+					DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
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
+	gprs_cid_take(gc->gprs, cid);
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


--===============8846392054016993466==--

