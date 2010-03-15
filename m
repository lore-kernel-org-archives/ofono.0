Content-Type: multipart/mixed; boundary="===============9222453228487542200=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/8][RFC] Set polling interval depending on whether calls are
 active.
Date: Mon, 15 Mar 2010 22:20:55 +0100
Message-ID: <1268688055-3732-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9222453228487542200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/voicecall.h |    2 ++
 src/sim.c           |   37 +++++++++++++++++++++++++++++++++++--
 src/voicecall.c     |    5 +++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/voicecall.h b/include/voicecall.h
index 6ceb3d8..dcce91a 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -114,6 +114,8 @@ void ofono_voicecall_set_data(struct ofono_voicecall *v=
c, void *data);
 void *ofono_voicecall_get_data(struct ofono_voicecall *vc);
 int ofono_voicecall_get_next_callid(struct ofono_voicecall *vc);
 =

+const GSList *ofono_voicecall_get_list(struct ofono_voicecall *vc);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/sim.c b/src/sim.c
index 733e876..c710cc2 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -43,6 +43,7 @@
 #include "simutil.h"
 #include "storage.h"
 #include "stkutil.h"
+#include "voicecall.h"
 =

 #define SIM_MANAGER_INTERFACE "org.ofono.SimManager"
 =

@@ -101,6 +102,8 @@ struct ofono_sim {
 	gint poll_timeout;
 	gboolean poll_enabled;
 	gboolean inserted;
+	unsigned int voicecall_watch;
+	struct ofono_voicecall *voicecall;
 	const struct ofono_sim_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -1807,10 +1810,11 @@ void ofono_sim_proactive_command_notify(struct ofon=
o_sim *sim, int length)
 =

 static void sim_status_poll_schedule(struct ofono_sim *sim)
 {
-	/* TODO: Decide on the interval based on whether any call is active */
 	/* TODO: On idle, possibly only schedule if proactive commands enabled
 	 * as indicated by EFphase + EFsst (51.011: 11.6.1) */
-	int interval =3D sim->idle_poll_interval;
+	int interval =3D
+		(sim->voicecall && ofono_voicecall_get_list(sim->voicecall)) ?
+		sim->incall_poll_interval : sim->idle_poll_interval;
 =

 	sim->poll_timeout =3D g_timeout_add_seconds(interval,
 			sim_status_poll, sim);
@@ -2026,6 +2030,7 @@ static void sim_unregister(struct ofono_atom *atom)
 static void sim_remove(struct ofono_atom *atom)
 {
 	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 =

 	DBG("atom: %p", atom);
 =

@@ -2085,6 +2090,11 @@ static void sim_remove(struct ofono_atom *atom)
 		sim->poll_timeout =3D 0;
 	}
 =

+	if (sim->voicecall_watch) {
+		__ofono_modem_remove_atom_watch(modem, sim->voicecall_watch);
+		sim->voicecall_watch =3D 0;
+	}
+
 	g_free(sim);
 }
 =

@@ -2124,11 +2134,25 @@ struct ofono_sim *ofono_sim_create(struct ofono_mod=
em *modem,
 	return sim;
 }
 =

+static void voicecall_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_sim *sim =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		sim->voicecall =3D NULL;
+		return;
+	}
+
+	sim->voicecall =3D __ofono_atom_get_data(atom);
+}
+
 void ofono_sim_register(struct ofono_sim *sim)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(sim->atom);
 	const char *path =3D __ofono_atom_get_path(sim->atom);
+	struct ofono_atom *vc_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					SIM_MANAGER_INTERFACE,
@@ -2155,6 +2179,15 @@ void ofono_sim_register(struct ofono_sim *sim)
 		sim_status_poll(sim);
 	} else
 		ofono_sim_inserted(sim);
+
+	sim->voicecall_watch =3D __ofono_modem_add_atom_watch(modem,
+			OFONO_ATOM_TYPE_VOICECALL, voicecall_watch, sim, NULL);
+
+	vc_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_VOICECALL);
+
+	if (vc_atom && __ofono_atom_get_registered(vc_atom))
+		voicecall_watch(vc_atom,
+				OFONO_ATOM_WATCH_CONDITION_REGISTERED, sim);
 }
 =

 void ofono_sim_remove(struct ofono_sim *sim)
diff --git a/src/voicecall.c b/src/voicecall.c
index 25ea353..18b923f 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1928,3 +1928,8 @@ int ofono_voicecall_get_next_callid(struct ofono_voic=
ecall *vc)
 =

 	return __ofono_modem_callid_next(modem);
 }
+
+const GSList *ofono_voicecall_get_list(struct ofono_voicecall *vc)
+{
+	return vc->call_list;
+}
-- =

1.6.1


--===============9222453228487542200==--

