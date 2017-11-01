Content-Type: multipart/mixed; boundary="===============8149093860732745928=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 7/8] sim: implement create context with AID
Date: Wed, 01 Nov 2017 10:33:47 -0700
Message-ID: <1509557628-15121-7-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509557628-15121-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8149093860732745928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

API to create a sim context for a given AID. This AID based
context is only relevant for an ISIM application, so during
AID discovery, if an ISIM is found, a new fs object is
initialized for the ISIM. If any atom wants to create an
AID based context for the ISIM AID, the ISIM fs object will
be used.
---
 src/sim.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index 53eb048..8b466c9 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -122,6 +122,7 @@ struct ofono_sim {
 	unsigned int cphs_spn_short_watch;
 =

 	struct sim_fs *simfs;
+	struct sim_fs *simfs_isim;
 	struct ofono_sim_context *context;
 	struct ofono_sim_context *early_context;
 =

@@ -1477,6 +1478,14 @@ static void discover_apps_cb(const struct ofono_erro=
r *error,
 		memcpy(&s->record, app, sizeof(struct sim_app_record));
 		sim->aid_sessions =3D g_slist_prepend(sim->aid_sessions, s);
 =

+		if (app->type =3D=3D SIM_APP_TYPE_ISIM) {
+			/*
+			 * If an ISIM application is found, we should init
+			 * the FS structure so the ISIM EF's can be accessed.
+			 */
+			sim->simfs_isim =3D sim_fs_new(sim, sim->driver);
+		}
+
 		g_free(app);
 =

 		iter =3D g_slist_next(iter);
@@ -2235,6 +2244,36 @@ struct ofono_sim_context *ofono_sim_context_create(s=
truct ofono_sim *sim)
 	return sim_fs_context_new(sim->simfs);
 }
 =

+struct ofono_sim_context *ofono_sim_context_create_isim(
+		struct ofono_sim *sim)
+{
+	GSList *iter =3D sim->aid_sessions;
+
+	if (sim =3D=3D NULL || sim->simfs_isim =3D=3D NULL)
+		return NULL;
+
+	/*
+	 * Check if the AID is even valid
+	 */
+	while (iter) {
+		struct sim_app_record *app =3D iter->data;
+
+		/*
+		 * This AID based context is only relevant for an ISIM AID. A
+		 * USIM application can be accessed with the 'default' FS
+		 * context API's.
+		 */
+		if (app->type =3D=3D SIM_APP_TYPE_ISIM) {
+			return sim_fs_context_new_with_aid(sim->simfs_isim,
+					app->aid);
+		}
+
+		iter =3D g_slist_next(iter);
+	}
+
+	return NULL;
+}
+
 void ofono_sim_context_free(struct ofono_sim_context *context)
 {
 	return sim_fs_context_free(context);
@@ -3056,6 +3095,8 @@ static void sim_remove(struct ofono_atom *atom)
 =

 	sim_fs_free(sim->simfs);
 	sim->simfs =3D NULL;
+	sim_fs_free(sim->simfs_isim);
+	sim->simfs_isim =3D NULL;
 =

 	g_free(sim);
 }
-- =

2.7.4


--===============8149093860732745928==--

