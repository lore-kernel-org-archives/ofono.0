Content-Type: multipart/mixed; boundary="===============4862595056921013173=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] sim: Handle multiple invocations of sim_imsi_obtained
Date: Tue, 06 May 2014 14:54:41 +0300
Message-ID: <1399377281-3896-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4862595056921013173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To avoid leaking memory and issuing unnecessary D-Bus signals
---
 src/sim.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index edae5eb..1b0cb80 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1425,11 +1425,18 @@ static void sim_set_ready(struct ofono_sim *sim)
 =

 static void sim_imsi_obtained(struct ofono_sim *sim, const char *imsi)
 {
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path =3D __ofono_atom_get_path(sim->atom);
+	DBusConnection *conn;
+	const char *path;
+
+	if (sim->imsi && !strcmp(sim->imsi, imsi))
+		return;
 =

+	DBG("%s", imsi);
+	g_free(sim->imsi);
 	sim->imsi =3D g_strdup(imsi);
 =

+	conn =3D ofono_dbus_get_connection();
+	path =3D __ofono_atom_get_path(sim->atom);
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
 						"SubscriberIdentity",
-- =

1.8.3.2


--===============4862595056921013173==--

