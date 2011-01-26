Content-Type: multipart/mixed; boundary="===============8030854985185906335=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 4/5] gprs: add gprs context provisioning
Date: Wed, 26 Jan 2011 14:34:14 +0200
Message-ID: <1296045255-29890-5-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1296045255-29890-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8030854985185906335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+--
 1 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 92d0b1a..7fad23b 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -43,6 +43,8 @@
 #include "common.h"
 #include "storage.h"
 #include "idmap.h"
+#include "simutil.h"
+#include "util.h"
 =

 #define GPRS_FLAG_ATTACHING 0x1
 #define GPRS_FLAG_RECHECK 0x2
@@ -2531,6 +2533,75 @@ remove:
 		storage_sync(imsi, SETTINGS_STORE, gprs->settings);
 }
 =

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
 void ofono_gprs_register(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2538,6 +2609,7 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
 	struct ofono_atom *netreg_atom;
 	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CONNECTION_MANAGER_INTERFACE,
@@ -2555,14 +2627,33 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
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
+	if (gprs->contexts =3D=3D NULL) {
+		struct ofono_gprs_provision_data *settings =3D NULL;
+		int count =3D 0;
+		int i;
+
+		__ofono_gprs_provision_get_settings(ofono_sim_get_mcc(sim),
+							ofono_sim_get_mnc(sim),
+							&settings, &count);
+
+		if (count > 0) {
+			for (i =3D 0; i < count; i++)
+				provision_context(&settings[i], gprs);
+
+			__ofono_gprs_provision_free_settings(settings, count);
+		} else {
+			ofono_warn("Context settings provisioning failed");
+			add_context(gprs, NULL,
+					OFONO_GPRS_CONTEXT_TYPE_INTERNET);
+		}
+	}
 =

 	gprs->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
 					OFONO_ATOM_TYPE_NETREG,
-- =

1.7.1


--===============8030854985185906335==--

