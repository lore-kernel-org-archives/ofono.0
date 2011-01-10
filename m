Content-Type: multipart/mixed; boundary="===============6174393906520683721=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCH 2/4] gprs: add automatic context settings provisioning
Date: Mon, 10 Jan 2011 15:11:10 +0200
Message-ID: <1294665072-13630-3-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1294665072-13630-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6174393906520683721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++++----=
---
 1 files changed, 102 insertions(+), 14 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 58166f8..7d188a3 100644
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
@@ -2454,13 +2455,15 @@ remove:
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
@@ -2475,18 +2478,6 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
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
@@ -2500,6 +2491,103 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

+static void provision_context(gpointer data, gpointer user_data)
+{
+	struct ofono_gprs_provisioning_data *ap =3D data;
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
+		gprs->contexts =3D g_slist_append(gprs->contexts,
+						context);
+		write_context_settings(gprs, context);
+	}
+}
+
+
+static void provision_cb(GSList *settings, void *userdata)
+{
+	struct ofono_gprs *gprs =3D userdata;
+
+	g_slist_foreach(settings, provision_context, gprs);
+	g_slist_foreach(settings, (GFunc) ofono_gprs_provisioning_data_free,
+			NULL);
+	g_slist_free(settings);
+
+	ofono_gprs_finish_register(gprs);
+}
+
+void ofono_gprs_register(struct ofono_gprs *gprs)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
+
+	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+
+	if (sim_atom !=3D NULL) {
+		const char *imsi =3D ofono_sim_get_imsi(sim);
+		sim =3D __ofono_atom_get_data(sim_atom);
+		gprs_load_settings(gprs, imsi);
+	}
+
+	if (gprs->contexts =3D=3D NULL) {
+		/* Start settings provisioning */
+		ofono_gprs_provision_get_settings(modem, provision_cb, gprs);
+		return;
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


--===============6174393906520683721==--

