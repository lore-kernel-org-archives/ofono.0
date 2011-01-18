Content-Type: multipart/mixed; boundary="===============4161586537617580361=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 5/8] gprs: add gprs context provisioning
Date: Tue, 18 Jan 2011 10:09:29 +0200
Message-ID: <1295338172-12773-6-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295338172-12773-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4161586537617580361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  147 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 files changed, 133 insertions(+), 14 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0e86bdf..b0d58f6 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -43,6 +43,7 @@
 #include "common.h"
 #include "storage.h"
 #include "idmap.h"
+#include "gprs-provision.h"
 =

 #define GPRS_FLAG_ATTACHING 0x1
 #define GPRS_FLAG_RECHECK 0x2
@@ -82,6 +83,7 @@ struct ofono_gprs {
 	const struct ofono_gprs_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct provision_request *provision;
 };
 =

 struct ofono_gprs_context {
@@ -122,6 +124,10 @@ struct pri_context {
 	struct ofono_gprs *gprs;
 };
 =

+struct provision_request {
+	struct ofono_gprs *gprs;
+};
+
 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
 =

@@ -2203,6 +2209,9 @@ static void gprs_remove(struct ofono_atom *atom)
 	if (gprs->driver && gprs->driver->remove)
 		gprs->driver->remove(gprs);
 =

+	if (gprs->provision !=3D NULL)
+		gprs->provision->gprs =3D NULL;
+
 	g_free(gprs);
 }
 =

@@ -2456,13 +2465,15 @@ remove:
 		storage_sync(imsi, SETTINGS_STORE, gprs->settings);
 }
 =

-void ofono_gprs_register(struct ofono_gprs *gprs)
+static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
 	struct ofono_atom *netreg_atom;
-	struct ofono_atom *sim_atom;
+
+	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
+		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CONNECTION_MANAGER_INTERFACE,
@@ -2477,18 +2488,6 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 	ofono_modem_add_interface(modem,
 				OFONO_CONNECTION_MANAGER_INTERFACE);
 =

-	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
-
-	if (sim_atom) {
-		struct ofono_sim *sim =3D __ofono_atom_get_data(sim_atom);
-		const char *imsi =3D ofono_sim_get_imsi(sim);
-
-		gprs_load_settings(gprs, imsi);
-	}
-
-	if (gprs->contexts =3D=3D NULL)
-		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
-
 	gprs->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
 					OFONO_ATOM_TYPE_NETREG,
 					netreg_watch, gprs, NULL);
@@ -2502,6 +2501,126 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

+static void provision_context(gpointer data, gpointer user_data)
+{
+	struct ofono_gprs_provision_data *ap =3D data;
+	struct ofono_gprs *gprs =3D user_data;
+
+	unsigned int id;
+	struct pri_context *context =3D NULL;
+
+	/* Sanity check */
+	if (ap =3D=3D NULL || ap->name =3D=3D NULL)
+		return;
+
+	if (gprs->last_context_id)
+		id =3D idmap_alloc_next(gprs->pid_map, gprs->last_context_id);
+	else
+		id =3D idmap_alloc(gprs->pid_map);
+
+	if (id > idmap_get_max(gprs->pid_map))
+		return;
+
+	context =3D pri_context_create(gprs, ap->name, ap->type);
+	DBG("%s context%d '%s' %s", gprs_context_default_name(ap->type),
+		id, ap->name, context ? "created" : "creation failed");
+
+	if (context =3D=3D NULL)
+		return;
+
+	context->id =3D id;
+
+	if (ap->username !=3D NULL)
+		strncpy(context->context.username, ap->username,
+			OFONO_GPRS_MAX_USERNAME_LENGTH);
+
+	if (ap->password !=3D NULL)
+		strncpy(context->context.password, ap->password,
+			OFONO_GPRS_MAX_PASSWORD_LENGTH);
+
+	if (ap->apn !=3D NULL)
+		strncpy(context->context.apn, ap->apn,
+			OFONO_GPRS_MAX_APN_LENGTH);
+
+	context->context.proto =3D ap->proto;
+
+	if (ap->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS &&
+			ap->message_proxy !=3D NULL)
+		strncpy(context->message_proxy, ap->message_proxy,
+			MAX_MESSAGE_PROXY_LENGTH);
+
+	if (ap->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS &&
+			ap->message_center !=3D NULL)
+		strncpy(context->message_center, ap->message_center,
+			MAX_MESSAGE_CENTER_LENGTH);
+
+	if (context_dbus_register(context) =3D=3D TRUE) {
+		gprs->last_context_id =3D id;
+		gprs->contexts =3D g_slist_append(gprs->contexts, context);
+		write_context_settings(gprs, context);
+
+		if (context->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
+			g_key_file_set_string(gprs->settings, context->key,
+						"MessageProxy",
+						context->message_proxy);
+			g_key_file_set_string(gprs->settings, context->key,
+						"MessageCenter",
+						context->message_center);
+		}
+
+		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
+	}
+}
+
+
+static void provision_cb(GSList *settings, void *user_data)
+{
+	struct provision_request *req =3D user_data;
+	struct ofono_gprs *gprs =3D req->gprs;
+
+	if (gprs !=3D NULL) {
+		gprs->provision =3D NULL;
+		g_slist_foreach(settings, provision_context, gprs);
+		ofono_gprs_finish_register(gprs);
+	}
+
+	g_free(req);
+	g_slist_foreach(settings, (GFunc) ofono_gprs_provision_data_free,
+			NULL);
+	g_slist_free(settings);
+}
+
+void ofono_gprs_register(struct ofono_gprs *gprs)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
+	struct ofono_atom *sim_atom;
+
+	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+
+	if (sim_atom !=3D NULL) {
+		struct ofono_sim *sim =3D __ofono_atom_get_data(sim_atom);
+		const char *imsi =3D ofono_sim_get_imsi(sim);
+
+		gprs_load_settings(gprs, imsi);
+	}
+
+	if (gprs->contexts =3D=3D NULL) {
+		/* Start settings provisioning */
+		struct provision_request *req;
+
+		req =3D g_try_new0(struct provision_request, 1);
+		if (req !=3D NULL) {
+			req->gprs =3D gprs;
+			gprs->provision =3D req;
+			__ofono_gprs_provision_get_settings(modem, provision_cb,
+								req);
+			return;
+		}
+	}
+
+	ofono_gprs_finish_register(gprs);
+}
+
 void ofono_gprs_remove(struct ofono_gprs *gprs)
 {
 	__ofono_atom_free(gprs->atom);
-- =

1.7.1


--===============4161586537617580361==--

