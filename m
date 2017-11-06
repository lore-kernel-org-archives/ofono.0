Content-Type: multipart/mixed; boundary="===============4625667598607052542=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 3/5] sim: implement create ISIM context
Date: Mon, 06 Nov 2017 09:49:32 -0800
Message-ID: <1509990574-19950-3-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509990574-19950-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4625667598607052542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

API to create a sim context for the ISIM application, if found.
During AID discovery, if an ISIM AID is found, a new fs object is
initialized for the ISIM which will be used for any future
ISIM context creation.
---
 src/sim.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index 101914e..23a6395 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -123,6 +123,7 @@ struct ofono_sim {
 	unsigned int cphs_spn_short_watch;
 =

 	struct sim_fs *simfs;
+	struct sim_fs *simfs_isim;
 	struct ofono_sim_context *context;
 	struct ofono_sim_context *early_context;
 =

@@ -1483,6 +1484,14 @@ static void discover_apps_cb(const struct ofono_erro=
r *error,
 		s->state =3D SESSION_STATE_INACTIVE;
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
 		iter =3D g_slist_next(iter);
 	}
 }
@@ -2237,6 +2246,36 @@ struct ofono_sim_context *ofono_sim_context_create(s=
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
+		struct ofono_sim_aid_session *session =3D iter->data;
+
+		/*
+		 * This AID based context is only relevant for an ISIM AID. A
+		 * USIM application can be accessed with the 'default' FS
+		 * context API's.
+		 */
+		if (session->record->type =3D=3D SIM_APP_TYPE_ISIM) {
+			return sim_fs_context_new_with_aid(sim->simfs_isim,
+					session->record->aid);
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
@@ -3067,6 +3106,8 @@ static void sim_remove(struct ofono_atom *atom)
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


--===============4625667598607052542==--

