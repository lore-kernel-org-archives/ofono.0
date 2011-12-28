Content-Type: multipart/mixed; boundary="===============4498614382502386077=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 3/3] gprs: Use netreg SPN watch API
Date: Wed, 28 Dec 2011 15:18:44 +0200
Message-ID: <1325078324-30548-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1325078324-30548-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4498614382502386077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   67 ++++++++++++++++++++++++++++++++------------------------=
---
 1 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 4e46743..356479c 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -46,8 +46,9 @@
 #include "simutil.h"
 #include "util.h"
 =

-#define GPRS_FLAG_ATTACHING 0x1
-#define GPRS_FLAG_RECHECK 0x2
+#define GPRS_FLAG_ATTACHING	0x1
+#define GPRS_FLAG_RECHECK	0x2
+#define GPRS_FLAG_READ_SPN	0x4
 =

 #define SETTINGS_STORE "gprs"
 #define SETTINGS_GROUP "Settings"
@@ -87,6 +88,7 @@ struct ofono_gprs {
 	struct ofono_netreg *netreg;
 	unsigned int netreg_watch;
 	unsigned int status_watch;
+	unsigned int spn_watch;
 	GKeyFile *settings;
 	char *imsi;
 	DBusMessage *pending;
@@ -148,6 +150,7 @@ struct pri_context {
 =

 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
+static void spn_read_cb(gpointer spn, gpointer user_data);
 =

 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
@@ -1528,11 +1531,15 @@ static void gprs_netreg_removed(struct ofono_gprs *=
gprs)
 {
 	gprs->netreg =3D NULL;
 =

-	gprs->flags &=3D ~(GPRS_FLAG_RECHECK | GPRS_FLAG_ATTACHING);
+	gprs->flags &=3D ~(GPRS_FLAG_RECHECK | GPRS_FLAG_ATTACHING |
+						GPRS_FLAG_READ_SPN);
 	gprs->status_watch =3D 0;
 	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
 	gprs->driver_attached =3D FALSE;
 =

+	if (gprs->spn_watch)
+		__ofono_netreg_remove_spn_watch(gprs->netreg, &gprs->spn_watch);
+
 	gprs_attached_update(gprs);
 }
 =

@@ -2625,6 +2632,12 @@ static void netreg_watch(struct ofono_atom *atom,
 					netreg_status_changed, gprs, NULL);
 =

 	gprs_netreg_update(gprs);
+
+	if (gprs->flags & GPRS_FLAG_READ_SPN) {
+		__ofono_netreg_add_spn_watch(gprs->netreg, &gprs->spn_watch,
+						spn_read_cb, gprs, NULL);
+		gprs->flags &=3D ~GPRS_FLAG_READ_SPN;
+	}
 }
 =

 static gboolean load_context(struct ofono_gprs *gprs, const char *group)
@@ -2948,34 +2961,29 @@ static void ofono_gprs_finish_register(struct ofono=
_gprs *gprs)
 	ofono_modem_add_interface(modem,
 				OFONO_CONNECTION_MANAGER_INTERFACE);
 =

-	gprs->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
-					OFONO_ATOM_TYPE_NETREG,
-					netreg_watch, gprs, NULL);
-
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

-static void sim_spn_read_cb(int ok, int length, int record,
-				const unsigned char *data,
-				int record_length, void *userdata)
+static void spn_read_cb(gpointer spn, gpointer user_data)
 {
-	struct ofono_gprs *gprs	=3D userdata;
-	char *spn =3D NULL;
+	struct ofono_gprs *gprs	=3D user_data;
 	struct ofono_atom *sim_atom;
-	struct ofono_sim *sim =3D NULL;
+	struct ofono_sim *sim;
 =

-	if (ok)
-		spn =3D sim_string_to_utf8(data + 1, length - 1);
+	if (gprs->spn_watch =3D=3D 0)
+		return;
+
+	__ofono_netreg_remove_spn_watch(gprs->netreg, &gprs->spn_watch);
 =

 	sim_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(gprs->atom),
 						OFONO_ATOM_TYPE_SIM);
-	if (sim_atom) {
+	if (sim_atom)
 		sim =3D __ofono_atom_get_data(sim_atom);
+
+	if (sim !=3D NULL && spn !=3D NULL)
 		provision_contexts(gprs, ofono_sim_get_mcc(sim),
 					ofono_sim_get_mnc(sim), spn);
-	}
 =

-	g_free(spn);
 	ofono_gprs_finish_register(gprs);
 }
 =

@@ -2985,27 +2993,24 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 	struct ofono_atom *sim_atom;
 	struct ofono_sim *sim =3D NULL;
 =

-	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+	sim_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(gprs->atom),
+						OFONO_ATOM_TYPE_SIM);
 =

 	if (sim_atom) {
-		const char *imsi;
 		sim =3D __ofono_atom_get_data(sim_atom);
 =

-		imsi =3D ofono_sim_get_imsi(sim);
-		gprs_load_settings(gprs, imsi);
+		gprs_load_settings(gprs, ofono_sim_get_imsi(sim));
 	}
 =

-	if (gprs->contexts =3D=3D NULL && sim !=3D NULL) {
-		/* Get Service Provider Name from SIM for provisioning */
-		gprs->sim_context =3D ofono_sim_context_create(sim);
+	if (gprs->contexts =3D=3D NULL && sim !=3D NULL)
+		gprs->flags |=3D GPRS_FLAG_READ_SPN;
 =

-		if (ofono_sim_read(gprs->sim_context, SIM_EFSPN_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-					sim_spn_read_cb, gprs) >=3D 0)
-			return;
-	}
+	gprs->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_NETREG,
+					netreg_watch, gprs, NULL);
 =

-	ofono_gprs_finish_register(gprs);
+	if (gprs->spn_watch =3D=3D 0)
+		ofono_gprs_finish_register(gprs);
 }
 =

 void ofono_gprs_remove(struct ofono_gprs *gprs)
-- =

1.7.5.4


--===============4498614382502386077==--

