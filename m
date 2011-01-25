Content-Type: multipart/mixed; boundary="===============0624576248242645441=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 3/4] gprs: add gprs context provisioning
Date: Tue, 25 Jan 2011 14:15:13 +0200
Message-ID: <1295957714-21053-4-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295957714-21053-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0624576248242645441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  172 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 162 insertions(+), 10 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 92d0b1a..3e281e5 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -44,6 +44,11 @@
 #include "storage.h"
 #include "idmap.h"
 =

+#include "sim.h"
+#include "simutil.h"
+#include "util.h"
+#include "gprs-provision.h"
+
 #define GPRS_FLAG_ATTACHING 0x1
 #define GPRS_FLAG_RECHECK 0x2
 =

@@ -95,6 +100,7 @@ struct ofono_gprs {
 	const struct ofono_gprs_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct spn_read_request *reading_spn;
 };
 =

 struct ofono_gprs_context {
@@ -135,6 +141,12 @@ struct pri_context {
 	struct ofono_gprs *gprs;
 };
 =

+struct spn_read_request {
+	struct ofono_gprs *gprs;
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+};
+
 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
 =

@@ -2251,10 +2263,15 @@ static void gprs_unregister(struct ofono_atom *atom)
 		gprs->netreg =3D NULL;
 	}
 =

-	ofono_modem_remove_interface(modem,
+	if (gprs->reading_spn =3D=3D NULL) {
+		ofono_modem_remove_interface(modem,
 					OFONO_CONNECTION_MANAGER_INTERFACE);
-	g_dbus_unregister_interface(conn, path,
+		g_dbus_unregister_interface(conn, path,
 					OFONO_CONNECTION_MANAGER_INTERFACE);
+	} else {
+		gprs->reading_spn->gprs =3D NULL;
+		gprs->reading_spn =3D NULL;
+	}
 }
 =

 static void gprs_remove(struct ofono_atom *atom)
@@ -2279,6 +2296,9 @@ static void gprs_remove(struct ofono_atom *atom)
 	if (gprs->driver && gprs->driver->remove)
 		gprs->driver->remove(gprs);
 =

+	if (gprs->reading_spn !=3D NULL)
+		gprs->reading_spn->gprs =3D NULL;
+
 	g_free(gprs);
 }
 =

@@ -2531,13 +2551,14 @@ remove:
 		storage_sync(imsi, SETTINGS_STORE, gprs->settings);
 }
 =

-void ofono_gprs_register(struct ofono_gprs *gprs)
+static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
-	struct ofono_atom *netreg_atom;
-	struct ofono_atom *sim_atom;
+
+	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
+		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CONNECTION_MANAGER_INTERFACE,
@@ -2546,24 +2567,134 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 		ofono_error("Could not create %s interface",
 				OFONO_CONNECTION_MANAGER_INTERFACE);
 =

+		gprs_unregister(gprs->atom);
 		return;
 	}
 =

 	ofono_modem_add_interface(modem,
 				OFONO_CONNECTION_MANAGER_INTERFACE);
+}
+
+static void provision_context(const struct ofono_gprs_provision_data *ap,
+				struct ofono_gprs *gprs)
+{
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
+static void sim_spn_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *user_data)
+{
+	struct spn_read_request *req =3D user_data;
+	struct ofono_gprs *gprs =3D req->gprs;
+	char *spn =3D NULL;
+	struct ofono_gprs_provision_data *settings =3D NULL;
+	int count =3D 0;
+	int i;
+
+	if (gprs =3D=3D NULL)
+		goto out;
+
+	gprs->reading_spn =3D NULL;
+
+	if (ok)
+		spn =3D sim_string_to_utf8(data + 1, length - 1);
+
+	__ofono_gprs_provision_get_settings(req->mcc, req->mnc, spn,
+						&settings, &count);
+
+	if (count > 0)
+		DBG("Provisioning %d contexts", count);
+
+	for (i =3D 0; i < count; i++)
+		provision_context(&settings[i], gprs);
+
+	provision_settings_free(settings, count);
+	ofono_gprs_finish_register(gprs);
+out:
+	g_free(req);
+}
+
+void ofono_gprs_register(struct ofono_gprs *gprs)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
+	struct ofono_atom *netreg_atom;
 =

 	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
 =

 	if (sim_atom) {
-		struct ofono_sim *sim =3D __ofono_atom_get_data(sim_atom);
-		const char *imsi =3D ofono_sim_get_imsi(sim);
+		const char *imsi;
 =

+		sim =3D __ofono_atom_get_data(sim_atom);
+		imsi =3D ofono_sim_get_imsi(sim);
 		gprs_load_settings(gprs, imsi);
 	}
 =

-	if (gprs->contexts =3D=3D NULL)
-		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
-
 	gprs->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
 					OFONO_ATOM_TYPE_NETREG,
 					netreg_watch, gprs, NULL);
@@ -2575,6 +2706,27 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 				OFONO_ATOM_WATCH_CONDITION_REGISTERED, gprs);
 =

 	__ofono_atom_register(gprs->atom, gprs_unregister);
+
+	if (gprs->contexts =3D=3D NULL && sim !=3D NULL) {
+		/* Start reading spn for provisioning */
+		struct spn_read_request *req;
+
+		DBG("start reading EF-SPN");
+
+		req =3D g_try_new0(struct spn_read_request, 1);
+		if (req !=3D NULL) {
+			req->gprs =3D gprs;
+			gprs->reading_spn =3D req;
+			strcpy(req->mcc, ofono_sim_get_mcc(sim));
+			strcpy(req->mnc, ofono_sim_get_mnc(sim));
+			if (ofono_sim_read(sim, SIM_EFSPN_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					sim_spn_read_cb, req) >=3D 0)
+				return;
+		}
+	}
+
+	ofono_gprs_finish_register(gprs);
 }
 =

 void ofono_gprs_remove(struct ofono_gprs *gprs)
-- =

1.7.1


--===============0624576248242645441==--

