Content-Type: multipart/mixed; boundary="===============1770230650426515265=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 8/8] sim: added NetworkAccessIdentifier to SimManager
Date: Wed, 01 Nov 2017 10:33:48 -0700
Message-ID: <1509557628-15121-8-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509557628-15121-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1770230650426515265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

EAP-SIM/AKA/AKA' requires the SIM's NAI to authenticate.
If available, this can be obtained from the ISIM AID.

If the ISIM AID is found a new AID based context will be
created and the EFIMPI file will be read from the SIM
which contains the NAI.
---
 src/sim.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index 8b466c9..f09c550 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -125,6 +125,7 @@ struct ofono_sim {
 	struct sim_fs *simfs_isim;
 	struct ofono_sim_context *context;
 	struct ofono_sim_context *early_context;
+	struct ofono_sim_context *isim_context;
 =

 	unsigned char *iidf_image;
 	unsigned int *iidf_watch_ids;
@@ -136,6 +137,7 @@ struct ofono_sim {
 	unsigned int hfp_watch;
 =

 	GSList *aid_sessions;
+	char *nai;
 };
 =

 struct msisdn_set_request {
@@ -407,6 +409,10 @@ static DBusMessage *sim_get_properties(DBusConnection =
*conn,
 		ofono_dbus_dict_append(&dict, "ServiceProviderName",
 					DBUS_TYPE_STRING, &sim->spn);
 =

+	if (sim->nai)
+		ofono_dbus_dict_append(&dict, "NetworkAccessIdentifier",
+					DBUS_TYPE_STRING, &sim->nai);
+
 	fdn =3D sim->fixed_dialing;
 	ofono_dbus_dict_append(&dict, "FixedDialing", DBUS_TYPE_BOOLEAN, &fdn);
 =

@@ -1456,6 +1462,25 @@ static void sim_set_ready(struct ofono_sim *sim)
 	call_state_watches(sim);
 }
 =

+static void impi_read_cb(int ok, int total_length, int record,
+		const unsigned char *data,
+		int record_length, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	if (!ok) {
+		DBG("error reading IMPI");
+		return;
+	}
+
+	if (data[0] !=3D 0x80) {
+		DBG("invalid TLV tag 0x%02x", data[0]);
+		return;
+	}
+
+	sim->nai =3D g_strndup((const char *)data + 2, data[1]);
+}
+
 static void discover_apps_cb(const struct ofono_error *error,
 		const unsigned char *dataobj,
 		int len, void *data)
@@ -1484,6 +1509,12 @@ static void discover_apps_cb(const struct ofono_erro=
r *error,
 			 * the FS structure so the ISIM EF's can be accessed.
 			 */
 			sim->simfs_isim =3D sim_fs_new(sim, sim->driver);
+			sim->isim_context =3D ofono_sim_context_create_isim(
+					sim);
+			/* attempt to get the NAI from EFimpi */
+			ofono_sim_read_bytes(sim->isim_context,
+					SIM_ISIM_EFIMPI_FILEID, 0, 255, NULL,
+					0, impi_read_cb, sim);
 		}
 =

 		g_free(app);
@@ -2547,6 +2578,14 @@ static void sim_free_main_state(struct ofono_sim *si=
m)
 		sim->context =3D NULL;
 	}
 =

+	if (sim->isim_context) {
+		ofono_sim_context_free(sim->isim_context);
+		sim->isim_context =3D NULL;
+	}
+
+	if (sim->nai)
+		g_free(sim->nai);
+
 	if (sim->aid_sessions)
 		g_slist_free(sim->aid_sessions);
 }
-- =

2.7.4


--===============1770230650426515265==--

