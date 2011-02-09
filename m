Content-Type: multipart/mixed; boundary="===============2625329238707349178=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: [RFC PATCH v3] gprs: add function to handle activated context
Date: Wed, 09 Feb 2011 18:31:37 +0000
Message-ID: <8281606748F03E4390BB98A3F47F2E948A9F71E69A@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2625329238707349178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The purpose of the patch is to handle Network Initiated Context Activation =
and PDN connection request as part of EPS Attach procedure (LTE) in oFono c=
ore.

In order to avoid issue regarding CID allocation :
- driver should call the core using ofono_gprs_set_cid_range function to sp=
ecify CID range for UE initiated PDN connection
- driver could use a new function to check if the CID is already used or no=
t : ofono_gprs_is_cid_used, usefull in case the modem is not using a specif=
ic range for UE initiated PDN connection.
- driver will use a new function to notify the gprs atom of a new PDN conne=
ction with all the ip parameters from AT+CGCONTRDP (I can provide an update=
 later to handle PCSCF and IMS Signaling Flag as well) commmand : ofono_gpr=
s_context_activated

ofono_gprs_context_activated is similar to ofono_gprs_context_deactivated.
This function must be call by any gprs driver when :
 - a context has been activated without explicit request as part of attach =
procedure in LTE (PDN ACT X and X is a unused CID)
 - a context has been activated by the Network (NW PDN ACT X, NW ACT X,Y)

Behavior of the function :

List all the context and try to find correct APN with empty username and em=
pty password.
If such context is not found then create a new one with "Internet" type onl=
y if we are in LTE with no Active context.
Otherwise deactivate the connection.

For the context (found or created):
	Update the settings
	Set to active

The function will also assign the context to a context driver.
---
 include/gprs-context.h |    7 +++
 include/gprs.h         |    3 +
 src/gprs.c             |  139 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/idmap.c            |   12 ++++
 src/idmap.h            |    1 +
 5 files changed, 162 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index c29c0dc..e208b66 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -76,6 +76,13 @@ struct ofono_gprs_context_driver {
 					ofono_gprs_context_cb_t cb, void *data);
 };
 =

+
+void ofono_gprs_context_activated(struct ofono_gprs_context *gc,
+		const int cid, const char *apn,
+		const char *interface, ofono_bool_t static_ip,
+		const char *address, const char *netmask,
+		const char *gw, const char **dns);
+
 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
 					unsigned int id);
 =

diff --git a/include/gprs.h b/include/gprs.h
index 157a6f9..5a96c1c 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -75,6 +75,9 @@ void *ofono_gprs_get_data(struct ofono_gprs *gprs);
 =

 void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
 				unsigned int min, unsigned int max);
+ofono_bool_t ofono_gprs_is_cid_used(struct ofono_gprs *gprs,
+				int cid);
+
 void ofono_gprs_add_context(struct ofono_gprs *gprs,
 				struct ofono_gprs_context *gc);
 =

diff --git a/src/gprs.c b/src/gprs.c
index 5ea864c..9ab853c 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -730,6 +730,13 @@ static void pri_activate_callback(const struct ofono_e=
rror *error,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
 }
 =

+static void ofono_gprs_context_activated_deactivate_callback(const struct =
ofono_error *error, void *data)
+{
+	struct ofono_gprs_context *gc_driver =3D data;
+	if (gc_driver !=3D NULL)
+		gc_driver->inuse =3D FALSE;
+}
+
 static void pri_deactivate_callback(const struct ofono_error *error, void =
*data)
 {
 	struct pri_context *ctx =3D data;
@@ -2026,6 +2033,15 @@ void ofono_gprs_set_cid_range(struct ofono_gprs *gpr=
s,
 	gprs->cid_map =3D idmap_new_from_range(min, max);
 }
 =

+ofono_bool_t ofono_gprs_is_cid_used(struct ofono_gprs *gprs,
+				int cid)
+{
+	if (gprs =3D=3D NULL || gprs->cid_map =3D=3D NULL)
+		return 0;
+
+	return idmap_is_free(gprs->cid_map, cid);
+}
+
 static void gprs_context_unregister(struct ofono_atom *atom)
 {
 	struct ofono_gprs_context *gc =3D __ofono_atom_get_data(atom);
@@ -2067,6 +2083,129 @@ void ofono_gprs_bearer_notify(struct ofono_gprs *gp=
rs, int bearer)
 					"Bearer", DBUS_TYPE_STRING, &value);
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
+	const char *path;
+	DBusMessage *signal;
+	GKeyFile *settings;
+	int active_context =3D 0;
+	int technology =3D 0;
+	struct pri_context *context =3D 0;
+
+
+	if (gc->gprs =3D=3D NULL)
+		return;
+
+	for (l =3D gc->gprs->contexts; l; l =3D l->next) {
+		context =3D l->data;
+
+		if (strcmp(context->context.apn, apn) =3D=3D 0
+				&& strcmp(context->context.username, "") =3D=3D 0
+				&& strcmp(context->context.password, "") =3D=3D 0)
+			break;
+
+		if (context->active)
+			active_context =3D 1;
+	}
+
+	if (gc->gprs->netreg)
+		technology =3D ofono_netreg_get_technology(gc->gprs->netreg);
+
+	if (!l && !(active_context =3D=3D 0 && technology =3D=3D 7)) {
+
+		for (l =3D gc->gprs->context_drivers; l; l =3D l->next) {
+			struct ofono_gprs_context *gc_driver =3D l->data;
+
+			if (gc_driver->inuse !=3D TRUE) {
+				gc_driver->inuse =3D TRUE;
+				gc_driver->driver->deactivate_primary(gc_driver, cid,
+						ofono_gprs_context_activated_deactivate_callback, gc_driver);
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
+	if (context =3D=3D NULL)
+		return;
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
+
+			break;
+		}
+	}
+
+	ofono_dbus_signal_property_changed(conn, context->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+
+}
+
 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
 					unsigned int cid)
 {
diff --git a/src/idmap.c b/src/idmap.c
index 6d46e8a..90dcd41 100644
--- a/src/idmap.c
+++ b/src/idmap.c
@@ -166,6 +166,18 @@ void idmap_take(struct idmap *idmap, unsigned int id)
 	idmap->bits[offset] |=3D 1 << (bit % BITS_PER_LONG);
 }
 =

+int idmap_is_free(struct idmap *idmap, unsigned int id)
+{
+	unsigned int bit =3D id - idmap->min;
+	unsigned int offset;
+
+	if (bit >=3D idmap->size)
+		return 0;
+
+	offset =3D bit / BITS_PER_LONG;
+	return (idmap->bits[offset] & (1 <<  (bit % BITS_PER_LONG))) =3D=3D 0;
+}
+
 /*
  * Allocate the next bit skipping the ids up to and including last.  If th=
ere
  * is no free ids until the max id is encountered, the counter is wrapped =
back
diff --git a/src/idmap.h b/src/idmap.h
index d6141c2..3333581 100644
--- a/src/idmap.h
+++ b/src/idmap.h
@@ -25,6 +25,7 @@ struct idmap *idmap_new(unsigned int size);
 void idmap_free(struct idmap *idmap);
 void idmap_put(struct idmap *idmap, unsigned int id);
 void idmap_take(struct idmap *idmap, unsigned int id);
+int idmap_is_free(struct idmap *idmap, unsigned int id);
 unsigned int idmap_alloc(struct idmap *idmap);
 unsigned int idmap_alloc_next(struct idmap *idmap, unsigned int last);
 struct idmap *idmap_new_from_range(unsigned int min, unsigned int max);
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


--===============2625329238707349178==--

