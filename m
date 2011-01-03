Content-Type: multipart/mixed; boundary="===============4760997465112577541=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCHv2 3/4] gprs: add automatic context settings provisioning
Date: Mon, 03 Jan 2011 09:31:51 +0200
Message-ID: <1294039912-6008-4-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1294039912-6008-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4760997465112577541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  176 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 files changed, 162 insertions(+), 14 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 58166f8..c9d4fb3 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -43,6 +43,9 @@
 #include "common.h"
 #include "storage.h"
 #include "idmap.h"
+#include "util.h"
+#include "simutil.h"
+#include "operator-settings.h"
 =

 #define GPRS_FLAG_ATTACHING 0x1
 #define GPRS_FLAG_RECHECK 0x2
@@ -2261,6 +2264,84 @@ static void netreg_watch(struct ofono_atom *atom,
 	gprs_netreg_update(gprs);
 }
 =

+static gboolean provision_contexts(struct ofono_gprs *gprs,
+					const char *mcc,
+					const char *mnc,
+					const char *spn)
+{
+	gboolean ret =3D FALSE;
+	GSList *settings, *sp;
+
+	settings =3D get_operator_settings(mcc, mnc, spn);
+
+	for (sp =3D settings; sp !=3D NULL; sp =3D sp->next) {
+		unsigned int id;
+		struct pri_context *context =3D NULL;
+		struct gprs_access_settings *ap =3D sp->data;
+
+		/* Sanity check */
+		if (ap =3D=3D NULL || ap->name =3D=3D NULL) {
+			sp =3D sp->next;
+			continue;
+		}
+
+		if (gprs->last_context_id)
+			id =3D idmap_alloc_next(gprs->pid_map,
+						gprs->last_context_id);
+		else
+			id =3D idmap_alloc(gprs->pid_map);
+
+		if (id > idmap_get_max(gprs->pid_map))
+			break;
+
+		context =3D pri_context_create(gprs, ap->name, ap->type);
+		DBG("Provisioned context %d '%s' %s", id, ap->name,
+			context ? "created" : "creation failed");
+
+		if (context =3D=3D NULL)
+			continue;
+
+		context->id =3D id;
+
+		if (ap->username !=3D NULL)
+			strncpy(context->context.username, ap->username,
+				OFONO_GPRS_MAX_USERNAME_LENGTH);
+
+		if (ap->password !=3D NULL)
+			strncpy(context->context.password, ap->password,
+				OFONO_GPRS_MAX_PASSWORD_LENGTH);
+
+		if (ap->apn !=3D NULL)
+			strncpy(context->context.apn, ap->apn,
+				OFONO_GPRS_MAX_APN_LENGTH);
+
+		context->context.proto =3D ap->proto;
+
+		if (ap->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS &&
+			ap->proxy !=3D NULL)
+			strncpy(context->message_proxy, ap->proxy,
+				MAX_MESSAGE_PROXY_LENGTH);
+
+		if (ap->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS &&
+			ap->mms_server !=3D NULL)
+			strncpy(context->message_center, ap->mms_server,
+				MAX_MESSAGE_CENTER_LENGTH);
+
+		if (context_dbus_register(context) =3D=3D TRUE) {
+			gprs->last_context_id =3D id;
+			gprs->contexts =3D g_slist_append(gprs->contexts,
+							context);
+			write_context_settings(gprs, context);
+			ret =3D TRUE;
+		}
+	}
+
+	g_slist_foreach(settings, (GFunc) gprs_access_settings_free, NULL);
+	g_slist_free(settings);
+
+	return ret;
+}
+
 static gboolean load_context(struct ofono_gprs *gprs, const char *group)
 {
 	char *name =3D NULL;
@@ -2454,13 +2535,16 @@ remove:
 		storage_sync(imsi, SETTINGS_STORE, gprs->settings);
 }
 =

-void ofono_gprs_register(struct ofono_gprs *gprs)
+static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
 {
+
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
@@ -2475,18 +2559,6 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
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
@@ -2498,6 +2570,82 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 				OFONO_ATOM_WATCH_CONDITION_REGISTERED, gprs);
 =

 	__ofono_atom_register(gprs->atom, gprs_unregister);
+
+}
+
+static void sim_spn_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_gprs *gprs =3D userdata;
+	char *spn =3D NULL;
+
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim;
+	const char *imsi;
+
+	unsigned char mnc_length;
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
+
+	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+	if (sim_atom =3D=3D NULL)
+		goto finish;
+
+	sim =3D __ofono_atom_get_data(sim_atom);
+	imsi =3D ofono_sim_get_imsi(sim);
+	if (imsi =3D=3D NULL)
+		goto finish;
+
+	mnc_length =3D ofono_sim_get_mnc_length(sim);
+	if (mnc_length =3D=3D 0)
+		goto finish;
+
+	strncpy(mcc, imsi, OFONO_MAX_MCC_LENGTH);
+	mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
+	strncpy(mnc, imsi + OFONO_MAX_MCC_LENGTH, mnc_length);
+	mnc[mnc_length] =3D '\0';
+
+	if (ok)
+		spn =3D sim_string_to_utf8(data + 1, length - 1);
+
+	/* TODO: if SPN is missing/empty, use operator name mapped from
+	   mcc/mnc (when implemented in oFono) */
+
+	DBG("MCC %s, MNC %s, SPN %s", mcc, mnc, spn);
+	provision_contexts(gprs, mcc, mnc, spn);
+	g_free(spn);
+
+finish:
+	ofono_gprs_finish_register(gprs);
+
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
+	if (gprs->contexts =3D=3D NULL && sim !=3D NULL) {
+		/* Try reading SPN for automatic context provisioning */
+		ofono_sim_read(sim, SIM_EFSPN_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				sim_spn_read_cb, gprs);
+		return;
+	}
+
+	ofono_gprs_finish_register(gprs);
 }
 =

 void ofono_gprs_remove(struct ofono_gprs *gprs)
-- =

1.7.1


--===============4760997465112577541==--

